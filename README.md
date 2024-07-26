# KORE-MINT-SSIS-home-task

## Process
First, the user should launch an instance of SQL Server locally, then clone this repository and
run the initialize_database.sql script to set up the database.

I designed the ETL process using Visual Studio with the SSIS project integration, so they should
then download that if they don't have it installed. Next, they should be able to open the solution 
from the SSIS_ETL directory.

Finally, you will need to update the connection managers in the SSIS_ETL project accordingly to
point to your database, and the path in backup_prod_table.sql.

Then, the user should be about to start the process from Visual Studio, and see the rows updated
in the prod.Users table afterwards. They can also use Visual Studio to deploy the process as a 
package to the database instance and run it directly there. I did so using SSMS.

The data source is set to use SSIS_ETL/users.csv, but can be changed as needed in the second
step of the SSIS control flow.

Rows that are filtered out for data errors or duplications on UserID or Email are sent to 
SSIS_ETL/data_sources/error_records.csv for further review.

## Error handling
Error handling in the package happens in 2 stages. First, the columns from the input
flat file are converted into their correct types, and nullable fields are included,
converting empty strings and "null" strings into NULL datatypes. For this assignment,
I decided that only the UserID, FullName and Email are required fields, so if they
contain nulls they will be filtered out at this stage. Also rows with certain 
incorrect values are also filtered out here, such as negative numerical values,
invalid dates and duplicates across all columns.

Next, the remaining rows are loaded into an empty staging table, and further data
cleaning occurs. Records with duplicate emails or UserIDs within the staging table are filtered
out as they are ambiguous, and rows with an email belonging to a different UserID in the production
table are also removed.

Other records are filtered out of they:
- Have a data field before 1970 or after today
- Have a LastLoginDate less than their RegistrationDate
- Have a PurchaseTotal above 100000
- Have an email not following the *@*.* format (could be further narrowed down later)