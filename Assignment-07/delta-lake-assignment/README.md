Delta Lake MERGE Implementation using Databricks

--Objective:

The objective of this assignment was to understand how Delta Lake supports incremental data processing using the MERGE operation and to learn the implementation of Slowly Changing Dimensions (SCD Type 1 and SCD Type 2) in Databricks.

--Work Performed
Uploaded the Customer Master and Customer Incremental CSV datasets into Databricks.

Converted the datasets into Delta tables.

Standardized column names by replacing spaces and special characters with underscores to ensure compatibility with Delta Lake.

Created an incremental dataset containing:
Existing records with updated values to simulate updates.
New records with unique Row_IDs to simulate inserts.

Implemented SCD Type 1 using the Delta Lake MERGE operation, where existing records were updated and new records were inserted.

Implemented SCD Type 2 by maintaining historical versions of records using additional columns such as is_current, effective_date, and end_date.

Validated the results by verifying inserted records, updated records, and historical records.
Challenges Faced

Column names containing spaces and special characters caused MERGE errors and were standardized.

Date format inconsistencies between the master and incremental datasets resulted in data type conversion errors, which were resolved by applying the correct date parsing.

Ensuring identical schemas between the source and target Delta tables before performing the MERGE operation.


--Key Learnings
Understood the concept of incremental loading in Delta Lake.

Learned how the MERGE command performs UPDATE and INSERT operations in a single transaction.

Understood the difference between SCD Type 1 (overwrites existing data) and SCD Type 2 (preserves historical data).

Learned the importance of selecting the correct business key (Row_ID in this assignment) for performing MERGE operations.

Gained practical experience working with Delta tables in Databricks.


--Conclusion

This assignment provided hands-on experience with Delta Lake's MERGE functionality and Slowly Changing Dimensions. It improved my understanding of incremental data processing, data versioning, schema consistency, and common ETL challenges encountered in modern data engineering workflows.