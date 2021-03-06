USE [SmartParking]
GO
/****** Object:  Table [dbo].[Masini]    Script Date: 7/7/2016 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Masini](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ModelID] [int] NOT NULL,
	[NrInmatriculare] [nvarchar](50) NULL,
	[Culoare] [nvarchar](50) NULL,
 CONSTRAINT [PK_Masini] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Model]    Script Date: 7/7/2016 1:05:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Model](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nume] [nvarchar](100) NOT NULL,
	[ProducatorID] [int] NOT NULL,
	[Activ] [bit] NOT NULL,
	[An] [int] NOT NULL,
 CONSTRAINT [PK__Model__3214EC278AEBA964] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producator]    Script Date: 7/7/2016 1:05:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producator](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nume] [nvarchar](100) NOT NULL,
	[Activ] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vizite]    Script Date: 7/7/2016 1:05:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vizite](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MasinaID] [int] NOT NULL,
	[DataSosire] [datetime2](7) NOT NULL,
	[DataPlecare] [datetime2](7) NULL,
	[Durata_calculata]  AS (datediff(minute,[DataSosire],[DataPlecare])/(60.0)),
 CONSTRAINT [PK_Vizite] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Masini]  WITH CHECK ADD  CONSTRAINT [FK_Masini_Model] FOREIGN KEY([ModelID])
REFERENCES [dbo].[Model] ([ID])
GO
ALTER TABLE [dbo].[Masini] CHECK CONSTRAINT [FK_Masini_Model]
GO
ALTER TABLE [dbo].[Model]  WITH CHECK ADD  CONSTRAINT [FK_Model_Producator] FOREIGN KEY([ProducatorID])
REFERENCES [dbo].[Producator] ([ID])
GO
ALTER TABLE [dbo].[Model] CHECK CONSTRAINT [FK_Model_Producator]
GO
ALTER TABLE [dbo].[Vizite]  WITH CHECK ADD  CONSTRAINT [FK_Vizite_Masini] FOREIGN KEY([MasinaID])
REFERENCES [dbo].[Masini] ([ID])
GO
ALTER TABLE [dbo].[Vizite] CHECK CONSTRAINT [FK_Vizite_Masini]
GO
