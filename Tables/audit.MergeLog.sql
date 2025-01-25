CREATE TABLE [audit].[MergeLog]
(
[PKMergeLog] [bigint] NOT NULL IDENTITY(1, 1),
[MergeDate] [date] NULL,
[SchemaName] [sys].[sysname] NOT NULL,
[TableName] [sys].[sysname] NOT NULL,
[InsertCount] [int] NULL,
[UpdateCount] [int] NULL,
[DeleteCount] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [audit].[MergeLog] ADD CONSTRAINT [PK_audit_MergeLog] PRIMARY KEY CLUSTERED  ([PKMergeLog]) ON [PRIMARY]
GO
