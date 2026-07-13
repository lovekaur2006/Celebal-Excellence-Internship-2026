# E-Commerce Order Analytics System

## Project Overview

The E-Commerce Order Analytics System is an end-to-end data analytics project designed to simulate a real-world e-commerce environment. The project demonstrates the complete data lifecycle, including data generation, data cleaning, database integration, SQL analytics, reporting, and data quality validation.

The system generates synthetic e-commerce datasets, cleans and validates the data, loads it into a SQLite database, performs advanced analytical queries, and provides an interactive command-line reporting tool for business insights.

---

## Objectives

- Generate realistic e-commerce datasets.
- Perform data cleaning and validation using Python.
- Load cleaned data into a relational database.
- Write SQL queries ranging from basic aggregations to advanced analytics.
- Build a Python-based reporting tool integrated with SQLite.
- Implement edge-case testing to ensure data quality and robustness.

---

## Technologies Used

- Python 3
- SQLite
- SQL
- Faker
- Pandas
- DB Browser for SQLite

---

## Project Structure

```text
ecommerce-analytics-system/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   └── cleaned/
│       ├── customers.csv
│       ├── products.csv
│       ├── orders.csv
│       └── order_items.csv
│
├── database/
│   └── ecommerce.db
│
├── scripts/
│   ├── generate_data.py
│   ├── clean_data.py
│   ├── load_database.py
│   ├── report_cli.py
│   └── test_cases.py
│
├── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   └── cohort_analysis.sql
│
├── output/
│
└── README.md
```

---

# Dataset Description

## Customers

Contains customer information.

| Column |
|----------|
| customer_id |
| customer_name |
| email |
| registration_date |
| customer_type |

---

## Products

Contains product catalog information.

| Column |
|----------|
| product_id |
| product_name |
| category |
| subcategory |
| cost_price |

---

## Orders

Contains order-level information.

| Column |
|----------|
| order_id |
| customer_id |
| order_date |
| status |
| region_code |

Order Status Values:

- PLACED
- SHIPPED
- DELIVERED
- RETURNED
- CANCELLED

---

## Order Items

Contains item-level transaction details.

| Column |
|----------|
| item_id |
| order_id |
| product_id |
| quantity |
| unit_price |
| discount_percent |

---

# Part 1: Data Generation

Synthetic data is generated using Python and Faker.

Generated datasets:

- customers.csv
- products.csv
- orders.csv
- order_items.csv

Features:

- Realistic customer records
- Product categories and pricing
- Order transactions
- Discounts and returns
- Multiple order statuses

---

# Part 2: Data Cleaning & Validation

Implemented using Python and Pandas.

### Functions

### clean_orders()

- Standardizes date formats
- Handles missing customer IDs

### clean_products()

- Trims extra spaces
- Converts product names to title case

### validate_emails()

- Detects invalid email addresses
- Generates validation report

### check_referential_integrity()

- Identifies order items referencing non-existent orders

Output:

- Cleaned CSV files
- Validation report

---

# Part 3: SQL Analytics

## Basic Queries

1. Total Revenue per Category
2. Top 10 Customers by Total Order Value
3. Month-wise Order Count

---

## Intermediate Queries

4. Customers Who Never Had a Delivered Order
5. Products with More Returns Than Purchases
6. Return Rate per Category

---

## Advanced SQL Queries

7. Running Total of Revenue per Region
8. Product Ranking using DENSE_RANK()
9. Customer Gap Analysis using LAG()
10. Monthly Customer Segmentation using Multi-Level CTEs
11. Customer Segmentation using NTILE()
12. Year-over-Year Revenue Comparison
13. First Purchased Category vs Latest Purchased Category
14. Revenue Contribution Analysis using Cumulative Distribution
15. Customer Cohort Analysis
16. Frequently Bought Together Products

Concepts Used:

- CTEs
- Window Functions
- DENSE_RANK
- NTILE
- LAG
- Self Joins
- Cohort Analysis
- Running Totals
- Year-over-Year Analysis

---

# Part 4: Python + SQL Integration

A command-line reporting application was built to generate business reports directly from the SQLite database.

### Features

- Daily Reports
- Weekly Reports
- Monthly Reports

### User Inputs

- Report Type
- Start Date
- End Date

### Report Output

- Total Orders
- Total Revenue
- Unique Customers
- Top 3 Products
- Revenue Change (%) Compared to Previous Period

Example:

```text
=========================================
          ECOMMERCE REPORT
=========================================

Report Type      : Monthly
Period           : 2025-01-01 to 2025-01-31

Total Orders     : 82
Total Revenue    : 154320.55
Unique Customers : 67

Top 3 Products
----------------------------
Wireless Mouse       34
Running Shoes        28
Coffee Maker         25

Revenue Change : 12.47%
=========================================
```

---

# Part 5: Edge Case Handling

Implemented validation test cases to verify data integrity.

### Test Cases

### test_invalid_order_reference()

Checks whether any order item references a non-existent order.

### test_discount_greater_than_100()

Detects invalid discounts greater than 100%.

### test_zero_quantity()

Detects transactions with zero quantity.

### test_future_order_date()

Detects orders with future dates.

---

# Database Design

Relationships:

```text
Customers
    |
    | customer_id
    |
Orders
    |
    | order_id
    |
Order_Items
    |
    | product_id
    |
Products
```

Primary Keys:

- customer_id
- product_id
- order_id
- item_id

Foreign Keys:

- orders.customer_id → customers.customer_id
- order_items.order_id → orders.order_id
- order_items.product_id → products.product_id

---

# How to Run

## 1. Generate Data

```bash
python scripts/generate_data.py
```

## 2. Clean Data

```bash
python scripts/clean_data.py
```

## 3. Load Data into SQLite

```bash
python scripts/load_database.py
```

## 4. Run Reports

```bash
python scripts/report_cli.py
```

## 5. Run Test Cases

```bash
python scripts/test_cases.py
```

---

# Key Learning Outcomes

- Data Generation using Faker
- Data Cleaning using Pandas
- Relational Database Design
- SQL Analytics
- Window Functions
- Cohort Analysis
- Python-SQL Integration
- Data Quality Validation
- Command-Line Application Development

---

# Author

**Lovepreet Kaur**

B.Tech Student | Aspiring Data Engineer

This project was developed as part of a data engineering and analytics assignment to demonstrate practical skills in Python, SQL, SQLite, ETL workflows, and business analytics.