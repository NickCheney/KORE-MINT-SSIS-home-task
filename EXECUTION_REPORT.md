# Outcomes
Overall, the ETL process is easy to use and can be modified at each stage.
In the future, some variables could be parametrized, like the staging record cleaning SQL
to reduce redundacy.

## Number of records successfully processed 
Overall, 24/33 records made their way into the production table.

## Excluded Records
Please see SSIS_ETL/data_sources/error_records.csv for a list of excluded records.
These records all fail data conversion or the other data cleaning criteria specified
in README.md.

## Challenges Faced
My biggest challenges were debugging the type casting, for example when converting
empty strings into NULLS. I realized some NULLs were missed as a result of remaining
quotes in the "empty" strings, so I added a clause to remove those after looking
closely.