USE [SocietySquare]
GO
/****** Object:  StoredProcedure [dbo].[CalculateMaintenance]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Akshay Kulkarni>
-- Create date: <Create Date,27/12/2014>
-- Description:	<Description,calculate monthly maintenance of society>
-- EXEC  [dbo].[CalculateMaintenance] 'Residential'
-- =============================================
CREATE PROCEDURE [dbo].[CalculateMaintenance]
	-- Add the parameters for the stored procedure here
	@PropertyType varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @TableName varchar(50),@PropertyID varchar(10)
	IF (@PropertyType = 'Residential')
	BEGIN
		SET @TableName = 'ResidentialMaintenance'
		SET @PropertyID = 'FlatId'
	END	
	ELSE
	BEGIN
		SET @TableName = 'CommercialMaintenance'
		SET @PropertyID = 'ShopId'
	END	

	EXEC('
		DECLARE @EffectiveFrom Datetime, @EffectiveTo Datetime

		SET @EffectiveFrom = CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))-1),DATEADD(mm,1,GETDATE())),120) 
		SET @EffectiveTo = CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,@EffectiveFrom))),DATEADD(mm,1,@EffectiveFrom)),120)
	
		-- Insert statements for procedure here
		INSERT INTO '+@TableName+' ('+@PropertyID+',MaintenanceID,EffectiveFrom,EffectiveTo,Amount,AmountBalance,Active,CreatedBy,CreatedOn)
		SELECT a.FlatId,b.MaintenanceID,@EffectiveFrom,@EffectiveTo,
		CASE WHEN CalculationMethodID = 1 THEN CASE WHEN IsRented = 1 THEN CEILING(MaintenancePerFlat + TenantMaintenance) ELSE CEILING(MaintenancePerFlat) END   -- Fixed Monthly Fee
			 WHEN CalculationMethodID = 2 THEN CEILING(PerSquareFeetRate * a.TotalArea) -- Per Square Feet Rate
			 WHEN CalculationMethodID = 3 THEN CEILING((FixedRate * FixedSqft) + (AdditionalSqftRate * (TotalArea - FixedSqft)))  --Partial Flat Rate
			 --WHEN CalculationMethod = 4 THEN 
		ELSE 0.00 END AMOUNT ,
		CASE WHEN CalculationMethodID = 1 THEN CASE WHEN IsRented = 1 THEN CEILING(MaintenancePerFlat + TenantMaintenance) ELSE CEILING(MaintenancePerFlat) END   -- Fixed Monthly Fee
			 WHEN CalculationMethodID = 2 THEN CEILING(PerSquareFeetRate * a.TotalArea) -- Per Square Feet Rate
			 WHEN CalculationMethodID = 3 THEN CEILING((FixedRate * FixedSqft) + (AdditionalSqftRate * (TotalArea - FixedSqft)))  --Partial Flat Rate
			 --WHEN CalculationMethod = 4 THEN 
		ELSE 0.00 END AmountBalance
		 ,1 Active,''AUTOJOB'' CreatedBy,GETDATE() CreatedOn
		FROM FlatMaster a
		INNER JOIN MaintenanceMaster b ON b.Active=1 AND EffectiveToDate =''1900-01-01 00:00:00.000'' AND a.PropertyType ='''+@PropertyType+'''
		INNER JOIN MaintenanceCaltypeMaster c ON b.CalculationMethodID = c.CalcMasterID
		WHERE CONVERT(varchar(10),b.EffectiveFromDate,120) <= CONVERT(varchar(10),@EffectiveFrom,120)
	')
END
GO
/****** Object:  Table [dbo].[BuildingMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BuildingMaster](
	[BuildingId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Floors] [int] NOT NULL,
	[Flats] [int] NOT NULL,
	[TotalArea] [int] NULL,
	[AminityId] [int] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_BuildingMaster] PRIMARY KEY CLUSTERED 
(
	[BuildingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BuildingMaster] ON
INSERT [dbo].[BuildingMaster] ([BuildingId], [Name], [Floors], [Flats], [TotalArea], [AminityId], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (15, N'Sai-A', 6, 10, 6000, NULL, 1, N'admin', CAST(0x0000A42100DA4D6A AS DateTime), NULL, NULL)
INSERT [dbo].[BuildingMaster] ([BuildingId], [Name], [Floors], [Flats], [TotalArea], [AminityId], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (16, N'Sai-B', 10, 15, 6700, NULL, 1, N'admin', CAST(0x0000A42100F31605 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[BuildingMaster] OFF
/****** Object:  Table [dbo].[BasicInformation]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BasicInformation](
	[BasicinfoID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[MaidenName] [varchar](50) NULL,
	[Gender] [varchar](10) NULL,
	[Birthday] [datetime] NULL,
	[Relationship] [varchar](20) NULL,
	[OtherName] [varchar](50) NULL,
	[Interests] [varchar](250) NULL,
	[ImagePath] [varchar](150) NULL,
	[Tagline] [varchar](150) NULL,
	[Occupation] [varchar](100) NULL,
	[AboutUs] [nvarchar](500) NULL,
	[WorkSkills] [varchar](200) NULL,
	[WebsiteUrl] [varchar](100) NULL,
	[Facebook] [varchar](100) NULL,
	[Twitter] [varchar](100) NULL,
	[GooglePlus] [varchar](100) NULL,
	[LinkedIn] [varchar](100) NULL,
	[Pincode] [int] NULL,
	[Place] [varchar](50) NULL,
	[Latitude] [nvarchar](50) NULL,
	[Longitude] [nvarchar](50) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_BasicInformation] PRIMARY KEY CLUSTERED 
(
	[BasicinfoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[BasicInformation] ON
INSERT [dbo].[BasicInformation] ([BasicinfoID], [ID], [FirstName], [LastName], [MaidenName], [Gender], [Birthday], [Relationship], [OtherName], [Interests], [ImagePath], [Tagline], [Occupation], [AboutUs], [WorkSkills], [WebsiteUrl], [Facebook], [Twitter], [GooglePlus], [LinkedIn], [Pincode], [Place], [Latitude], [Longitude], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [Active]) VALUES (20, 3, N'NULL', N'NULL', N'dadad', N'Male', CAST(0x0000A43800000000 AS DateTime), N'Married', N'NULL', N'tttfsfs', NULL, N'dada', N'adada', N'dddfs daada dada&nbsp; gsgfsfsfs dadada dadada ada dadaddadf', NULL, N'NULL', N'http://www.Facebook.com/NULL', N'http://www.Twittter.com/', N'http://www.Google.com/', N'http://www.linkedin.', NULL, NULL, NULL, NULL, NULL, CAST(0x0000A437010D5956 AS DateTime), N'pranav', CAST(0x0000A43B00DD342C AS DateTime), 1)
INSERT [dbo].[BasicInformation] ([BasicinfoID], [ID], [FirstName], [LastName], [MaidenName], [Gender], [Birthday], [Relationship], [OtherName], [Interests], [ImagePath], [Tagline], [Occupation], [AboutUs], [WorkSkills], [WebsiteUrl], [Facebook], [Twitter], [GooglePlus], [LinkedIn], [Pincode], [Place], [Latitude], [Longitude], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [Active]) VALUES (1017, 2, N'pranav', N'dada', N'dada', N'Male', CAST(0x0000A44300000000 AS DateTime), N'Married', N'ddd', N'dadad', N'2mail.png', N'dadadad', N'adad', N'adadadad dadada', NULL, N'www.abc.com', N'www.abc.com', N'www.abc.com', N'www.abc.com', N'www.abc.com', NULL, NULL, NULL, NULL, N'admin', CAST(0x0000A43A00D4A9DE AS DateTime), N'admin', CAST(0x0000A46100B91483 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[BasicInformation] OFF
/****** Object:  Table [dbo].[AminityMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AminityMaster](
	[AminityId] [int] IDENTITY(1,1) NOT NULL,
	[BuildingId] [int] NOT NULL,
	[Gymnasium] [bit] NOT NULL,
	[GymDesc] [varchar](1000) NULL,
	[Parking] [bit] NOT NULL,
	[ParkingDesc] [varchar](1000) NULL,
	[Lift] [bit] NOT NULL,
	[LiftDesc] [varchar](1000) NULL,
	[CCTV] [bit] NOT NULL,
	[CCTVDesc] [varchar](1000) NULL,
	[InterCom] [bit] NOT NULL,
	[IntercomDesc] [varchar](1000) NULL,
	[Security] [bit] NOT NULL,
	[SecurityDesc] [varchar](1000) NULL,
	[GeneratorBkp] [bit] NOT NULL,
	[GeneratorDesc] [varchar](1000) NULL,
	[CommunityHall] [bit] NOT NULL,
	[CommunityDesc] [varchar](1000) NULL,
	[SwimmingPool] [bit] NOT NULL,
	[SwimmingDesc] [varchar](1000) NULL,
	[Chairs] [bit] NOT NULL,
	[ChairsDesc] [varchar](1000) NULL,
	[Tables] [bit] NOT NULL,
	[TablesDesc] [varchar](1000) NULL,
	[MusicSystem] [bit] NOT NULL,
	[MusicSysDesc] [varchar](1000) NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_AminityMaster] PRIMARY KEY CLUSTERED 
(
	[AminityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[AminityMaster] ON
INSERT [dbo].[AminityMaster] ([AminityId], [BuildingId], [Gymnasium], [GymDesc], [Parking], [ParkingDesc], [Lift], [LiftDesc], [CCTV], [CCTVDesc], [InterCom], [IntercomDesc], [Security], [SecurityDesc], [GeneratorBkp], [GeneratorDesc], [CommunityHall], [CommunityDesc], [SwimmingPool], [SwimmingDesc], [Chairs], [ChairsDesc], [Tables], [TablesDesc], [MusicSystem], [MusicSysDesc], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 16, 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'Yes', 1, N'admin', CAST(0x0000A421010526FE AS DateTime), NULL, NULL)
INSERT [dbo].[AminityMaster] ([AminityId], [BuildingId], [Gymnasium], [GymDesc], [Parking], [ParkingDesc], [Lift], [LiftDesc], [CCTV], [CCTVDesc], [InterCom], [IntercomDesc], [Security], [SecurityDesc], [GeneratorBkp], [GeneratorDesc], [CommunityHall], [CommunityDesc], [SwimmingPool], [SwimmingDesc], [Chairs], [ChairsDesc], [Tables], [TablesDesc], [MusicSystem], [MusicSysDesc], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 15, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 1, N'admin', CAST(0x0000A45400D1B7BC AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[AminityMaster] OFF
/****** Object:  Table [dbo].[EmployeeMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeMaster](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[EmployeeNo] [varchar](50) NOT NULL,
	[JobDescription] [varchar](1000) NOT NULL,
	[ContactNo] [bigint] NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[PAN] [varchar](10) NULL,
	[AadhaarCard] [varchar](12) NULL,
	[Salary] [money] NOT NULL,
	[Designation] [varchar](50) NOT NULL,
	[DOJ] [datetime] NOT NULL,
	[DOL] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_EmployeeMaster] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[EmployeeMaster] ON
INSERT [dbo].[EmployeeMaster] ([EmployeeId], [Name], [EmployeeNo], [JobDescription], [ContactNo], [Address], [PAN], [AadhaarCard], [Salary], [Designation], [DOJ], [DOL], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'abc', N'E0001', N'Employee', 9955844408, N'kharghar,navi mumbai', N'ASDFD1234J', N'856745856856', 6000.0000, N'car washer', CAST(0x0000A42700000000 AS DateTime), CAST(0x0000A43100000000 AS DateTime), 0, N'admin', CAST(0x0000A421010FD01D AS DateTime), NULL, NULL)
INSERT [dbo].[EmployeeMaster] ([EmployeeId], [Name], [EmployeeNo], [JobDescription], [ContactNo], [Address], [PAN], [AadhaarCard], [Salary], [Designation], [DOJ], [DOL], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'dgfd', N'E0002', N'sevice', 9658745856, N'nerul,navi mumbai', N'WSDES5845W', N'856745889655', 8000.0000, N'employee', CAST(0x0000A41700000000 AS DateTime), CAST(0x0000A43000000000 AS DateTime), 1, N'admin', CAST(0x0000A42101105F92 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[EmployeeMaster] OFF
/****** Object:  Table [dbo].[CommiteeMemberMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommiteeMemberMaster](
	[CommiteeMemberId] [int] IDENTITY(1,1) NOT NULL,
	[OwnerId] [int] NOT NULL,
	[FlatId] [int] NOT NULL,
	[Designation] [varchar](500) NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_CommiteeMemberMaster] PRIMARY KEY CLUSTERED 
(
	[CommiteeMemberId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CommiteeMemberMaster] ON
INSERT [dbo].[CommiteeMemberMaster] ([CommiteeMemberId], [OwnerId], [FlatId], [Designation], [EffectiveFrom], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 1, 1, N'Chairman / President', CAST(0x0000A41700000000 AS DateTime), 1, N'', CAST(0x0000A42201011AB4 AS DateTime), NULL, NULL)
INSERT [dbo].[CommiteeMemberMaster] ([CommiteeMemberId], [OwnerId], [FlatId], [Designation], [EffectiveFrom], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 2, 2, N'Secretary', CAST(0x0000A43000000000 AS DateTime), 1, N'', CAST(0x0000A42201014AC3 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[CommiteeMemberMaster] OFF
/****** Object:  Table [dbo].[CommercialMaintenanceCollection]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommercialMaintenanceCollection](
	[CommercialMainCollID] [int] IDENTITY(1,1) NOT NULL,
	[MaintenanceID] [int] NOT NULL,
	[PaidAmount] [money] NOT NULL,
	[ModePayment] [int] NOT NULL,
	[InstrumentNumber] [bigint] NOT NULL,
	[InstrumentDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_CommercialMaintenanceCollection] PRIMARY KEY CLUSTERED 
(
	[CommercialMainCollID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CommercialMaintenance]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CommercialMaintenance](
	[ShopmaintenanceId] [int] IDENTITY(1,1) NOT NULL,
	[ShopId] [int] NOT NULL,
	[MaintenanceID] [int] NOT NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NOT NULL,
	[Amount] [money] NOT NULL,
	[AmountBalance] [money] NULL,
	[LastDate] [datetime] NULL,
	[FineAmount] [money] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_CommercialMaintenance] PRIMARY KEY CLUSTERED 
(
	[ShopmaintenanceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FlatMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FlatMaster](
	[FlatId] [int] IDENTITY(1,1) NOT NULL,
	[FlatNumber] [varchar](100) NOT NULL,
	[CarpetArea] [int] NOT NULL,
	[TotalArea] [int] NOT NULL,
	[FlatType] [varchar](10) NOT NULL,
	[IsShareCertificateGiven] [bit] NOT NULL,
	[IsRented] [bit] NOT NULL,
	[BuildingId] [int] NOT NULL,
	[OwnerId] [int] NOT NULL,
	[PropertyType] [varchar](50) NULL,
	[BusinessType] [varchar](50) NULL,
	[LicenseNo] [varchar](50) NULL,
	[ShopDescription] [varchar](200) NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_FlatMaster] PRIMARY KEY CLUSTERED 
(
	[FlatId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[FlatMaster] ON
INSERT [dbo].[FlatMaster] ([FlatId], [FlatNumber], [CarpetArea], [TotalArea], [FlatType], [IsShareCertificateGiven], [IsRented], [BuildingId], [OwnerId], [PropertyType], [BusinessType], [LicenseNo], [ShopDescription], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Sai-A- 101', 0, 700, N'1BHK', 0, 1, 15, 3, N'Residential', N'', N'', N'', 1, N'admin', CAST(0x0000A48001539A0E AS DateTime), NULL, NULL)
INSERT [dbo].[FlatMaster] ([FlatId], [FlatNumber], [CarpetArea], [TotalArea], [FlatType], [IsShareCertificateGiven], [IsRented], [BuildingId], [OwnerId], [PropertyType], [BusinessType], [LicenseNo], [ShopDescription], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Sai-A- 103', 0, 700, N'1BHK', 0, 0, 15, 2, N'Residential', N'', N'', N'', 1, N'admin', CAST(0x0000A4800154E3D8 AS DateTime), NULL, NULL)
INSERT [dbo].[FlatMaster] ([FlatId], [FlatNumber], [CarpetArea], [TotalArea], [FlatType], [IsShareCertificateGiven], [IsRented], [BuildingId], [OwnerId], [PropertyType], [BusinessType], [LicenseNo], [ShopDescription], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Sai-B- 304', 0, 700, N'1BHK', 0, 0, 16, 1, N'Residential', N'', N'', N'', 1, N'admin', CAST(0x0000A48001550B18 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[FlatMaster] OFF
/****** Object:  Table [dbo].[EventMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventMaster](
	[EventId] [int] IDENTITY(1,1) NOT NULL,
	[EventName] [varchar](200) NOT NULL,
	[EventDescription] [varchar](max) NOT NULL,
	[EventOn] [datetime] NOT NULL,
	[EventTime] [varchar](50) NULL,
	[ContactPerson] [varchar](50) NOT NULL,
	[MobileNo] [bigint] NULL,
	[Contribution] [money] NULL,
	[FileUploadFileName] [varchar](50) NULL,
	[FileName] [varchar](100) NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_EventMaster] PRIMARY KEY CLUSTERED 
(
	[EventId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[EventMaster] ON
INSERT [dbo].[EventMaster] ([EventId], [EventName], [EventDescription], [EventOn], [EventTime], [ContactPerson], [MobileNo], [Contribution], [FileUploadFileName], [FileName], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Independance day', N'<p>heeeelllo<br></p>', CAST(0x0000A42500000000 AS DateTime), N'10:00 AM', N'komal', 9856545498, 500.0000, N'', N'', 1, N'admin', CAST(0x0000A42101188C0D AS DateTime), NULL, NULL)
INSERT [dbo].[EventMaster] ([EventId], [EventName], [EventDescription], [EventOn], [EventTime], [ContactPerson], [MobileNo], [Contribution], [FileUploadFileName], [FileName], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'dfdg', N'<p>fgfg<br></p>', CAST(0x0000A42B00000000 AS DateTime), N'5:31 PM', N'fghtf', 9658745854, 600.0000, N'', N'', 1, N'admin', CAST(0x0000A42101210709 AS DateTime), NULL, NULL)
INSERT [dbo].[EventMaster] ([EventId], [EventName], [EventDescription], [EventOn], [EventTime], [ContactPerson], [MobileNo], [Contribution], [FileUploadFileName], [FileName], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Birthday', N'<p>&nbsp;hello</p>', CAST(0x0000A42800000000 AS DateTime), N'5:41 AM', N'komal', 9652314253, 200.0000, N'asim.gif', N'20150121$174400$6337890_asim.gif', 1, N'admin', CAST(0x0000A42701244032 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[EventMaster] OFF
/****** Object:  StoredProcedure [dbo].[GetEmployeebyFlag]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec [GetEmployeebyFlag ] 'searchbyempno','EM',0
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployeebyFlag] 
	-- Add the parameters for the stored procedure here
	(
		@Flag varchar(30),
	    @EmployeeNo varchar(50),
		@EmployeeId int
		
		)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--DECLARE	@EmployeeNo varchar(50)
--SET @EmployeeNo =''
	SET NOCOUNT ON;
	
    IF(@flag='searchbyempno')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@EmployeeId <> '')
            begin
                set @SQL = @SQL + ' and EmployeeId ='+ Convert(NVARCHAR,@EmployeeId)
            END
            
            if(@EmployeeNo <> '')
            begin
              set @SQL = @SQL + ' and EmployeeNo like '''+ Convert(NVARCHAR(50),@EmployeeNo)+'%'''
            END

   IF(@EmployeeId <> '')----EDIT
                    BEGIN   
                        exec('SELECT EmployeeId,Name,EmployeeNo,JobDescription,ContactNo,Address,PAN,AadhaarCard,Designation,DOJ,DOL
                              From dbo.EmployeeMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY EmployeeId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('SELECT EmployeeId,Name,JobDescription,EmployeeNo,ContactNo
                              From dbo.EmployeeMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY EmployeeId
                        ')  
                    END    
	
	END	   
END
GO
/****** Object:  StoredProcedure [dbo].[GeteBuildingMstrbyNam]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec GeteBuildingMstrbyNam 'searchbyBuildname','sai',0
-- =============================================
CREATE PROCEDURE [dbo].[GeteBuildingMstrbyNam]
		-- Add the parameters for the stored procedure here
	(
		@flag varchar(30),
	  @BuildingName varchar(50),
		@BuildingId int
		
		)
AS
BEGIN
	
	SET NOCOUNT ON;
	
    IF(@flag='searchbyBuildname')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@BuildingId <> '')
            begin
                set @SQL = @SQL + ' and BuildingId ='+ Convert(NVARCHAR,@BuildingId)
            END
            
            if(@BuildingName <> '')
            begin
              set @SQL = @SQL + ' and Name like '''+ Convert(NVARCHAR(50),@BuildingName)+'%'''
            END

   IF(@BuildingId <> '')----EDIT
                    Begin   
                        exec('SELECT BuildingId,Name,Floors
                              From dbo.BuildingMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY BuildingId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('SELECT BuildingId,Name,Floors
                              From dbo.BuildingMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY BuildingId
                        ')  
                    END    
	
	END	   
END
GO
/****** Object:  StoredProcedure [dbo].[GetMonthlyMaintenanceInfo]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<,>
-- Createdate: <Create Date,08-JUNE-2014>
-- Description:	<Description,,>
-- EXEC [GetMonthlyMaintenanceInfo] 'searchMonthlyMaininfo',0,'','Residential','',''
-- =============================================
CREATE PROCEDURE [dbo].[GetMonthlyMaintenanceInfo] 
	-- Add the parameters for the stored procedure here	
   (
		@flag varchar(30),
		@MonthlyMaintenaceId int= NULL,
		@CalculationMethod varchar(50)=null,
		@PropertyType varchar(50)=null,
		@EffectiveFromDate varchar(50)=null,
		@EffectiveToDate varchar(50)=null
	)
		--select PropertyType from MonthlyMaintenanceMaster
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
	SET NOCOUNT ON;

		IF(@flag='searchMonthlyMaininfo')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500),@EfectivetempDate datetime,@EffectiveTempToDate datetime
            set @SQL=''
            set @JOIN=''
              set @EfectivetempDate = convert(datetime,convert(varchar ,@EffectiveFromDate),103)

			  
			  --print @EfectivetempDate
			 set @EffectiveTempToDate =convert(datetime,convert(varchar ,@EffectiveToDate),103)
			   --print @EffectiveTempToDate
				     
              If(@MonthlyMaintenaceId <> '')
            Begin
                set @SQL = @SQL + ' and MonthlyMaintenaceId ='+ Convert(NVARCHAR,@MonthlyMaintenaceId)
			 
            END

			if(@CalculationMethod <> '')
            Begin
              set @SQL = @SQL + ' and CalculationMethod like '''+ Convert(NVARCHAR(50),@CalculationMethod)+'%'''
            END			


			if(@PropertyType <> '')
            Begin
              set @SQL = @SQL + ' and PropertyType like '''+ Convert(NVARCHAR(50),@PropertyType)+'%'''

            END
            
			
		
			
			IF(@EffectiveToDate <> '' and @EffectiveFromDate <> '' )
				 BEGIN
					set @SQL = @SQL + ' and EffectiveFromDate BETWEEN '''+ CONVERT(NVARCHAR(29),CONVERT(DATETIME,@EffectiveFromDate,103) , 120) + ''' and ''' +  CONVERT(NVARCHAR(29),CONVERT(DATETIME,@EffectiveToDate,103),120)   +''''
				 END	
			else if(@EffectiveFromDate <> '')
				Begin
				  set @SQL = @SQL + ' and EffectiveFromDate like '''+ Convert(NVARCHAR(50),@EfectivetempDate)+'%'''
				END

			else IF(@EffectiveToDate <> '')
				BEGIN
					set @SQL = @SQL + ' and EffectiveToDate like '''+  Convert(NVARCHAR(50),@EffectiveTempToDate)+'%'''
				END
								

   IF(@MonthlyMaintenaceId <> '')----EDIT
                    BEGIN   
                        EXEC('SELECT MonthlyMaintenaceId,PropertyType,
								CalculationMethod,
								EffectiveFromDate,EffectiveToDate
                              From dbo.MonthlyMaintenanceMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY MonthlyMaintenaceId
                        ')   
                    END
                ELSE
                    BEGIN
                             EXEC('SELECT MonthlyMaintenaceId,PropertyType,
								CalculationMethod,
								EffectiveFromDate,EffectiveToDate
                              From dbo.MonthlyMaintenanceMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY MonthlyMaintenaceId')  
                    END    
	
	END	 
		
		
	
	
  
END
GO
/****** Object:  StoredProcedure [dbo].[GetAmenitybyFlag]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAmenitybyFlag] 
	-- Add the parameters for the stored procedure here
	(
		@Flag varchar(40),
	    @AminityId int,
		@BuildingId int
		)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--DECLARE	@EmployeeNo varchar(50)
--SET @EmployeeNo =''
	SET NOCOUNT ON;
	
    IF(@flag='searchbyname')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@AminityId <> '')
            begin
                set @SQL = @SQL + ' and a.AminityId ='+ Convert(NVARCHAR,@AminityId)
            END
            
            if(@BuildingId <> '')
            begin
             -- set @SQL = @SQL + ' and b.BuildingId like '''+ Convert(NVARCHAR,@BuildingId)+'%'''
              set @SQL = @SQL + ' and a.BuildingId ='+ Convert(NVARCHAR,@BuildingId)
            END

   IF(@BuildingId <> '')----EDIT
                    BEGIN   
                       exec('SELECT a.AminityId,a.BuildingId,b.Name
		FROM dbo.AminityMaster a
		INNER JOIN  dbo.BuildingMaster b ON b.BuildingId =a.BuildingId
	    WHERE a.Active=1
	    '+@SQL+' 
                              ORDER BY a.BuildingId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('SELECT a.AminityId,a.BuildingId,b.Name
		FROM dbo.AminityMaster a
		INNER JOIN dbo.BuildingMaster b ON b.BuildingId =a.BuildingId
	    WHERE a.Active=1
	    '+@SQL+' 
                              ORDER BY a.BuildingId 
                        ')  
                    END    
	
	END	   
END
GO
/****** Object:  StoredProcedure [dbo].[GetParkingInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetParkingInfo]
	-- Add the parameters for the stored procedure here
		-- Add the parameters for the stored procedure here
	(
		@Flag varchar(30),
	    @FlatNumber varchar(50),
		@ParkingId int
		
		)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--DECLARE	@EmployeeNo varchar(50)
--SET @EmployeeNo =''
	SET NOCOUNT ON;
	
    IF(@flag='searchbyFlatNo')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@ParkingId <> '')
            begin
                set @SQL = @SQL + ' and a.ParkingId ='+ Convert(NVARCHAR,@ParkingId)
            END
            
            if(@FlatNumber <> '')
            begin
              set @SQL = @SQL + ' and c.FlatNumber like '''+ Convert(NVARCHAR(50),@FlatNumber)+'%'''
            END

   IF(@ParkingId <> '')----EDIT
                    BEGIN   
                        exec('SELECT a.ParkingId,c.FlatNumber,b.OwnerName1 as OwnerName,a.ParkingId,a.FlatId,a.OwnerId,a.ParkingType,a.NumberOfParking,a.Parking1,a.Parking2,a.Parking3,a.Parking1Type,a.Parking2Type,a.Parking3Type
		FROM ParkingMaster a
		Inner join dbo.OwnerMaster b On b.OwnerId =a.OwnerId
		Inner join dbo.FlatMaster c ON a.FlatId=c.FlatId
	    WHERE a.Active=1
                              '+@SQL+' 
                              ORDER BY a.ParkingId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('SELECT a.ParkingId,c.FlatNumber,b.OwnerName1 as OwnerName,a.ParkingId,a.FlatId,a.OwnerId,a.ParkingType,a.NumberOfParking,a.Parking1,a.Parking2,a.Parking3,a.Parking1Type,a.Parking2Type,a.Parking3Type
		FROM ParkingMaster a
		Inner join dbo.OwnerMaster b On b.OwnerId =a.OwnerId
		Inner join dbo.FlatMaster c ON a.FlatId=c.FlatId
	    WHERE a.Active=1
                              '+@SQL+' 
                              ORDER BY a.ParkingId
                        ')  
                    END    
	
	END	   
END
GO
/****** Object:  UserDefinedFunction [dbo].[HtmltoText]    Script Date: 04/29/2015 19:23:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[HtmltoText] 
(
  @string varchar(8000)
) 
returns varchar(8000)

AS
BEGIN
---------------------------------------------------------------------------------------------------
-- Title:        ScrapeText
--                 
--               
-- Example:      This text will be parsed and returned but not the P's
--               
---------------------------------------------------------------------------------------------------
-- Date Revised: 
-- Author:       
-- Reason:       
---------------------------------------------------------------------------------------------------

declare @text  varchar(8000),
        @PenDown char(1),
        @char  char(1),
        @len   int,
        @count int

select  @count = 0,
        @len   = 0,
        @text  = ''


---------------------------------------------------------------------------------------------------
-- M A I N   P R O C E S S I N G
---------------------------------------------------------------------------------------------------

-- Add tokens
select @string = '>' + @string + '<'

-- Replace Special Characters
select @string = replace(@string,'&nbsp;',' ')

-- Parse out the formatting codes
select @len = len(@string)
while (@count <= @len)
begin
  select @char = substring(@string,@count,1)

  if (@char = '>')
     select @PenDown = 'Y'
  else 
  if (@char = '<')
    select @PenDown = 'N'
  else  
  if (@PenDown = 'Y')
    select @text = @text + @char

  select @count = @count + 1
end

RETURN @text
END
GO
/****** Object:  Table [dbo].[MaintenanceCaltypeMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MaintenanceCaltypeMaster](
	[CalcMasterID] [int] IDENTITY(1,1) NOT NULL,
	[CalculationMethod] [varchar](50) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_MaintenanceCaltypeMaster] PRIMARY KEY CLUSTERED 
(
	[CalcMasterID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[MaintenanceCaltypeMaster] ON
INSERT [dbo].[MaintenanceCaltypeMaster] ([CalcMasterID], [CalculationMethod], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [Active]) VALUES (1, N'Flat Monthly Fee', N'Pranav', NULL, NULL, NULL, 1)
INSERT [dbo].[MaintenanceCaltypeMaster] ([CalcMasterID], [CalculationMethod], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [Active]) VALUES (2, N'Per Square Feet Rate', N'Panav', NULL, NULL, NULL, 1)
INSERT [dbo].[MaintenanceCaltypeMaster] ([CalcMasterID], [CalculationMethod], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [Active]) VALUES (3, N'Partial Flat Rate', N'Pranav', NULL, NULL, NULL, 1)
INSERT [dbo].[MaintenanceCaltypeMaster] ([CalcMasterID], [CalculationMethod], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [Active]) VALUES (4, N'Mixed Approach
', N'Pranav', NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[MaintenanceCaltypeMaster] OFF
/****** Object:  Table [dbo].[OwnerMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OwnerMaster](
	[OwnerId] [int] IDENTITY(1,1) NOT NULL,
	[OwnerName1] [varchar](100) NOT NULL,
	[OwnerName2] [varchar](100) NULL,
	[OwnerName3] [varchar](100) NULL,
	[ContactNumber] [bigint] NOT NULL,
	[Occupation] [varchar](500) NOT NULL,
	[OfficeAddress] [varchar](1000) NULL,
	[OfficeContactNo] [bigint] NULL,
	[PAN] [varchar](10) NOT NULL,
	[AdhaarCard] [varchar](12) NOT NULL,
	[IsCommiteeMember] [bit] NOT NULL,
	[Photo] [varchar](250) NULL,
	[ResidingFrom] [datetime] NULL,
	[DOB] [datetime] NOT NULL,
	[permanentAddress] [varchar](1000) NULL,
	[Designation] [varchar](50) NULL,
	[Effectivefrom] [datetime] NULL,
	[TempAddress] [varchar](1000) NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_OwnerMaster_1] PRIMARY KEY CLUSTERED 
(
	[OwnerId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[OwnerMaster] ON
INSERT [dbo].[OwnerMaster] ([OwnerId], [OwnerName1], [OwnerName2], [OwnerName3], [ContactNumber], [Occupation], [OfficeAddress], [OfficeContactNo], [PAN], [AdhaarCard], [IsCommiteeMember], [Photo], [ResidingFrom], [DOB], [permanentAddress], [Designation], [Effectivefrom], [TempAddress], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Sunder Seetaram', NULL, NULL, 8655096955, N'Programmer', N'', 8655096955, N'aicpj9418k', N'123585458458', 1, NULL, CAST(0x0000A02700000000 AS DateTime), CAST(0x000071B900000000 AS DateTime), N'kharghar', N'Treasurer', CAST(0x0000A2AE00000000 AS DateTime), N'kharghar', 1, N'admin', CAST(0x0000A48001514A37 AS DateTime), NULL, NULL)
INSERT [dbo].[OwnerMaster] ([OwnerId], [OwnerName1], [OwnerName2], [OwnerName3], [ContactNumber], [Occupation], [OfficeAddress], [OfficeContactNo], [PAN], [AdhaarCard], [IsCommiteeMember], [Photo], [ResidingFrom], [DOB], [permanentAddress], [Designation], [Effectivefrom], [TempAddress], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Vivek Kadam', NULL, NULL, 8655096955, N'Civil Engineer', N'kharghar', 8655096955, N'aicpj1234y', N'787878787878', 1, NULL, CAST(0x0000A00800000000 AS DateTime), CAST(0x000078BD00000000 AS DateTime), N'kharghar', N'Secretary', CAST(0x0000A2AE00000000 AS DateTime), N'kharghar', 1, N'admin', CAST(0x0000A4800152CDDB AS DateTime), NULL, NULL)
INSERT [dbo].[OwnerMaster] ([OwnerId], [OwnerName1], [OwnerName2], [OwnerName3], [ContactNumber], [Occupation], [OfficeAddress], [OfficeContactNo], [PAN], [AdhaarCard], [IsCommiteeMember], [Photo], [ResidingFrom], [DOB], [permanentAddress], [Designation], [Effectivefrom], [TempAddress], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Avinash', NULL, NULL, 8888888888, N'Network Engineer', N'', 8888888888, N'Aicpj1234i', N'878787878787', 0, NULL, CAST(0x0000A13900000000 AS DateTime), CAST(0x0000766B00000000 AS DateTime), N'Ghatkoper', N'', CAST(0x0000000000000000 AS DateTime), N'Ghatkoper', 1, N'admin', CAST(0x0000A480015362FD AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[OwnerMaster] OFF
/****** Object:  Table [dbo].[OwnerFamilyMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OwnerFamilyMaster](
	[OwnerFamilyId] [int] IDENTITY(1,1) NOT NULL,
	[FlatId] [int] NULL,
	[Name] [varchar](50) NULL,
	[ResidingFrom] [datetime] NULL,
	[ContactNo] [bigint] NULL,
	[PAN] [varchar](10) NULL,
	[AadhaarCard] [varchar](12) NULL,
	[Relation] [varchar](50) NULL,
	[DOB] [datetime] NULL,
	[Address] [varchar](500) NULL,
	[OtherRelation] [varchar](50) NULL,
	[Gender] [varchar](8) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[Photo] [varchar](250) NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_OwnerFamilyMaster] PRIMARY KEY CLUSTERED 
(
	[OwnerFamilyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[OwnerFamilyMaster] ON
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (12, 9, N'pranav s patil', CAST(0x0000A42000000000 AS DateTime), 9029583367, N'5451551514', N'555555555555', N'Father', CAST(0x00007DA200000000 AS DateTime), N'dadadad', NULL, N'Male', 1, N'', CAST(0x0000A417010C0D3A AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (13, 9, N'Komal', CAST(0x0000A42000000000 AS DateTime), 8023658285, N'5451551514', N'555555555555', N'Sister', CAST(0x00007DA200000000 AS DateTime), N'dadadad', NULL, N'Male', 1, N'', CAST(0x0000A417010C0D3A AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (14, 1, N'ty6ui6t', CAST(0x0000A41900000000 AS DateTime), 9658745856, N'WEDRF8745Y', N'965774584574', N'Father', CAST(0x0000A41800000000 AS DateTime), N'DFER', N'&nbsp;', N'Male', 1, N'admin', CAST(0x0000A4210139DD1A AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (15, 1, N'REY', CAST(0x00009E1C00000000 AS DateTime), 9658745856, N'AWEDF8785R', N'564745854512', N'Mother', CAST(0x0000A41800000000 AS DateTime), N'RTER', NULL, N'Female', 1, N'admin', CAST(0x0000A4210139DD1A AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (16, 2, N'ur', CAST(0x0000A41700000000 AS DateTime), 9658745856, N'AWSED5874U', N'956874585858', N'Mother', CAST(0x0000A42600000000 AS DateTime), N'GR', NULL, N'Female', 0, N'admin', CAST(0x0000A42200DCE288 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (17, 3, N'Why1', CAST(0x0000A42400000000 AS DateTime), 9775845845, N'EDTFE5864R', N'456745798465', N'Father', CAST(0x0000A48B00000000 AS DateTime), N'jfdhrb', NULL, N'Male', 1, N'admin', CAST(0x0000A42200DE2073 AS DateTime), NULL, N'pranav', CAST(0x0000A433010C436B AS DateTime))
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (18, 1, N'gfdg', CAST(0x0000A41E00000000 AS DateTime), 9658745856, N'AWSED4587H', N'564758568545', N'Father', CAST(0x0000A41E00000000 AS DateTime), N'ERGYER', NULL, N'Male', 1, N'admin', CAST(0x0000A42200E0EB7C AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (19, 3, N'pranav', CAST(0x0000A41300000000 AS DateTime), 9658745856, N'ASWDE4563H', N'564756856253', N'Father', CAST(0x0000A43100000000 AS DateTime), N'kharghar', N'&nbsp;', N'Male', 1, N'pranav', CAST(0x0000A42300D22EDF AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (20, 3, N'komal', CAST(0x0000A41B00000000 AS DateTime), 9658745256, N'JHGFT4574G', N'5647458525', N'Mother', CAST(0x0000A43000000000 AS DateTime), N'JGSD', NULL, N'Female', 1, N'pranav', CAST(0x0000A42300D22EDF AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (21, 2, N'pranav', CAST(0x0000A43500000000 AS DateTime), 9029583367, N'AEWER4754T', N'333333333333', N'Father', CAST(0x00007B9300000000 AS DateTime), N'dadadadad', NULL, N'Male', 1, N'admin', CAST(0x0000A43301098CF1 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[OwnerFamilyMaster] ([OwnerFamilyId], [FlatId], [Name], [ResidingFrom], [ContactNo], [PAN], [AadhaarCard], [Relation], [DOB], [Address], [OtherRelation], [Gender], [Active], [CreatedBy], [CreatedOn], [Photo], [ModifiedBy], [ModifiedOn]) VALUES (22, 3, N'dsadad', CAST(0x0000A43C00000000 AS DateTime), 9028545454, N'AQWER4754E', N'444444444444', N'Mother', CAST(0x0000A44300000000 AS DateTime), N'asda', NULL, N'Female', 0, N'pranav', CAST(0x0000A433010C90A8 AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[OwnerFamilyMaster] OFF
/****** Object:  Table [dbo].[MonthlyMaintenanceMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MonthlyMaintenanceMaster](
	[MonthlyMaintenaceId] [int] IDENTITY(1,1) NOT NULL,
	[PropertyType] [varchar](50) NULL,
	[CalculationMethod] [varchar](50) NULL,
	[OwnerMonthlyMaintenance] [money] NULL,
	[TenantMonthlyMaintenance] [money] NULL,
	[TotalMonthlyMaintenace] [money] NULL,
	[PerSquareFeetRate] [money] NULL,
	[EffectiveFromDate] [datetime] NULL,
	[EffectiveToDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](100) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedOn] [varchar](50) NULL,
 CONSTRAINT [PK_MonthlyMaintenanceMaster] PRIMARY KEY CLUSTERED 
(
	[MonthlyMaintenaceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[MonthlyMaintenanceMaster] ON
INSERT [dbo].[MonthlyMaintenanceMaster] ([MonthlyMaintenaceId], [PropertyType], [CalculationMethod], [OwnerMonthlyMaintenance], [TenantMonthlyMaintenance], [TotalMonthlyMaintenace], [PerSquareFeetRate], [EffectiveFromDate], [EffectiveToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Residential', N'FlatMonthlyFee', 1000.0000, 1150.0000, 2150.0000, 0.0000, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), 1, N'', CAST(0x0000A47C00F51329 AS DateTime), NULL, NULL)
INSERT [dbo].[MonthlyMaintenanceMaster] ([MonthlyMaintenaceId], [PropertyType], [CalculationMethod], [OwnerMonthlyMaintenance], [TenantMonthlyMaintenance], [TotalMonthlyMaintenace], [PerSquareFeetRate], [EffectiveFromDate], [EffectiveToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, N'Commercial', N'PerSquareFeetRate', 0.0000, 0.0000, 0.0000, 500.0000, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), 1, N'', CAST(0x0000A47C00F6B06B AS DateTime), N'', N'Apr 17 2015 12:08PM')
SET IDENTITY_INSERT [dbo].[MonthlyMaintenanceMaster] OFF
/****** Object:  Table [dbo].[Society_reg]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Society_reg](
	[UID] [int] IDENTITY(1,1) NOT NULL,
	[Fullname] [varchar](50) NULL,
	[Username] [varchar](50) NULL,
	[OwnerId] [int] NULL,
	[BuildingId] [int] NULL,
	[FlatId] [int] NULL,
	[Password] [varchar](150) NULL,
	[Emailid] [varchar](50) NULL,
	[RollId] [int] NULL,
	[Mobileno] [varchar](50) NULL,
	[Wings] [varchar](50) NULL,
	[Flatno] [varchar](50) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Society_reg] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Society_reg] ON
INSERT [dbo].[Society_reg] ([UID], [Fullname], [Username], [OwnerId], [BuildingId], [FlatId], [Password], [Emailid], [RollId], [Mobileno], [Wings], [Flatno], [Active]) VALUES (1, N'sa', N'sa', NULL, NULL, NULL, N'g8shDrY1H2MncOUGxwcw/6RAazvPucgeFJJ6BwRtY34H3Zig9HsjXs8Ieh+JHm0glgEVjOcLi8oLXfrWjm4cq8GpXj+O', N'pranav2@gmail.com', 3, N'9029583367', N'B', N'A001', 1)
SET IDENTITY_INSERT [dbo].[Society_reg] OFF
/****** Object:  Table [dbo].[SecuritySalaryMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SecuritySalaryMaster](
	[SecurityId] [int] IDENTITY(1,1) NOT NULL,
	[NoOfSecurityGuards] [int] NULL,
	[GuardSalary] [int] NULL,
	[TotalGuardsal] [int] NULL,
	[NoOfSupervisor] [int] NULL,
	[SupervisorSalary] [int] NULL,
	[CompanyName] [varchar](100) NULL,
	[TotalSalary] [int] NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_SecuritySalaryMaster] PRIMARY KEY CLUSTERED 
(
	[SecurityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[SecuritySalaryMaster] ON
INSERT [dbo].[SecuritySalaryMaster] ([SecurityId], [NoOfSecurityGuards], [GuardSalary], [TotalGuardsal], [NoOfSupervisor], [SupervisorSalary], [CompanyName], [TotalSalary], [FromDate], [ToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 4, 8000, 32000, 1, 10000, N'ABC corp', 42000, NULL, NULL, 1, N'Admin', CAST(0x0000A48001560D8C AS DateTime), NULL, CAST(0x0000A48001560D8C AS DateTime))
SET IDENTITY_INSERT [dbo].[SecuritySalaryMaster] OFF
/****** Object:  Table [dbo].[RolegroupMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RolegroupMaster](
	[URole_Id] [int] NOT NULL,
	[URole_Name] [varchar](50) NOT NULL,
	[Subscription] [int] NOT NULL,
	[Menu_Id] [int] NOT NULL,
	[Save_Permission] [char](1) NULL,
	[Update_Permission] [char](1) NULL,
	[View_Permission] [char](1) NULL,
	[DOE] [datetime] NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 1, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 2, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 3, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 4, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 5, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 6, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 7, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 8, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 9, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 10, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 11, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 12, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 13, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 14, N'N', N'N', N'N', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 1, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 2, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 3, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 4, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 5, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 6, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 7, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 8, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 9, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 10, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 11, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 12, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 13, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 14, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 17, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 18, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 19, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 20, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (2, N'SocietyMember', 3, 19, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 21, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 20, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 23, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 24, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 25, N'Y', N'Y', N'Y', NULL, 1)
INSERT [dbo].[RolegroupMaster] ([URole_Id], [URole_Name], [Subscription], [Menu_Id], [Save_Permission], [Update_Permission], [View_Permission], [DOE], [Active]) VALUES (1, N'Admin', 3, 26, N'Y', N'Y', N'Y', NULL, 1)
/****** Object:  Table [dbo].[ResidentialMaintenanceCollection]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResidentialMaintenanceCollection](
	[ResidentialMainCollID] [int] IDENTITY(1,1) NOT NULL,
	[MaintenanceID] [int] NOT NULL,
	[PaidAmount] [money] NOT NULL,
	[ModePayment] [int] NOT NULL,
	[InstrumentNumber] [bigint] NOT NULL,
	[InstrumentDate] [datetime] NOT NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_MaintenanceCollection] PRIMARY KEY CLUSTERED 
(
	[ResidentialMainCollID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ResidentialMaintenanceCollection] ON
INSERT [dbo].[ResidentialMaintenanceCollection] ([ResidentialMainCollID], [MaintenanceID], [PaidAmount], [ModePayment], [InstrumentNumber], [InstrumentDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 0, 1500.0000, 1, 34234, CAST(0x0000A42100000000 AS DateTime), 1, N'', CAST(0x0000A42C012A420D AS DateTime), NULL, NULL)
INSERT [dbo].[ResidentialMaintenanceCollection] ([ResidentialMainCollID], [MaintenanceID], [PaidAmount], [ModePayment], [InstrumentNumber], [InstrumentDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 1, 1600.0000, 1, 4354, CAST(0x0000A42900000000 AS DateTime), 1, N'Admin', CAST(0x0000A42C013F91B2 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[ResidentialMaintenanceCollection] OFF
/****** Object:  Table [dbo].[ResidentialMaintenance]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ResidentialMaintenance](
	[FlatmaintenanceId] [int] IDENTITY(1,1) NOT NULL,
	[FlatId] [int] NOT NULL,
	[MaintenanceID] [int] NOT NULL,
	[EffectiveFrom] [datetime] NOT NULL,
	[EffectiveTo] [datetime] NULL,
	[Amount] [money] NOT NULL,
	[AmountBalance] [money] NULL,
	[LastDate] [datetime] NULL,
	[FineAmount] [money] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_FlatMaintenance] PRIMARY KEY CLUSTERED 
(
	[FlatmaintenanceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ResidentialMaintenance] ON
INSERT [dbo].[ResidentialMaintenance] ([FlatmaintenanceId], [FlatId], [MaintenanceID], [EffectiveFrom], [EffectiveTo], [Amount], [AmountBalance], [LastDate], [FineAmount], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 1, 1, CAST(0x0000A48B00000000 AS DateTime), CAST(0x0000A4A900000000 AS DateTime), 28384.0000, 28384.0000, NULL, NULL, 1, N'AUTOJOB', CAST(0x0000A48001597388 AS DateTime), NULL, NULL)
INSERT [dbo].[ResidentialMaintenance] ([FlatmaintenanceId], [FlatId], [MaintenanceID], [EffectiveFrom], [EffectiveTo], [Amount], [AmountBalance], [LastDate], [FineAmount], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 2, 1, CAST(0x0000A48B00000000 AS DateTime), CAST(0x0000A4A900000000 AS DateTime), 28234.0000, 28234.0000, NULL, NULL, 1, N'AUTOJOB', CAST(0x0000A48001597388 AS DateTime), NULL, NULL)
INSERT [dbo].[ResidentialMaintenance] ([FlatmaintenanceId], [FlatId], [MaintenanceID], [EffectiveFrom], [EffectiveTo], [Amount], [AmountBalance], [LastDate], [FineAmount], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 3, 1, CAST(0x0000A48B00000000 AS DateTime), CAST(0x0000A4A900000000 AS DateTime), 28234.0000, 28234.0000, NULL, NULL, 1, N'AUTOJOB', CAST(0x0000A48001597388 AS DateTime), NULL, NULL)
INSERT [dbo].[ResidentialMaintenance] ([FlatmaintenanceId], [FlatId], [MaintenanceID], [EffectiveFrom], [EffectiveTo], [Amount], [AmountBalance], [LastDate], [FineAmount], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, 1, 1, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000A48A00000000 AS DateTime), 28384.0000, 28384.0000, NULL, NULL, 1, N'AUTOJOB', CAST(0x0000A48001597388 AS DateTime), NULL, NULL)
INSERT [dbo].[ResidentialMaintenance] ([FlatmaintenanceId], [FlatId], [MaintenanceID], [EffectiveFrom], [EffectiveTo], [Amount], [AmountBalance], [LastDate], [FineAmount], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, 2, 1, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000A48A00000000 AS DateTime), 28234.0000, 28234.0000, NULL, NULL, 1, N'AUTOJOB', CAST(0x0000A48001597388 AS DateTime), NULL, NULL)
INSERT [dbo].[ResidentialMaintenance] ([FlatmaintenanceId], [FlatId], [MaintenanceID], [EffectiveFrom], [EffectiveTo], [Amount], [AmountBalance], [LastDate], [FineAmount], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, 3, 1, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000A48A00000000 AS DateTime), 28234.0000, 28234.0000, NULL, NULL, 1, N'AUTOJOB', CAST(0x0000A48001597388 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[ResidentialMaintenance] OFF
/****** Object:  StoredProcedure [dbo].[ResetPassword]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ResetPassword]
@Username varchar (50),
@NewPassword varchar (50),
@UID int

AS
BEGIN
	
	UPDATE DetailTable
	SET Password=@NewPassword
	WHERE UID=@UID AND Username=@Username AND active=1
END
GO
/****** Object:  Table [dbo].[PaymentModeMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentModeMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentMode] [varchar](20) NOT NULL,
	[Active] [bit] NOT NULL,
	[Created_By] [varchar](20) NOT NULL,
	[Created_On] [datetime] NOT NULL,
	[Modified_By] [varchar](20) NULL,
	[Modified_On] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentModeMaster] ON
INSERT [dbo].[PaymentModeMaster] ([ID], [PaymentMode], [Active], [Created_By], [Created_On], [Modified_By], [Modified_On]) VALUES (1, N'Cash', 1, N'Akshay', CAST(0x0000A42400000000 AS DateTime), NULL, NULL)
INSERT [dbo].[PaymentModeMaster] ([ID], [PaymentMode], [Active], [Created_By], [Created_On], [Modified_By], [Modified_On]) VALUES (2, N'Cheque', 1, N'Akshay', CAST(0x0000A42400000000 AS DateTime), NULL, NULL)
INSERT [dbo].[PaymentModeMaster] ([ID], [PaymentMode], [Active], [Created_By], [Created_On], [Modified_By], [Modified_On]) VALUES (3, N'Demand Draft', 1, N'Akshay', CAST(0x0000A42400000000 AS DateTime), NULL, NULL)
INSERT [dbo].[PaymentModeMaster] ([ID], [PaymentMode], [Active], [Created_By], [Created_On], [Modified_By], [Modified_On]) VALUES (4, N'ECS', 1, N'Akshay', CAST(0x0000A42400000000 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[PaymentModeMaster] OFF
/****** Object:  Table [dbo].[PaymentMode]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentMode](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentType] [varchar](50) NULL,
	[Active] [bit] NULL,
	[DOE] [date] NULL,
 CONSTRAINT [PK_PaymentMode] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[PaymentMode] ON
INSERT [dbo].[PaymentMode] ([PaymentID], [PaymentType], [Active], [DOE]) VALUES (1, N'Cash', 1, NULL)
INSERT [dbo].[PaymentMode] ([PaymentID], [PaymentType], [Active], [DOE]) VALUES (2, N'Cheque', 1, NULL)
INSERT [dbo].[PaymentMode] ([PaymentID], [PaymentType], [Active], [DOE]) VALUES (3, N'DD', 1, NULL)
INSERT [dbo].[PaymentMode] ([PaymentID], [PaymentType], [Active], [DOE]) VALUES (4, N'ECS', 1, NULL)
SET IDENTITY_INSERT [dbo].[PaymentMode] OFF
/****** Object:  Table [dbo].[MonthlyExpensesMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MonthlyExpensesMaster](
	[MonthlyExpenseId] [int] IDENTITY(1,1) NOT NULL,
	[SecurityId] [int] NOT NULL,
	[SecurityGuardsSalary] [money] NULL,
	[PowerCharges] [money] NULL,
	[WaterCharges] [money] NULL,
	[HousekeepingSalary] [money] NULL,
	[ManagerSalary] [money] NULL,
	[Stationary] [money] NULL,
	[DgSet] [money] NULL,
	[GymInstructor] [money] NULL,
	[CommunityHall] [money] NULL,
	[InsurancePremium] [money] NULL,
	[Miscellaneous] [money] NULL,
	[SupervisorSalary] [money] NULL,
	[SumTotal] [money] NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_MonthlyExpensesMaster] PRIMARY KEY CLUSTERED 
(
	[MonthlyExpenseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[MonthlyExpensesMaster] ON
INSERT [dbo].[MonthlyExpensesMaster] ([MonthlyExpenseId], [SecurityId], [SecurityGuardsSalary], [PowerCharges], [WaterCharges], [HousekeepingSalary], [ManagerSalary], [Stationary], [DgSet], [GymInstructor], [CommunityHall], [InsurancePremium], [Miscellaneous], [SupervisorSalary], [SumTotal], [FromDate], [ToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 0, 8000.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 9000.0000, 1110.0000, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), 1, N'Admin', CAST(0x0000A479011D9DC4 AS DateTime), NULL, CAST(0x0000A479011D9DC4 AS DateTime))
INSERT [dbo].[MonthlyExpensesMaster] ([MonthlyExpenseId], [SecurityId], [SecurityGuardsSalary], [PowerCharges], [WaterCharges], [HousekeepingSalary], [ManagerSalary], [Stationary], [DgSet], [GymInstructor], [CommunityHall], [InsurancePremium], [Miscellaneous], [SupervisorSalary], [SumTotal], [FromDate], [ToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 0, NULL, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, NULL, 1000.0000, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), 1, N'Admin', CAST(0x0000A47A0058B081 AS DateTime), NULL, CAST(0x0000A47A0058B081 AS DateTime))
INSERT [dbo].[MonthlyExpensesMaster] ([MonthlyExpenseId], [SecurityId], [SecurityGuardsSalary], [PowerCharges], [WaterCharges], [HousekeepingSalary], [ManagerSalary], [Stationary], [DgSet], [GymInstructor], [CommunityHall], [InsurancePremium], [Miscellaneous], [SupervisorSalary], [SumTotal], [FromDate], [ToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, 6, 8000.0000, 200.0000, 200.0000, 200.0000, 200.0000, 200.0000, 200.0000, 200.0000, 200.0000, 200.0000, 200.0000, 9000.0000, 19000.0000, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), 1, N'Admin', CAST(0x0000A47A0074C9F0 AS DateTime), NULL, CAST(0x0000A47A0074C9F0 AS DateTime))
INSERT [dbo].[MonthlyExpensesMaster] ([MonthlyExpenseId], [SecurityId], [SecurityGuardsSalary], [PowerCharges], [WaterCharges], [HousekeepingSalary], [ManagerSalary], [Stationary], [DgSet], [GymInstructor], [CommunityHall], [InsurancePremium], [Miscellaneous], [SupervisorSalary], [SumTotal], [FromDate], [ToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (10, 6, 8000.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 100.0000, 9000.0000, 18000.0000, CAST(0x0000A46D00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), 1, N'Admin', CAST(0x0000A47B0129BD5A AS DateTime), NULL, CAST(0x0000A47B0129BD5A AS DateTime))
SET IDENTITY_INSERT [dbo].[MonthlyExpensesMaster] OFF
/****** Object:  Table [dbo].[MenuMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MenuMaster](
	[MenuId] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [varchar](100) NULL,
	[ParentID] [int] NULL,
	[CssIcon] [varchar](50) NULL,
	[URL] [varchar](max) NULL,
	[MenuType] [varchar](50) NULL,
	[Sequence] [int] NULL,
	[Active] [bit] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[MenuMaster] ON
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (1, N'Dashboard', 0, N'icon-home', N'#', N'Dashboard', 1, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (3, N'Owner Information', 2, N'icon-shield', N'Masters/OwnerMasterView.aspx', N'Master', 1, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (5, N'Flat Information', 2, NULL, N'Masters/FlatMasterView.aspx', N'Master', 3, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (7, N'Parking Information', 2, NULL, N'Masters/ParkingMasterView.aspx', N'Master', 5, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (9, N'Amenities Information', 2, NULL, N'Masters/AmenityMasterView.aspx', N'Master', 7, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (11, N'Tenant Information', 2, NULL, N'Master/TenantMaster.aspx', N'Master', 10, 0)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (13, N'Employee Information', 2, N'icon-key', N'Masters/EmployeeMasterView.aspx', N'Master', 11, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (15, N'Test Information', 4, N'icon-basket', N'Masters/ParkingMaster.aspx', N'Master', 1, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (2, N'Master', 0, N'icon-info', N'#', N'Master', 2, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (4, N'Building Information', 2, N'icon-sitemap', N'Masters/BuildingMasterView.aspx', N'Master', 2, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (6, N'Vehicle Information', 2, NULL, N'Masters/VehicleMasterView.aspx', N'Master', 4, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (8, N'Maintenance Information', 17, NULL, N'Finance/MaintenanceMasterView.aspx', N'Finance', 1, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (10, N'Flat Member Information', 2, NULL, N'Masters/FlatMemberMaster.aspx', N'Master', 8, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (12, N'Reports', 0, N'icon-key', N'#', N'Report', 5, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (14, N'Event Information', 2, N'icon-basket', N'Masters/EventMasterView.aspx', N'Master', 12, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (16, N'Profile', 2, N'icon-basket', N'Profile/AccountsSettings.aspx', N'Master', 13, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (17, N'Finance', 0, N'icon-basket', N'#', N'Finance', 3, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (18, N'Maintenance Collection', 17, N'icon-basket', N'Finance/MaintenanceCollection.aspx', N'Finance', 2, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (19, N'Member Information ', 2, N'icon-basket', N'Masters/MemberMasterView.aspx', N'Master', 9, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (20, N'Monthly Report', 12, N'icon-key', N'Reports/MothlyMaintenance.aspx', N'Report', 1, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (21, N'Society Information', 2, N'icon-shield', N'Masters/SocietyInformationView.aspx', N'Master', 15, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (25, N'Maintain Vendors', 0, N'icon-key', NULL, N'Vendor', 4, 1)
INSERT [dbo].[MenuMaster] ([MenuId], [MenuName], [ParentID], [CssIcon], [URL], [MenuType], [Sequence], [Active]) VALUES (26, N'Security Salary', 25, N'icon-key', N'Vendor/SecuritySalaryMaster.aspx', N'Vendor', 1, 1)
SET IDENTITY_INSERT [dbo].[MenuMaster] OFF
/****** Object:  Table [dbo].[MaintenanceMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MaintenanceMaster](
	[MaintenanceID] [int] IDENTITY(1,1) NOT NULL,
	[PropertyType] [varchar](20) NOT NULL,
	[CalculationMethodId] [int] NOT NULL,
	[PropertyTaxes] [money] NULL,
	[WaterCharges] [money] NULL,
	[ElectricityCharges] [money] NULL,
	[RepairsMaintenanceFund] [money] NULL,
	[LiftCharges] [money] NULL,
	[SinkingFund] [money] NULL,
	[ServiceCharges] [money] NULL,
	[CarParkingCharges] [money] NULL,
	[InterestonDefaultedCharges] [money] NULL,
	[RepaymentInstmntLoanInterest] [money] NULL,
	[NonOccupancyCharges] [money] NULL,
	[InsuranceCharges] [money] NULL,
	[LeaseRent] [money] NULL,
	[NonAgriculturalTax] [money] NULL,
	[OtherCharges] [money] NULL,
	[SecuritySalary] [money] NULL,
	[HousekeepingSalary] [money] NULL,
	[ManagerSalary] [money] NULL,
	[Stationary] [money] NULL,
	[DgSet] [money] NULL,
	[GymInstructor] [money] NULL,
	[CommunityHall] [money] NULL,
	[SupervisorSalary] [money] NULL,
	[TenantMaintenance] [money] NULL,
	[TotalMaintenanceSum] [money] NULL,
	[MaintenancePerFlat] [money] NULL,
	[PerSquareFeetRate] [money] NULL,
	[FixedSqft] [int] NULL,
	[FixedRate] [money] NULL,
	[AdditionalSqft] [int] NULL,
	[AdditionalSqftRate] [money] NULL,
	[EffectiveFromDate] [datetime] NOT NULL,
	[EffectiveToDate] [datetime] NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NULL,
	[ModifiedOn] [varchar](50) NULL,
 CONSTRAINT [PK_MaintenanceMaster] PRIMARY KEY CLUSTERED 
(
	[MaintenanceID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[MaintenanceMaster] ON
INSERT [dbo].[MaintenanceMaster] ([MaintenanceID], [PropertyType], [CalculationMethodId], [PropertyTaxes], [WaterCharges], [ElectricityCharges], [RepairsMaintenanceFund], [LiftCharges], [SinkingFund], [ServiceCharges], [CarParkingCharges], [InterestonDefaultedCharges], [RepaymentInstmntLoanInterest], [NonOccupancyCharges], [InsuranceCharges], [LeaseRent], [NonAgriculturalTax], [OtherCharges], [SecuritySalary], [HousekeepingSalary], [ManagerSalary], [Stationary], [DgSet], [GymInstructor], [CommunityHall], [SupervisorSalary], [TenantMaintenance], [TotalMaintenanceSum], [MaintenancePerFlat], [PerSquareFeetRate], [FixedSqft], [FixedRate], [AdditionalSqft], [AdditionalSqftRate], [EffectiveFromDate], [EffectiveToDate], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Residential', 1, NULL, 4500.0000, 23000.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0.0000, NULL, NULL, 0.0000, 32000.0000, 5200.0000, 6000.0000, 2000.0000, 0.0000, 0.0000, 0.0000, 10000.0000, 150.0000, 84700.0000, 28233.3301, 0.0000, 0, 0.0000, 0, 0.0000, CAST(0x0000A48B00000000 AS DateTime), CAST(0x0000000000000000 AS DateTime), 1, N'admin', CAST(0x0000A480015656B2 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[MaintenanceMaster] OFF
/****** Object:  Table [dbo].[ParkingMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ParkingMaster](
	[ParkingId] [int] IDENTITY(1,1) NOT NULL,
	[FlatId] [int] NOT NULL,
	[OwnerId] [int] NOT NULL,
	[IsParkingAvailable] [varchar](20) NULL,
	[ParkingType] [varchar](50) NOT NULL,
	[NumberOfParking] [int] NOT NULL,
	[Parking1] [varchar](20) NOT NULL,
	[Parking1Type] [varchar](50) NULL,
	[Parking2] [varchar](20) NOT NULL,
	[Parking2Type] [varchar](50) NULL,
	[Parking3] [varchar](20) NOT NULL,
	[Parking3Type] [varchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_ParkingMaster] PRIMARY KEY CLUSTERED 
(
	[ParkingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ParkingMaster] ON
INSERT [dbo].[ParkingMaster] ([ParkingId], [FlatId], [OwnerId], [IsParkingAvailable], [ParkingType], [NumberOfParking], [Parking1], [Parking1Type], [Parking2], [Parking2Type], [Parking3], [Parking3Type], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 2, 2, N'Yes', N'Open', 2, N'MH-5658744588', NULL, N'MH-8568745874', NULL, N'', NULL, 1, N'admin', CAST(0x0000A42200CC15FE AS DateTime), N'admin', CAST(0x0000A42200CCEA85 AS DateTime))
INSERT [dbo].[ParkingMaster] ([ParkingId], [FlatId], [OwnerId], [IsParkingAvailable], [ParkingType], [NumberOfParking], [Parking1], [Parking1Type], [Parking2], [Parking2Type], [Parking3], [Parking3Type], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 1, 1, N'Yes', N'Open,Stilt', 2, N'MH-9029568745', N'Stilt', N'MH-9029548745', N'Open', N'', N'', 1, N'admin', CAST(0x0000A42200CCA851 AS DateTime), N'admin', CAST(0x0000A4490142DE0E AS DateTime))
INSERT [dbo].[ParkingMaster] ([ParkingId], [FlatId], [OwnerId], [IsParkingAvailable], [ParkingType], [NumberOfParking], [Parking1], [Parking1Type], [Parking2], [Parking2Type], [Parking3], [Parking3Type], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 3, 3, N'Yes', N'Open', 1, N'MH-235685', NULL, N'', NULL, N'', NULL, 1, N'admin', CAST(0x0000A42201261DBF AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[ParkingMaster] OFF
/****** Object:  Table [dbo].[SocietyInfo]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SocietyInfo](
	[SocietyID] [int] IDENTITY(1,1) NOT NULL,
	[SocietyName] [varchar](250) NULL,
	[SocietyAddress] [varchar](550) NULL,
	[Logo] [varchar](50) NULL,
	[SocietyStamp] [varchar](50) NULL,
	[Secretorysign] [varchar](50) NULL,
	[Active] [bit] NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_SocietyInfo] PRIMARY KEY CLUSTERED 
(
	[SocietyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[SocietyInfo] ON
INSERT [dbo].[SocietyInfo] ([SocietyID], [SocietyName], [SocietyAddress], [Logo], [SocietyStamp], [Secretorysign], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Sai Sadan ', N'Sainik Schools Society Room No. 101, D-1 Wing, Sena Bhawan, New Delhi-110011 Tel: 011-23014731', N'Images/SocietyInfo/logo.png', N'Images/SocietyInfo/authorized-stamp.gif



', N'Images/SocietyInfo/sign.png', 1, N'Admin', CAST(0x0000A4450117EEB1 AS DateTime), N'admin', CAST(0x0000A448010FFDE9 AS DateTime))
INSERT [dbo].[SocietyInfo] ([SocietyID], [SocietyName], [SocietyAddress], [Logo], [SocietyStamp], [Secretorysign], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'sai', N'Sainik Schools Society Room No. 101, D-1 Wing, Sena Bhawan, New Delhi-110011 Tel: 011-23014731', N'Images/SocietyInfo/1logo.png', N'Images/SocietyInfo/1authorized-stamp.gif', N'Images/SocietyInfo/1sign.png', 0, N'admin', CAST(0x0000A4480119482B AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[SocietyInfo] OFF
/****** Object:  Table [dbo].[VehicleMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VehicleMaster](
	[Vehicleid] [int] IDENTITY(1,1) NOT NULL,
	[FlatId] [int] NOT NULL,
	[NoOfVehichle] [varchar](50) NOT NULL,
	[VehicleType1] [varchar](20) NULL,
	[VehicleNumber1] [varchar](20) NULL,
	[IsStickerGiven1] [bit] NULL,
	[VehicleType2] [varchar](20) NULL,
	[VehicleNumber2] [varchar](20) NULL,
	[IsStickerGiven2] [bit] NULL,
	[VehicleType3] [varchar](20) NULL,
	[VehicleNumber3] [varchar](20) NULL,
	[IsStickerGiven3] [bit] NULL,
	[VehicleType4] [varchar](20) NULL,
	[VehicleNumber4] [varchar](20) NULL,
	[IsStickerGiven4] [bit] NULL,
	[ExtraInfo] [varchar](50) NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_VehicleMaster] PRIMARY KEY CLUSTERED 
(
	[Vehicleid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[VehicleMaster] ON
INSERT [dbo].[VehicleMaster] ([Vehicleid], [FlatId], [NoOfVehichle], [VehicleType1], [VehicleNumber1], [IsStickerGiven1], [VehicleType2], [VehicleNumber2], [IsStickerGiven2], [VehicleType3], [VehicleNumber3], [IsStickerGiven3], [VehicleType4], [VehicleNumber4], [IsStickerGiven4], [ExtraInfo], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 1, N'Three', N'2-Wheeler', N'MH-1245254125', 0, N'2-Wheeler', N'MH-4758965874', 1, N'2-Wheeler', N'MH-7845748574', 0, N'', N'', 0, N'', 1, N'admin', CAST(0x0000A42200C45F8E AS DateTime), N'admin', CAST(0x0000A42200CB454F AS DateTime))
INSERT [dbo].[VehicleMaster] ([Vehicleid], [FlatId], [NoOfVehichle], [VehicleType1], [VehicleNumber1], [IsStickerGiven1], [VehicleType2], [VehicleNumber2], [IsStickerGiven2], [VehicleType3], [VehicleNumber3], [IsStickerGiven3], [VehicleType4], [VehicleNumber4], [IsStickerGiven4], [ExtraInfo], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 3, N'one', N'3-Wheeler', N'MH-5896471252', 1, N'', N'', 1, N'', N'', 0, N'', N'', 0, N'', 0, N'', CAST(0x0000A42200C97C51 AS DateTime), NULL, NULL)
INSERT [dbo].[VehicleMaster] ([Vehicleid], [FlatId], [NoOfVehichle], [VehicleType1], [VehicleNumber1], [IsStickerGiven1], [VehicleType2], [VehicleNumber2], [IsStickerGiven2], [VehicleType3], [VehicleNumber3], [IsStickerGiven3], [VehicleType4], [VehicleNumber4], [IsStickerGiven4], [ExtraInfo], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 2, N'one', N'2-Wheeler', N'MH-25HJ-1245', 0, N'', N'', 0, N'', N'', 0, N'', N'', 0, N'', 1, N'admin', CAST(0x0000A46B0127B3C4 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[VehicleMaster] OFF
/****** Object:  Table [dbo].[UserMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMaster](
	[UID] [bigint] IDENTITY(1,1) NOT NULL,
	[Login_Type] [varchar](50) NOT NULL,
	[ID] [varchar](50) NOT NULL,
	[Login_ID] [varchar](100) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[EmailID] [varchar](100) NULL,
	[Expiry_Date] [datetime] NULL,
	[Lock] [bit] NULL,
	[Role_ID] [bigint] NULL,
	[Subscription] [int] NOT NULL,
	[MobileNo] [varchar](20) NULL,
	[City] [varchar](150) NULL,
	[Country] [varchar](150) NULL,
	[CreatedBy] [varchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
	[DOE] [datetime] NULL,
	[Active] [bit] NOT NULL,
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[UID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[UserMaster] ON
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (1, N'Admin     ', N'2', N'admin', N'V1LKMi2gk6q607QQsDMrVtyVd1p1nvkPl86H0AbzLBGzZ10KXuFnsmKjBVAZeefeMkaw7smLbW3AWi8Q8L3m9wSNLFK0ZA==', N'akapkulkarni@gmail.com', CAST(0x0000B7EE00000000 AS DateTime), 0, 1, 3, NULL, NULL, NULL, NULL, CAST(0x0000A3FE010A2187 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (2, N'SocietyMember', N'3', N'pranav', N'2cxQLjPDIz+sdczBtwcSJsbomqtxNewVe+f9FuNhqmDswEkme7ro1x3kEXFtBw369FDRorQTSnKsU2PIo2X/pHrPoupp', N'pranavpanvel@gmail.com', CAST(0x0000A9A900000000 AS DateTime), 0, 2, 3, NULL, NULL, NULL, NULL, CAST(0x0000A3FE010A2187 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (11, N'SocietyMember', N'6', N'A002', N'enh9zm10hjQtBeOQ1wOZNVMR/CEf6WGfdJu3fsbudJO0ucBHeFbJYEOn+zq60owT/vCVI33YBlMZ9FWCrbEJC4Mw22rE', N'akapkulkarni@gmail.com', CAST(0x0000A9A900000000 AS DateTime), 0, 2, 3, NULL, NULL, NULL, NULL, CAST(0x0000A3FE010A2187 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (13, N'Employee', N'17', N'Rajesh', N'enh9zm10hjQtBeOQ1wOZNVMR/CEf6WGfdJu3fsbudJO0ucBHeFbJYEOn+zq60owT/vCVI33YBlMZ9FWCrbEJC4Mw22rE', N'rajeshg@gmail.com', CAST(0x0000A9A900000000 AS DateTime), 0, 4, 3, NULL, NULL, NULL, NULL, CAST(0x0000A3FE010A2187 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (14, N'Guest', N'5000', N'Guest1', N'enh9zm10hjQtBeOQ1wOZNVMR/CEf6WGfdJu3fsbudJO0ucBHeFbJYEOn+zq60owT/vCVI33YBlMZ9FWCrbEJC4Mw22rE', N'rahulsharma@gmail.com', CAST(0x0000A40100000000 AS DateTime), 0, 5, 3, NULL, NULL, NULL, NULL, CAST(0x0000A3FE010A2187 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (16, N'Guest', N'5001', N'pranav1', N'c1KgfdXojZ+xs4iWxzA1ZP9BZI9Qc75O+SVUhclONfNaIcQDlz7Uje3FyG5LffAvQ1ENfhUseqiMf3fXtIahyybbieLzmQ==', N'pranav@gmail.com', CAST(0x0000A40D0122158A AS DateTime), 1, 5, 1, N'9025854454', N'panvel', N'IN', N'Guest', CAST(0x0000A3FE0122158A AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (17, N'CommitteeMember', N'21', N'Rajesh', N'enh9zm10hjQtBeOQ1wOZNVMR/CEf6WGfdJu3fsbudJO0ucBHeFbJYEOn+zq60owT/vCVI33YBlMZ9FWCrbEJC4Mw22rE', N'rajeshg@gmail.com', CAST(0x0000A9A900000000 AS DateTime), 0, 3, 1, N'8956645454', NULL, NULL, NULL, CAST(0x0000A3FE010A2187 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (18, N'Guest', N'5002', N'a', N'a', N'a', CAST(0x0000A42A00C80526 AS DateTime), 0, 5, 3, N'95656565', N'klkl', N'oioi', N'pranav', CAST(0x0000A41B00C80526 AS DateTime), NULL, NULL, NULL, 1)
INSERT [dbo].[UserMaster] ([UID], [Login_Type], [ID], [Login_ID], [Password], [EmailID], [Expiry_Date], [Lock], [Role_ID], [Subscription], [MobileNo], [City], [Country], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn], [DOE], [Active]) VALUES (19, N'Admin     ', N'4', N'sunder', N'enh9zm10hjQtBeOQ1wOZNVMR/CEf6WGfdJu3fsbudJO0ucBHeFbJYEOn+zq60owT/vCVI33YBlMZ9FWCrbEJC4Mw22rE', N'akapkulkarni@gmail.com', CAST(0x0000B7EE00000000 AS DateTime), 0, 1, 1, NULL, NULL, NULL, NULL, CAST(0x0000A3FE010A2187 AS DateTime), NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
/****** Object:  Table [dbo].[TenantMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TenantMaster](
	[TenantId] [int] IDENTITY(1,1) NOT NULL,
	[FlatId] [int] NOT NULL,
	[TenantName] [varchar](50) NOT NULL,
	[ResidingFrom] [datetime] NOT NULL,
	[ResidingTo] [datetime] NULL,
	[Rent] [money] NOT NULL,
	[PAN] [varchar](10) NOT NULL,
	[AadhaarCard] [varchar](12) NULL,
	[PermanantAddress] [varchar](500) NOT NULL,
	[ContactNo1] [bigint] NOT NULL,
	[ContactNo2] [bigint] NULL,
	[DOB] [datetime] NULL,
	[Gender] [varchar](8) NULL,
	[Active] [bit] NOT NULL,
	[CreatedBy] [varchar](20) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[ModifiedBy] [varchar](20) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_TenantMaster] PRIMARY KEY CLUSTERED 
(
	[TenantId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[TenantMaster] ON
INSERT [dbo].[TenantMaster] ([TenantId], [FlatId], [TenantName], [ResidingFrom], [ResidingTo], [Rent], [PAN], [AadhaarCard], [PermanantAddress], [ContactNo1], [ContactNo2], [DOB], [Gender], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, 6, N'ddadas', CAST(0x0000A3FE00000000 AS DateTime), CAST(0x0000A40400000000 AS DateTime), 854.0000, N'AQWER4754D', N'90256565', N'fsffsfsf', 9021212121, 9456544565, CAST(0x0000A40A00000000 AS DateTime), N'Male', 1, N'Administrator', CAST(0x0000A3F600BEDA77 AS DateTime), NULL, NULL)
INSERT [dbo].[TenantMaster] ([TenantId], [FlatId], [TenantName], [ResidingFrom], [ResidingTo], [Rent], [PAN], [AadhaarCard], [PermanantAddress], [ContactNo1], [ContactNo2], [DOB], [Gender], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, 1, N'pranav1', CAST(0x0000A42000000000 AS DateTime), CAST(0x0000A42600000000 AS DateTime), 9500.0000, N'AWEDS5684R', N'564758568565', N'GDFH', 9658745856, 9658745845, CAST(0x0000A42600000000 AS DateTime), N'Female', 1, N'admin', CAST(0x0000A42200E33E8C AS DateTime), N'admin', CAST(0x0000A43300F5BEBD AS DateTime))
INSERT [dbo].[TenantMaster] ([TenantId], [FlatId], [TenantName], [ResidingFrom], [ResidingTo], [Rent], [PAN], [AadhaarCard], [PermanantAddress], [ContactNo1], [ContactNo2], [DOB], [Gender], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (3, 1, N'Komal1', CAST(0x0000A42500000000 AS DateTime), CAST(0x0000A42800000000 AS DateTime), 6000.0000, N'FVGHR3456T', N'654752365212', N'GFHJURTY', 9658745856, 9658745856, CAST(0x0000A42C00000000 AS DateTime), N'Female', 1, N'admin', CAST(0x0000A42200F6552B AS DateTime), N'admin', CAST(0x0000A433010154E5 AS DateTime))
INSERT [dbo].[TenantMaster] ([TenantId], [FlatId], [TenantName], [ResidingFrom], [ResidingTo], [Rent], [PAN], [AadhaarCard], [PermanantAddress], [ContactNo1], [ContactNo2], [DOB], [Gender], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (4, 1, N'abhi1', CAST(0x0000A42500000000 AS DateTime), CAST(0x0000A42800000000 AS DateTime), 6000.0000, N'FVGHR3456T', N'654752365212', N'GFHJURTY', 9658745856, 9658745856, CAST(0x0000A42C00000000 AS DateTime), N'Female', 1, N'admin', CAST(0x0000A42200F7231F AS DateTime), N'admin', CAST(0x0000A43301017BDD AS DateTime))
INSERT [dbo].[TenantMaster] ([TenantId], [FlatId], [TenantName], [ResidingFrom], [ResidingTo], [Rent], [PAN], [AadhaarCard], [PermanantAddress], [ContactNo1], [ContactNo2], [DOB], [Gender], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, 1, N'GBDX', CAST(0x0000A42500000000 AS DateTime), CAST(0x0000A42E00000000 AS DateTime), 7500.0000, N'ADEFF2354K', N'564758568548', N'YHF', 9658745856, 9658745865, CAST(0x0000A42500000000 AS DateTime), N'Male', 0, N'admin', CAST(0x0000A42200F7231F AS DateTime), NULL, NULL)
INSERT [dbo].[TenantMaster] ([TenantId], [FlatId], [TenantName], [ResidingFrom], [ResidingTo], [Rent], [PAN], [AadhaarCard], [PermanantAddress], [ContactNo1], [ContactNo2], [DOB], [Gender], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, 1, N'abc', CAST(0x0000A41D00000000 AS DateTime), CAST(0x0000A42000000000 AS DateTime), 4500.0000, N'ASWED3456T', N'965745845474', N'dfd', 9658745856, 9654585685, CAST(0x0000A42400000000 AS DateTime), N'Male', 0, N'admin', CAST(0x0000A42200FE2F97 AS DateTime), NULL, NULL)
INSERT [dbo].[TenantMaster] ([TenantId], [FlatId], [TenantName], [ResidingFrom], [ResidingTo], [Rent], [PAN], [AadhaarCard], [PermanantAddress], [ContactNo1], [ContactNo2], [DOB], [Gender], [Active], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (7, 1, N'xyz', CAST(0x0000A41300000000 AS DateTime), CAST(0x0000A43100000000 AS DateTime), 7500.0000, N'DFERF4564G', N'457474585685', N'GFDFG', 9658745856, 9658256541, CAST(0x0000A42C00000000 AS DateTime), N'Male', 0, N'admin', CAST(0x0000A42200FE81ED AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[TenantMaster] OFF
/****** Object:  Table [dbo].[SubscriptionMaster]    Script Date: 04/29/2015 19:22:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubscriptionMaster](
	[SubscriptionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[Created_On] [datetime] NOT NULL,
	[Created_By] [varchar](20) NOT NULL,
	[Modified_By] [varchar](20) NULL,
	[Modified_On] [datetime] NULL,
	[Active] [bit] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[SubscriptionMaster] ON
INSERT [dbo].[SubscriptionMaster] ([SubscriptionId], [Name], [Code], [Created_On], [Created_By], [Modified_By], [Modified_On], [Active]) VALUES (1, N'Basic', N'Basic', CAST(0x0000A3FB00000000 AS DateTime), N'Akshay', NULL, NULL, 1)
INSERT [dbo].[SubscriptionMaster] ([SubscriptionId], [Name], [Code], [Created_On], [Created_By], [Modified_By], [Modified_On], [Active]) VALUES (2, N'Economic', N'Eco', CAST(0x0000A3FB00000000 AS DateTime), N'Akshay', NULL, NULL, 1)
INSERT [dbo].[SubscriptionMaster] ([SubscriptionId], [Name], [Code], [Created_On], [Created_By], [Modified_By], [Modified_On], [Active]) VALUES (3, N'Professional', N'Pro', CAST(0x0000A3FB00000000 AS DateTime), N'Akshay', NULL, NULL, 1)
INSERT [dbo].[SubscriptionMaster] ([SubscriptionId], [Name], [Code], [Created_On], [Created_By], [Modified_By], [Modified_On], [Active]) VALUES (1, N'Basic', N'Basic', CAST(0x0000A3FB00000000 AS DateTime), N'Akshay', NULL, NULL, 1)
INSERT [dbo].[SubscriptionMaster] ([SubscriptionId], [Name], [Code], [Created_On], [Created_By], [Modified_By], [Modified_On], [Active]) VALUES (2, N'Economic', N'Eco', CAST(0x0000A3FB00000000 AS DateTime), N'Akshay', NULL, NULL, 1)
INSERT [dbo].[SubscriptionMaster] ([SubscriptionId], [Name], [Code], [Created_On], [Created_By], [Modified_By], [Modified_On], [Active]) VALUES (3, N'Professional', N'Pro', CAST(0x0000A3FB00000000 AS DateTime), N'Akshay', NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[SubscriptionMaster] OFF
/****** Object:  StoredProcedure [dbo].[GetEventDetailsbyName]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEventDetailsbyName]
		-- Add the parameters for the stored procedure here
	(
		@flag varchar(30),
	  @EventName varchar(200),
		@EventOn varchar (200)
		
		)
AS
BEGIN
	
	SET NOCOUNT ON;
	
    IF(@flag='searchbyEventname')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@EventOn <> '')
            begin
                set @SQL = @SQL + ' and EventOn like '''+ Convert(NVARCHAR(50),@EventOn)+'%'''
            END
            
            if(@EventName <> '')
            begin
              set @SQL = @SQL + ' and EventName like '''+ Convert(NVARCHAR(50),@EventName)+'%'''
            END

   IF(@EventName <> '')----EDIT
                    Begin   
                        exec('SELECT EventId,EventName,EventDescription,EventOn,ContactPerson,Contribution,MobileNo
                              From dbo.EventMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY EventId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('SELECT EventId,EventName,EventDescription,EventOn,ContactPerson,Contribution,MobileNo
                              From dbo.EventMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY EventId
                        ')  
                    END    
	
	END	   
END
GO
/****** Object:  StoredProcedure [dbo].[GetEventById]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<    ,   >
-- Createdate: <  ,  >
-- Description:	<Description,,>
-- EXEC [dbo].[TenantGetById] '3'
-- =============================================
CREATE PROCEDURE [dbo].[GetEventById]
	-- Add the parameters for the stored procedure here
	@EventId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT EventId,EventName,EventDescription,EventOn,ContactPerson,Contribution,FileUploadFileName,FileName,EventTime,MobileNo
			FROM EventMaster
	WHERE Active=1 and EventId = @EventId	
END
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeeInfo]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetEmployeeInfo]
	-- Add the parameters for the stored procedure here
	(
		@EmployeeId int 
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	

		IF(@EmployeeId != 0)
			BEGIN
			   Select EmployeeId,Name,EmployeeNo,JobDescription,ContactNo,Address,PAN,AadhaarCard,Salary,Designation,DOJ,DOL from dbo.EmployeeMaster where EmployeeId=@EmployeeId and Active=1
			END
		ELSE
		    BEGIN
				 Select EmployeeId,Name,EmployeeNo,JobDescription,ContactNo from dbo.EmployeeMaster where Active=1
		    END
		
END
GO
/****** Object:  StoredProcedure [dbo].[SocietyRegistrationGuest]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SocietyRegistrationGuest]
	-- Add the parameters for the stored procedure here
	(
		@UID int,
		@emailid varchar(100),
		@mobileno varchar(20),
		@Country varchar(100),
		@City varchar(150),
		@username varchar(50),
		@password varchar(200),
		@LoginType varchar(20),
		@RoleID int,
		@Subscription int,
		@CreatedBy varchar(20),
		@INS_OUT_MSG varchar OUTPUT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	Declare @id int,@MaxId int

	select @MaxId=Max(ID) from UserMaster where Login_Type=@LoginType
	set	@id = @MaxId+1

	if(@UID=0 or @UID='')
	BEGIN
		 IF NOT EXISTS(SELECT @UID FROM [dbo].[UserMaster] WHERE ACTIVE=1 and Login_ID=@username)
					BEGIN	
							INSERT INTO [dbo].[UserMaster](EmailID,MobileNo,Country,City,Login_ID,password,Login_Type,Role_ID,Subscription,ID,Lock,Expiry_Date,CreatedBy)
							VALUES(@emailid,@mobileno,@Country,@City,@username,@password,@LoginType,@RoleID,@Subscription,@id,0,DATEADD(day,15,GETDATE()),@CreatedBy)
							SET @INS_OUT_MSG='Registration Done Successfully!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='UserName Already Exists..!!'
					    END
	END


END
GO
/****** Object:  StoredProcedure [dbo].[SocietyLogin_LockCheck]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SocietyLogin_LockCheck]
	-- Add the parameters for the stored procedure here
	(
		@LoginId varchar(50)
    )
AS
BEGIN

SET NOCOUNT ON;
	 declare @lock varchar(50),@INS_OUT_MSG varchar(350)
	SET @INS_OUT_MSG='';
	
	set @lock = (select Lock From [dbo].[UserMaster] where Login_ID=@LoginId)
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
			IF(@lock=0)
				BEGIN
					IF(@LoginId <> '')
					BEGIN
	  
						SELECT a.UID,LTRIM(RTRIM(a.Login_Type)) [Login_Type],a.ID,a.Login_ID,a.Password,a.EmailID,a.Expiry_Date,a.Lock,a.Role_ID,a.Subscription,a.DOE
						FROM [dbo].[UserMaster] a
						WHERE a.Active=1 AND Login_ID=@LoginId and Lock=0 and Convert(varchar(10),GETDATE(),120) <= Convert(varchar(10),Expiry_Date,120)
					END
				END
			ELSE
			   BEGIN
			     SET @INS_OUT_MSG='Your Account Is lock Please Contact Administratot.';
			   END

	END


END
GO
/****** Object:  StoredProcedure [dbo].[SocietyLogin_LockAccount]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SocietyLogin_LockAccount]
	-- Add the parameters for the stored procedure here
		(
		@LoginId varchar(50),
		@INS_OUT_MSG varchar(300) OUTPUT
    )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF(@LoginId <> '')
				BEGIN
						Update [dbo].[UserMaster] set Lock=1 where @LoginId=Login_ID
						set @INS_OUT_MSG='Your Account is Lock For more info contact administrator!'
				END
END
GO
/****** Object:  StoredProcedure [dbo].[SocietyLogin_Check]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pramod
-- Create date: 01/04/1990
-- Description:	Login Check
--exec [dbo].[SocietyLogin_Check] 'pranav'
-- =============================================
CREATE PROCEDURE [dbo].[SocietyLogin_Check] 
	-- Add the parameters for the stored procedure here
	(
		@LoginId varchar(50)
    )
AS
 DECLARE @LoginType varchar(40)
BEGIN
	IF(@LoginId <> '')
	BEGIN
			 set @LoginType=(select Login_Type from UserMaster where Active=1and Login_ID=@LoginId)
					print @LoginType
			 IF(@LoginType='Admin')
				 BEGIN
					 SELECT  a.UID,LTRIM(RTRIM(a.Login_Type)) [Login_Type],a.ID,a.Login_ID,a.Password,a.EmailID,a.Expiry_Date,a.Lock,a.Role_ID,a.Subscription,a.DOE
						FROM [dbo].[UserMaster] a
						WHERE a.Active=1 AND a.Login_ID=@LoginId and Convert(varchar(10),GETDATE(),120) <= Convert(varchar(10),a.Expiry_Date,120)
				 END

			 IF(@LoginType='SocietyMember')
				 BEGIN
					 SELECT  f.FlatId,f.IsRented,f.FlatNumber,a.UID,LTRIM(RTRIM(a.Login_Type)) [Login_Type],a.ID,a.Login_ID,a.Password,a.EmailID,a.Expiry_Date,a.Lock,a.Role_ID,a.Subscription,a.DOE
						FROM [dbo].[UserMaster] a
						inner join FlatMaster f on f.OwnerId =a.ID
						WHERE a.Active=1 AND a.Login_ID=@LoginId and Convert(varchar(10),GETDATE(),120) <= Convert(varchar(10),a.Expiry_Date,120)
				 END
	
			  IF(@LoginType='Employee')
				 BEGIN
					SELECT  f.FlatId,f.IsRented,f.FlatNumber,a.UID,LTRIM(RTRIM(a.Login_Type)) [Login_Type],a.ID,a.Login_ID,a.Password,a.EmailID,a.Expiry_Date,a.Lock,a.Role_ID,a.Subscription,a.DOE
						FROM [dbo].[UserMaster] a
						inner join FlatMaster f on f.OwnerId =a.ID
						WHERE a.Active=1 AND a.Login_ID=@LoginId and Convert(varchar(10),GETDATE(),120) <= Convert(varchar(10),a.Expiry_Date,120)
				 END

		     IF(@LoginType='Guest')
				 BEGIN
					  SELECT  f.FlatId,f.IsRented,f.FlatNumber,a.UID,LTRIM(RTRIM(a.Login_Type)) [Login_Type],a.ID,a.Login_ID,a.Password,a.EmailID,a.Expiry_Date,a.Lock,a.Role_ID,a.Subscription,a.DOE
						FROM [dbo].[UserMaster] a
						inner join FlatMaster f on f.OwnerId =a.ID
						WHERE a.Active=1 AND a.Login_ID=@LoginId and Convert(varchar(10),GETDATE(),120) <= Convert(varchar(10),a.Expiry_Date,120)
				 END

				 IF(@LoginType='CommitteeMember')
				 BEGIN
					  SELECT  f.FlatId,f.IsRented,f.FlatNumber,a.UID,LTRIM(RTRIM(a.Login_Type)) [Login_Type],a.ID,a.Login_ID,a.Password,a.EmailID,a.Expiry_Date,a.Lock,a.Role_ID,a.Subscription,a.DOE
						FROM [dbo].[UserMaster] a
						inner join FlatMaster f on f.OwnerId =a.ID
						WHERE a.Active=1 AND a.Login_ID=@LoginId and Convert(varchar(10),GETDATE(),120) <= Convert(varchar(10),a.Expiry_Date,120)
				 END

		


	END
END
GO
/****** Object:  StoredProcedure [dbo].[TenantGetById]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<    ,   >
-- Createdate: <  ,  >
-- Description:	<Description,,>
-- EXEC [dbo].[TenantGetById] '3'
-- =============================================
CREATE PROCEDURE [dbo].[TenantGetById]
	-- Add the parameters for the stored procedure here
	@TenantId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TenantId,FlatId,TenantName,ResidingFrom,ResidingTo,Rent,PAN,
			AadhaarCard,PermanantAddress,ContactNo1,ContactNo2
			FROM TenantMaster 
	WHERE Active=1 and TenantId = @TenantId	
END
GO
/****** Object:  StoredProcedure [dbo].[TenantDetailsGet]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Akshay Kulkarni>
-- Createdate: <Create Date,08-JUNE-2014>
-- Description:	<Description,,>
-- Exec [dbo].[GetExamMaster]  
-- =============================================
CREATE PROCEDURE [dbo].[TenantDetailsGet] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    
		SELECT TenantId,FlatId,TenantName,ResidingFrom,ResidingTo,Rent,PAN,AadhaarCard,PermanantAddress,ContactNo1,ContactNo2
		FROM TenantMaster 
	    WHERE Active=1
	
END
GO
/****** Object:  StoredProcedure [dbo].[TenantMasterInsert]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<      ,      >
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TenantMasterInsert]
	-- Add the parameters for the stored procedure here
	(
		@TenantId int,
		@FlatNo varchar(50),
		@TenantName varchar(50),
		@ResidingFrom datetime,
		@ResidingTo datetime,
		@Rent money,
		@PAN varchar(10),
		@AadhaarCard varchar(12),
		@PermanantAddress varchar(500),
		@ContactNo1 varchar(50),
		@ContactNo2 varchar(50),
		@Createdby varchar(100),
		@INS_OUT_MSG varchar(350) OUTPUT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result SETs from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	SET @INS_OUT_MSG = ''
    -- Insert statements for procedure here
    IF(@TenantId=0)	
			BEGIN
				INSERT INTO TenantMaster(FlatId,TenantName,ResidingFrom,ResidingTo,Rent,PAN,AadhaarCard,PermanantAddress,ContactNo1,ContactNo2,CreatedBy,CreatedOn)
				VALUES(@FlatNo,@TenantName,@ResidingFrom,@ResidingTo,@Rent,@PAN,@AadhaarCard,@PermanantAddress,@ContactNo1,@ContactNo2,@Createdby,getdate())
				SET @INS_OUT_MSG = 'Record Inserted Successfully..!!'				
			END
	ELSE
			BEGIN
				UPDATE TenantMaster SET FlatId=@FlatNo,TenantName=@TenantName,ResidingFrom=@ResidingFrom,
										ResidingTo=@ResidingTo,Rent=@Rent,PAN=@PAN,AadhaarCard=@AadhaarCard,
										PermanantAddress=@PermanantAddress,ContactNo1=@ContactNo1,
										ContactNo2=@ContactNo2,ModifiedBy=@Createdby,ModifiedOn=Getdate()
										WHERE TenantId=@TenantId and Active=1	
				SET @INS_OUT_MSG = 'Record Updated Successfully..!!'				
			END	
								
END
GO
/****** Object:  StoredProcedure [dbo].[Society_UserInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  Pramod  
-- Create date: 02/05/2014  
-- Description: insert user info  
-- SELECT * from t_usermaster  
-- =============================================  
CREATE PROCEDURE [dbo].[Society_UserInfo]   
 -- Add the parameters for the stored procedure here     
 @username varchar(50),
 @mobileno varchar(50),  
 @password varchar(150),  
 @emailid varchar(50),  
 @fullname varchar(50), 
 @wing varchar(50), 
 @flatno varchar(50),  
 @INS_OUT_MSG VARCHAR(50) OUTPUT  
AS  
BEGIN  
 -- SET NOCOUNT ON added to prevent extra result SETs from  
 -- interfering with SELECT statements.  
 SET NOCOUNT ON  
 SET @INS_OUT_MSG = ''  
  
    -- Insert statements for procedure here  
    IF NOT EXISTS(SELECT UID FROM Society_reg WHERE Wings=@wing AND Flatno=@flatno)
  BEGIN  
  INSERT INTO Society_reg(Fullname,Username,Password,Emailid,Mobileno,Wings,Flatno)  
  VALUES ( @fullname,@username,@password,@emailid,@mobileno,@wing,@flatno)
  SET @INS_OUT_MSG = 'Registration Done Successfully..!!'  
  END  
  ELSE
    BEGIN  
   SELECT '0' as [UID]  
   SET @INS_OUT_MSG = 'UserName Already Exists..!!'  
    END  
END
GO
/****** Object:  StoredProcedure [dbo].[ParkingGetById]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<    ,   >
-- Createdate: <  ,  >
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ParkingGetById]
	-- Add the parameters for the stored procedure here
	@ParkingId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ParkingId,FlatId,OwnerId,ParkingType,NumberOfParking,Parking1,Parking2,Parking3,Parking1Type,Parking2Type,Parking3Type
			FROM ParkingMaster
	WHERE Active=1 and ParkingId = @ParkingId	
END
GO
/****** Object:  StoredProcedure [dbo].[ParkingDetailsGet]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<,>
-- Createdate: <Create Date,08-JUNE-2014>
-- Description:	<Description,,>
-- Exec [ParkingDetailsGet] 0  
-- =============================================
CREATE PROCEDURE [dbo].[ParkingDetailsGet] 
	-- Add the parameters for the stored procedure here
	@ParkingId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    if(@ParkingId !=0)
    BEGIN
		SELECT a.ParkingId,c.FlatNumber,b.OwnerName1 as OwnerName,a.IsParkingAvailable,a.FlatId,a.OwnerId,a.ParkingType,a.NumberOfParking,a.Parking1,a.Parking2,a.Parking3,a.Parking1Type,a.Parking2Type,a.Parking3Type
		FROM ParkingMaster a
		Inner join dbo.OwnerMaster b On b.OwnerId =a.OwnerId
		Inner join dbo.FlatMaster c ON a.FlatId=c.FlatId
	    WHERE a.Active=1 and a.ParkingId=@ParkingId
	END
ELSE
	BEGIN
		SELECT a.ParkingId,c.FlatNumber,b.OwnerName1 as OwnerName,a.IsParkingAvailable,a.FlatId,a.OwnerId,a.ParkingType,a.NumberOfParking,a.Parking1,a.Parking2,a.Parking3,a.Parking1Type,a.Parking2Type,a.Parking3Type
		FROM ParkingMaster a
		Inner join dbo.OwnerMaster b On b.OwnerId =a.OwnerId
		Inner join dbo.FlatMaster c ON a.FlatId=c.FlatId
	    WHERE a.Active=1
	END    
	
END
GO
/****** Object:  StoredProcedure [dbo].[MaintenanceGetById]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<    ,   >
-- Createdate: <  ,  >
-- Description:	<Description,,>
-- EXEC [dbo].[MaintainanceGetById] 3,'getallrecordbyMenid'
-- =============================================
CREATE PROCEDURE [dbo].[MaintenanceGetById]
	-- Add the parameters for the stored procedure here	
    (
	@MaintenanceID int,
	@flag varchar(35)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   if(@flag='getallrecordbyMenid')
		
		BEGIN
		IF(@MaintenanceID != 0)
			BEGIN
			  select m.MaintenanceID,c.CalculationMethod as CalculationMethodName ,m.CalculationMethodId,m.PropertyType,m.PropertyTaxes,m.WaterCharges,m.ElectricityCharges,m.RepairsMaintenanceFund,m.LiftCharges,m.SinkingFund,m.ServiceCharges,m.CarParkingCharges,m.InterestonDefaultedCharges,m.RepaymentInstmntLoanInterest,m.NonOccupancyCharges,m.InsuranceCharges,m.LeaseRent,m.NonAgriculturalTax,m.OtherCharges,m.OtherCharges,m.TotalMaintenanceSum,m.MaintenancePerFlat,m.PerSquareFeetRate,m.FixedSqft,m.FixedRate,m.AdditionalSqft,m.AdditionalSqftRate,m.EffectiveFromDate,m.EffectiveToDate
			   from [dbo].[MaintenanceMaster] m
			   inner join  [dbo].[MaintenanceCaltypeMaster] c on c.CalcMasterID =m.CalculationMethodId 
			   where m.Active=1 and m.MaintenanceID=@MaintenanceID
			END
		ELSE
		    BEGIN
			   select m.MaintenanceID,c.CalculationMethod as CalculationMethodName,m.CalculationMethodId,m.PropertyType,m.PropertyTaxes,m.WaterCharges,m.ElectricityCharges,m.RepairsMaintenanceFund,m.LiftCharges,m.SinkingFund,m.ServiceCharges,m.CarParkingCharges,m.InterestonDefaultedCharges,m.RepaymentInstmntLoanInterest,m.NonOccupancyCharges,m.InsuranceCharges,m.LeaseRent,m.NonAgriculturalTax,m.OtherCharges,m.OtherCharges,m.TotalMaintenanceSum,m.MaintenancePerFlat,m.PerSquareFeetRate,m.FixedSqft,m.FixedRate,m.AdditionalSqft,m.AdditionalSqftRate,m.EffectiveFromDate,m.EffectiveToDate
			   from [dbo].[MaintenanceMaster] m
			   inner join  [dbo].[MaintenanceCaltypeMaster] c on c.CalcMasterID =m.CalculationMethodId 
			   where m.Active=1
		    END
		END
END
GO
/****** Object:  StoredProcedure [dbo].[ParkingMasterInsert]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<      ,      >
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC ParkingMasterInsert 0,6,2,'Open',1,'gg','','','',''
-- =============================================
CREATE PROCEDURE [dbo].[ParkingMasterInsert]
	-- Add the parameters for the stored procedure here
	(
	    @ParkingId int,
		@FlatId int,
		@OwnerId int,
		@IsParkingAvailable varchar(20),
		@ParkingType varchar(50),
		@NumberOfParking int,
		@Parking1 varchar(50),
		@Parking2 varchar(50),
		@Parking3 varchar(50),
		@Parking1Type varchar(50),
		@Parking2Type varchar(50),
		@Parking3Type varchar(50),
		@Createdby varchar(50),
		@INS_OUT_MSG VARCHAR(50) OUTPUT  
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result SETs from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	SET @INS_OUT_MSG = ''
    -- Insert statements for procedure here
    IF(@ParkingId != 0 )
			
			BEGIN
				
				
				UPDATE ParkingMaster
				 SET FlatId=@FlatId,OwnerId=@OwnerId,IsParkingAvailable=@IsParkingAvailable,ParkingType=@ParkingType,
										NumberOfParking=@NumberOfParking,Parking1=@Parking1,
										Parking2=@Parking2,Parking3=@Parking3,Parking1Type=@Parking1Type,Parking2Type=@Parking2Type,Parking3Type=@Parking3Type,
										ModifiedBy=@Createdby,ModifiedOn=Getdate()
										WHERE ParkingId=@ParkingId
				SET @INS_OUT_MSG = 'Record Updated Successfully..!!'	
							
			END
	ELSE
			BEGIN
			 IF NOT EXISTS(SELECT @ParkingId FROM dbo.ParkingMaster WHERE ACTIVE=1 and FlatId=@FlatId)
				INSERT INTO ParkingMaster(FlatId,OwnerId,IsParkingAvailable,ParkingType,NumberOfParking,Parking1,Parking2,Parking3,Parking1Type,Parking2Type,Parking3Type,CreatedBy,CreatedOn)
				VALUES(@FlatId,@OwnerId,@IsParkingAvailable,@ParkingType,@NumberOfParking,@Parking1,@Parking2,@Parking3,@Parking1Type,@Parking2Type,@Parking3Type,@Createdby,getdate())
				SET @INS_OUT_MSG = 'Record Inserted Successfully..!!'				
			END	
								
END
GO
/****** Object:  StoredProcedure [dbo].[MonthlyMaintenance]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- EXEC	 [dbo].[MonthlyMaintenance]  'Admin',3,'01/02/2015'
--EXEC [dbo].[MonthlyMaintenance]  'SocietyMember',2,'01/01/2015'
-- =============================================
CREATE PROCEDURE [dbo].[MonthlyMaintenance] 
	-- Add the parameters for the stored procedure here
	 (
	 @Login_Type varchar(50),
	 @flatNumber int=null,
	 @ReportDate varchar(50)=null
	 	 
	 ) 
AS
BEGIN
  DECLARE @PropType varchar(20), @OwnerID int,@IsRented varchar(3),@flatcount varchar(10), @CurrentMonth varchar(50),@CurrentYear varchar(50), @CalculationMethod int,@YearMonth varchar(50),@totalArea varchar(50)
		
		  SET @PropType =''
		  SET @OwnerID=(select OwnerId from [dbo].[FlatMaster] where FlatId=@flatNumber)

		print @OwnerID
	SELECT @PropType = PropertyType, @IsRented = CASE WHEN IsRented ='1' THEN 'Yes' else 'No' END 
	FROM FlatMaster f
	INNER JOIN OwnerMaster o on o.OwnerId = f.OwnerId 
	WHERE o.OwnerId = @OwnerID

	  print @PropType

	SET @CurrentMonth = (SELECT MONTH(GETDATE()))
		SET @CurrentYear = (SELECT year(GETDATE()))		  
		SET @YearMonth = CONVERT(datetime, CONVERT(NVARCHAR,(CONVERT(varchar(2),1) +'/'+ @CurrentMonth + '/' + @CurrentYear)),103)
		SET @totalArea= (SELECT TotalArea from FlatMaster where OwnerId=@OwnerID	)
		SET @flatcount=	 (SELECT count(*) from FlatMaster)

	   print @Login_Type
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 
	SET NOCOUNT ON;
		
    -- Insert statements for procedure here
	IF(@Login_Type='Admin')
		BEGIN
			 IF(@PropType = 'Residential')
			BEGIN
					SELECT @flatcount as FlatCount,@totalArea as TotalArea,M.MaintenanceID,m.PropertyType,CalculationMethodId,MC.CalculationMethod,PropertyTaxes,WaterCharges,ElectricityCharges,RepairsMaintenanceFund,
						LiftCharges,SinkingFund,ServiceCharges,CarParkingCharges,InterestonDefaultedCharges,RepaymentInstmntLoanInterest,
						NonOccupancyCharges,InsuranceCharges,LeaseRent,NonAgriculturalTax,OtherCharges,TotalMaintenanceSum,MaintenancePerFlat,
						PerSquareFeetRate,FixedSqft,FixedRate,AdditionalSqft,AdditionalSqftRate,CONVERT(varchar(11),EffectiveFromDate) as EffectiveFromDate,
						CONVERT(varchar(11),EffectiveToDate) as EffectiveToDate,o.OwnerName1 as OwnerName,R.AmountBalance,F.FlatNumber,f.BusinessType,f.LicenseNo,f.ShopDescription,b.Name as BuildingName,( CONVERT(money, PerSquareFeetRate) *  CONVERT(money, @totalArea)) as SqFeetAmount, U.Login_ID,u.EmailID, (CONVERT(varchar(50),@ReportDate)) as EffectiveFromDate1 
					FROM [MaintenanceMaster] M
					INNER JOIN [dbo].[ResidentialMaintenance] R on R.MaintenanceID=M.MaintenanceID
					INNER JOIN [dbo].[FlatMaster]  F ON F.FlatId= R.FlatId
					INNER JOIN [dbo].[BuildingMaster] B ON B.BuildingId =F.BuildingId
					INNER JOIN [dbo].[UserMaster]  U ON u.ID = @OwnerID 
					INNER JOIN [dbo].[MaintenanceCaltypeMaster] MC ON MC.CalcMasterID = m.CalculationMethodId 
					INNER JOIN [dbo].[OwnerMaster]  o ON o.OwnerId= f.OwnerId
					 --	select * from [MaintenanceMaster]
					 --	select * from [ResidentialMaintenance]
					 --	select * from [FlatMaster]
					 --	select * from [BuildingMaster]
					 --	select * from [dbo].[UserMaster]
					 --	select * from [dbo].[MaintenanceCaltypeMaster]
					 -- select * from  [dbo].[OwnerMaster]
					WHERE M.Active=1 and M.EffectiveFromDate=CONVERT(DATETIME, @ReportDate, 103) and M.PropertyType=@PropType  and R.FlatId=@flatNumber

					select * from SocietyInfo
			END
			ELSE IF(@PropType = 'Commercial')
			BEGIN
					SELECT @flatcount as FlatCount,@totalArea as TotalArea,M.MaintenanceID,PropertyType,CalculationMethodId,PropertyTaxes,WaterCharges,ElectricityCharges,RepairsMaintenanceFund,
						LiftCharges,SinkingFund,ServiceCharges,CarParkingCharges,InterestonDefaultedCharges,RepaymentInstmntLoanInterest,
						NonOccupancyCharges,InsuranceCharges,LeaseRent,NonAgriculturalTax,OtherCharges,TotalMaintenanceSum,MaintenancePerFlat,
						PerSquareFeetRate,FixedSqft,FixedRate,AdditionalSqft,AdditionalSqftRate,CONVERT(varchar(11),EffectiveFromDate) as EffectiveFromDate,
						CONVERT(varchar(11),EffectiveToDate) as EffectiveToDate,(CONVERT(varchar(50),@ReportDate)) as EffectiveFromDate1 
					FROM [MaintenanceMaster] M
					INNER JOIN  [dbo].[ResidentialMaintenance] R on R.MaintenanceID=M.MaintenanceID 
					WHERE M.Active=1 and M.EffectiveFromDate=CONVERT(DATETIME, @ReportDate, 103) and M.PropertyType=@PropType and R.FlatId=@flatNumber

					select * from SocietyInfo
			END
		END
	 ELSE IF(@Login_Type='SocietyMember')
	    BEGIN
			   IF(@PropType = 'Residential')
			BEGIN
					SELECT @flatcount as FlatCount,@totalArea as TotalArea,M.MaintenanceID,m.PropertyType,CalculationMethodId,MC.CalculationMethod,PropertyTaxes,WaterCharges,ElectricityCharges,RepairsMaintenanceFund,
						LiftCharges,SinkingFund,ServiceCharges,CarParkingCharges,InterestonDefaultedCharges,RepaymentInstmntLoanInterest,
						NonOccupancyCharges,InsuranceCharges,LeaseRent,NonAgriculturalTax,OtherCharges,TotalMaintenanceSum,MaintenancePerFlat,
						PerSquareFeetRate,FixedSqft,FixedRate,AdditionalSqft,AdditionalSqftRate,CONVERT(varchar(11),EffectiveFromDate) as EffectiveFromDate,
						CONVERT(varchar(11),EffectiveToDate) as EffectiveToDate,o.OwnerName1 as OwnerName,R.AmountBalance,F.FlatNumber,f.BusinessType,f.LicenseNo,f.ShopDescription,b.Name as BuildingName,( CONVERT(money, PerSquareFeetRate) *  CONVERT(money, @totalArea)) as SqFeetAmount, U.Login_ID,u.EmailID, (CONVERT(varchar(50),@ReportDate)) as EffectiveFromDate1 
					FROM [MaintenanceMaster] M
					INNER JOIN [dbo].[ResidentialMaintenance] R on R.MaintenanceID=M.MaintenanceID
					INNER JOIN [dbo].[FlatMaster]  F ON F.FlatId= R.FlatId
					INNER JOIN [dbo].[BuildingMaster] B ON B.BuildingId =F.BuildingId
					INNER JOIN [dbo].[UserMaster]  U ON u.ID = @OwnerID 
					INNER JOIN [dbo].[MaintenanceCaltypeMaster] MC ON MC.CalcMasterID = m.CalculationMethodId 
					INNER JOIN [dbo].[OwnerMaster]  o ON o.OwnerId= f.OwnerId
					
					WHERE M.Active=1 and M.EffectiveFromDate=CONVERT(DATETIME, @ReportDate, 103) and M.PropertyType=@PropType  and R.FlatId=@flatNumber

					select * from SocietyInfo
			END
			ELSE IF(@PropType = 'Commercial')
			BEGIN
					SELECT @flatcount as FlatCount,@totalArea as TotalArea,M.MaintenanceID,PropertyType,CalculationMethodId,PropertyTaxes,WaterCharges,ElectricityCharges,RepairsMaintenanceFund,
						LiftCharges,SinkingFund,ServiceCharges,CarParkingCharges,InterestonDefaultedCharges,RepaymentInstmntLoanInterest,
						NonOccupancyCharges,InsuranceCharges,LeaseRent,NonAgriculturalTax,OtherCharges,TotalMaintenanceSum,MaintenancePerFlat,
						PerSquareFeetRate,FixedSqft,FixedRate,AdditionalSqft,AdditionalSqftRate,CONVERT(varchar(11),EffectiveFromDate) as EffectiveFromDate,
						CONVERT(varchar(11),EffectiveToDate) as EffectiveToDate,(CONVERT(varchar(50),@ReportDate)) as EffectiveFromDate1 
					FROM [MaintenanceMaster] M
					INNER JOIN  [dbo].[ResidentialMaintenance] R on R.MaintenanceID=M.MaintenanceID 
					WHERE M.Active=1 and M.EffectiveFromDate=CONVERT(DATETIME, @ReportDate, 103) and M.PropertyType=@PropType

					select * from SocietyInfo
			END
		END

		
END
GO
/****** Object:  StoredProcedure [dbo].[InstertVehicleInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InstertVehicleInfo]
	-- Add the parameters for the stored procedure here
	(
		@Vehicleid int,
		@FlatId int,
		@NoOfVehichle varchar(15),
		@VehicleType1 varchar(15),
		@VehicleNumber1 varchar(15),
		@IsStickerGiven1 bit,
		@VehicleType2 varchar(15),
		@VehicleNumber2 varchar(15),
		@IsStickerGiven2 bit,
		@VehicleType3 varchar(15),
		@VehicleNumber3 varchar(15),
		@IsStickerGiven3 bit,
		@VehicleType4 varchar(15),
		@VehicleNumber4 varchar(15),
		@IsStickerGiven4 bit,
		@ExtraInfo varchar(1000),
		@CreatedBy varchar(15),
		@INS_OUT_MSG VARCHAR(50) OUTPUT  
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@Vehicleid != 0)
			
		      BEGIN
					UPDATE VehicleMaster
					 SET FlatId=@FlatId,NoOfVehichle=@NoOfVehichle,VehicleType1=@VehicleType1,VehicleNumber1=@VehicleNumber1,IsStickerGiven1=@IsStickerGiven1,VehicleType2=@VehicleType2,VehicleNumber2=@VehicleNumber2,IsStickerGiven2=@IsStickerGiven2,VehicleType3=@VehicleType3,VehicleNumber3=@VehicleNumber3,IsStickerGiven3=@IsStickerGiven3,VehicleType4=@VehicleType4,VehicleNumber4=@VehicleNumber4,IsStickerGiven4=@IsStickerGiven4,ExtraInfo=@ExtraInfo,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					WHERE Vehicleid = @Vehicleid	
					SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				  IF NOT EXISTS(SELECT @Vehicleid FROM dbo.VehicleMaster WHERE ACTIVE=1 and FlatId=@FlatId)
					BEGIN	
							INSERT INTO VehicleMaster(FlatId,NoOfVehichle,VehicleType1,VehicleNumber1,IsStickerGiven1,VehicleType2,VehicleNumber2,IsStickerGiven2,VehicleType3,VehicleNumber3,IsStickerGiven3,VehicleType4,VehicleNumber4,IsStickerGiven4,ExtraInfo,CreatedBy,CreatedOn)
							VALUES(@FlatId,@NoOfVehichle,@VehicleType1,@VehicleNumber1,@IsStickerGiven1,@VehicleType2,@VehicleNumber2,@IsStickerGiven2,@VehicleType3,@VehicleNumber3,@IsStickerGiven3,@VehicleType4,@VehicleNumber4,@IsStickerGiven4,@ExtraInfo,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertSocietyInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertSocietyInfo]
	-- Add the parameters for the stored procedure here
	(
		@ID	int,
		@societyName varchar(50),
		@SocietyAddress	varchar(1000),
		@FuLogo varchar(100),
		@fustamp varchar(100),
		@fuSign varchar(100),
		@CreatedBy varchar(100),
		@INS_OUT_MSG varchar(350) output
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@ID != 0)
			
		      BEGIN
					 UPDATE [dbo].[SocietyInfo]
					 SET SocietyName=@societyName, SocietyAddress=@SocietyAddress,Logo=@FuLogo,SocietyStamp=@fustamp,Secretorysign=@fuSign,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					 WHERE SocietyID = @ID	
					 SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				  IF NOT EXISTS(SELECT @ID FROM [dbo].[BasicInformation] WHERE Active=1 and ID=@ID)
					BEGIN	
							INSERT INTO [dbo].[SocietyInfo](SocietyName,SocietyAddress,Logo,SocietyStamp,Secretorysign,CreatedBy,CreatedOn)
							VALUES(@societyName,@SocietyAddress,@FuLogo,@fustamp,@fuSign,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertSecuritysalaryInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec [InsertSecuritysalaryInfo] ,1,8000,1,10000,'sasa',18000,'',''
-- =============================================
CREATE PROCEDURE [dbo].[InsertSecuritysalaryInfo]
-- Add the parameters for the stored procedure here
	(
	@SecurityId int,
	@NoOfSecurityGuards int,
	@GuardSalary int,
	@TotalGuardsal int,
	@NoOfSupervisor int,
	@SupervisorSalary int,
	@CompanyName varchar(100),
	@TotalSalary int,
	@CreatedBy varchar(20), 
		@INS_OUT_MSG VARCHAR(50) OUTPUT )
		AS
BEGIN
	SET NOCOUNT ON;
	
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@SecurityId != 0)
			
		      BEGIN
		      UPDATE SecuritySalaryMaster
		      SET NoOfSecurityGuards=@NoOfSecurityGuards,GuardSalary=@GuardSalary,TotalGuardsal=@TotalGuardsal,NoOfSupervisor=@NoOfSupervisor, SupervisorSalary=@SupervisorSalary,CompanyName=@CompanyName,TotalSalary=@TotalSalary,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
		      WHERE SecurityId=@SecurityId 
		      SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
			   
		ELSE
				BEGIN
				IF NOT EXISTS(SELECT @SecurityId FROM dbo.SecuritySalaryMaster WHERE Active=1 and CompanyName=@CompanyName)
					BEGIN	
							INSERT INTO SecuritySalaryMaster(NoOfSecurityGuards,
GuardSalary,
TotalGuardsal,
NoOfSupervisor,
SupervisorSalary,
CompanyName,
TotalSalary,CreatedBy,CreatedOn)
							VALUES(@NoOfSecurityGuards,
							
@GuardSalary,
@TotalGuardsal,
@NoOfSupervisor,
@SupervisorSalary,
@CompanyName,
@TotalSalary,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOwnerInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- EXEC [dbo].[InsertOwnerInfo] 3,'pranav',9658745856,'ff','ff','add','HGG',8745454545,'ASDF1234J','212457896321',1,'','','28/10/1988','28/10/1988','28/10/1988','administrator','',''
-- =============================================
CREATE PROCEDURE [dbo].[InsertOwnerInfo]
	-- Add the parameters for the stored procedure here
	   (
	   @OwnerId int,
		@OwnerName varchar(100),
		@ContactNo bigint,
		@Occupation varchar(500),
		@permanentAddress varchar(1000),
		@TempAddress varchar(1000),
		@OfficeAddress varchar(1000),
		@OfficeContactNo bigint,
		@PAN varchar(10),
		@AadhaarCard varchar(12),
		@IsCommiteeMember bit,
		@Designation varchar(250),
		@Photo varchar(250),
		@ResidingFrom varchar(250),
		@Effectivefrom varchar(250),
		@DOB varchar(250),
		@CreatedBy varchar(100), 
		@INS_OUT_MSG VARCHAR(50) OUTPUT  
		)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@OwnerId = '' or @OwnerId = 0)
			BEGIN
				  IF NOT EXISTS(SELECT @OwnerId FROM dbo.OwnerMaster WHERE ACTIVE=1 and PAN=@PAN)
					BEGIN	
							INSERT INTO dbo.OwnerMaster(OwnerName1,ContactNumber,Occupation,permanentAddress,TempAddress,OfficeAddress,OfficeContactNo,PAN,AdhaarCard,IsCommiteeMember,Designation,Effectivefrom,Photo,ResidingFrom,DOB,CreatedBy,CreatedOn)
							VALUES(@OwnerName,@ContactNo,@Occupation,@permanentAddress,@TempAddress,@OfficeAddress,@OfficeContactNo,@PAN,@AadhaarCard,@IsCommiteeMember,@Designation,@Effectivefrom,@Photo,CONVERT(datetime, @ResidingFrom, 103),CONVERT(datetime, @DOB, 103),@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
			END
		     
		ELSE
			
                BEGIN
					UPDATE dbo.OwnerMaster
					 SET OwnerName1=@OwnerName,ContactNumber=@ContactNo,Occupation=@Occupation,permanentAddress=@permanentAddress,TempAddress=@TempAddress,OfficeAddress=@OfficeAddress,OfficeContactNo=@OfficeContactNo,PAN=@PAN,AdhaarCard=@AadhaarCard,IsCommiteeMember=@IsCommiteeMember,Designation=@Designation,Effectivefrom=@Effectivefrom,Photo=@Photo,ResidingFrom=CONVERT(datetime, @ResidingFrom, 103),DOB=CONVERT(datetime, @DOB, 103),ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					WHERE OwnerId = @OwnerId	
					SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			    END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertOtherinfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertOtherinfo] 
	-- Add the parameters for the stored procedure here
	-- Add the parameters for the stored procedure here
	(
	@BasicinfoID int,
	@ID int,
	@WebsiteUrl varchar(150),
	@Facebook varchar(150),
	@Twitter varchar(150),
	@GooglePlus varchar(150),
	@LinkedIn varchar(150),
	@CreatedBy varchar(20),
	@INS_OUT_MSG varchar(350) output
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@BasicinfoID != 0)
			
		      BEGIN
					 UPDATE [dbo].[BasicInformation]
					 SET @ID=@ID,WebsiteUrl=@WebsiteUrl,Facebook=@Facebook,Twitter=@Twitter,GooglePlus=@GooglePlus,LinkedIn=@LinkedIn,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					 WHERE BasicinfoID = @BasicinfoID	
					 SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				  IF NOT EXISTS(SELECT @BasicinfoID FROM [dbo].[BasicInformation] WHERE Active=1 and ID=@ID)
					BEGIN	
							INSERT INTO [dbo].[BasicInformation](ID,WebsiteUrl,Facebook,Twitter,GooglePlus,LinkedIn,CreatedBy,CreatedOn)
							VALUES(@ID,@WebsiteUrl,@Facebook,@Twitter,@GooglePlus,@LinkedIn,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertMonthlyMaintenanceMaster]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<      ,      >
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec [dbo].[InsertMaintenanceMaster] 1,'',456,2,3,3
-- EXEC [InsertMaintenanceMaster] 0,'Residential',2,33,33,33,33,33,33,33,33,33,33,33,55,5,55,55,55,55,55,0,0,0,0,'1/2/2015','','',''
-- =============================================
CREATE PROCEDURE [dbo].[InsertMonthlyMaintenanceMaster]
	-- Add the parameters for the stored procedure here
	(  
		@MonthlyMaintenaceId int,
		@PropertyType varchar(50),
		@CalculationMethod varchar(50),
		@OwnerMonthlyMaintenance float,
		@TenantMonthlyMaintenance float,
		@TotalMonthlyMaintenace float,
		@PerSquareFeetRate float,
		@EffectiveFromDate varchar(50),
		@EffectiveToDate varchar(50),
		@CreatedBy varchar(50),
		@INS_OUT_MSG varchar(350) OUTPUT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result SETs from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	SET @INS_OUT_MSG = ''
	SET @EffectiveToDate=''
    -- Insert statements for procedure here
	declare @_ID int,@todate datetime,@lastid int	

	
	--SELECT @_ID as Rowcount2
	
	--SELECT @fromdate as Rowcount3

	set @lastID=(SELECT MAX(@MonthlyMaintenaceId) AS LastID FROM [dbo].[MonthlyMaintenanceMaster] where Active=1)

    IF(@MonthlyMaintenaceId=0)
	BEGIN	
			set @todate=(SELECT DATEADD(day, -1, CONVERT(datetime, @EffectiveFromDate, 103)))
			select @_ID=@lastID 

			IF NOT EXISTS(SELECT * FROM MonthlyMaintenanceMaster WHERE PropertyType=@PropertyType
									AND EffectiveFromDate =CONVERT(datetime,@EffectiveFromDate,103)
									
									AND EffectiveToDate='1900-01-01 00:00:00:000'
									AND ACTIVE=1 )				
				BEGIN
					INSERT INTO [dbo].MonthlyMaintenanceMaster(PropertyType,CalculationMethod,OwnerMonthlyMaintenance,TenantMonthlyMaintenance,TotalMonthlyMaintenace,PerSquareFeetRate,EffectiveFromDate,EffectiveToDate,CreatedBy)
					VALUES(@PropertyType,@CalculationMethod,@OwnerMonthlyMaintenance,@TenantMonthlyMaintenance,@TotalMonthlyMaintenace,@PerSquareFeetRate,CONVERT(datetime, @EffectiveFromDate, 103),@EffectiveToDate,@Createdby)
					SET @INS_OUT_MSG = 'Record Inserted Successfully..!!'
					--SET @MaintainanceID=SCOPE_IDENTITY()
						if(@_ID <> 0)
								BEGIN

								declare @fromdate datetime
								--set @fromdate =(select EffectiveFromDate from [MaintainanceMaster] where active=1 and MaintainanceID=@_ID)
					
									update [dbo].MonthlyMaintenanceMaster
									SET EffectiveToDate = @todate
									WHERE MonthlyMaintenaceId=@_ID and Active=1
								END							
			   END
	     ELSE
				BEGIN
					SET @INS_OUT_MSG='Record Already Exists..!!'
			   END
		END
	ELSE
			BEGIN
				UPDATE [dbo].[MonthlyMaintenanceMaster] SET PropertyType=@PropertyType,CalculationMethod=@CalculationMethod,OwnerMonthlyMaintenance=@OwnerMonthlyMaintenance,TenantMonthlyMaintenance=@TenantMonthlyMaintenance,TotalMonthlyMaintenace=@TotalMonthlyMaintenace,PerSquareFeetRate=@PerSquareFeetRate,ModifiedBy=@Createdby,ModifiedOn=Getdate()
										WHERE MonthlyMaintenaceId=@MonthlyMaintenaceId and Active=1	
				SET @INS_OUT_MSG = 'Record Updated Successfully..!!'				
			END	
		END		


	--	select SCOPE_IDENTITY(),@@IDENTITY from [dbo].[MaintenanceMaster] where active=1
GO
/****** Object:  StoredProcedure [dbo].[InsertMonthlyExpenses]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec [InsertMonthlyExpenses] ,1,8000,1,10000,'sasa',18000,'',''
-- =============================================
CREATE PROCEDURE [dbo].[InsertMonthlyExpenses]
-- Add the parameters for the stored procedure here
	(
	@MonthlyExpenseId int,
	@SecurityId int,
	@PowerCharges float,
	@WaterCharges float,
	@SecuritySalary float,
	@HousekeepingSalary float,
	@ManagerSalary float,
	@Stationary float,
	@DgSet float,
	@GymInstructor float,
	@CommunityHall float,
	@InsurancePremium float,
	@Miscellaneous float,
	@SupervisorSalary float,
	@SumTotal float,
	@FromDate varchar(50),
	@ToDate varchar(50),
	@CreatedBy varchar(20), 
		@INS_OUT_MSG VARCHAR(50) OUTPUT )
		AS
BEGIN
	SET NOCOUNT ON;
	
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@MonthlyExpenseId != 0)
			
		      BEGIN
		      UPDATE MonthlyExpensesMaster
		      SET SecurityId=@SecurityId,PowerCharges=@PowerCharges,WaterCharges=@WaterCharges,SecurityGuardsSalary=@SecuritySalary,HousekeepingSalary=@HousekeepingSalary,
			   ManagerSalary=@ManagerSalary,Stationary=@Stationary,DgSet=@DgSet,GymInstructor=@GymInstructor,CommunityHall=@CommunityHall,
			   InsurancePremium=@InsurancePremium,Miscellaneous=@Miscellaneous,SupervisorSalary=@SupervisorSalary,SumTotal=@SumTotal,
			   FromDate=@FromDate,ToDate=@ToDate,
			   ModifiedBy=@Createdby,ModifiedOn=Getdate()
			   where MonthlyExpenseId=@MonthlyExpenseId
			   SET @INS_OUT_MSG='Record Updated Successfully!'
			   END
		ELSE
				BEGIN
				
				declare @_SecurityId int
				set @_SecurityId= (select max(SecurityId) from SecuritySalaryMaster where Active=1)
				
				IF NOT EXISTS(SELECT @MonthlyExpenseId FROM dbo.MonthlyExpensesMaster WHERE Active=1 and SecurityId=@_SecurityId and MonthlyExpenseId=@MonthlyExpenseId)
					BEGIN	
							INSERT INTO MonthlyExpensesMaster (
SecurityId,
SecurityGuardsSalary,
PowerCharges,
WaterCharges,
HousekeepingSalary,
ManagerSalary,
Stationary,
DgSet,
GymInstructor,
CommunityHall,
InsurancePremium,
Miscellaneous,
SupervisorSalary,
SumTotal,
FromDate,
ToDate,
CreatedBy,
CreatedOn
)
							VALUES(
@_SecurityId,
@SecuritySalary,
@PowerCharges,
@WaterCharges,
@HousekeepingSalary,
@ManagerSalary,
@Stationary,
@DgSet,
@GymInstructor,
@CommunityHall,
@InsurancePremium,
@Miscellaneous,
@SupervisorSalary,
@SumTotal,
CONVERT(datetime, @FromDate, 103),
CONVERT(datetime, @ToDate, 103),
@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertMemberMaster]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertMemberMaster]
	-- Add the parameters for the stored procedure here
	(
	  @ID int,
	  @FlatId int,
	  @Name	varchar(150),
	  @ResidingFrom varchar(50),
	  @ResidingTo varchar(50)=null,
	  @Rent	money=null,
	  @PAN varchar(20),
	  @AadhaarCard Bigint,
	  @PermanantAddress	varchar(500),
	  @ContactNo1 Bigint,
	  @ContactNo2 Bigint=null,
	  @DOB varchar(50),
	  @Gender varchar(50),
	  @OtherRelation varchar(50)=null,
	  @Relation varchar(50)=null,
	  @IsRented int,
	  @CreatedBy  varchar(50)=null,
	  @INS_OUT_MSG varchar(350) OUTPUT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @INS_OUT_MSG = ''
    -- Insert statements for procedure here
	
	  IF(@ID <> 0)	
		   IF(@IsRented=1)
			BEGIN
					UPDATE [dbo].[TenantMaster] SET FlatId=@FlatId,TenantName=@Name,@ResidingFrom=CONVERT(datetime,ResidingFrom,103),@ResidingTo=CONVERT(datetime,ResidingTo,103),
											Rent=@Rent,PAN=@PAN,AadhaarCard=@AadhaarCard,PermanantAddress=@PermanantAddress,ContactNo1=@ContactNo1,ContactNo2=@ContactNo2,@DOB=CONVERT(datetime,DOB,103),Gender=@Gender,
											ModifiedBy=@Createdby,ModifiedOn=Getdate()
											WHERE TenantId=@ID and Active=1	
					  SET @INS_OUT_MSG = 'Record Updated Successfully..!!'				
			END	
		ELSE
			  BEGIN
					UPDATE [dbo].[OwnerFamilyMaster] SET FlatId=@FlatId,Name=@Name,@ResidingFrom=CONVERT(datetime,ResidingFrom,103),
										PAN=@PAN,AadhaarCard=@AadhaarCard,Address=@PermanantAddress,ContactNo=@ContactNo1,@DOB=CONVERT(datetime,DOB,103),Gender=@Gender,Relation=@Relation,OtherRelation=@OtherRelation,
										ModifiedBy=@Createdby,ModifiedOn=Getdate()
										WHERE OwnerFamilyId=@ID and Active=1	
				    	SET @INS_OUT_MSG = 'Record Updated Successfully..!!'	
			  END

END
GO
/****** Object:  StoredProcedure [dbo].[InsertMaintenanceMaster]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<      ,      >
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec [dbo].[InsertMaintenanceMaster] 1,'',456,2,3,3
-- EXEC [InsertMaintenanceMaster] 0,'Residential',2,33,33,33,33,33,33,33,33,33,33,33,55,5,55,55,55,55,55,0,0,0,0,'1/2/2015','','',''
-- =============================================
CREATE PROCEDURE [dbo].[InsertMaintenanceMaster]
	-- Add the parameters for the stored procedure here
	(  
		@MaintenanceID int,
		@PropertyType varchar(50),
		@CalculationMethod int,
		@WaterCharges float,
		@ElectricityCharges float,
		@SecuritySalary float,
		@HousekeepingSalary float,
		@ManagerSalary float,
		@Stationary float,
		@DgSet float,
		@GymInstructor float,
		@CommunityHall float,
		@InsuranceCharges float,
		@OtherCharges float,
		@TenantMaintenance float,
		@SupervisorSalary float,
		@TotalMaintenanceSum float,
		@MaintenancePerFlat float,
		@PerSquareFeetRate float, 
		@FixedSqft int,
		@FixedRate float,
		@AdditionalSqft int,
		@AdditionalSqftRate float,
		@EffectiveFromDate varchar(50),
		@EffectiveToDate varchar(50),
		@CreatedBy varchar(50),
		@INS_OUT_MSG varchar(350) OUTPUT
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result SETs from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	SET @INS_OUT_MSG = ''
	SET @EffectiveToDate=''
    -- Insert statements for procedure here
	declare @ID int,@todate datetime,@lastid int	

	SELECT @lastID = MAX(MaintenanceID) FROM [dbo].[MaintenanceMaster] where Active=1

    IF(@MaintenanceID=0)
	BEGIN	
			set @todate=(SELECT DATEADD(day, -1, CONVERT(datetime, @EffectiveFromDate, 103)))
			select @ID=@lastID 

			IF NOT EXISTS(SELECT * FROM MAINTENANCEMASTER WHERE PropertyType=@PropertyType
									AND EffectiveFromDate =CONVERT(datetime,@EffectiveFromDate,103)
									AND CalculationMethodId = @CalculationMethod
									AND EffectiveToDate='1900-01-01 00:00:00:000'
									AND ACTIVE=1 )				
				BEGIN
					INSERT INTO [dbo].[MaintenanceMaster](PropertyType,CalculationMethodID,WaterCharges,ElectricityCharges,SecuritySalary,HousekeepingSalary,ManagerSalary,Stationary,DgSet,GymInstructor,CommunityHall,InsuranceCharges,SupervisorSalary,OtherCharges,TotalMaintenanceSum,TenantMaintenance,MaintenancePerFlat,PerSquareFeetRate,FixedSqft,FixedRate,AdditionalSqft,AdditionalSqftRate,EffectiveFromDate,EffectiveToDate,CreatedBy)
					VALUES(@PropertyType,@CalculationMethod,@WaterCharges,@ElectricityCharges,@SecuritySalary,@HousekeepingSalary,@ManagerSalary,@Stationary,@DgSet,@GymInstructor,@CommunityHall,@InsuranceCharges,@SupervisorSalary,@OtherCharges,@TotalMaintenanceSum,@TenantMaintenance,@MaintenancePerFlat,@PerSquareFeetRate,@FixedSqft,@FixedRate,@AdditionalSqft,@AdditionalSqftRate,CONVERT(datetime, @EffectiveFromDate, 103),@EffectiveToDate,@Createdby)
					SET @INS_OUT_MSG = 'Record Inserted Successfully..!!'
					--SET @MaintainanceID=SCOPE_IDENTITY()
						if(@ID <> 0)
								BEGIN

								declare @fromdate datetime
								--set @fromdate =(select EffectiveFromDate from [MaintainanceMaster] where active=1 and MaintainanceID=@_ID)
					
									update [dbo].[MaintenanceMaster]
									SET EffectiveToDate = @todate
									WHERE MaintenanceID=@ID and Active=1
								END							
			   END
	     ELSE
				BEGIN
					SET @INS_OUT_MSG='Record Already Exists..!!'
			   END
		END
	--ELSE
	--		BEGIN
	--			UPDATE [dbo].[MaintenanceMaster] SET PropertyType=@PropertyType,CalculationMethodID=@CalculationMethod,PropertyTaxes=@PropertyTaxes,WaterCharges=@WaterCharges,ElectricityCharges=@ElectricityCharges,RepairsMaintenanceFund=@RepairsMaintenanceFund,LiftCharges=@LiftCharges,SinkingFund=@SinkingFund,ServiceCharges=@ServiceCharges,CarParkingCharges=@CarParkingCharges,InterestonDefaultedCharges=@InterestonDefaultedCharges,RepaymentInstmntLoanInterest=@RepaymentInstmntLoanInterest,NonOccupancyCharges=@NonOccupancyCharges,InsuranceCharges=@InsuranceCharges,LeaseRent=@LeaseRent,NonAgriculturalTax=@NonAgriculturalTax,OtherCharges=@OtherCharges,TotalMaintenanceSum=@TotalMaintenanceSum,MaintenancePerFlat=@MaintenancePerFlat,PerSquareFeetRate=@PerSquareFeetRate,FixedSqft=@FixedSqft,FixedRate=@FixedRate,AdditionalSqft=@AdditionalSqft,AdditionalSqftRate=@AdditionalSqftRate,ModifiedBy=@Createdby,ModifiedOn=Getdate()
	--									WHERE MaintenanceID=@MaintenanceID and Active=1	
	--			SET @INS_OUT_MSG = 'Record Updated Successfully..!!'				
	--		END	
	END
GO
/****** Object:  StoredProcedure [dbo].[InsertMaintenanceCollection]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>		   [dbo].[MaintenanceCollection]
-- EXEC	[InsertMaintenanceCollection] 0,'Residential',2,3,5000.12,2500,1,24242424,'21/01/2015','',''
-- =============================================
CREATE PROCEDURE [dbo].[InsertMaintenanceCollection]
	-- Add the parameters for the stored procedure here
	(
		@MainCollID int,
		@MaintenanceID int,
		@PaidAmount float,
		@ModePayment int,
		@PropertyType varchar(20),
		@InstrumentNumber bigint,
		@InstrumentDate varchar(50),
		@CreatedBy varchar(50),
		@INS_OUT_MSG varchar(300) OUTPUT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result SETs from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	SET @INS_OUT_MSG = ''
    -- Insert statements for procedure here
    IF(@MainCollID=0 AND @PropertyType = 'Residential')	
	BEGIN
		INSERT INTO [dbo].[ResidentialMaintenanceCollection](MaintenanceID,PaidAmount,ModePayment,InstrumentNumber,InstrumentDate,CreatedBy,CreatedOn)
		VALUES(@MaintenanceID,@PaidAmount,@ModePayment,@InstrumentNumber,CONVERT(datetime,@InstrumentDate,103),@CreatedBy,getdate())
				
		UPDATE ResidentialMaintenance 
		SET AmountBalance = CONVERT(money,AmountBalance) - CONVERT(money,@PaidAmount)
		WHERE FlatmaintenanceId = @MaintenanceID

		SET @INS_OUT_MSG = 'Record Inserted Successfully..!!'				
	END
	ELSE IF(@MainCollID=0 AND @PropertyType = 'Commercial')
	BEGIN
		INSERT INTO [dbo].[CommercialMaintenanceCollection](MaintenanceID,PaidAmount,ModePayment,InstrumentNumber,InstrumentDate,CreatedBy,CreatedOn)
		VALUES(@MaintenanceID,@PaidAmount,@ModePayment,@InstrumentNumber,CONVERT(datetime,@InstrumentDate,103),@CreatedBy,getdate())

		UPDATE CommercialMaintenance 
		SET AmountBalance = CONVERT(money,AmountBalance) - CONVERT(money,@PaidAmount)
		WHERE ShopmaintenanceId = @MaintenanceID

		SET @INS_OUT_MSG = 'Record Inserted Successfully..!!'				
	END
	ELSE IF(@MainCollID <> 0 AND @PropertyType = 'Residential')	
	BEGIN
		UPDATE [dbo].[ResidentialMaintenanceCollection]
		SET PaidAmount=@PaidAmount,ModePayment=@ModePayment,InstrumentNumber=@InstrumentNumber,InstrumentDate=CONVERT(datetime,@InstrumentDate,103),
			ModifiedBy=@CreatedBy,ModifiedOn=Getdate()
		WHERE ResidentialMainCollID=@MainCollID and Active=1	

		SET @INS_OUT_MSG = 'Record Updated Successfully..!!'				
	END	
	ELSE IF(@MainCollID <> 0 AND @PropertyType = 'Commercial')	
	BEGIN
		UPDATE [dbo].[CommercialMaintenanceCollection]
		SET PaidAmount=@PaidAmount,ModePayment=@ModePayment,InstrumentNumber=@InstrumentNumber,InstrumentDate=CONVERT(datetime,@InstrumentDate,103),
			ModifiedBy=@CreatedBy,ModifiedOn=Getdate()
		WHERE CommercialMainCollID=@MainCollID and Active=1	

		SET @INS_OUT_MSG = 'Record Updated Successfully..!!'				
	END	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertFlatInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- EXEC [dbo].[InsertFlatInfo] 10,'A005',454,7000,'1BHK',1,0,2,1,'','','','','administrator',''
-- 
-- =============================================
CREATE PROCEDURE [dbo].[InsertFlatInfo]
-- Add the parameters for the stored procedure here
	   (
	   @FlatId int,
	   @FlatNumber varchar(50),
	   @CarpetArea int,
	   @TotalArea int,
	   @FlatType varchar(20),
	   @IsShareCertificateGiven bit,
	   @IsRented bit,
	   @BuildingId int,
	   @OwnerId int,
	   @PropertyType varchar(50),  
	   @BusinessType varchar(50),
	   @LicenseNo varchar(50),
	   @ShopDescription varchar(200),
	   @CreatedBy varchar(20),
	   @INS_OUT_MSG VARCHAR(50) OUTPUT 
	   )
	   AS
BEGIN
	SET NOCOUNT ON;
	
	SET @INS_OUT_MSG='';
	declare @count varchar(50),@totalflat int;
	
	select @count = COUNT(FlatId)from FlatMaster where BuildingId=@BuildingId AND Active=1
	select @totalflat= Flats from BuildingMaster where BuildingId=@BuildingId 
	if(@count >= @totalflat)
	BEGIN
		SET @INS_OUT_MSG='Please Select Proper Building Name, Flat Limit Crossed..!'
	END
	ELSE
	BEGIN
	  IF(@FlatId != 0)
			BEGIN
				  UPDATE FlatMaster
				 SET FlatNumber=@FlatNumber,CarpetArea=@CarpetArea,TotalArea=@TotalArea,FlatType=@FlatType,IsShareCertificateGiven=@IsShareCertificateGiven,IsRented=@IsRented,BuildingId=@BuildingId,OwnerId=@OwnerId,PropertyType=@PropertyType,@BusinessType=@BusinessType,LicenseNo=@LicenseNo,ShopDescription=@ShopDescription,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
							WHERE FlatId = @FlatId	
							SET @INS_OUT_MSG='Record Updated Successfully..!!'
			END	
	  ELSE
			BEGIN
				IF NOT EXISTS(SELECT @FlatId FROM dbo.FlatMaster WHERE ACTIVE=1 and FlatNumber=@FlatNumber)
					BEGIN
						INSERT INTO dbo.FlatMaster(FlatNumber,CarpetArea,TotalArea,FlatType,IsShareCertificateGiven,IsRented,BuildingId,OwnerId,PropertyType,BusinessType,LicenseNo,ShopDescription,CreatedBy,CreatedOn)
							VALUES(@FlatNumber,@CarpetArea,@TotalArea,@FlatType,@IsShareCertificateGiven,@IsRented,@BuildingId,@OwnerId,@PropertyType,@BusinessType,@LicenseNo,@ShopDescription,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
							
					 END
		          ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
	       END
END

END
GO
/****** Object:  StoredProcedure [dbo].[InsertEventMaster]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<      ,      >
-- Create date: <Create Date,,>
-- Description:	<Description,,>		  .
--exec [InsertEventMaster] 0,'2121','<p>dadadaaa<p>','30/12/2014','9029583364',50,'tt','tttttttt','ttt','' 
-- =============================================
CREATE PROCEDURE [dbo].[InsertEventMaster]
	-- Add the parameters for the stored procedure here
	(
	    @EventId int,
		@EventName varchar(200),
		@EventDescription varchar(500),
		@EventOn varchar(100),
		@ContactPerson varchar(50),	
		@MobileNumber  bigint,	
		@Contribution money,
		@FileUploadFileName varchar(50),
		@FileName varchar(50),
		@EventTime varchar(50),
		@Createdby varchar(50),
		@INS_OUT_MSG varchar(350) OUTPUT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result SETs from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	SET @INS_OUT_MSG = ''
    -- Insert statements for procedure here
   IF(@EventId=0)	
		BEGIN
			IF NOT EXISTS (SELECT @EventId FROM EventMaster WHERE Active = 1 AND EventName=@EventName and EventOn=CONVERT(datetime,@EventOn,103))
				BEGIN 
					INSERT INTO EventMaster(EventName,EventDescription,EventOn,ContactPerson,MobileNo,Contribution,FileUploadFileName,FileName,EventTime,CreatedBy,CreatedOn)
					VALUES(@EventName,@EventDescription,CONVERT(datetime,@EventOn,103),@ContactPerson,@MobileNumber,@Contribution,@FileUploadFileName,@FileName,@EventTime,@Createdby,getdate())
					SET @INS_OUT_MSG = 'Record Inserted Successfully..!!'		
					
				END
			ELSE
				BEGIN
					SET @INS_OUT_MSG='Please Change Your Event Name,Is Aleady Exists !!'
				END
		END
	ELSE
		BEGIN
				UPDATE EventMaster SET EventName=@EventName,EventDescription=@EventDescription,EventOn=CONVERT(datetime,@EventOn,103),
										ContactPerson=@ContactPerson,MobileNo=@MobileNumber,Contribution=@Contribution,FileUploadFileName=@FileUploadFileName,FileName=@FileName,EventTime=@EventTime,
										ModifiedBy=@Createdby,ModifiedOn=Getdate()
										WHERE EventId=@EventId and Active=1	
				SET @INS_OUT_MSG = 'Record Updated Successfully..!!'				
		END	
								
END
GO
/****** Object:  StoredProcedure [dbo].[InsertEmployeeInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertEmployeeInfo]
	-- Add the parameters for the stored procedure here
	(@EmployeeId int,
		@Name varchar(100),
		@EmployeeNo varchar(100),
		@JobDescription varchar(1000),
		@ContactNo bigint,
		@Address varchar(100),
		@PAN varchar(10),
		@AadhaarCard varchar(12),
		@Salary money,
		@Designation varchar(50),
		@DOJ varchar(50),
		@DOL varchar(50),
		@CreatedBy varchar(100), 
		@INS_OUT_MSG VARCHAR(50) OUTPUT  
		)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@EmployeeId != 0)
			
		      BEGIN
					UPDATE EmployeeMaster
					 SET Name=@Name,EmployeeNo=@EmployeeNo,JobDescription=@JobDescription,ContactNo=@ContactNo,Address=@Address,PAN=@PAN,AadhaarCard=@AadhaarCard,Salary=@Salary,Designation=@Designation,DOJ=CONVERT(datetime, @DOJ, 103),DOL=CONVERT(datetime, @DOL, 103),ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					WHERE EmployeeId = @EmployeeId	
					SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				  IF NOT EXISTS(SELECT @EmployeeId FROM dbo.EmployeeMaster WHERE ACTIVE=1 and EmployeeNo=@EmployeeNo)
					BEGIN	
							INSERT INTO EmployeeMaster(Name,EmployeeNo,JobDescription,ContactNo,Address,PAN,AadhaarCard,Salary,Designation,DOJ,DOL,CreatedBy,CreatedOn)
							VALUES(@Name,@EmployeeNo,@JobDescription,@ContactNo,@Address,@PAN,@AadhaarCard,@Salary,@Designation,CONVERT(datetime, @DOJ, 103),CONVERT(datetime, @DOL, 103),@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertCommitteeMaster]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertCommitteeMaster] 
	-- Add the parameters for the stored procedure here
	(
	
	@CommiteeMemberId int,
	@OwnerId int,
	@FlatId int,
	@Designation varchar(25),
	@EffectiveFrom varchar(60),
	@CreatedBy varchar(20),
	@INS_OUT_MSG VARCHAR(50) OUTPUT  
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@CommiteeMemberId != 0)
			
		      BEGIN
					UPDATE dbo.CommiteeMemberMaster
					 SET OwnerId=@OwnerId,FlatId=@FlatId,Designation=@Designation,EffectiveFrom=CONVERT(datetime, @EffectiveFrom, 103),ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					WHERE CommiteeMemberId = @CommiteeMemberId	
					SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				  IF NOT EXISTS(SELECT @CommiteeMemberId FROM dbo.CommiteeMemberMaster WHERE ACTIVE=1 and FlatId=@FlatId)
					BEGIN	
							INSERT INTO CommiteeMemberMaster(OwnerId,FlatId,Designation,EffectiveFrom,CreatedBy,CreatedOn)
							VALUES(@OwnerId,@FlatId,@Designation,CONVERT(datetime, @EffectiveFrom, 103),@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertBuildingInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertBuildingInfo]
-- Add the parameters for the stored procedure here
	(@BuildingId int,
	@Name varchar(200),
	@Floors int,
	@Flats int,
	@TotalArea int,
	@CreatedBy varchar(20), 
		@INS_OUT_MSG VARCHAR(50) OUTPUT )
		AS
BEGIN
	SET NOCOUNT ON;
	
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@BuildingId != 0)
			
		      BEGIN
		      UPDATE BuildingMaster
		      SET Name=@Name,Floors=@Floors, Flats=@Flats, TotalArea=@TotalArea,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
		      WHERE BuildingId=@BuildingId
		      SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				IF NOT EXISTS(SELECT @BuildingId FROM dbo.BuildingMaster WHERE ACTIVE=1 and Name=@Name)
					BEGIN	
							INSERT INTO BuildingMaster(Name,Floors,Flats,TotalArea,CreatedBy,CreatedOn)
							VALUES(@Name,@Floors,@Flats,@TotalArea,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertBasicinfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertBasicinfo] 
	-- Add the parameters for the stored procedure here
	(
	@BasicinfoID int,
	@ID int,
	@FirstName varchar(50),
	@LastName varchar(50),
	@MaidenName varchar(50),
	@Gender varchar(10),
	@Birthday varchar(50),
	@Relationship varchar(20),
	@OtherName varchar(50),
	@Interests varchar(250),
	@Occupation varchar(100),
	@Tagline varchar(150),
	@AboutUs nvarchar(1000),
	@CreatedBy varchar(20),
	@INS_OUT_MSG varchar(350) output
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@BasicinfoID != 0)
			
		      BEGIN
					UPDATE [dbo].[BasicInformation]
					 SET @ID=@ID,FirstName=@FirstName,LastName=@LastName,MaidenName=@MaidenName,Gender=@Gender,Birthday=Convert(datetime,@Birthday,103),Relationship=@Relationship,OtherName=@OtherName,Interests=@Interests,Occupation=@Occupation,Tagline=@Tagline,AboutUs=@AboutUs,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					WHERE BasicinfoID = @BasicinfoID	
					SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				  IF NOT EXISTS(SELECT @BasicinfoID FROM [dbo].[BasicInformation] WHERE Active=1 and ID=@ID)
					BEGIN	
							INSERT INTO [dbo].[BasicInformation](ID,FirstName,LastName,MaidenName,Gender,Birthday,Relationship,OtherName,Interests,Occupation,Tagline,AboutUs,CreatedBy,CreatedOn)
							VALUES(@ID,@FirstName,@LastName,@MaidenName,@Gender,Convert(datetime,@Birthday,103),@Relationship,@OtherName,@Interests,@Occupation,@Tagline,@AboutUs,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[InsertAvatar]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertAvatar] 
	-- Add the parameters for the stored procedure here
	
	(
		@ID int,
		@Avatar varchar(75),
		@CreatedBy varchar(20),
		@INS_OUT_MSG VARCHAR(50) OUTPUT
	)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
						 

		Declare @BasicInfoID varchar(100)

		Set @BasicInfoID=(select BasicinfoID from [dbo].[BasicInformation] where ID=@ID )


   IF(@BasicInfoID != 0)
			
		      BEGIN
		      UPDATE [BasicInformation]
		      SET ID=@ID,ImagePath=@Avatar,CreatedBy=@CreatedBy,ModifiedOn=GETDATE()
		      WHERE BasicinfoID=@BasicInfoID
		      SET @INS_OUT_MSG='Profile Avatar Uploded Successfully..!!'	
			   END
		
	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertAminityInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertAminityInfo]
-- Add the parameters for the stored procedure here
	(@AminityId int,
		@BuildingId int,
		@Gymnasium bit,
@GymDesc varchar(1000),
@Parking bit,
@ParkingDesc varchar(1000),
@Lift bit,
@LiftDesc varchar(1000),
@CCTV bit,
@CCTVDesc varchar(1000),
@InterCom bit,
@IntercomDesc varchar(1000),
@Security bit,
@SecurityDesc varchar(1000),
@GeneratorBkp bit,
@GeneratorDesc varchar(1000),
@CommunityHall bit,
@CommunityDesc varchar(1000),
@SwimmingPool bit,
@SwimmingDesc varchar(1000),
@Chairs bit,
@ChairsDesc varchar(1000),
@Tables bit,
@TablesDesc varchar(1000),
@MusicSystem bit,
@MusicSysDesc varchar(1000),
		@CreatedBy varchar(20),
		@INS_OUT_MSG VARCHAR(50) OUTPUT  
		)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @INS_OUT_MSG='';
	
	 -- IF(@opt='InsertEmpInfo')
		BEGIN
		IF(@AminityId != 0)
			
		      BEGIN
					UPDATE AminityMaster
					 SET BuildingId=@BuildingId,Gymnasium=@Gymnasium,GymDesc=@GymDesc,Parking=@Parking,ParkingDesc=@ParkingDesc,Lift=@Lift,LiftDesc=@LiftDesc,CCTV=@CCTV,CCTVDesc=@CCTVDesc,InterCom=@InterCom,IntercomDesc=@IntercomDesc,Security=@Security,SecurityDesc=@SecurityDesc,GeneratorBkp=@GeneratorBkp,GeneratorDesc=@GeneratorDesc,CommunityHall=@CommunityHall,CommunityDesc=@CommunityDesc,SwimmingPool=@SwimmingPool,SwimmingDesc=@SwimmingDesc,Chairs=@Chairs,ChairsDesc=@ChairsDesc,Tables=@Tables,TablesDesc=@TablesDesc,MusicSystem=@MusicSystem,MusicSysDesc=@MusicSysDesc,ModifiedBY=@CreatedBy,ModifiedOn=GETDATE()
					WHERE AminityId = @AminityId	
					SET @INS_OUT_MSG='Record Updated Successfully..!!'	
			   END
		ELSE
				BEGIN
				  IF NOT EXISTS(SELECT @AminityId FROM dbo.AminityMaster WHERE ACTIVE=1 and BuildingId=@BuildingId)
					BEGIN	
							INSERT INTO AminityMaster(BuildingId,Gymnasium,GymDesc,Parking,ParkingDesc,Lift,LiftDesc,CCTV,CCTVDesc,InterCom,IntercomDesc,Security,SecurityDesc,GeneratorBkp,GeneratorDesc,CommunityHall,CommunityDesc,SwimmingPool,SwimmingDesc,Chairs,ChairsDesc,Tables,TablesDesc,MusicSystem,MusicSysDesc,CreatedBy,CreatedOn)
							VALUES(@BuildingId,@Gymnasium,@GymDesc,@Parking,@ParkingDesc,@Lift,@LiftDesc,@CCTV,@CCTVDesc,@InterCom,@IntercomDesc,@Security,@SecurityDesc,@GeneratorBkp,@GeneratorDesc,@CommunityHall,@CommunityDesc,@SwimmingPool,@SwimmingDesc,@Chairs,@ChairsDesc,@Tables,@TablesDesc,@MusicSystem,@MusicSysDesc,@CreatedBy,GETDATE())
							SET @INS_OUT_MSG='Record Inserted Successfully..!!'
					END	
						ELSE
						BEGIN
							SET @INS_OUT_MSG='Record Already Exists..!!'
					    END
				END
		 
	    END
END
GO
/****** Object:  StoredProcedure [dbo].[GetVehicleInfobyID]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetVehicleInfobyID] 
	-- Add the parameters for the stored procedure here
	
	(
	@Vehicleid int,
	@flag varchar(19)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   if(@flag='getallrecordbyvehid')
		
		BEGIN
		IF(@Vehicleid != 0)
		BEGIN
			   Select * from dbo.VehicleMaster
			    where Vehicleid=@Vehicleid and Active=1
			END
		ELSE
		    BEGIN
				  Select *
			   from VehicleMaster
			    where Active=1
		    END
		END
		
END
GO
/****** Object:  StoredProcedure [dbo].[GetVehicleInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetVehicleInfo]
	-- Add the parameters for the stored procedure here
	(
	@flag varchar(30),
	@FlatNumber varchar(50)= NULL,
	@FlatId int 
	
	)
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
	SET NOCOUNT ON;

	if(@flag='getallrecord')
		
		BEGIN
				set @FlatNumber=0; 
			IF(@FlatId != 0)
			BEGIN
			   Select v.FlatId,b.Name as [BuildingName],v.Vehicleid,v.NoOfVehichle,f.FlatNumber ,v.VehicleType1,
					v.VehicleNumber1,v.IsStickerGiven1,v.VehicleType2,v.VehicleNumber2,v.IsStickerGiven2,v.VehicleType3,v.VehicleNumber3,
					v.IsStickerGiven3,v.VehicleType4,v.VehicleNumber4,v.IsStickerGiven4,v.ExtraInfo
			   from dbo.VehicleMaster v
			   Inner join FlatMaster f ON f.FlatId = v.FlatId
			   Inner join BuildingMaster B ON B.BuildingId = f.BuildingId
			    where v.FlatId=@FlatId and v.Active=1
			END
		ELSE
		    BEGIN
				   Select v.FlatId,b.Name as [BuildingName],v.Vehicleid,v.NoOfVehichle,f.FlatNumber 
			   from dbo.VehicleMaster v
			   Inner join FlatMaster f ON f.FlatId = v.FlatId
			   Inner join BuildingMaster B ON B.BuildingId = f.BuildingId
			    where v.Active=1
		    END
		END
		
		
		
	 IF(@flag='searchVehicleinfo')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@FlatId <> '')
            begin
                set @SQL = @SQL + ' and FlatId ='+ Convert(NVARCHAR,@FlatId)
            END
            
            if(@FlatNumber <> '')
            begin
              set @SQL = @SQL + ' and FlatNumber like '''+ Convert(NVARCHAR(50),@FlatNumber)+'%'''
            END

   IF(@FlatId <> '')----EDIT
                    BEGIN   
                        exec('Select v.FlatId,b.Name as [BuildingName],v.Vehicleid,v.NoOfVehichle,f.FlatNumber ,v.VehicleType1,
					v.VehicleNumber1,v.IsStickerGiven1,v.VehicleType2,v.VehicleNumber2,v.IsStickerGiven2,v.VehicleType3,v.VehicleNumber3,
					v.IsStickerGiven3,v.VehicleType4,v.VehicleNumber4,v.IsStickerGiven4,v.ExtraInfo
			   from dbo.VehicleMaster v
			   Inner join FlatMaster f ON f.FlatId = v.FlatId
			   Inner join BuildingMaster B ON B.BuildingId = f.BuildingId

			    where v.Active=1
                              '+@SQL+' 
                              ORDER BY f.FlatId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('Select v.FlatId,b.Name as [BuildingName],v.Vehicleid,v.NoOfVehichle,f.FlatNumber 
			   from dbo.VehicleMaster v
			   Inner join FlatMaster f ON f.FlatId = v.FlatId 
			   Inner join BuildingMaster B ON B.BuildingId = f.BuildingId
			   where v.Active=1
                              '+@SQL+' 
                              ORDER BY f.FlatId
                        ')  
                    END    
	
	END	 

    
END
GO
/****** Object:  StoredProcedure [dbo].[GetTenantInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTenantInfo] 
	-- Add the parameters for the stored procedure here
	   (
			@ID int,
			@flag varchar(50)
		)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@flag='GetGetTenantInfoByID')
	BEGIN
		IF(@ID!=0)
			BEGIN	
				SELECT TenantId,FlatId,TenantName,ResidingFrom,ResidingTo,Rent,PAN,aadhaarCard,PermanantAddress,
				ContactNo1,ContactNo2,DOB,Gender 
				FROM [dbo].[TenantMaster] WHERE TenantId=@ID and Active=1
			END
		ELSE
			BEGIN
			    SELECT TenantId,FlatId,TenantName,ResidingFrom,ResidingTo,Rent,PAN,aadhaarCard,PermanantAddress,
				ContactNo1,ContactNo2,DOB,Gender 
				FROM [dbo].[TenantMaster] WHERE Active=1
			END
	END
END
GO
/****** Object:  StoredProcedure [dbo].[GetSocietyInfobyFlag]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- EXEC [GetSocietyInfobyFlag] 'searchSocityinfobyID',0
-- =============================================
CREATE PROCEDURE [dbo].[GetSocietyInfobyFlag]
	-- Add the parameters for the stored procedure here
	(
		  @flag varchar(50)=null,
		  @ID int =null
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	 if(@flag='searchSocityinfobyID')
	   BEGIN
	      
	   IF(@ID<>0)
		  BEGIN
		        SELECT SocietyID,SocietyName,SocietyAddress,Logo,SocietyStamp,Secretorysign FROM [dbo].[SocietyInfo] Where Active=1 and SocietyID=@ID 
		  END
	 ELSE
			BEGIN
		       SELECT SocietyID,SocietyName,SocietyAddress,Logo,SocietyStamp,Secretorysign FROM 	[dbo].[SocietyInfo]	Where Active=1
			END

	   END



END
GO
/****** Object:  StoredProcedure [dbo].[GetSocietyInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSocietyInfo]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
      
		 
		     SELECT SocietyID,SocietyName,SocietyAddress,Logo,SocietyStamp,Secretorysign FROM [dbo].[SocietyInfo]	Where Active=1
	
			


END
GO
/****** Object:  StoredProcedure [dbo].[GetProfileInfobyID]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC GetProfileInfobyID 'otherinfobyID',3
-- =============================================
CREATE PROCEDURE [dbo].[GetProfileInfobyID] 
	-- Add the parameters for the stored procedure here
	(
		@flag varchar(30),
		@id int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	    declare @LoginType varchar(50)
		SET @LoginType=(Select Login_Type from [dbo].[UserMaster] WHERE ID=@id)
		 print @LoginType
    -- Insert statements for procedure here
	--if(@flag='BasicinfobyID')
	--BEGIN
	-- -- select ID,BasicinfoID from [dbo].[BasicInformation] WHERE ID=@id
	-- select * from [dbo].[BuildingMaster]
	--END



	if(@flag='BasicinfobyID')
	BEGIN

	   IF(@LoginType='Admin')
		   BEGIN
				  select ID,BasicinfoID,FirstName,LastName,MaidenName,Gender,CONVERT(varchar(10),Birthday, 103) as Birthday,Relationship,OtherName,Interests,Tagline,Occupation,AboutUs from [dbo].[BasicInformation] WHERE ID=@id
		   END
	   ELSE IF(@LoginType='SocietyMember')
		   BEGIN
					 Declare @count_profile int

					 set  @count_profile= (select count(ID) From [BasicInformation] where ID=@ID)

					
						   if(@count_profile = 0)
						   BEGIN
					 	      INSERT INTO [dbo].[BasicInformation](ID,FirstName,Birthday,Occupation)
					           SELECT @id,OwnerName1,DOB,Occupation from [dbo].[OwnerMaster]  where OwnerId=@id
					       END

				   select ID,BasicinfoID,FirstName,LastName,MaidenName,Gender,CONVERT(varchar(10),Birthday, 103) as Birthday,Relationship,OtherName,Interests,Tagline,Occupation,AboutUs from [dbo].[BasicInformation] WHERE ID=@id
		   END
	   ELSE
		   BEGIN
		     select ID,BasicinfoID,FirstName,LastName,MaidenName,Gender,CONVERT(varchar(10),Birthday, 103) as Birthday,Relationship,OtherName,Interests,Tagline,Occupation,AboutUs from [dbo].[BasicInformation] WHERE ID=@id
		   END

	  
	
	END

	if(@flag='otherinfobyID')
	BEGIN

	   IF(@LoginType='Admin')
		   BEGIN
				  select BasicinfoID,ID,WebsiteUrl,Facebook,Twitter,GooglePlus,LinkedIn from [dbo].[BasicInformation] WHERE ID=@id
		   END
	   ELSE IF(@LoginType='SocietyMember')
		   BEGIN
					 Declare @count_profile_other int

					 set  @count_profile_other= (select count(ID) From [BasicInformation] where ID=@ID)
					print @count_profile_other
					
						   if(@count_profile_other = 0)
						   BEGIN
						 
					 	      INSERT INTO [dbo].[BasicInformation](ID,WebsiteUrl,Facebook,Twitter,GooglePlus,LinkedIn) 
							  VALUES(@id,'','','','','') 
					       END

			     select  BasicinfoID,ID,WebsiteUrl,Facebook,Twitter,GooglePlus,LinkedIn from [dbo].[BasicInformation] WHERE ID=@id
		   END
	   ELSE
		   BEGIN
		          select  BasicinfoID,ID,WebsiteUrl,Facebook,Twitter,GooglePlus,LinkedIn from [dbo].[BasicInformation] WHERE ID=@id
		   END

	END

END
GO
/****** Object:  StoredProcedure [dbo].[GetProfileDetails]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC GetProfileDetails 2,'GetProfileInfo'
-- =============================================
CREATE PROCEDURE [dbo].[GetProfileDetails] 
	-- Add the parameters for the stored procedure here
	(
	@ID int,
	@flag varchar(50)
	
	)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 IF(@flag ='GetProfileInfo')
	 BEGIN
		   declare @Login_Type varchar(50),@count int

		   SET	@Login_Type= (select Login_Type from  [dbo].[UserMaster] where 	ID=@ID )

			SET	@COUNT=(Select COUNT(ID) from [dbo].[BasicInformation]  where ID=@ID )  

				print @Login_Type
				  print @COUNT

				 	IF(@Login_Type='Admin')
			BEGIN
				 IF(@COUNT = 0)
					BEGIN
						  INSERT INTO [dbo].[BasicInformation](ID)
					      SELECT @id from [dbo].[UserMaster] where ID=@id

						  		select ISNULL(o.ContactNumber,'') as ContactNumber,b.basicinfoID,b.ID,ISNULL(b.FirstName,'-') as FirstName,ISNULL(b.LastName,'-') as LastName,
									   ISNULL(b.MaidenName,'') as MaidenName,ISNULL(b.Gender,'') as Gender,ISNULL(b.Birthday,'') as Birthday,ISNULL(b.Relationship,'') as Relationship,
									   ISNULL(b.OtherName ,'') as OtherName,ISNULL(b.Interests ,'') as Interests,ISNULL(b.ImagePath ,'') as ImagePath,ISNULL(b.Tagline ,'') as Tagline,
									   ISNULL(b.Occupation,'')as Occupation,ISNULL(b.AboutUs ,'') as AboutUs,ISNULL(b.WorkSkills,'') as WorkSkills ,ISNULL(b.WebsiteUrl,'') as WebsiteUrl,
									   ISNULL(b.Facebook,'') as Facebook,ISNULL(b.Twitter ,'') as Twitter,ISNULL(b.GooglePlus ,'') as GooglePlus,ISNULL(b.LinkedIn	,'' ) as LinkedIn,
									   ISNULL(b.Pincode ,'') as Pincode,ISNULL(b.Place,'') as Place,ISNULL(b.Latitude,'') as Latitude,ISNULL(b.Longitude ,'') as Longitude  from [dbo].[BasicInformation] b
									            INNER JOIN [dbo].[OwnerMaster] o on  o.OwnerId =b.ID  
												where ID=@ID 

					END
				 ELSE
				   BEGIN
						   select ISNULL(o.ContactNumber,'') as ContactNumber,b.basicinfoID,b.ID,ISNULL(b.FirstName,'-') as FirstName,ISNULL(b.LastName,'-') as LastName,
									   ISNULL(b.MaidenName,'') as MaidenName,ISNULL(b.Gender,'') as Gender,ISNULL(b.Birthday,'') as Birthday,ISNULL(b.Relationship,'') as Relationship,
									   ISNULL(b.OtherName ,'') as OtherName,ISNULL(b.Interests ,'') as Interests,ISNULL(b.ImagePath ,'') as ImagePath,ISNULL(b.Tagline ,'') as Tagline,
									   ISNULL(b.Occupation,'')as Occupation,ISNULL(b.AboutUs ,'') as AboutUs,ISNULL(b.WorkSkills,'') as WorkSkills ,ISNULL(b.WebsiteUrl,'') as WebsiteUrl,
									   ISNULL(b.Facebook,'') as Facebook,ISNULL(b.Twitter ,'') as Twitter,ISNULL(b.GooglePlus ,'') as GooglePlus,ISNULL(b.LinkedIn	,'' ) as LinkedIn,
									   ISNULL(b.Pincode ,'') as Pincode,ISNULL(b.Place,'') as Place,ISNULL(b.Latitude,'') as Latitude,ISNULL(b.Longitude ,'') as Longitude  from [dbo].[BasicInformation] b
									            INNER JOIN [dbo].[OwnerMaster] o on  o.OwnerId =b.ID  
												where ID=@ID 
				   END


			END

	  ELSE IF(@Login_Type='SocietyMember')
			BEGIN
					IF(@COUNT = 0)
						BEGIN
							  INSERT INTO [dbo].[BasicInformation](ID,FirstName,Birthday,Occupation)
							  SELECT @id,OwnerName1,DOB,Occupation from [dbo].[OwnerMaster]  where OwnerId=@id

							  select ISNULL(o.ContactNumber,'') as ContactNumber,b.basicinfoID,b.ID,ISNULL(b.FirstName,'-') as FirstName,ISNULL(b.LastName,'-') as LastName,
									   ISNULL(b.MaidenName,'') as MaidenName,ISNULL(b.Gender,'') as Gender,ISNULL(b.Birthday,'') as Birthday,ISNULL(b.Relationship,'') as Relationship,
									   ISNULL(b.OtherName ,'') as OtherName,ISNULL(b.Interests ,'') as Interests,ISNULL(b.ImagePath ,'') as ImagePath,ISNULL(b.Tagline ,'') as Tagline,
									   ISNULL(b.Occupation,'')as Occupation,ISNULL(b.AboutUs ,'') as AboutUs,ISNULL(b.WorkSkills,'') as WorkSkills ,ISNULL(b.WebsiteUrl,'') as WebsiteUrl,
									   ISNULL(b.Facebook,'') as Facebook,ISNULL(b.Twitter ,'') as Twitter,ISNULL(b.GooglePlus ,'') as GooglePlus,ISNULL(b.LinkedIn	,'' ) as LinkedIn,
									   ISNULL(b.Pincode ,'') as Pincode,ISNULL(b.Place,'') as Place,ISNULL(b.Latitude,'') as Latitude,ISNULL(b.Longitude ,'') as Longitude  from [dbo].[BasicInformation] b
									            INNER JOIN [dbo].[OwnerMaster] o on  o.OwnerId =b.ID  
												where ID=@ID 
						END
				   ELSE
				     BEGIN
							select ISNULL(o.ContactNumber,'') as ContactNumber,b.basicinfoID,b.ID,ISNULL(b.FirstName,'-') as FirstName,ISNULL(b.LastName,'-') as LastName,
									   ISNULL(b.MaidenName,'') as MaidenName,ISNULL(b.Gender,'') as Gender,ISNULL(b.Birthday,'') as Birthday,ISNULL(b.Relationship,'') as Relationship,
									   ISNULL(b.OtherName ,'') as OtherName,ISNULL(b.Interests ,'') as Interests,ISNULL(b.ImagePath ,'') as ImagePath,ISNULL(b.Tagline ,'') as Tagline,
									   ISNULL(b.Occupation,'')as Occupation,ISNULL(b.AboutUs ,'') as AboutUs,ISNULL(b.WorkSkills,'') as WorkSkills ,ISNULL(b.WebsiteUrl,'') as WebsiteUrl,
									   ISNULL(b.Facebook,'') as Facebook,ISNULL(b.Twitter ,'') as Twitter,ISNULL(b.GooglePlus ,'') as GooglePlus,ISNULL(b.LinkedIn	,'' ) as LinkedIn,
									   ISNULL(b.Pincode ,'') as Pincode,ISNULL(b.Place,'') as Place,ISNULL(b.Latitude,'') as Latitude,ISNULL(b.Longitude ,'') as Longitude  from [dbo].[BasicInformation] b
									            INNER JOIN [dbo].[OwnerMaster] o on  o.OwnerId =b.ID  
												where ID=@ID 
					 END

			END
	 

	END 
	-- select * from [BasicInformation]
	-- select * from [OwnerMaster]
END
GO
/****** Object:  StoredProcedure [dbo].[GetOwnerinfobyflatID]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOwnerinfobyflatID]
	-- Add the parameters for the stored procedure here
	(
	@flag varchar(30),
	@FlatId int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@flag='getallrecord')
		

		
		BEGIN
				
			IF(@FlatId != 0)
			BEGIN
			   Select a.FlatId,a.FlatNumber,b.OwnerId,b.OwnerName1 
			   from dbo.FlatMaster a
			   Inner Join dbo.OwnerMaster b ON b.OwnerId =a.OwnerId
			   where a.FlatId=@FlatId  
			   and a.Active=1
			END
		ELSE
		    BEGIN
			   Select a.FlatId,a.FlatNumber,b.OwnerId,b.OwnerName1 
			   from dbo.FlatMaster a
			   Inner Join dbo.OwnerMaster b ON b.OwnerId =a.OwnerId
			   where  a.Active=1
		    END
		END
END
GO
/****** Object:  StoredProcedure [dbo].[GetownerInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec [GetownerInfo ] 'getallrecord',0,9
--exec [GetownerInfo ] 'searchownerinfo','45',0
-- =============================================
CREATE PROCEDURE [dbo].[GetownerInfo]
	-- Add the parameters for the stored procedure here
	
	(
	@flag varchar(30),
	@OwnerName1 varchar(50)= NULL,
	@OwnerId int 
	
	)
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
	SET NOCOUNT ON;

	if(@flag='getallrecord')
		
		BEGIN
				
			IF(@OwnerId != 0)
			BEGIN
			    Select OwnerId,ContactNumber,Occupation,OfficeAddress,OfficeContactNo,PAN,AdhaarCard,IsCommiteeMember,Photo,ResidingFrom,Designation,Effectivefrom,DOB,permanentAddress,TempAddress,(OwnerName1+' ('+Convert(varchar(40),ContactNumber)+')') as[ownername]  from dbo.OwnerMaster where OwnerId=@OwnerId and Active=1
			END
		ELSE
		    BEGIN
				 Select OwnerId,ContactNumber,Occupation,OfficeAddress,OfficeContactNo,PAN,AdhaarCard,IsCommiteeMember,Photo,ResidingFrom,Designation,Effectivefrom,DOB,permanentAddress,TempAddress,(OwnerName1+' ('+Convert(varchar(40),ContactNumber)+')') as[ownername]  from dbo.OwnerMaster where Active=1
		    END
		END
		
		
		
	 IF(@flag='searchownerinfo')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
            
              
              if(@OwnerId <> '')
            begin
                set @SQL = @SQL + ' and OwnerId ='+ Convert(NVARCHAR,@OwnerId)
            END
            
            if(@OwnerName1 <> '')
            begin
              set @SQL = @SQL + ' and OwnerName1 like '''+ Convert(NVARCHAR(50),@OwnerName1)+'%'''
            END

   IF(@OwnerId <> '')----EDIT
                    BEGIN   
                        exec('SELECT OwnerId,PAN,ContactNumber,
OwnerName1+''(''+Convert(varchar(15),ContactNumber)+'')'' as[ownername]
                              From dbo.OwnerMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY OwnerId
                        ')  
                    END
                ELSE
                    BEGIN
                               exec('SELECT OwnerId,PAN,ContactNumber,
OwnerName1+''(''+Convert(varchar(15),ContactNumber)+'')'' as[ownername]
                              From dbo.OwnerMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY OwnerId
                        ')  
                    END
                    
	
	END	 

    
END
GO
/****** Object:  StoredProcedure [dbo].[GetOwnerFamilyInfo]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOwnerFamilyInfo] 
	-- Add the parameters for the stored procedure here
	(
	@ID int,
	@flag varchar(50)
	)
		  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	if(@flag='GetGetOwnerFamilyInfoByID')
	BEGIN
		IF(@ID!=0)
			BEGIN	
				SELECT OwnerFamilyId,FlatId,Name,ResidingFrom,ContactNo,PAN,AadhaarCard,Relation,
				      DOB,Address,OtherRelation,Gender,Active,Photo FROM [dbo].[OwnerFamilyMaster]  WHERE OwnerFamilyId=@ID and Active=1
			END
		ELSE
			BEGIN
			   SELECT OwnerFamilyId,FlatId,Name,ResidingFrom,ContactNo,PAN,AadhaarCard,Relation,
				      DOB,Address,OtherRelation,Gender,Active,Photo 
					  FROM [dbo].[OwnerFamilyMaster]
					  WHERE Active=1
			END
	END

	--
END
GO
/****** Object:  StoredProcedure [dbo].[GetMonthlyRecordbyId]    Script Date: 04/29/2015 19:23:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pramod
-- Create date: 01/04/1990
-- Description:	Login Check
--exec [GetMonthlyRecordbyId] 3
-- =============================================
CREATE PROCEDURE [dbo].[GetMonthlyRecordbyId] 
	-- Add the parameters for the stored procedure here
	(

	@MonthlyMaintenaceId int
	)
AS
BEGIN

SELECT MonthlyMaintenaceId,
PropertyType,
CalculationMethod,
OwnerMonthlyMaintenance,
TenantMonthlyMaintenance,
TotalMonthlyMaintenace,
PerSquareFeetRate,
EffectiveFromDate,
EffectiveToDate
			FROM MonthlyMaintenanceMaster
			
	WHERE Active=1 and MonthlyMaintenaceId=@MonthlyMaintenaceId
END
GO
/****** Object:  StoredProcedure [dbo].[Get_MenuTab]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Akshay Kulkarni	
-- ALTERdate: 14/11/2014
-- Description:	For User Menu
-- [dbo].[Get_MenuTab] '2',2,''
-- =============================================
CREATE PROCEDURE [dbo].[Get_MenuTab] 
	-- Add the parameters for the stored procedure here
(
	@RoleId varchar(25), 
	@UID int,
	@Parentid varchar(25)
)
As
Begin
 
	IF(@UID <> '' AND @RoleId <> '')
	BEGIN
	
		SELECT a.Menu_Id as [MenuID],c.Role_ID,b.CssIcon,b.MenuName,b.URL,b.MenuType,b.ParentID,
			 case when b.MenuType='Dashboard' then '1'						
						 when b.MenuType='Master' then '2'					 
						 when b.MenuType='Finance' then '17'					 
						 when b.MenuType='Report' then '12' 
						 when b.MenuType='Vendor' then '25' 
					ELSE '' END [RootID]
		FROM RoleGroupMaster a	
		INNER JOIN MenuMaster b on a.Menu_Id=b.MenuId
		INNER JOIN UserMaster c on a.URole_Id = c.Role_ID AND c.Subscription = a.Subscription AND c.UID = @UID
		WHERE a.Active=1 and b.Active=1 and a.URole_Id=@RoleId and a.View_Permission='Y' 
		order by b.ParentID,b.MenuType,b.Sequence

	END
END
GO
/****** Object:  StoredProcedure [dbo].[ForgotPassword]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [ForgotPassword] 'pranav@gmail.com'
-- =============================================
CREATE PROCEDURE [dbo].[ForgotPassword] 
	-- Add the parameters for the stored procedure here
	@EmailID varchar(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN

	SELECT COUNT(*)as count FROM UserMaster WHERE EmailID=@EmailID or Login_ID=@EmailID AND Active=1
	END   
END
GO
/****** Object:  StoredProcedure [dbo].[FnchangePassword]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FnchangePassword]
(
@NewPassword varchar(100),
@UID int
)
AS
BEGIN
UPDATE UserMaster
SET Password=@NewPassword
WHERE UID=@UID AND active=1
END
GO
/****** Object:  StoredProcedure [dbo].[GetMonthlyMaintenaceInfobyId]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pramod
-- Create date: 01/04/1990
-- Description:	Login Check
--exec [GetMonthlyMaintenaceInfobyId] 3
-- =============================================
CREATE  PROCEDURE [dbo].[GetMonthlyMaintenaceInfobyId] 
	-- Add the parameters for the stored procedure here
	(

	@MonthlyMaintenaceId int
	)
AS
BEGIN

SELECT MonthlyMaintenaceId,
PropertyType,
CalculationMethod,
OwnerMonthlyMaintenance,
TenantMonthlyMaintenance,
TotalMonthlyMaintenace,
PerSquareFeetRate,
EffectiveFromDate,
EffectiveToDate
			FROM MonthlyMaintenanceMaster
			
	WHERE Active=1 	
END
GO
/****** Object:  StoredProcedure [dbo].[GetMemberMasterInfoByOwnerID]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC GetMemberMasterInfoByOwnerID 'SocietyMember',7,1,10,0
-- =============================================
CREATE PROCEDURE [dbo].[GetMemberMasterInfoByOwnerID] 
	-- Add the parameters for the stored procedure her
	   @MemberLoginType varchar(40)
	  ,@ID int
      ,@PageIndex INT = 1
      ,@PageSize INT = 10
      ,@RecordCount INT OUTPUT
AS		
BEGIN
     SET NOCOUNT ON;
      declare @propertyType varchar(20),@flatID int,@IsRented bit,@total int
	  
	SET @IsRented= (select IsRented from [dbo].[FlatMaster] where  OwnerId=@ID)

 SET @flatID = (select FlatId from [dbo].[FlatMaster] where  OwnerId=@ID)

 IF(@MemberLoginType='SocietyMember')		
 BEGIN
		 If(@IsRented=1)
			BEGIN
		 	    
				 SELECT ROW_NUMBER() OVER
			  (
				   ORDER BY TenantId ASC
			  )AS RowNumber
			  ,TenantId as ID
			   ,FlatId
			   ,TenantName
			   ,CONVERT(varchar,CONVERT(date,ResidingFrom,103),103) as ResidingFrom
			   ,CONVERT(varchar,CONVERT(date,ResidingTo,103),103) as ResidingTo
			   ,Rent
			   ,PAN
			   ,AadhaarCard
			   ,PermanantAddress
			   ,ContactNo1
			   ,ContactNo2
			   ,CONVERT(varchar,CONVERT(date,DOB,103),103) as DOB
			   ,Gender
			  INTO #Results
			  FROM [dbo].[TenantMaster]	where FlatId=@flatID and Active=1
     
			  SELECT @RecordCount = COUNT(*)
			  FROM #Results		 
			  
			  Select @total=( @RecordCount / @PageSize)
			  if(@total=0)
			  Begin
				 Select @total=1
			  END
			  ELSE
				  BEGIN
					 Select @total=( @RecordCount / @PageSize)
				  END
           
			  SELECT *,@RecordCount as RecordCount,'TenantMaster' as TableName FROM #Results
			  WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
     
			 select IsRented,@total as total,@RecordCount as RecordCount from [dbo].[FlatMaster] where  OwnerId=@ID

			  DROP TABLE #Results
			  
			END

	If(@IsRented=0 )
			BEGIN
		 			 SELECT ROW_NUMBER() OVER
			  (
				   ORDER BY OwnerFamilyId ASC
			  )AS RowNumber
       			   ,OwnerFamilyId as ID
				   ,FlatId
				   ,Name
				   ,CONVERT(varchar,CONVERT(date,ResidingFrom,103),103) as ResidingFrom
				   ,ContactNo
				   ,PAN
				   ,AadhaarCard
				   ,Relation
				   ,CONVERT(varchar,CONVERT(date,DOB,103),103) as DOB
				   ,Address
				   ,OtherRelation
				   ,Gender
			  INTO #Results1
			  FROM 	[dbo].[OwnerFamilyMaster] where FlatId=@flatID and Active=1
     
			  SELECT @RecordCount = COUNT(*)
			  FROM #Results1
	    
		        Select @total=( @RecordCount / @PageSize)

			if(@total=0)
					  Begin
						 Select @total=1
					  END
			  ELSE
				  BEGIn
					 Select @total=( @RecordCount / @PageSize)
				  END
           
			  SELECT *,@RecordCount as RecordCount,'OwnerFamilyMaster' as TableName FROM #Results1
			  WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
     
			  select IsRented,@total as total,@RecordCount as RecordCount from [dbo].[FlatMaster] where  OwnerId=@ID
			 

			  DROP TABLE #Results1		
			END
 END

  --IF(@MemberLoginType='Admin')
 --BEGIN
 --END

	
     
END												    
--select * from  [dbo].[TenantMaster]							
--select * from  [dbo].[OwnerFamilyMaster] 
--select * from  [dbo].[FlatMaster]
--select * from  [dbo].[UserMaster]
GO
/****** Object:  StoredProcedure [dbo].[GetMemberMasterInfoByFlatID]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC GetMemberMasterInfoByFlatID 'Admin',1,1,10,0
-- =============================================
CREATE PROCEDURE [dbo].[GetMemberMasterInfoByFlatID]
		-- Add the parameters for the stored procedure her
	   @MemberLoginType varchar(40)
	  ,@ID int =null
      ,@PageIndex INT = 1
      ,@PageSize INT = 10
      ,@RecordCount INT OUTPUT
AS		
BEGIN
     SET NOCOUNT ON;
      declare @propertyType varchar(20),@flatID int,@IsRented bit,@total int
	  
	

    

 IF(@MemberLoginType='SocietyMember')
 BEGIN
     SET @IsRented= (select IsRented from [dbo].[FlatMaster] where  OwnerId=@ID)
	 SET @flatID = (select FlatId from [dbo].[FlatMaster] where  OwnerId=@ID)
		 If(@IsRented=1)
			BEGIN
		 	
				 SELECT ROW_NUMBER() OVER
			  (
				   ORDER BY TenantId ASC
			  )AS RowNumber
			   ,TenantId as ID
			   ,f.FlatId as FlatId
			   ,TenantName as Name	  
			   ,ResidingFrom
			   ,PAN
			   ,ContactNo1 as ContactNo
			   ,f.FlatNumber as FlatName
			 
			  INTO #Results
			    FROM [dbo].[TenantMaster] T
			   INNER JOIN [dbo].[FlatMaster] F ON F.FlatId=	T.FlatId
			  where T.FlatId=@flatID and T.Active=1
     
			  SELECT @RecordCount = COUNT(*)
			  FROM #Results		 
			  
			  Select @total=( @RecordCount / @PageSize)
			  if(@total=0)
			  Begin
				 Select @total=1
			  END
			  ELSE
				  BEGIN
					 Select @total=( @RecordCount / @PageSize)
				  END
           
			  SELECT *,@RecordCount as RecordCount,'TenantMaster' as TableName FROM #Results
			  WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
     
			 select IsRented,@total as total,@RecordCount as RecordCount from [dbo].[FlatMaster] where  FlatId=@flatID

			  DROP TABLE #Results
			  
			END

	If(@IsRented=0 )
			BEGIN
		 			 SELECT ROW_NUMBER() OVER
			  (
				   ORDER BY OwnerFamilyId ASC
			  )AS RowNumber
       			   ,OwnerFamilyId as ID
				   ,f.FlatId as FlatId
				   ,Name
				   ,ResidingFrom
				   ,ContactNo
				   ,PAN
				   ,f.FlatNumber as FlatName

			  INTO #Results1
			        FROM [dbo].[OwnerFamilyMaster] O 
				  INNER JOIN [dbo].[FlatMaster] F ON F.FlatId=	O.FlatId
			   where O.FlatId=@flatID and O.Active=1
     
			  SELECT @RecordCount = COUNT(*)
			  FROM #Results1
	    
		        Select @total=( @RecordCount / @PageSize)

			if(@total=0)
					  Begin
						 Select @total=1
					  END
			  ELSE
				  BEGIn
					 Select @total=( @RecordCount / @PageSize)
				  END
           
			  SELECT *,@RecordCount as RecordCount,'OwnerFamilyMaster' as TableName FROM #Results1
			  WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
     
			  select IsRented,@total as total,@RecordCount as RecordCount from [dbo].[FlatMaster] where FlatId=@flatID
			 

			  DROP TABLE #Results1		
			END
 END

  IF(@MemberLoginType='Admin')
		 BEGIN
     SET @IsRented= (select IsRented from [dbo].[FlatMaster] where  FlatId=@ID)

		   If(@IsRented=1)
			BEGIN
		 	    
				 SELECT ROW_NUMBER() OVER
			  (
				   ORDER BY TenantId ASC
			  )AS RowNumber
			  ,TenantId as ID
			   ,f.FlatId as  FlatId
			   ,TenantName as Name	  
			   ,ResidingFrom
			   ,PAN
			   ,ContactNo1 as ContactNo
			   ,f.FlatNumber as FlatName
			 
			  INTO #Results11
			  FROM [dbo].[TenantMaster]	T
			   INNER JOIN [dbo].[FlatMaster] F ON F.FlatId=	T.FlatId
			  where T.FlatId=@ID and T.Active=1
     
			  SELECT @RecordCount = COUNT(*)
			  FROM #Results11 		 
			  
			  Select @total=( @RecordCount / @PageSize)
			  if(@total=0)
			  Begin
				 Select @total=1
			  END
			  ELSE
				  BEGIN
					 Select @total=( @RecordCount / @PageSize)
				  END
           
			  SELECT *,@RecordCount as RecordCount,'TenantMaster' as TableName FROM #Results11
			  WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
     
			select IsRented,@total as total,@RecordCount as RecordCount from [dbo].[FlatMaster] where FlatId=@ID

			  DROP TABLE #Results11
			  
			END

	If(@IsRented=0 )
			BEGIN
		 			 SELECT ROW_NUMBER() OVER
			  (
				   ORDER BY OwnerFamilyId ASC
			  )AS RowNumber
       			   ,OwnerFamilyId as ID
				   ,f.FlatId as FlatId
				   ,Name
				   ,ResidingFrom
				   ,ContactNo
				   ,PAN
				   ,f.FlatNumber as FlatName

			  INTO #Results12
			  FROM 	[dbo].[OwnerFamilyMaster] O 
				  INNER JOIN [dbo].[FlatMaster] F ON F.FlatId=	O.FlatId
			  where O.FlatId=@ID and O.Active=1
     
			  SELECT @RecordCount = COUNT(*)
			  FROM #Results12
	    
		        Select @total=( @RecordCount / @PageSize)

			if(@total=0)
					  Begin
						 Select @total=1
					  END
			  ELSE
				  BEGIn
					 Select @total=( @RecordCount / @PageSize)
				  END
           
			  SELECT *,@RecordCount as RecordCount,'OwnerFamilyMaster' as TableName FROM #Results12
			  WHERE RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
     
			  select IsRented,@total as total,@RecordCount as RecordCount from [dbo].[FlatMaster] where FlatId=@ID
			 

			  DROP TABLE #Results12		
			END


		 END

	
     
END												    
--select * from  [dbo].[TenantMaster]							
--select * from  [dbo].[OwnerFamilyMaster] 
--select * from  [dbo].[FlatMaster]
--select * from  [dbo].[UserMaster]
GO
/****** Object:  StoredProcedure [dbo].[GetmemberMasterbyID]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- EXEC GetmemberMasterbyID 12,'GetOwnerFamilyInfo'
-- =============================================
CREATE PROCEDURE [dbo].[GetmemberMasterbyID]
	-- Add the parameters for the stored procedure here
	(
	   @ID int,
	   @flag varchar(50)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   if(@flag='GetTenantInfo')
	   BEGIN
		   select * From  [dbo].[TenantMaster] where TenantId=@ID and active=1
	   END

   if(@flag='GetOwnerFamilyInfo')
	    BEGIN
		    select * From [dbo].[OwnerFamilyMaster] where OwnerFamilyId=@ID and active=1
	    END

END
GO
/****** Object:  StoredProcedure [dbo].[GetMaintenanceInfobyId]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- EXEC GetMaintananceInfobyId 0,'FillcaltypemasterDropDowns'
-- =============================================
CREATE PROCEDURE [dbo].[GetMaintenanceInfobyId]
	-- Add the parameters for the stored procedure here
	(
		@id int,
		@flag varchar(50)

	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@flag='FillcaltypemasterDropDowns')
		BEGIN
		if(@id=0 )
			BEGIN
				select CalcMasterID,CalculationMethod from [dbo].[MaintenanceCaltypeMaster] where Active=1
			END
	ELSE
			BEGIN
				SELECT CalcMasterID,CalculationMethod from [dbo].[MaintenanceCaltypeMaster] where Active=1 and CalcMasterID=@id
			END	
		END
END
GO
/****** Object:  StoredProcedure [dbo].[GetMaintenanceInfo]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<,>
-- Createdate: <Create Date,08-JUNE-2014>
-- Description:	<Description,,>
-- Exec [dbo].[]  
-- EXEC [GetMaintenanceInfo] 'searchMaininfo','',0,'','','1/01/2014','1/03/2015'
--EXEC [GetMaintenanceInfo] 'getallrecord',3
-- =============================================
CREATE PROCEDURE [dbo].[GetMaintenanceInfo] 
	-- Add the parameters for the stored procedure here	
   (
		@flag varchar(30),
		@EffectiveFrom varchar(50)= NULL,
		@MaintenanceID int= NULL,
		@CalculationMethod int=null,
		@PropertyType varchar(50)=null,
		@EffectiveFromDate varchar(50)=null,
		@EffectiveToDate varchar(50)=null
	)
		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
	SET NOCOUNT ON;

	if(@flag='getallrecord')
		
			BEGIN
				set @MaintenanceID=0	
				set @EffectiveFrom=0
			IF(@MaintenanceID != 0)
			BEGIN
			  select row_number() OVER (ORDER BY m.MaintenanceID) AS rownumber,m.MaintenanceID,c.CalculationMethod as CalculationMethodName,m.PropertyType,m.EffectiveFromDate,m.EffectiveToDate
			   from [dbo].[MaintenanceMaster] m
			   inner join  [dbo].[MaintenanceCaltypeMaster] c on c.CalcMasterID =m.CalculationMethodId 
			   where m.Active=1 and m.MaintenanceID=@MaintenanceID
			END
		ELSE
		    BEGIN
			   select row_number() OVER (ORDER BY m.MaintenanceID) AS rownumber,m.MaintenanceID,c.CalculationMethod as CalculationMethodName,m.PropertyType,m.EffectiveFromDate,m.EffectiveToDate
			   from [dbo].[MaintenanceMaster] m
			   inner join  [dbo].[MaintenanceCaltypeMaster] c on c.CalcMasterID =m.CalculationMethodId 
			   where m.Active=1
		    END
		END
		
		IF(@flag='searchMaininfo')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500),@EfectivetempDate datetime,@EffectiveTempToDate datetime
            set @SQL=''
            set @JOIN=''
              set @EfectivetempDate = convert(datetime,convert(varchar ,@EffectiveFromDate),103)

			  
			  --print @EfectivetempDate
			 set @EffectiveTempToDate =convert(datetime,convert(varchar ,@EffectiveToDate),103)
			   --print @EffectiveTempToDate
				     
              If(@MaintenanceID <> '')
            Begin
                set @SQL = @SQL + ' and m.MaintenanceID ='+ Convert(NVARCHAR,@MaintenanceID)
			 
            END

			

			if(@PropertyType <> '')
            Begin
              set @SQL = @SQL + ' and m.PropertyType like '''+ Convert(NVARCHAR(50),@PropertyType)+'%'''

            END

			if(@CalculationMethod <> '')
            Begin
              set @SQL = @SQL + ' and m.CalculationMethodId= '+ Convert(NVARCHAR(50),@CalculationMethod)
            END
		
			
			IF(@EffectiveToDate <> '' and @EffectiveFromDate <> '' )
				 BEGIN
					set @SQL = @SQL + ' and EffectiveFromDate BETWEEN '''+ CONVERT(NVARCHAR(29),CONVERT(DATETIME,@EffectiveFromDate,103) , 120) + ''' and ''' +  CONVERT(NVARCHAR(29),CONVERT(DATETIME,@EffectiveToDate,103),120)   +''''
				 END	
			else if(@EffectiveFromDate <> '')
				Begin
				  set @SQL = @SQL + ' and m.EffectiveFromDate like '''+ Convert(NVARCHAR(50),@EfectivetempDate)+'%'''
				END

			else IF(@EffectiveToDate <> '')
				BEGIN
					set @SQL = @SQL + ' and EffectiveToDate like '''+  Convert(NVARCHAR(50),@EffectiveTempToDate)+'%'''
				END
								

   IF(@MaintenanceID <> '')----EDIT
                    BEGIN   
                        EXEC('select row_number() OVER (ORDER BY MaintenanceID) AS rownumber,m.MaintenanceID,c.CalculationMethod as CalculationMethodName ,m.CalculationMethodid,m.PropertyType,m.PropertyTaxes,m.WaterCharges,m.ElectricityCharges,m.RepairsMaintenanceFund,m.LiftCharges,m.SinkingFund,m.ServiceCharges,m.CarParkingCharges,m.InterestonDefaultedCharges,m.RepaymentInstmntLoanInterest,m.NonOccupancyCharges,m.InsuranceCharges,m.LeaseRent,m.NonAgriculturalTax,m.OtherCharges,m.OtherCharges,m.TotalMaintenanceSum,m.MaintenancePerFlat,m.PerSquareFeetRate,m.FixedSqft,m.FixedRate,m.AdditionalSqft,m.AdditionalSqftRate,m.EffectiveFromDate,m.EffectiveToDate
			   from [MaintenanceMaster] m
			   inner join  [dbo].[MaintenanceCaltypeMaster] c on c.CalcMasterID =m.CalculationMethodId where m.Active=1
                              '+@SQL+' 
                              ORDER BY m.MaintenanceID
                        ')   
                    END
                ELSE
                    BEGIN
                             EXEC('select row_number() OVER (ORDER BY MaintenanceID) AS rownumber,m.MaintenanceID,c.CalculationMethod as CalculationMethodName ,m.CalculationMethodid,m.PropertyType,m.PropertyTaxes,m.WaterCharges,m.ElectricityCharges,m.RepairsMaintenanceFund,m.LiftCharges,m.SinkingFund,m.ServiceCharges,m.CarParkingCharges,m.InterestonDefaultedCharges,m.RepaymentInstmntLoanInterest,m.NonOccupancyCharges,m.InsuranceCharges,m.LeaseRent,m.NonAgriculturalTax,m.OtherCharges,m.OtherCharges,m.TotalMaintenanceSum,m.MaintenancePerFlat,m.PerSquareFeetRate,m.FixedSqft,m.FixedRate,m.AdditionalSqft,m.AdditionalSqftRate,m.EffectiveFromDate,m.EffectiveToDate
			   from [MaintenanceMaster] m
			   inner join  [dbo].[MaintenanceCaltypeMaster] c on c.CalcMasterID =m.CalculationMethodId  where m.Active=1
                              '+@SQL+' 
                              ORDER BY m.MaintenanceID')  
                    END    
	
	END	 
		
		
	
	--SELECT row_number() OVER (ORDER BY MaintenanceID) AS RowNumber from MaintenanceMaster
  
END
GO
/****** Object:  StoredProcedure [dbo].[GetMaintenanceCollection]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [GetMaintenanceCollection] 4,'GetMaintenanceAmount',''
--EXEC GetMaintenanceCollection 3,'FillDrpMaintenancePeriod','Residential'
--EXEC GetMaintenanceCollection 3,'GetMaintenanceAmountByID','Residential'
-- =============================================
CREATE PROCEDURE [dbo].[GetMaintenanceCollection]
	-- Add the parameters for the stored procedure here
	(
		@id int=null,
		@flag varchar(50)=null,
		@PropertyType varchar(50)=null	
	)
AS		 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@flag='FillDrpFlatNoByPropertyType')
		BEGIN
			if(@id=0 )
				BEGIN
					select FlatId,FlatNumber from [dbo].[FlatMaster] where Active=1	 and PropertyType=@PropertyType
				END
		ELSE
				BEGIN
					select FlatId,FlatNumber from [dbo].[FlatMaster] where Active=1 and FlatId=@id and PropertyType=@PropertyType
				END	
		END
			
	 if(@flag='FillDrpMaintenancePeriod')
		BEGIN
		if(@id!=0 )
			BEGIN
			      if(@PropertyType='Residential')																																					 --select * from [dbo].[ResidentialMaintenance]
				  BEGIN
				      select ROW_NUMBER() OVER(ORDER BY MaintenanceID) as Row, FlatmaintenanceId as ID, CONVERT(varchar,CONVERT(datetime,EffectiveFrom,100),107)+' - '+CONVERT(varchar,CONVERT(datetime,EffectiveTo,100),107) as MaintenancePeriod
					  from [dbo].[ResidentialMaintenance]
					  where Active=1 and FlatId=@id and AmountBalance > CONVERT(money, 0)
				  END
				   
				    if(@PropertyType='Commercial')
				  BEGIN
				      select ROW_NUMBER() OVER(ORDER BY MaintenanceID) as Row, ShopmaintenanceId as ID, CONVERT(varchar,CONVERT(datetime,EffectiveFrom,100),107)+' - '+CONVERT(varchar,CONVERT(datetime,EffectiveTo,100),107) as MaintenancePeriod
					  from [dbo].[CommercialMaintenance] 
					  where Active=1  and ShopId=@id and AmountBalance > CONVERT(money, 0)
				  END	
			END	
		END

		 if(@flag='GetMaintenanceAmountByID')
		BEGIN
		if(@id!=0 )
			BEGIN			   
				   if(@PropertyType='Residential')
				  BEGIN
				      select AmountBalance [Amount] from [dbo].[ResidentialMaintenance] where Active=1  and FlatmaintenanceId=@ID
				   END
				   
				    if(@PropertyType='Commercial')
				  BEGIN
				      select AmountBalance [Amount] from  [dbo].[CommercialMaintenance] where Active=1  and ShopmaintenanceId=@ID
				   END  	
			END	
		END

	 if(@flag='GetPaymentMode')
		BEGIN		     	
     			 select PaymentID, PaymentType from  [dbo].[PaymentMode] where Active=1   			
		END
END
GO
/****** Object:  StoredProcedure [dbo].[getinfobyemailid]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--	 EXEC [dbo].[getinfobyemailid] 'pranavpanvel@gmail.com'
 -- select * from  [dbo].[UserMaster]
-- =============================================
CREATE PROCEDURE [dbo].[getinfobyemailid] 
	-- Add the parameters for the stored procedure here
	@EmailID varchar(100)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	BEGIN

	SELECT UID,Login_ID,Password,EmailID FROM UserMaster WHERE EmailID=@EmailID or Login_ID=@EmailID AND Active=1
	END   
END
GO
/****** Object:  StoredProcedure [dbo].[getGuardsSalary]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec [getGuardsSalary] 6
-- =============================================
CREATE PROCEDURE [dbo].[getGuardsSalary]
-- Add the parameters for the stored procedure here
		AS
BEGIN
	SET NOCOUNT ON;
			select SupervisorSalary,TotalGuardsal,TotalSalary from SecuritySalaryMaster where active=1
END
GO
/****** Object:  StoredProcedure [dbo].[GetFlatno]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pramod
-- Create date: 01/04/1990
-- Description:	Login Check
--exec [GetFlatno] 0,16
-- =============================================
CREATE PROCEDURE [dbo].[GetFlatno] 
	-- Add the parameters for the stored procedure here
	(

	@FlatId int
	
	)
AS
BEGIN
if(@FlatId !=0)
BEGIN

SELECT a.FlatId,a.BuildingId,a.FlatNumber,b.Name
		FROM dbo.FlatMaster a
		INNER JOIN  dbo.BuildingMaster b ON b.BuildingId =a.BuildingId
	    WHERE a.Active=1 and a.FlatId=@FlatId 
END
BEGIN
SELECT a.FlatId,a.BuildingId,a.FlatNumber,b.Name
		FROM dbo.FlatMaster a
		INNER JOIN  dbo.BuildingMaster b ON a.BuildingId =b.BuildingId
	    WHERE a.Active=1 
END
END
GO
/****** Object:  StoredProcedure [dbo].[GetFlatinfobyID]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC GetFlatinfobyID 'getallrecord',1
-- =============================================
CREATE PROCEDURE [dbo].[GetFlatinfobyID]
	-- Add the parameters for the stored procedure here
	(
	@flag varchar(30),
	@ownerId int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@flag='getallrecord')
		
		BEGIN
				
			IF(@ownerId != 0)
			BEGIN
			   Select * from dbo.FlatMaster where OwnerId=@ownerId  and Active=1
			END
		ELSE
		    BEGIN
				 Select * from dbo.FlatMaster where Active=1
		    END
		END
END
GO
/****** Object:  StoredProcedure [dbo].[GetFlatinfoByFlag]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec	[GetFlatinfoByFlag]	'GetFlatID',3

-- =============================================
CREATE PROCEDURE [dbo].[GetFlatinfoByFlag]

	-- Add the parameters for the stored procedure here
	
	(
	@flag varchar(30),
	@FlatNumber varchar(50)= NULL,
	@FlatId int=null, 
	@ID int=null
	)
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
	SET NOCOUNT ON;

	if(@flag='searchflatinfo')
		
		BEGIN
				
			IF(@FlatId != 0)
			BEGIN
			   SELECT FlatId,FlatId,FlatNumber,CarpetArea,TotalArea,FlatType,IsShareCertificateGiven,IsRented,BuildingId,OwnerId,PropertyType,BusinessType,LicenseNo,ShopDescription
                              From dbo.FlatMaster where FlatId=@FlatId and Active=1
			END
		ELSE
		    BEGIN
				 SELECT FlatId,FlatNumber,IsRented,IsShareCertificateGiven
                              From dbo.FlatMaster
                               Where Active=1
		    END
		END
		
		
		
	 IF(@flag='searchflatinfoview')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@FlatId <> '')
            begin
                set @SQL = @SQL + ' and FlatId ='+ Convert(NVARCHAR,@FlatId)
            END
            
            if(@FlatNumber <> '')
            begin
              set @SQL = @SQL + ' and FlatNumber like '''+ Convert(NVARCHAR(50),@FlatNumber)+'%'''
            END

   IF(@FlatId <> '')----EDIT
                    BEGIN   
                        exec('SELECT FlatId,FlatNumber,IsRented,IsShareCertificateGiven
                              From dbo.FlatMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY FlatId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('SELECT FlatId,FlatNumber,IsRented,IsShareCertificateGiven
                              From dbo.FlatMaster
                               Where Active=1
                              '+@SQL+' 
                              ORDER BY FlatId
                        ')  
                    END    
	
	END	 

    
	if(@flag='FlatCount')
		BEGIN
		set @FlatNumber=''
		set @FlatId=0
		set @ID=0
			select count(FlatId) as count from FlatMaster where Active=1
		END


			if(@flag='GetFlatID')
		
		BEGIN
	   set @FlatNumber=''
		set @FlatId=0
			select FlatId from FlatMaster where Active=1  and OwnerId=@ID
		END


END
GO
/****** Object:  StoredProcedure [dbo].[GetFlatInfo]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--exec GetFlatInfo 'flatidforbind'
--exec GetFlatInfo 'FlatCount',"0",0
-- =============================================
CREATE PROCEDURE [dbo].[GetFlatInfo]
	-- Add the parameters for the stored procedure here
	(
	@flag varchar(30),
	@FlatNumber varchar(50)= NULL,
	@FlatId int )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@flag='getallrecord')
		
		BEGIN
		SET @FlatNumber=0; 
			IF(@FlatId != 0)
			BEGIN
			
			   Select FlatId,FlatNumber,CarpetArea,TotalArea,FlatType,IsShareCertificateGiven,IsRented,BuildingId,OwnerId,PropertyType,BusinessType,LicenseNo,ShopDescription from dbo.FlatMaster where FlatId=@FlatId and Active=1
			
			END
		ELSE
		    BEGIN
				 Select FlatId,FlatNumber,CarpetArea,TotalArea,FlatType,IsShareCertificateGiven,IsRented,BuildingId,OwnerId,PropertyType,BusinessType,LicenseNo,ShopDescription from dbo.FlatMaster where Active=1
		    END
		END
		
		
END
GO
/****** Object:  StoredProcedure [dbo].[GetDashboardDetails]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author, Akshay Kulkarni>
-- Create date: <Create Date,27/12/2014>
-- Description:	<Description,Get Dashboard data to show from DB>
-- Exec [GetDashboardDetails] 'SocietyMember',3
-- =============================================
CREATE PROCEDURE [dbo].[GetDashboardDetails] 
	-- Add the parameters for the stored procedure here
	@LoginType varchar(20),
	@ID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @PropType varchar(20),@IsRented varchar(3),@ResPaidamt money,@CommerPaidamt money
	SET @PropType =''
	
	SELECT @PropType = PropertyType, @IsRented = CASE WHEN IsRented ='1' THEN 'Yes' else 'No' END 
	FROM FlatMaster f
	INNER JOIN OwnerMaster o on o.OwnerId = f.OwnerId 
	WHERE o.OwnerId = @ID

    -- Insert statements for procedure here
	IF(@LoginType ='SocietyMember')
	BEGIN
	-- Top row 4 boxes data

		-- Current Month Maintenance Amount (1st Box)
		
			IF(@PropType = 'Residential')
			BEGIN
				SELECT 'Rs ' + CONVERT(varchar(15), AMOUNT) as AMOUNT
				FROM [dbo].[ResidentialMaintenance] a
				INNER JOIN FlatMaster b ON b.FlatId = a.FlatId AND PropertyType ='Residential' AND a.Active=1
				WHERE b.OwnerId = @ID AND CONVERT(VARCHAR(10),a.EffectiveTo,120) = CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE())),120)
			END
			ELSE IF(@PropType = 'Commercial')
			BEGIN
				SELECT 'Rs ' + CONVERT(varchar(15), AMOUNT) as AMOUNT
				FROM [dbo].[CommercialMaintenance] a
				INNER JOIN FlatMaster b ON a.ShopId = b.FlatId AND PropertyType ='Commercial' AND a.Active=1
				WHERE b.OwnerId = @ID AND CONVERT(VARCHAR(10),a.EffectiveTo,120) = CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE())),120)
			END
	   
		-- IsRented (2nd Box)
			SELECT @IsRented as IsRented

		-- Society Account Details (3rd Box)
			SELECT YEAR(GETDATE()) as AccountDetails	

		-- Society Helpdesk (4th Box)
			SELECT '022-2254205' as SocietyHelpdesk

	-- Data in Contentplaceholders
	
		--Profile Details
			SELECT *,d.EmailID,b.Name as BuildingName,c.OwnerName1 as OwnerName,d.Login_Type,e.IsParkingAvailable,f.ImagePath
			FROM FlatMaster a
			INNER JOIN BuildingMaster b ON a.BuildingId = b.BuildingId AND b.Active=1
			INNER JOIN OwnerMaster c ON a.OwnerId = c.OwnerId AND c.Active=1 
			INNER JOIN UserMaster d ON d.ID=a.OwnerId AND d.Active=1
			LEFT JOIN  ParkingMaster e ON e.FlatId=a.FlatId AND e.Active=1		 
			LEFT JOIN  BasicInformation f ON f.ID = a.OwnerId AND e.Active=1
			WHERE a.Active=1 AND a.OwnerId = @ID
													 
		--Previous 6 months maintenance Details
		--select * from [ResidentialMaintenance]
		--select * from FlatMaster
			IF(@PropType = 'Residential')
			BEGIN
				SELECT CONVERT(date,EffectiveFrom) as EffectiveFrom,CONVERT(date,EffectiveTo) as EffectiveTo,'Rs ' + CONVERT(varchar(15), AMOUNT) as AMOUNT
				FROM [dbo].[ResidentialMaintenance] a
				INNER JOIN FlatMaster b ON a.FlatId = b.FlatId AND PropertyType ='Residential' AND a.Active=1 and b.OwnerId=@ID
				WHERE CONVERT(VARCHAR(10),a.EffectiveTo,120) Between CONVERT(VARCHAR(10),DATEADD(mm,-6,DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE()))),120) AND CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE())),120)
			END
			ELSE IF(@PropType = 'Commercial')
			BEGIN
				SELECT CONVERT(date,EffectiveFrom) as EffectiveFrom,CONVERT(date,EffectiveTo) as EffectiveTo,'Rs ' + CONVERT(varchar(15), AMOUNT) as AMOUNT
				FROM [dbo].[CommercialMaintenance] a
				INNER JOIN FlatMaster b ON a.ShopId = b.FlatId AND PropertyType ='Commercial' AND a.Active=1 and b.OwnerId=@ID
				WHERE CONVERT(VARCHAR(10),a.EffectiveTo,120) Between CONVERT(VARCHAR(10),DATEADD(mm,-6,DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE()))),120) AND CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE())),120)
			END
			  
		--Upcoming Event Details
			SELECT EventName,CONVERT(date,EventOn) as EventOn,EventTime,ContactPerson,MobileNo,ContactPerson+' ('+Convert(varchar(50),MobileNo) +')' as [CntctDetails],'Rs '+ CONVERT(varchar(15), Contribution) as Contribution,FileName
			FROM EventMaster 
			WHERE ACTIVE=1 AND CONVERT(varchar(10),EventOn,120) >= CONVERT(varchar(10),GETDATE(),120)

		-- Calculate GetMaintenanceInfoCurrentMonth  
		DECLARE @CurrentMonth varchar(50),@CurrentYear varchar(50), @CalculationMethod int,@YearMonth varchar(50),@totalArea varchar(50),@flatcount varchar(10)
		SET @CurrentMonth = (SELECT MONTH(GETDATE()))
		SET @CurrentYear = (SELECT year(GETDATE()))		  
		SET @YearMonth = CONVERT(datetime, CONVERT(NVARCHAR,(CONVERT(varchar(2),1) +'/'+ @CurrentMonth + '/' + @CurrentYear)),103)
		SET @totalArea= (SELECT TotalArea from FlatMaster where OwnerId=@ID	)
		SET @flatcount=	 (SELECT count(*) from FlatMaster)
			 
		IF(@PropType = 'Residential')
			BEGIN
					SELECT @flatcount as FlatCount,@totalArea as TotalArea,MaintenanceID,PropertyType,CalculationMethodId,PropertyTaxes,WaterCharges,ElectricityCharges,RepairsMaintenanceFund,
						LiftCharges,SinkingFund,ServiceCharges,CarParkingCharges,InterestonDefaultedCharges,RepaymentInstmntLoanInterest,
						NonOccupancyCharges,InsuranceCharges,LeaseRent,NonAgriculturalTax,OtherCharges,TotalMaintenanceSum,MaintenancePerFlat,
						PerSquareFeetRate,FixedSqft,FixedRate,AdditionalSqft,AdditionalSqftRate,CONVERT(varchar(11),EffectiveFromDate) as EffectiveFromDate,
						CONVERT(varchar(11),EffectiveToDate) as EffectiveToDate,(CONVERT(varchar(50),MONTH(EffectiveFromDate)) + '/' + CONVERT(varchar(50),YEAR(EffectiveFromDate))) as EffectiveFromDate1 
					FROM [MaintenanceMaster] 
					WHERE Active=1 and EffectiveFromDate=@YearMonth and PropertyType=@PropType
			END
			ELSE IF(@PropType = 'Commercial')
			BEGIN
					SELECT MaintenanceID,PropertyType,CalculationMethodId,PropertyTaxes,WaterCharges,ElectricityCharges,RepairsMaintenanceFund,
						LiftCharges,SinkingFund,ServiceCharges,CarParkingCharges,InterestonDefaultedCharges,RepaymentInstmntLoanInterest,
						NonOccupancyCharges,InsuranceCharges,LeaseRent,NonAgriculturalTax,OtherCharges,TotalMaintenanceSum,MaintenancePerFlat,
						PerSquareFeetRate,FixedSqft,FixedRate,AdditionalSqft,AdditionalSqftRate,CONVERT(varchar(11),EffectiveFromDate) as EffectiveFromDate,CONVERT(varchar(11),EffectiveToDate) as EffectiveToDate,(CONVERT(varchar(50),MONTH(EffectiveFromDate)) + '/' + CONVERT(varchar(50),YEAR(EffectiveFromDate))
						) as EffectiveFromDate1
					FROM [MaintenanceMaster] 
					WHERE Active=1 and EffectiveFromDate=@YearMonth and PropertyType=@PropType
			END
	END				 
	ELSE IF(@LoginType ='Admin')
	BEGIN
	-- Top row 4 boxes data

		-- Current Month Income Amount (1st Box)
		
				SELECT @ResPaidamt = SUM(c.PaidAmount)
				FROM [dbo].[ResidentialMaintenance] a
				INNER JOIN FlatMaster b ON b.FlatId = a.FlatId AND PropertyType ='Residential' AND a.Active=1
				INNER JOIN ResidentialMaintenanceCollection c ON a.MaintenanceID = c.MaintenanceID
				WHERE CONVERT(VARCHAR(10),a.EffectiveTo,120) = CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE())),120)
				
				SELECT  @CommerPaidamt = SUM(PaidAmount) 
				FROM [dbo].[CommercialMaintenance] a
				INNER JOIN FlatMaster b ON a.ShopId = b.FlatId AND PropertyType ='Commercial' AND a.Active=1
				INNER JOIN CommercialMaintenanceCollection c ON a.MaintenanceID = c.MaintenanceID
				WHERE CONVERT(VARCHAR(10),a.EffectiveTo,120) = CONVERT(VARCHAR(10),DATEADD(dd,-(DAY(DATEADD(mm,1,GETDATE()))),DATEADD(mm,1,GETDATE())),120)
				
	   			SELECT 'Rs.'+ Convert(varchar(15),isnull(@ResPaidamt,0.0000)+isnull(@CommerPaidamt,0.0000)) as [Income]

		-- Current Month Expense Amount (2nd Box)
				SELECT CONVERT(NUMERIC(36,2),CEILING(SUM(Expense))) Expense FROM(
					SELECT SUM(Amount) as [Expense]
					FROM ResidentialMaintenance 
					WHERE ACTIVE=1 AND CONVERT(varchar(10),EffectiveFrom,120) = CONVERT(varchar(10),CAST(SUBSTRING(Convert(varchar(10),GETDATE(),120),1,8)+'01' as Datetime),120)
					UNION ALL
					SELECT SUM(Amount) as [Expense]
					FROM CommercialMaintenance 
					WHERE ACTIVE=1 AND CONVERT(varchar(10),EffectiveFrom,120) = CONVERT(varchar(10),CAST(SUBSTRING(Convert(varchar(10),GETDATE(),120),1,8)+'01' as Datetime),120)
				)A
		-- Current Month Expense Amount (3rd Box)

		-- Current Month Expense Amount (4th Box)

		-- ContenantPlace Holder Data
				
			--	SELECT * FROM MaintenanceMaster
	END


END
GO
/****** Object:  StoredProcedure [dbo].[GetCommitteeinformation]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec [GetCommitteeinformation] 
-- =============================================
CREATE PROCEDURE [dbo].[GetCommitteeinformation]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
		
			   SELECT a.CommiteeMemberId,a.Designation,c.FlatNumber,b.ContactNumber,b.OwnerName1 as OwnerName,a.CommiteeMemberId,a.FlatId,a.OwnerId
		FROM CommiteeMemberMaster a
		Inner join dbo.OwnerMaster b On b.OwnerId =a.OwnerId
		Inner join dbo.FlatMaster c ON a.FlatId=c.FlatId
	    WHERE a.Active=1
			END
		--select * from OwnerMaster
GO
/****** Object:  StoredProcedure [dbo].[GetCommitteeInfobyid]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- exec GetCommitteeInfobyid 4,'GetCommitteeInfobyid'
-- =============================================
CREATE PROCEDURE [dbo].[GetCommitteeInfobyid]
	-- Add the parameters for the stored procedure here
	(
	@CommiteeMemberId int,
	@flag varchar(35)
	)
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if(@flag='GetCommitteeInfobyid')
		
		BEGIN
		IF(@CommiteeMemberId != 0)
		   BEGIN
			   Select * from dbo.CommiteeMemberMaster
			    WHERE CommiteeMemberId=@CommiteeMemberId and Active=1
			END
		ELSE
		    BEGIN
				  Select *
			   from dbo.CommiteeMemberMaster
			    where Active=1
		    END
		END
		
END
GO
/****** Object:  StoredProcedure [dbo].[GetCommitteeInfo]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCommitteeInfo] 
	-- Add the parameters for the stored procedure here
	(
	@flag varchar(30),
	@Designation varchar(50)= NULL,
	@FlatId int 
	
	)
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	
	SET NOCOUNT ON;

	if(@flag='getallrecord')
		
		BEGIN
				set @Designation=0; 
			IF(@FlatId != 0)
			BEGIN
			    Select c.CommiteeMemberId,c.OwnerId,c.Designation,c.EffectiveFrom,c.FlatId,f.FlatNumber,o.OwnerName1 
			   from dbo.FlatMaster f
			   Inner join dbo.CommiteeMemberMaster c ON c.FlatId = f.FlatId
			   Inner join dbo.OwnerMaster o ON o.OwnerId = f.OwnerId
			    where f.FlatId=@FlatId and c.Active=1
			END
		ELSE
		    BEGIN
				   Select c.CommiteeMemberId,c.OwnerId,c.Designation,c.EffectiveFrom,c.FlatId,f.FlatNumber,o.OwnerName1 
			   from dbo.FlatMaster f
			   Inner join dbo.CommiteeMemberMaster c ON c.FlatId = f.FlatId
			   Inner join dbo.OwnerMaster o ON o.OwnerId = f.OwnerId
			    where c.Active=1
		    END
		END
		
		
		
	 IF(@flag='searchCommitteeinfo')
	BEGIN
		 Declare @SQL varchar(1000),@JOIN varchar(500)
            set @SQL=''
            set @JOIN=''
             
              
              if(@FlatId <> '')
            begin
                set @SQL = @SQL + ' and FlatId ='+ Convert(NVARCHAR,@FlatId)
            END
            
            if(@Designation <> '')
            begin
              set @SQL = @SQL + ' and Designation like '''+ Convert(NVARCHAR(50),@Designation)+'%'''
            END

   IF(@FlatId <> '')----EDIT
                    BEGIN   
                        exec('Select c.CommiteeMemberId,c.OwnerId,c.Designation,c.EffectiveFrom,c.FlatId,f.FlatNumber,o.OwnerName1 
			   from dbo.FlatMaster f
			   Inner join dbo.CommiteeMemberMaster c ON c.FlatId = f.FlatId
			   Inner join dbo.OwnerMaster o ON o.OwnerId = f.OwnerId
			    where c.Active=1
                              '+@SQL+' 
                              ORDER BY f.FlatId
                        ')   
                    END
                ELSE
                    BEGIN
                             exec('Select c.CommiteeMemberId,c.OwnerId,c.Designation,c.EffectiveFrom,c.FlatId,f.FlatNumber,o.OwnerName1 
			   from dbo.FlatMaster f
			   Inner join dbo.CommiteeMemberMaster c ON c.FlatId = f.FlatId
			   Inner join dbo.OwnerMaster o ON o.OwnerId = f.OwnerId
			    where c.Active=1
                              '+@SQL+' 
                              ORDER BY f.FlatId
                        ')  
                    END    
	
	END	 

    
END
GO
/****** Object:  StoredProcedure [dbo].[GetBuildingInfo]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetBuildingInfo]
	-- Add the parameters for the stored procedure here
	(
		@BuildingId int 
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
		IF(@BuildingId != 0)
			BEGIN
			   Select BuildingId,Name,Flats,Floors,TotalArea from dbo.BuildingMaster where BuildingId=@BuildingId and Active=1
			END
		ELSE
		    BEGIN
				 Select BuildingId,Name,Flats,Floors,TotalArea from dbo.BuildingMaster where Active=1
		    END
		
END
GO
/****** Object:  StoredProcedure [dbo].[GetAminityInfobyId]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetAminityInfobyId]
	-- Add the parameters for the stored procedure here
	(
		@AminityId int 
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
		IF(@AminityId != 0)
			BEGIN
			   Select * from dbo.AminityMaster where AminityId=@AminityId and Active=1
			END
		ELSE
		    BEGIN
				 Select * from dbo.AminityMaster where Active=1
		    END
		
END
GO
/****** Object:  StoredProcedure [dbo].[GetAminityInfo]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Pramod
-- Create date: 01/04/1990
-- Description:	Login Check
-- =============================================
CREATE PROCEDURE [dbo].[GetAminityInfo] 
	-- Add the parameters for the stored procedure here
	(

	@BuildingId int
	)
AS
BEGIN
if(@BuildingId !=0)
BEGIN

SELECT a.AminityId,a.BuildingId,b.Name
		FROM dbo.AminityMaster a
		INNER JOIN  dbo.BuildingMaster b ON b.BuildingId =a.BuildingId
	    WHERE a.Active=1 and a.BuildingId=@BuildingId 
END
BEGIN
SELECT a.AminityId,a.BuildingId,b.Name
		FROM dbo.AminityMaster a
		INNER JOIN dbo.BuildingMaster b ON b.BuildingId =a.BuildingId
	    WHERE a.Active=1
END
END
GO
/****** Object:  StoredProcedure [dbo].[EventDetailsGet]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<,>
-- Createdate: <Create Date,08-JUNE-2014>
-- Description:	<Description,,>
-- Exec [dbo].[]  
-- =============================================
CREATE PROCEDURE [dbo].[EventDetailsGet] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
      --select  dbo.HtmltoText(EventDescription) from EventMaster
		SELECT EventId,EventName,EventDescription,EventOn,ContactPerson,Contribution,MobileNo
		FROM EventMaster 
	    WHERE Active=1
	
END
GO
/****** Object:  StoredProcedure [dbo].[ChangePassword]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChangePassword]
(
@UID int
)
AS
BEGIN
if(@UID !=0)
	BEGIN 
		SELECT Login_ID,Password FROM dbo.UserMaster
		WHERE UID=@UID AND active=1
	END


END
GO
/****** Object:  StoredProcedure [dbo].[   ]    Script Date: 04/29/2015 19:23:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC GetFlatinfobyID 'getallrecord',1
-- =============================================
CREATE PROCEDURE [dbo].[   ]
	-- Add the parameters for the stored procedure here
	(
	@flag varchar(30),
	@ownerId int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@flag='getallrecord')
		
		BEGIN
				
			IF(@ownerId != 0)
			BEGIN
			   Select * from dbo.FlatMaster where OwnerId=@ownerId  and Active=1
			END
		ELSE
		    BEGIN
				 Select * from dbo.FlatMaster where Active=1
		    END
		END
END
GO
/****** Object:  Default [DF_AminityMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[AminityMaster] ADD  CONSTRAINT [DF_AminityMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_AminityMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[AminityMaster] ADD  CONSTRAINT [DF_AminityMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_BasicInformation_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[BasicInformation] ADD  CONSTRAINT [DF_BasicInformation_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_BasicInformation_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[BasicInformation] ADD  CONSTRAINT [DF_BasicInformation_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_BuildingMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[BuildingMaster] ADD  CONSTRAINT [DF_BuildingMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_BuildingMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[BuildingMaster] ADD  CONSTRAINT [DF_BuildingMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_CommercialMaintenanceCollection_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[CommercialMaintenanceCollection] ADD  CONSTRAINT [DF_CommercialMaintenanceCollection_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_CommercialMaintenanceCollection_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[CommercialMaintenanceCollection] ADD  CONSTRAINT [DF_CommercialMaintenanceCollection_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_CommiteeMemberMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[CommiteeMemberMaster] ADD  CONSTRAINT [DF_CommiteeMemberMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_CommiteeMemberMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[CommiteeMemberMaster] ADD  CONSTRAINT [DF_CommiteeMemberMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_EmployeeMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[EmployeeMaster] ADD  CONSTRAINT [DF_EmployeeMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_EmployeeMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[EmployeeMaster] ADD  CONSTRAINT [DF_EmployeeMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_EventMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[EventMaster] ADD  CONSTRAINT [DF_EventMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_FlatMaster_IsShareCertificateGiven]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[FlatMaster] ADD  CONSTRAINT [DF_FlatMaster_IsShareCertificateGiven]  DEFAULT ((0)) FOR [IsShareCertificateGiven]
GO
/****** Object:  Default [DF_FlatMaster_IsRented]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[FlatMaster] ADD  CONSTRAINT [DF_FlatMaster_IsRented]  DEFAULT ((0)) FOR [IsRented]
GO
/****** Object:  Default [DF_FlatMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[FlatMaster] ADD  CONSTRAINT [DF_FlatMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_FlatMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[FlatMaster] ADD  CONSTRAINT [DF_FlatMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_MaintenanceCaltypeMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MaintenanceCaltypeMaster] ADD  CONSTRAINT [DF_MaintenanceCaltypeMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_MaintainanceMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MaintenanceMaster] ADD  CONSTRAINT [DF_MaintainanceMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_MaintenanceMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MaintenanceMaster] ADD  CONSTRAINT [DF_MaintenanceMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_MonthlyExpensesMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MonthlyExpensesMaster] ADD  CONSTRAINT [DF_MonthlyExpensesMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_MonthlyExpensesMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MonthlyExpensesMaster] ADD  CONSTRAINT [DF_MonthlyExpensesMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_MonthlyExpensesMaster_ModifiedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MonthlyExpensesMaster] ADD  CONSTRAINT [DF_MonthlyExpensesMaster_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
/****** Object:  Default [DF_MonthlyMaintenanceMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MonthlyMaintenanceMaster] ADD  CONSTRAINT [DF_MonthlyMaintenanceMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_MonthlyMaintenanceMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MonthlyMaintenanceMaster] ADD  CONSTRAINT [DF_MonthlyMaintenanceMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_OwnerFamilyMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[OwnerFamilyMaster] ADD  CONSTRAINT [DF_OwnerFamilyMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_OwnerFamilyMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[OwnerFamilyMaster] ADD  CONSTRAINT [DF_OwnerFamilyMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_OwnerMaster_IsCommiteeMember]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[OwnerMaster] ADD  CONSTRAINT [DF_OwnerMaster_IsCommiteeMember]  DEFAULT ((1)) FOR [IsCommiteeMember]
GO
/****** Object:  Default [DF_OwnerMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[OwnerMaster] ADD  CONSTRAINT [DF_OwnerMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_OwnerMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[OwnerMaster] ADD  CONSTRAINT [DF_OwnerMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_ParkingMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[ParkingMaster] ADD  CONSTRAINT [DF_ParkingMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_PaymentMode_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[PaymentMode] ADD  CONSTRAINT [DF_PaymentMode_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_MaintenanceCollection_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[ResidentialMaintenanceCollection] ADD  CONSTRAINT [DF_MaintenanceCollection_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_MaintenanceCollection_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[ResidentialMaintenanceCollection] ADD  CONSTRAINT [DF_MaintenanceCollection_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_SecuritySalaryMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[SecuritySalaryMaster] ADD  CONSTRAINT [DF_SecuritySalaryMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_SecuritySalaryMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[SecuritySalaryMaster] ADD  CONSTRAINT [DF_SecuritySalaryMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_SecuritySalaryMaster_ModifiedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[SecuritySalaryMaster] ADD  CONSTRAINT [DF_SecuritySalaryMaster_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
/****** Object:  Default [DF_Society_reg_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[Society_reg] ADD  CONSTRAINT [DF_Society_reg_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_SocietyInfo_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[SocietyInfo] ADD  CONSTRAINT [DF_SocietyInfo_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_SocietyInfo_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[SocietyInfo] ADD  CONSTRAINT [DF_SocietyInfo_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_TenantMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[TenantMaster] ADD  CONSTRAINT [DF_TenantMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_TenantMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[TenantMaster] ADD  CONSTRAINT [DF_TenantMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_UserMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[UserMaster] ADD  CONSTRAINT [DF_UserMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  Default [DF_UserMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[UserMaster] ADD  CONSTRAINT [DF_UserMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_VehicleMaster_Active]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[VehicleMaster] ADD  CONSTRAINT [DF_VehicleMaster_Active]  DEFAULT ((1)) FOR [Active]
GO
/****** Object:  Default [DF_VehicleMaster_CreatedOn]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[VehicleMaster] ADD  CONSTRAINT [DF_VehicleMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
/****** Object:  ForeignKey [FK_FlatMaster_FlatMaster]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[FlatMaster]  WITH CHECK ADD  CONSTRAINT [FK_FlatMaster_FlatMaster] FOREIGN KEY([FlatId])
REFERENCES [dbo].[FlatMaster] ([FlatId])
GO
ALTER TABLE [dbo].[FlatMaster] CHECK CONSTRAINT [FK_FlatMaster_FlatMaster]
GO
/****** Object:  ForeignKey [FK_MonthlyExpensesMaster_MonthlyExpensesMaster]    Script Date: 04/29/2015 19:22:56 ******/
ALTER TABLE [dbo].[MonthlyExpensesMaster]  WITH CHECK ADD  CONSTRAINT [FK_MonthlyExpensesMaster_MonthlyExpensesMaster] FOREIGN KEY([MonthlyExpenseId])
REFERENCES [dbo].[MonthlyExpensesMaster] ([MonthlyExpenseId])
GO
ALTER TABLE [dbo].[MonthlyExpensesMaster] CHECK CONSTRAINT [FK_MonthlyExpensesMaster_MonthlyExpensesMaster]
GO
