/*
  Script Name: clean_staging_table.sql
  Description: This script removes staging table rows that don't meet data quality requirements 
  Author: Nick Cheney
  Date Created: 2024-07-25
  Version: 1.0
  Notes:
    - This script is run as part of the SSIS process.
    - See README.md for a description of bad record criteria
*/

BEGIN
DELETE FROM stg.Users
WHERE age NOT BETWEEN 1 AND 150
	OR LastLoginDate NOT BETWEEN '1970-01-01' and GETDATE()
	OR RegistrationDate NOT BETWEEN '1970-01-01' and GETDATE()
	OR RegistrationDate > LastLoginDate
	OR PurchaseTotal >= 100000
	OR Email NOT LIKE '%@%.%'
	OR UserID IN (
		SELECT UserID FROM stg.Users GROUP BY UserID HAVING COUNT(*) > 1
	)
	OR Email IN (
		SELECT Email FROM stg.Users GROUP BY Email HAVING COUNT(*) > 1
	)
	OR EXISTS (
		SELECT * from prod.Users prodU WHERE prodU.Email = Email and prodU.UserID <> UserID
	);
END