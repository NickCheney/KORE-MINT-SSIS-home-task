/*
  Script Name: initialize_database.sql
  Description: This script creates the database, staging and production schemas and User tables if they don't exist.
  Author: Nick Cheney
  Date Created: 2024-07-25
  Version: 1.0
  Notes:
    - This script only needs to be run once prior to configuring the SSIS process.
*/

-- Check and create KoreAssignment_Nick_Cheney database if it does not exist
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'KoreAssignment_Nick_Cheney')
BEGIN
	CREATE DATABASE [KoreAssignment_Nick_Cheney];
END
GO

USE [KoreAssignment_Nick_Cheney]
GO

-- Check and create stg schema if it does not exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'stg')
BEGIN
	EXEC('CREATE SCHEMA stg');
END
GO

-- Check and create prod schema if it does not exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'prod')
BEGIN
	EXEC('CREATE SCHEMA prod');
END
GO

-- Check and create stg.Users table if it does not exist
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'stg.Users') AND type in (N'U'))
BEGIN
	CREATE TABLE stg.Users (
		StgID INT IDENTITY(1,1) PRIMARY KEY,
		UserID INT,
		FullName NVARCHAR(255),
		Age INT,
		Email NVARCHAR(255),
		RegistrationDate DATE,
		LastLoginDate DATE,
		PurchaseTotal FLOAT
	);
END
GO

-- Check and create prod.Users table if it does not exist
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'prod.Users') AND type in (N'U'))
BEGIN
	CREATE TABLE prod.Users (
		ID INT IDENTITY(1,1) PRIMARY KEY,
		UserID INT,
		FullName NVARCHAR(255),
		Age INT,
		Email NVARCHAR(255),
		RegistrationDate DATE,
		LastLoginDate DATE,
		PurchaseTotal FLOAT,
		RecordLastUpdated DATETIME DEFAULT GETDATE()
	);
END
GO
