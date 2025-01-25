CREATE TABLE [Staging].[dRegionalKeyAccount]
(
[KeyAccountCode] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[KeyAccountDescription] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[RegionalKeyAccountCode] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[RegionalKeyAccountDescription] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[dRegionalKeyAccount] ADD CONSTRAINT [PK_Staging_dRegionalKeyAccount] PRIMARY KEY CLUSTERED  ([KeyAccountCode]) ON [PRIMARY]
GO
