# dbt + Snowflake + Airflow ETL Pipeline

A complete modern data engineering pipeline that demonstrates advanced ETL practices using dbt, Snowflake, and Apache Airflow with comprehensive data quality testing and automated orchestration.

![Pipeline Architecture](screenshots/architecture.jpg)

## 🏗️ Architecture

```
Raw Data (Seeds) → Staging Layer → Analytics Layer (Marts)
     ↓                ↓               ↓
   CSV Files    →  Clean/Transform  →  Dimensions & Facts
                      ↓
              Data Quality Tests (28 tests)
                      ↓
               Airflow Orchestration
```

## 🚀 Features

### ✅ Data Pipeline
- **4 Staging Models** with primary/foreign key constraints
- **3 Analytics Models** (2 dimensions, 1 fact table)
- **28 Data Quality Tests** ensuring data integrity
- **Automated Orchestration** via Airflow DAGs

### ✅ Database Design
- **Proper ID Naming**: `customer_id`, `product_id`, `order_id`, `item_id`
- **Referential Integrity**: Primary keys and foreign key relationships
- **Schema Separation**: Raw data in `DBT_DEV_RAW_RAW`, processed data in `DBT_DEV_RAW`

### ✅ Data Quality
- Uniqueness constraints on all primary keys
- Not-null validations on critical fields
- Relationship tests for foreign key integrity
- Business rule validations (order statuses, positive amounts)

## 📊 Data Models

### Raw Data (Seeds)
- `customers.csv` - 100 customer records
- `orders.csv` - 300 order records  
- `order_items.csv` - 600 order item records
- `products.csv` - 10 product records

### Staging Layer
- `stg_customers` - Cleaned customer data with `customer_id` PK
- `stg_products` - Product catalog with `product_id` PK
- `stg_orders` - Order data with `order_id` PK and FK to customers
- `stg_order_items` - Order line items with `item_id` PK and FKs to orders/products

### Analytics Layer (Marts)
- `dim_customers` - Customer dimension with segmentation (VIP, Regular, New)
- `dim_products` - Product dimension with performance metrics
- `fct_daily_order_revenue` - Daily revenue fact table with order analytics

## 🛠️ Technology Stack

- **🔄 dbt (1.9.0)** - Data transformation and modeling
- **❄️ Snowflake** - Cloud data warehouse
- **🌬️ Apache Airflow (2.10.3)** - Workflow orchestration
- **🐍 Python (3.11)** - Runtime environment
- **🧪 dbt Tests** - Data quality validation

## 🚀 Quick Start

### 1. Prerequisites
- Snowflake account with ACCOUNTADMIN access
- Python 3.11+
- Git

### 2. Setup

```bash
# Clone the repository
git clone https://github.com/ahmadelsap3/dbt-snowflake-airflow-etl-pipeline.git
cd dbt-snowflake-airflow-etl-pipeline

# Run setup
./setup_codespaces.sh
```

### 3. Configure Snowflake Connection

**Step 1: Environment Variables**
Update `snowflake_env.sh` with your credentials:
```bash
export SNOWFLAKE_USER="your_username"
export SNOWFLAKE_PASSWORD="your_password" 
export SNOWFLAKE_ACCOUNT="your_account_identifier"
export SNOWFLAKE_WAREHOUSE="your_warehouse"
export SNOWFLAKE_DATABASE="your_database"
```

**Step 2: dbt Profile**
Copy and configure the dbt profile:
```bash
# Copy the template
cp profiles_template.yml ~/.dbt/profiles.yml

# Edit with your Snowflake credentials
nano ~/.dbt/profiles.yml
```

Update the profile with your actual Snowflake connection details:
```yaml
dbt_snowflake_airflow_etl_pipeline:
  outputs:
    dev:
      account: YOUR_SNOWFLAKE_ACCOUNT  # e.g., xy12345.us-east-1
      database: YOUR_DATABASE_NAME    # e.g., finance_db
      role: ACCOUNTADMIN
      schema: YOUR_SCHEMA_NAME       # e.g., raw
      threads: 4
      type: snowflake
      user: YOUR_SNOWFLAKE_USERNAME
      warehouse: YOUR_WAREHOUSE_NAME # e.g., compute_wh
      password: "YOUR_SNOWFLAKE_PASSWORD"
  target: dev
```

**Step 3: Test Connection**
```bash
# Test dbt connection
source .venv/bin/activate
dbt debug
```

### 4. Start Services

```bash
# Start Airflow (webserver + scheduler)
./start_airflow_codespaces.sh

# Access Airflow UI at http://localhost:8080
# Username: admin, Password: admin
```

## 🎯 Pipeline Execution

### Manual Execution
```bash
# Load raw data
dbt seed --profiles-dir .

# Run staging transformations  
dbt run --select example.Staging --profiles-dir .

# Run analytics transformations
dbt run --select example.marts --profiles-dir .

# Run data quality tests
dbt test --profiles-dir .
```

### Automated Execution via Airflow
1. Access Airflow UI at http://localhost:8080
2. Navigate to DAG: `advanced_dbt_snowflake_pipeline`
3. Toggle DAG to "ON"
4. Click "Trigger DAG" to execute

## 📈 Pipeline Stages

