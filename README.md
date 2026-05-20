# Global E-commerce Analytics Project

## Project Overview

This project is an end-to-end Business Analytics and Data Analytics workflow built using SQL, PostgreSQL, Python, and Streamlit. The objective was to analyze global e-commerce transactions from 2023–2025 and identify business insights related to revenue growth, profitability, customer behavior, product performance, and operational efficiency.

The project follows a complete analytics pipeline from raw data ingestion to an interactive dashboard.

## Business Problem
How can an e-commerce company improve:
- Revenue growth
- Customer value
- Product performance
- Profitability
- Discount strategy effectiveness
- Shipping efficiency

## Dataset Information

The dataset contains:
- 2,000 orders
- 15 features
- 20 countries
- 40 products
- 3 customer segments
- Transaction period: 2023–2025

Main attributes include:
- Customer information
- Product details
- Sales metrics
- Discounts
- Shipping cost
- Profit
- Payment methods

## Tech Stack

- PostgreSQL
- SQL
- Python
- Streamlit
- Plotly
- Pandas

## Project Workflow

Raw CSV Data
→ Data Cleaning
→ Exploratory Data Analysis (EDA)
→ Business Analysis SQL Queries
→ Insights Summary
→ Interactive Streamlit Dashboard

## SQL Analysis Structure
sql/
├── 01_create_table.sql
├── 02_data_quality.sql
├── 03_cleaning_view.sql
├── 04_eda.sql
├── 05_business_analysis.sql

## Key Business Findings

- Consumer segment generated highest revenue and profit contribution.
- Higher discount levels reduced profit margins.
- South America had highest shipping cost burden.
- Furniture and Technology categories showed strong profitability, while several Office Supply products underperformed.

## Dashboard Features
Interactive dashboard built with Streamlit:
- KPI cards
- Monthly revenue & profit trends
- Region performance analysis
- Product category analysis
- Top-performing products
- Interactive filters

(Add screenshots later)