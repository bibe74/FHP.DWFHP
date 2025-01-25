CREATE TABLE [Staging].[dADUser]
(
[ADDomain] [nvarchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[ADUser] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[UserType] [nvarchar] (14) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[dADUser] ADD CONSTRAINT [PK_Staging_dADUser] PRIMARY KEY CLUSTERED  ([ADDomain], [ADUser]) ON [PRIMARY]
GO
