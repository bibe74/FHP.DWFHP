CREATE TABLE [LandingDbFlorence].[AnagraficaProdotti]
(
[CODSOCIETA] [nvarchar] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[CODART_F] [nvarchar] (18) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NULL,
[ChangeHashKey] [varbinary] (20) NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NULL,
[DESART1] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL,
[DESC_ART] [nvarchar] (80) COLLATE Latin1_General_CI_AS NULL,
[COD_LIV_3] [nvarchar] (18) COLLATE Latin1_General_CI_AS NULL,
[DESC_LIV_3] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[COD_LIV_2] [nvarchar] (18) COLLATE Latin1_General_CI_AS NULL,
[DESC_LIV_2] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[COD_LIV_1] [nvarchar] (18) COLLATE Latin1_General_CI_AS NULL,
[DESC_LIV_1] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
