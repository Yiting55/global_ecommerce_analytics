import streamlit as st
import pandas as pd
from sqlalchemy import create_engine
import plotly.express as px

st.title("Global E-commerce Dashboard")

engine = create_engine(
    "postgresql://postgres:Hytznby*0532@localhost:5432/ecommerce_project"
)

query = """
SELECT *
FROM clean_ecommerce_orders
"""

# to load the df
df = pd.read_sql(query,engine)

# add sidebar filters for product type and region
st.sidebar.header("Filters")

selected_region = st.sidebar.multiselect(
    "Select Region",
    options=df["region"].unique(),
    default=df["region"].unique()
)

selected_category = st.sidebar.multiselect(
    "Select Product Category",
    options=df["product_category"].unique(),
    default=df["product_category"].unique()
)

filtered_df = df[
    (df["region"].isin(selected_region)) &
    (df["product_category"].isin(selected_category))
]

# first section of the dashboard: preview table of data
st.subheader("Dataset Preview")
preview_df = filtered_df.head().copy()
preview_df.index = range(1, len(preview_df)+1)
st.dataframe(preview_df)

# second section of the dashboard: kpi metrics - revenue, profit, order count, average order value, and profit margin
total_revenue = filtered_df["total_sales"].sum()
total_profit = filtered_df["profit"].sum()
total_orders = filtered_df["order_id"].nunique()
avg_order_value = filtered_df["total_sales"].mean()
profit_margin = total_profit / total_revenue if total_revenue != 0 else 0

col1, col2, col3, col4, col5 = st.columns(5)

col1.metric("Revenue", f"${total_revenue/1_000_000:.2f}M")
col2.metric("Profit", f"${total_profit/1_000_000:.2f}M")
col3.metric("Orders", f"{total_orders:,}")
col4.metric("Avg Order Value", f"${avg_order_value:.2f}")
col5.metric("Profit Margin", f"{profit_margin:.2%}")

# third section of the dashboard: total revenue and profit trend over the period
monthly = filtered_df.groupby("order_month_year")[["total_sales", "profit"]].sum().reset_index()

fig = px.line(
    monthly,
    x="order_month_year",
    y=["total_sales", "profit"],
    title="Monthly Revenue and Profit Trend"
)
st.plotly_chart(fig, use_container_width=True)

# fourth section of the dashboard: total revenue by region
region = filtered_df.groupby("region")[["total_sales", "profit"]].sum().reset_index()

fig = px.bar(
    region,
    x="region",
    y="total_sales",
    title="Revenue by Region"
)
st.plotly_chart(fig, use_container_width=True)

# fifth section of the dashboard: profit by product category
category = filtered_df.groupby("product_category")[["total_sales", "profit"]].sum().reset_index()

fig = px.bar(
    category,
    x="product_category",
    y="profit",
    title="Profit by Product Category"
)
st.plotly_chart(fig, use_container_width=True)

# sixth section of the dashboard: table of top selling products order by profit
top_products = (
    filtered_df.groupby(["product_name", "product_category"])
    .agg(
        revenue=("total_sales", "sum"),
        profit=("profit", "sum"),
        orders=("order_id", "count")
    )
    .sort_values("profit", ascending=False)
    .reset_index()
    .head(10)
)

top_products.index = range(1, len(top_products)+1)

st.subheader("Top 10 Profitable Products")
st.dataframe(top_products)