### Stage 1: Data Ingestion (`dbt_seed`)
- Loads CSV files into Snowflake raw schema
- 1,010 total records across 4 tables

### Stage 2: Data Transformation (`dbt_run_staging`) 
- Creates 4 staging tables with clean, standardized data
- Applies data typing, filtering, and business rules
- Implements primary/foreign key constraints

### Stage 3: Analytics Layer (`dbt_run_marts`)
- Builds 2 dimension tables and 1 fact table
- Customer segmentation and product performance metrics
- Daily order revenue aggregations

### Stage 4: Quality Assurance (`dbt_test`)
- Executes 28 comprehensive data tests
- Validates uniqueness, completeness, and referential integrity
- Ensures business rule compliance

## 🔍 Data Quality Tests

### Primary Key Tests (4)
- Unique customer_id, product_id, order_id, item_id

### Not-Null Tests (15)
- Critical fields across all tables

### Relationship Tests (4)  
- Foreign key integrity between tables

### Business Rule Tests (5)
- Order status validation
- Positive amounts and quantities
- Valid date ranges

## 📁 Project Structure

```
├── dbt_project.yml          # dbt configuration
├── profiles.yml             # Database connection
├── snowflake_env.sh         # Environment variables
├── setup_codespaces.sh      # Setup script
├── start_airflow_codespaces.sh  # Airflow startup
├── requirements.txt         # Python dependencies
├── dags/
│   └── advanced_dbt_snowflake_dag.py  # Airflow DAG
├── models/
│   └── example/
│       ├── schema.yml       # Data tests & documentation
│       ├── Staging/         # Staging models
│       │   ├── stg_customers.sql
│       │   ├── stg_products.sql  
│       │   ├── stg_orders.sql
│       │   └── stg_order_items.sql
│       └── marts/           # Analytics models
│           ├── dim_customers.sql
│           ├── dim_products.sql
│           └── fct_daily_order_revenue.sql
├── seeds/                   # Raw CSV data
├── analyses/                # Ad-hoc queries
├── tests/                   # Custom tests
└── screenshots/             # Documentation images
```

## 🧪 Testing

### Run All Tests
```bash
dbt test --profiles-dir .
```

### Test Specific Models
```bash
dbt test --select stg_customers --profiles-dir .
```

### Test Relationships
```bash
dbt test --select test_type:relationships --profiles-dir .
```

## 🔧 Configuration

### dbt Profiles (`profiles.yml`)
- Environment-based configuration
- Secure credential management via environment variables

### Airflow Configuration
- Sequential executor for development
- SQLite metadata database
- 5-minute retry delays

## � Troubleshooting

### Common Issues

**1. "Could not find profile named 'dbt_snowflake_airflow_etl_pipeline'"**
```bash
# Solution: Configure dbt profile
cp profiles_template.yml ~/.dbt/profiles.yml
# Edit ~/.dbt/profiles.yml with your Snowflake credentials
dbt debug  # Test connection
```

**2. "Connection failed" or Snowflake authentication errors**
```bash
# Check your credentials in both files:
nano snowflake_env.sh      # Environment variables
nano ~/.dbt/profiles.yml   # dbt profile

# Test connection
source snowflake_env.sh
dbt debug
```

**3. "Schema not found" or permission errors**
```bash
# Ensure your Snowflake user has proper permissions:
# - CREATE SCHEMA on database
# - CREATE TABLE on schemas  
# - SELECT/INSERT/UPDATE/DELETE on tables
```

**4. Airflow DAG not appearing**
```bash
# Check DAG syntax
python dags/advanced_dbt_snowflake_dag.py

# Restart Airflow services
./start_airflow_codespaces.sh
```

### Debug Commands
```bash
# Test dbt models individually
dbt run --models stg_customers
dbt test --models stg_customers

# Check Airflow configuration
airflow config list

# View detailed logs
tail -f airflow_home/logs/scheduler/latest
```

## �📊 Performance Metrics

- **Pipeline Runtime**: ~30 seconds end-to-end
- **Data Volume**: 1,010 records processed
- **Test Coverage**: 28 data quality validations
- **Success Rate**: 100% test pass rate

## 🏆 Best Practices Implemented

### Data Engineering
- ✅ Schema separation (raw → staging → marts)
- ✅ Proper naming conventions
- ✅ Incremental processing capabilities
- ✅ Data lineage documentation

### Software Engineering  
- ✅ Version control with Git
- ✅ Environment-based configuration
- ✅ Comprehensive testing
- ✅ Automated CI/CD pipeline

### Data Quality
- ✅ Input validation and cleansing
- ✅ Business rule enforcement
- ✅ Referential integrity checks
- ✅ Automated monitoring

## 🔄 Continuous Integration

The pipeline supports automated execution with:
- Scheduled DAG runs (daily)
- Manual trigger capability
- Error handling and retries
- Comprehensive logging

## 📚 Additional Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [Snowflake Documentation](https://docs.snowflake.com/)
- [Apache Airflow Documentation](https://airflow.apache.org/docs/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `dbt test --profiles-dir .`
5. Submit a pull request

## 📄 License

MIT License - see LICENSE file for details.

---

**Built with ❤️ for modern data engineering**
