CREATE TABLE [LandingDbFlorence].[RiepilogoFatturato]
(
[CODSOCIETA] [varchar] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[DATA] [datetime] NOT NULL,
[CODCLI] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[CODART] [nvarchar] (18) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NULL,
[ChangeHashKey] [varbinary] (20) NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NULL,
[QTAFATT] [decimal] (38, 3) NULL,
[IMPFATT] [decimal] (38, 2) NULL
) ON [PRIMARY]
GO
