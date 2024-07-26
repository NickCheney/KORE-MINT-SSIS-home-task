/*
  Script Name: update_prod_table.sql
  Description: This script merges the staging table into the production table when ready
  Author: Nick Cheney
  Date Created: 2024-07-25
  Version: 1.0
  Notes:
    - This script is run as part of the SSIS package.
*/

BEGIN
MERGE INTO prod.Users AS target
USING stg.Users AS source
ON target.UserID = source.UserID

-- When a match is found, update the existing row in prod.Users 
WHEN MATCHED THEN
    UPDATE SET 
        target.FullName = source.FullName,
        target.Age = source.Age,
        target.Email = source.Email,
        target.RegistrationDate = source.RegistrationDate,
		target.LastLoginDate = source.LastLoginDate,
		target.PurchaseTotal = source.PurchaseTotal

-- When no match is found, insert a new row into prod.Users
WHEN NOT MATCHED BY TARGET THEN
    INSERT (UserID, FullName, Age, Email, RegistrationDate, LastLoginDate, PurchaseTotal)
    VALUES (source.UserID, source.FullName, source.Age, source.Email, source.RegistrationDate, source.LastLoginDate, source.PurchaseTotal);
END
GO