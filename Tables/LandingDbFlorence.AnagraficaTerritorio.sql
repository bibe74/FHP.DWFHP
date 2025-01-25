CREATE TABLE [LandingDbFlorence].[AnagraficaTerritorio]
(
[CODSOCIETA] [nvarchar] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[CODUTENTE] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NULL,
[ChangeHashKey] [varbinary] (20) NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NULL,
[COGNOME] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[NOME] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[CODUTENTEPADRE] [nvarchar] (10) COLLATE Latin1_General_CI_AS NULL,
[Padre_Cognome] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[Padre_Nome] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
