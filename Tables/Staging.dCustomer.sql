CREATE TABLE [Staging].[dCustomer]
(
[DivisionKey] [tinyint] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[CustomerBusinessKey] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[RegionalKeyAccount] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[StartDate] [date] NOT NULL,
[EndDate] [date] NOT NULL,
[Customer] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[KeyAccountCode] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[KeyAccountDescription] [nvarchar] (101) COLLATE Latin1_General_CI_AS NOT NULL,
[RegionalKeyAccountDescription] [nvarchar] (101) COLLATE Latin1_General_CI_AS NOT NULL,
[CustomerStatisticCode] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[PPHyerarchyCode] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel1Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel2Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel3Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel4Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel5Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel6Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel7Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[dCustomer] ADD CONSTRAINT [PK_Staging_dCustomer] PRIMARY KEY CLUSTERED  ([DivisionBusinessKey], [CustomerBusinessKey]) ON [PRIMARY]
GO
