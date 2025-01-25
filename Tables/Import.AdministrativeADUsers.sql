CREATE TABLE [Import].[AdministrativeADUsers]
(
[ADUser] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[Description] [nvarchar] (100) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Import].[AdministrativeADUsers] ADD CONSTRAINT [PK_Import_AdministrativeADUsers] PRIMARY KEY CLUSTERED  ([ADUser]) ON [PRIMARY]
GO
