-- Boot script: load extension + create session secret + attach Snowflake.
-- Run with:  duckdb duckdb_playground.duckdb -init connect.sql
-- or, from inside an open duckdb session: .read connect.sql

LOAD snowflake;

-- Session-scoped secret. v0.1.0 of the extension can't re-bind PERSISTENT secrets
-- on a fresh session, so we recreate it every time.
CREATE OR REPLACE SECRET snow_keypair (
    TYPE snowflake,
    ACCOUNT 'A6928236199671-AIDAPT_CHILD',
    USER 'AIDAPT_ALI',
    AUTH_TYPE 'key_pair',
    PRIVATE_KEY 'C:/Users/DELL/Downloads/queringSnowflakeDataintoDuckdb/keys/snowflake_rsa_key.p8',
    PRIVATE_KEY_PASSPHRASE '4KIqtlFx0cas5vIi0Gn8yi5zGQq6QqNa',
    DATABASE 'DUCKDB_PLAYGROUND',
    WAREHOUSE 'ALI_PROJECT_WH'
);

-- Re-attach only if not already attached
ATTACH IF NOT EXISTS '' AS snowflake_db (
    TYPE snowflake,
    SECRET snow_keypair,
    READ_ONLY,
    enable_pushdown true
);

SELECT 'snowflake_db attached' AS status;
