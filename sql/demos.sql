-- DEMO 1: Aggregation pushed down to Snowflake
SELECT '--- DEMO 1: aggregate in Snowflake ---' AS demo;
SELECT
    region,
    COUNT(*) AS n_customers,
    SUM(lifetime_value) AS total_ltv,
    AVG(lifetime_value)::DECIMAL(12,2) AS avg_ltv
FROM snowflake_db.greybeam_schema.my_table
GROUP BY region
ORDER BY total_ltv DESC;

-- DEMO 2: JOIN Snowflake table with a LOCAL CSV
SELECT '--- DEMO 2: join Snowflake + local CSV ---' AS demo;
SELECT
    s.customer_id,
    s.customer_name,
    s.region,
    s.lifetime_value,
    r.priority,
    r.sales_rep
FROM snowflake_db.greybeam_schema.my_table AS s
JOIN read_csv_auto('C:\Users\DELL\Downloads\queringSnowflakeDataintoDuckdb\local_regions.csv') AS r
  ON r.region = s.region
ORDER BY r.priority, s.lifetime_value DESC;

-- DEMO 3: Materialize Snowflake results locally
SELECT '--- DEMO 3: materialize Snowflake table locally ---' AS demo;
CREATE OR REPLACE TABLE local_customers AS
SELECT * FROM snowflake_db.greybeam_schema.my_table;

SELECT 'rows_materialized: ' || COUNT(*)::VARCHAR AS info FROM local_customers;

SELECT region, SUM(lifetime_value) AS total_ltv
FROM local_customers GROUP BY region ORDER BY total_ltv DESC;