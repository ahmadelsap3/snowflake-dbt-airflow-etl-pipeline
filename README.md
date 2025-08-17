# dbt + Snowflake + Airflow ETL Pipeline

**Final Project - Data Warehouse Concepts and Lakehouse Architecture Course**  
Information Technology Institute (ITI) - Data Engineering Round 1 2025/2026  
Port Said Branch

---

A complete modern data pipeline using dbt, Snowflake, and Apache Airflow for ETL orchestration, demonstrating advanced data warehouse concepts and lakehouse architecture patterns.

##  System Architecture

![Pipeline Architecture](screenshots/architecture.jpg)

*Complete ETL pipeline architecture showing data flow from raw sources through transformation layers to business-ready analytics*

## 🚀 Quick Start with GitHub Codespaces

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/ahmadelsap3/dbt-snowflake-airflow-etl-pipeline)

1. **Open in Codespaces** - Click the button above
2. **Run setup script**: `bash setup_codespaces.sh`
3. **Configure Snowflake credentials** (see below)
4. **Run the pipeline**

## 📋 Project Structure

```
├── dags/                      # Airflow DAGs
├── models/                    # dbt models
│   ├── staging/              # Staging layer (raw data cleanup)
│   └── marts/                # Business logic layer
├── seeds/                     # Raw CSV data
├── tests/                     # dbt tests
├── dataset(raw)/             # Source data files
├── screenshots/              # Project screenshots
├── .devcontainer/            # GitHub Codespaces configuration
├── dbt_project.yml           # dbt project configuration
├── requirements.txt          # Python dependencies
└── profiles_template.yml     # Snowflake connection template
```

## 🎓 Academic Context

This project demonstrates key concepts from the Data Warehouse and Lakehouse Architecture course:

- **Medallion Architecture**: Bronze → Silver → Gold data layers
- **ELT vs ETL**: Modern Extract-Load-Transform paradigm
- **Data Lineage**: Complete traceability from source to consumption
- **Data Quality**: Automated testing and validation
- **Orchestration**: Workflow management with Apache Airflow
- **Cloud Data Warehousing**: Snowflake as modern DWH solution
- **Infrastructure as Code**: Containerized development environment

## 🔧 Setup Instructions

### 1. Configure Snowflake Connection

Copy the template and add your credentials:
```bash
cp profiles_template.yml profiles.yml
```

Edit `profiles.yml` with your Snowflake details:
```yaml
dbt_snowflake_airflow_etl_pipeline:
  outputs:
    dev:
      account: YOUR_SNOWFLAKE_ACCOUNT    # e.g., ACHAMLP-CK87481
      database: finance_db
      role: ACCOUNTADMIN
      schema: raw
      threads: 4
      type: snowflake
      user: YOUR_SNOWFLAKE_USER          # e.g., AHMEDELSAB3
      warehouse: FINANCE_WH
      password: "YOUR_SNOWFLAKE_PASSWORD"
  target: dev
```

### 2. Test dbt Connection

```bash
dbt debug --profiles-dir .
```

### 3. Run the Pipeline

```bash
# Load raw data
dbt seed --profiles-dir .

# Run transformations
dbt run --profiles-dir .

# Run tests
dbt test --profiles-dir .

# Generate documentation
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir . --port 8081
```

### 4. Start Airflow

```bash
# Terminal 1: Webserver
airflow webserver --port 8080

# Terminal 2: Scheduler
airflow scheduler
```

## 🌐 Web Interfaces

- **Airflow UI**: http://localhost:8080 (admin/admin)
- **dbt Documentation**: http://localhost:8081

## 📊 Data Pipeline Architecture

The pipeline implements a modern lakehouse architecture with three distinct layers:

### Bronze Layer (Raw Data)
- **Seeds**: Raw CSV files loaded directly into Snowflake
- **Source Tables**: `customers`, `orders`, `order_items`, `products`
- **Characteristics**: Unprocessed, historical, append-only

### Silver Layer (Staging Models)  
- **Purpose**: Data cleaning, standardization, and basic transformations
- **Models**: `stg_customers`, `stg_orders`, `stg_order_items`, `stg_products`
- **Materialization**: Views for cost optimization
- **Transformations**: Column renaming, data type casting, basic validation

### Gold Layer (Mart Models)
- **Purpose**: Business-ready, aggregated data for analytics
- **Models**: `fct_daily_order_revenue`
- **Materialization**: Tables for performance
- **Business Logic**: Complex calculations, KPIs, dimensional modeling

### Data Flow
```
CSV Files → Seeds (Bronze) → Staging Models (Silver) → Mart Models (Gold)
```

## 🏗️ Technology Stack

- **dbt**: Data transformation and modeling framework
- **Snowflake**: Cloud-native data warehouse
- **Apache Airflow**: Workflow orchestration platform
- **GitHub Codespaces**: Cloud development environment
- **Python**: Orchestration and automation scripting

## 🔍 Key Features Demonstrated

- ✅ **Modern ELT Pipeline**: Extract-Load-Transform paradigm
- ✅ **Medallion Architecture**: Bronze-Silver-Gold data layers
- ✅ **Data Quality Testing**: Automated validation with dbt tests
- ✅ **Data Lineage**: Complete dependency mapping
- ✅ **Documentation**: Auto-generated technical documentation
- ✅ **Orchestration**: DAG-based workflow management
- ✅ **Cloud-Native**: Serverless and scalable architecture
- ✅ **DevOps Ready**: Containerized development environment

## 🧪 Data Quality & Testing

Comprehensive testing strategy includes:
- **Schema Tests**: Uniqueness, not-null constraints
- **Data Tests**: Accepted values, referential integrity  
- **Custom Tests**: Business rule validations
- **Continuous Testing**: Automated execution in pipeline

## 📈 Business Value

This pipeline processes e-commerce data to deliver:
- **Customer Analytics**: Segmentation and behavior insights
- **Revenue Metrics**: Daily, monthly, and product-level revenue
- **Operational KPIs**: Order fulfillment and inventory metrics
- **Data Governance**: Quality, lineage, and documentation

## 📝 Course Requirements Fulfilled

- ✅ **Data Warehouse Design**: Star/snowflake schema implementation
- ✅ **ETL/ELT Processes**: Modern transformation patterns
- ✅ **Data Quality**: Testing and validation frameworks
- ✅ **Cloud Technologies**: Snowflake and containerization
- ✅ **Orchestration**: Workflow automation and scheduling
- ✅ **Documentation**: Technical and business documentation

## 👨‍🎓 Student Information

**Course**: Data Warehouse Concepts and Lakehouse Architecture  
**Institution**: Information Technology Institute (ITI)  
**Program**: Data Engineering Round 1 2025/2026  
**Branch**: Port Said  
**Project Type**: Final Project

---

*This project demonstrates practical application of data warehousing concepts learned during the ITI Data Engineering program, showcasing industry-standard tools and best practices for modern data pipeline development.*




