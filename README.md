# Subscription Revenue Analysis Project Overview

Welcome to the Subscription Revenue Analysis project. This project streamlines the analysis of subscription-based revenue, churn, and transactional data using modern data stack tools.

## Introduction

- **Purpose**: Analyze and understand subscription data to optimize revenue.
- **Tools Used**: dbt for data transformation, Snowflake as the data warehouse, Metabase for visualization.
- **Key Metrics**: Monthly Recurring Revenue (MRR), customer churn, payment success rates, customer segments.

## Dbt Project Structure

The project's directory structure organizes the data models and tests as follows:

- `/models`
  - Core business logic and data transformations reside here.
  - `/core` - SQL models calculating MRR and churn.
  - `/dim` - Dimension models for customer data.
  - `/fct` - Fact tables for transaction data.
  - `/mart` - Data mart for aggregated analytical views.
- `/snapshots`
  - Capture and store historical data changes.
- `/tests`
  - Custom data validation and integrity checks.
- `/analysis`
  - Contains ad-hoc SQL analysis scripts.
- `schema.yml`
  - Define and test the structure of the data models.

## Workflow

The data workflow moves from ingestion to visualization:

1. **Data Ingestion**: CSVs are processed and loaded into Snowflake.
2. **Transformation**: Using dbt, raw data is transformed into analytical models.
3. **Visualization**: Metabase dashboards are used to visualize and derive insights.

![workflow](/assets/workflow.png "Project Workflow")

## Data Lineage

Data lineage illustrates the data's journey through our analytical pipeline, ensuring traceability and transparency from source to insight.

## Metabase Dashboard Analysis

Our Metabase dashboards allow for interactive and dynamic analysis of the transformed data, covering areas such as:

- Trends and patterns in revenue and churn.
- Analysis of revenue and customer changes over time
- Analysis customer payments events broken down w.r.t transaction success rates as well as customer segments

## References

This dbt project is an extension of sample dbt projects example to
modeling the subscription revenue. **The reference article can be found [here](https://blog.getdbt.com/modeling-subscription-revenue/)
**

Note: The mrr models used in the reference [repo](https://github.com/dbt-labs/mrr-playbook)
have been updated with subscription snapshots to incorporate SCDs in customer
subscriptions in the dbt analysis. The customer dimensions and payment events analysis
has been added as an extension to the base project.

## Future Directions and Insights

This project paves the way for further development, including:

- Predictive modeling for forecasting future trends.
- Customer behavior analysis for enhanced targeting and retention strategies.
- Expansion of the data mart for deeper multi-dimensional analysis.

## Optimisations

- Updating materializations in the DWH according to data usage requirements
- Add sophisticated test to continuously ensure data quality and add modularization through using reusable macros throughout the project
- Adjusting dbt configuration parameters to increase scalability and performance.
- Upgrade the project environment to staging and production after development and testing
- Productionize the project as well as dbt documentation using docker containers
