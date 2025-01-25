CREATE TABLE [Import].[TerritorialADUsers]
(
[CODAGENTE] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[ADUser] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[Description] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL,
[CODAGENTEPADRE] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL,
[SalesGroupDescription] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[SalesGroupADUser] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Import].[TerritorialADUsers] ADD CONSTRAINT [PK_Import_TerritorialADUsers] PRIMARY KEY CLUSTERED  ([CODAGENTE], [ADUser]) ON [PRIMARY]
GO
