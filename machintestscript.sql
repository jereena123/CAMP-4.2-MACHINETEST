USE [master]
GO
/****** Object:  Database [Flight1_db]    Script Date: 28-08-2024 03:50:35 ******/
CREATE DATABASE [Flight1_db]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Flight1_db', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Flight1_db.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Flight1_db_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Flight1_db_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Flight1_db] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Flight1_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Flight1_db] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Flight1_db] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Flight1_db] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Flight1_db] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Flight1_db] SET ARITHABORT OFF 
GO
ALTER DATABASE [Flight1_db] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Flight1_db] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Flight1_db] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Flight1_db] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Flight1_db] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Flight1_db] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Flight1_db] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Flight1_db] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Flight1_db] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Flight1_db] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Flight1_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Flight1_db] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Flight1_db] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Flight1_db] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Flight1_db] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Flight1_db] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Flight1_db] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Flight1_db] SET RECOVERY FULL 
GO
ALTER DATABASE [Flight1_db] SET  MULTI_USER 
GO
ALTER DATABASE [Flight1_db] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Flight1_db] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Flight1_db] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Flight1_db] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Flight1_db] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Flight1_db] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Flight1_db', N'ON'
GO
ALTER DATABASE [Flight1_db] SET QUERY_STORE = ON
GO
ALTER DATABASE [Flight1_db] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Flight1_db]
GO
/****** Object:  Table [dbo].[Airport]    Script Date: 28-08-2024 03:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airport](
	[AirportCode] [varchar](10) NOT NULL,
	[AirportName] [varchar](100) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AirportCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flight]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight](
	[FlightId] [int] NOT NULL,
	[DepartureAirport] [varchar](10) NOT NULL,
	[DepartureDate] [date] NOT NULL,
	[DepartureTime] [time](7) NOT NULL,
	[ArrivalAirport] [varchar](10) NOT NULL,
	[ArrivalDate] [date] NOT NULL,
	[ArrivalTime] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FlightId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](20) NOT NULL,
	[Password] [varchar](20) NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Airport] ([AirportCode], [AirportName], [City], [Country]) VALUES (N'K01', N'ALASKAAirport', N'New York', N'USA')
INSERT [dbo].[Airport] ([AirportCode], [AirportName], [City], [Country]) VALUES (N'K02', N'N Airport', N'London', N'UK')
GO
INSERT [dbo].[Flight] ([FlightId], [DepartureAirport], [DepartureDate], [DepartureTime], [ArrivalAirport], [ArrivalDate], [ArrivalTime]) VALUES (1, N'K01', CAST(N'2024-02-11' AS Date), CAST(N'08:00:00' AS Time), N'K02', CAST(N'2024-02-11' AS Date), CAST(N'20:00:00' AS Time))
INSERT [dbo].[Flight] ([FlightId], [DepartureAirport], [DepartureDate], [DepartureTime], [ArrivalAirport], [ArrivalDate], [ArrivalTime]) VALUES (2, N'K02', CAST(N'2022-09-02' AS Date), CAST(N'10:00:00' AS Time), N'K01', CAST(N'2022-09-02' AS Date), CAST(N'13:00:00' AS Time))
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Administrator')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [UserName], [Password], [RoleId]) VALUES (1, N'jereena', N'jereena@1', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD FOREIGN KEY([ArrivalAirport])
REFERENCES [dbo].[Airport] ([AirportCode])
GO
ALTER TABLE [dbo].[Flight]  WITH CHECK ADD FOREIGN KEY([DepartureAirport])
REFERENCES [dbo].[Airport] ([AirportCode])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
/****** Object:  StoredProcedure [dbo].[sp_AddFlight]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AddFlight]
    @DepAirport NVARCHAR(10),
    @DepDate DATE,
    @DepTime TIME,
    @ArrAirport NVARCHAR(10),
    @ArrDate DATE,
    @ArrTime TIME
AS
BEGIN
    INSERT INTO Flight (DepartureAirport, DepartureDate, DepartureTime, ArrivalAirport, ArrivalDate, ArrivalTime)
    VALUES (@DepAirport, @DepDate, @DepTime, @ArrAirport, @ArrDate, @ArrTime);
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetFlightById]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetFlightById]
    @FlightId INT
AS
BEGIN
    SELECT FlightId,DepartureAirport, DepartureDate, DepartureTime, ArrivalAirport, ArrivalDate, ArrivalTime
    FROM Flight
    WHERE FlightId = @FlightId;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserNamePasswords]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserNamePasswords]
			
    @UserName VARCHAR(20),
    @Password VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    
    SELECT 
        u.[UserId],
        u.[UserName],
        r.[RoleName]
    FROM [dbo].[User] u
    INNER JOIN [dbo].[Role] r ON u.[RoleId] = r.[RoleId]
    WHERE u.[UserName] = @UserName
      AND u.[Password] = @Password;
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ListAllFlights]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ListAllFlights]
AS
BEGIN
    SELECT FlightId, DepartureAirport, DepartureDate, DepartureTime, ArrivalAirport, ArrivalDate, ArrivalTime
    FROM Flight;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateFlight]    Script Date: 28-08-2024 03:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateFlight]
    @FlightId INT,
    @DepAirport NVARCHAR(10),
    @DepDate DATE,
    @DepTime TIME,
    @ArrAirport NVARCHAR(10),
    @ArrDate DATE,
    @ArrTime TIME
AS
BEGIN
    UPDATE Flight
    SET DepartureAirport = @DepAirport,
        DepartureDate = @DepDate,
        DepartureTime = @DepTime,
        ArrivalAirport = @ArrAirport,
        ArrivalDate = @ArrDate,
        ArrivalTime = @ArrTime
    WHERE FlightId = @FlightId;
END;

GO
USE [master]
GO
ALTER DATABASE [Flight1_db] SET  READ_WRITE 
GO
