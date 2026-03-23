# Instacart ELT Data Pipeline and Analysis

## Overview

This project implements an end-to-end ELT data pipeline using the Instacart public dataset. The pipeline ingests raw CSV data into cloud storage, loads it into a cloud data warehouse, and performs structured transformations using dbt to produce analytics-ready tables.
The goal of the project is to analyze customer purchasing behavior, product demand, and ordering patterns using a modern data stack.

## Tech Stack

* **AWS S3** – Storage for raw CSV datasets
* **Snowflake** – Cloud data warehouse for raw and transformed data
* **dbt (Data Build Tool)** – SQL-based data transformations and modeling
* **SQL** – Analytical queries and data modeling

## Dataset

The project uses the Instacart Online Grocery Shopping Dataset downloaded from kaggle at https://www.kaggle.com/datasets/yasserh/instacart-online-grocery-basket-analysis-dataset.
Key characteristics of the processed data:

* ~70,000 customer orders
* ~700,000 product order records
* Product metadata including departments and aisles

## Architecture

Pipeline workflow:

1. Raw Instacart CSV files are uploaded to AWS S3.
2. Snowflake loads the raw data and stores it in staging tables.
3. dbt performs transformations to structure the data using a dimensional model.
4. Analytical queries are executed against the transformed models.

High-level ELT flow:

Raw CSV → S3 → Snowflake (Raw Tables) → dbt Transformations → Analytics Models

## Data Modeling

A star schema was implemented to support analytical queries.

### Fact Tables

* **fct_orders** – order-level information
* **fct_order_items** – product-level records within orders

### Dimension Tables

* **dim_products**
* **dim_departments**
* **dim_aisles**
* **dim_users**

### Data Mart Models

Aggregated models were created for analysis, including:

* **mart_aisles**
* **mart_basket_sizes**
* **mart_reorders**

These models provide simplified datasets for answering common analytical questions.

## Analyses Performed

SQL analysis models were developed to explore customer behavior and product demand. The project generated result datasets that answer the following questions:

* What are the most frequently purchased products?
* Which products are most frequently reordered by customers?
* How many items do customers typically purchase per order?
* Which departments perform best in terms of product orders?
* What are the peak shopping days and hours?

Results were exported as CSV files for further exploration.

## Project Structure

```
instacart/
│
├── analyses/               # SQL queries used for exploratory analysis
│
├── models/
│   ├── staging/            # Raw data cleaning and preparation
│   ├── dim/                # Dimension tables
│   ├── fct/                # Fact tables
│   └── mart/               # Aggregated analytical models
│
├── macros/                 # dbt macros
├── seeds/                  # Static datasets
├── snapshots/              # dbt snapshot experiments
├── tests/                  # Data tests
│
├── dbt_project.yml
├── packages.yml
└── README.md
```
