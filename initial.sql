-- Use an admin role
USE ROLE ACCOUNTADMIN;

-- Create the `transform` role and assign it to ACCOUNTADMIN
CREATE ROLE IF NOT EXISTS TRANSFORM;
GRANT ROLE TRANSFORM TO ROLE ACCOUNTADMIN;

-- Create a default warehouse
CREATE WAREHOUSE IF NOT EXISTS COMPUTE_WH;
GRANT OPERATE ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM;

-- Create the 'dbt' user and assign to the transform role
CREATE USER IF NOT EXISTS dbt
    PASSWORD = 'dbtpassword123' 
    LOGIN_NAME = 'dbtuser'
    MUST_CHANGE_PASSWORD = FALSE
    DEFAULT_WAREHOUSE = 'COMPUTE_WH'
    DEFAULT_ROLE = TRANSFORM
    DEFAULT_NAMESPACE = 'INSTACART.RAW'
    COMMENT = ' dbt user used for data transformation';
ALTER USER dbt SET TYPE = LEGACY_SERVICE;
GRANT ROLE TRANSFORM TO USER dbt;

-- Create a database and schema for the InstaCart project
CREATE DATABASE IF NOT EXISTS INSTACART;
CREATE SCHEMA IF NOT EXISTS INSTACART.RAW;

-- Grant permissions to the 'transform' role
GRANT ALL ON WAREHOUSE COMPUTE_WH TO ROLE TRANSFORM;
GRANT ALL ON DATABASE INSTACART TO ROLE TRANSFORM;
GRANT ALL ON ALL SCHEMAS IN DATABASE INSTACART TO ROLE TRANSFORM;
GRANT ALL ON FUTURE SCHEMAS IN DATABASE INSTACART TO ROLE TRANSFORM;
GRANT ALL ON ALL TABLES IN SCHEMA INSTACART.RAW TO ROLE TRANSFORM;
GRANT ALL ON FUTURE TABLES IN SCHEMA INSTACART.RAW TO ROLE TRANSFORM;

USE WAREHOUSE COMPUTE_WH;
USE DATABASE INSTACART;
USE SCHEMA RAW;

CREATE STAGE IF NOT EXISTS instacartstage
    URL = 's3://instacartdemo207'
    CREDENTIALS = (AWS_KEY_ID = '', AWS_SECRET_KEY = '');

CREATE OR REPLACE TABLE raw_products (
    product_id INT,
    product_name TEXT,
    aisle_id INT,
    department_id INT
);

COPY INTO raw_products
FROM '@instacartstage/products.csv'
FILE_FORMAT = (TYPE = 'CSV', SKIP_HEADER = 1, FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_orders (
    order_id INT,
    user_id INT,
    eval_set TEXT,
    order_number INT,
    order_dow INT,
    order_hour_of_day SMALLINT,
    days_since_prior_order FLOAT
);

COPY INTO raw_orders
FROM '@instacartstage/orders.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_order_products_prior (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
);

COPY INTO raw_order_products_prior
from '@instacartstage/order_products__prior.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_order_products_train (
    order_id INT,
    product_id INT,
    add_to_cart_order INT,
    reordered INT
);

COPY INTO raw_order_products_train
from '@instacartstage/order_products__train.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_aisles (
    aisle_id INT,
    aisle TEXT
);

COPY INTO raw_aisles 
from '@instacartstage/aisles.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

CREATE OR REPLACE TABLE raw_departments (
    department_id INT,
    department TEXT
);

COPY INTO raw_departments
from '@instacartstage/departments.csv'
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"');

