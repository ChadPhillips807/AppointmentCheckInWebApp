USE [master]
GO
/****** Object:  Database [HealthcareDB]    Script Date: 2/6/2014 11:54:16 AM ******/
CREATE DATABASE [HealthcareDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HealthcareDB', FILENAME = N'C:\databases\HealthcareDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HealthcareDB_log', FILENAME = N'E:\Databases\SQLMainDBs\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\HealthcareDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HealthcareDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HealthcareDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HealthcareDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HealthcareDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HealthcareDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HealthcareDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HealthcareDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [HealthcareDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HealthcareDB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [HealthcareDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HealthcareDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HealthcareDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HealthcareDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HealthcareDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HealthcareDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HealthcareDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HealthcareDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HealthcareDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HealthcareDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HealthcareDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HealthcareDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HealthcareDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HealthcareDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HealthcareDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HealthcareDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HealthcareDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HealthcareDB] SET  MULTI_USER 
GO
ALTER DATABASE [HealthcareDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HealthcareDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HealthcareDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HealthcareDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [HealthcareDB]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 2/6/2014 11:54:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentId] [int] IDENTITY(1,1) NOT NULL,
	[PatientId] [int] NOT NULL,
	[DoctorId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Status] [bit] NOT NULL,
 CONSTRAINT [PK_Appointments] PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 2/6/2014 11:54:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 2/6/2014 11:54:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[DoctorId] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_Doctors] PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Patients]    Script Date: 2/6/2014 11:54:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[PatientId] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
 CONSTRAINT [PK_Patients] PRIMARY KEY CLUSTERED 
(
	[PatientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PhoneNumbers]    Script Date: 2/6/2014 11:54:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhoneNumbers](
	[PhoneId] [int] IDENTITY(1,1) NOT NULL,
	[ContactId] [int] NOT NULL,
	[PhoneNum] [nvarchar](12) NOT NULL,
 CONSTRAINT [PK_PhoneNumbers] PRIMARY KEY CLUSTERED 
(
	[PhoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Doctors] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[Doctors] ([DoctorId])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Doctors]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Patients] FOREIGN KEY([PatientId])
REFERENCES [dbo].[Patients] ([PatientId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Patients]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [FK_Doctors_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contacts] ([ContactId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [FK_Doctors_Contacts]
GO
ALTER TABLE [dbo].[Patients]  WITH CHECK ADD  CONSTRAINT [FK_Patients_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contacts] ([ContactId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Patients] CHECK CONSTRAINT [FK_Patients_Contacts]
GO
ALTER TABLE [dbo].[PhoneNumbers]  WITH CHECK ADD  CONSTRAINT [FK_PhoneNumbers_Contacts] FOREIGN KEY([ContactId])
REFERENCES [dbo].[Contacts] ([ContactId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PhoneNumbers] CHECK CONSTRAINT [FK_PhoneNumbers_Contacts]
GO
USE [master]
GO
ALTER DATABASE [HealthcareDB] SET  READ_WRITE 
GO

/*
	The below SQL code was written by Chad Phillips
	
	The statements enter data into the HealthcareDB database's tables. 
	Below the insert statements are a few commented out statements to 
	assist with querying the tables and dropping the database.

	INSERT Data into HealthcareDB script begins below
*/

USE HealthCareDB;
GO

-- Fills Contacts tbl with test data.
INSERT INTO Contacts (FirstName, LastName)
VALUES ('John', 'Candy') -- ContactId 1, Patient
, ('Steve', 'Martin') -- ContactId 2, Dr.
, ('Chevy', 'Chase') -- ContactId 3, Patient
, ('Bill', 'Murray') -- ContactId 4, Dr.
, ('Richard', 'Pryor'); -- ContactId 5, Patient 

-- Fills Patients tbl with test data.
INSERT INTO Patients (ContactId)
VALUES (1)
, (3)
, (5);

-- Fills Doctors tbl with data.
INSERT INTO Doctors (ContactId)
VALUES (2)
, (4);

-- Fills PhoneNumbers tbl with data.
INSERT INTO PhoneNumbers (ContactId, PhoneNum)
VALUES (1, '425-890-5535')
, (2, '425-256-2573')
, (3, '808-422-2222')
, (4, '808-533-3333')
, (5, '253-425-8070');

-- This var holds today's date for filling the tbl with relevant datetimes
DECLARE @TodaysDate datetime = GETDATE();

-- Fills Appointments tbl with data.
-- None of the patients are checked in
INSERT INTO Appointments (PatientId, DoctorId, DateTime, Status)
VALUES (1, 2, @TodaysDate, 0)
,(2, 1, @TodaysDate, 0)
,(3, 2, @TodaysDate, 0);

GO

--------------------------------------------------------------
/* 
	The below DELETE statement will remove all 
	the data from the tbls in HealthcareDB. 
	
	Uncomment to use.
*/
--DELETE FROM CONTACTS;
--GO

--------------------------------------------------------------
/*
	Use the below statements to verify that data
	is or isn't present in the tbls.
*/
--SELECT * FROM Contacts;
--SELECT * FROM Patients;
--SELECT * FROM Doctors;
--SELECT * FROM PhoneNumbers;
--SELECT * FROM Appointments;
--------------------------------------------------------------

/*
	The following drop statements:
		- Sever all connections to HealthcareDB so it can be dropped.
		- & DROP the database.
*/
--ALTER DATABASE HealthcareDB
--SET RESTRICTED_USER
--WITH ROLLBACK IMMEDIATE;
--GO

--DROP DATABASE HealthCareDB;
--GO
