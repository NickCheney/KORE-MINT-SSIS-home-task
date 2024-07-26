/*
  Script Name: backup_prod_table.sql
  Description: This script writes a backup of the production table to a .bak file
  Author: Nick Cheney
  Date Created: 2024-07-25
  Version: 1.0
  Notes:
    - This script is run as part of the SSIS process.
    - The disk path can be changed as neccessary
*/

BEGIN
BACKUP DATABASE KoreAssignment_Nick_Cheney
TO DISK = 'C:\Users\niche\Documents\Coding\Personal Projects\KORE-MINT-SSIS-home-task\db\KoreAssignment_Nick_Cheney.bak'
END
GO