CREATE TABLE [audit].[MergeLogDetails]
(
[MergeLogDetailId] [bigint] NOT NULL IDENTITY(1, 1),
[SchemaName] [sys].[sysname] NOT NULL,
[TableName] [sys].[sysname] NOT NULL,
[MergeAction] [varchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[MergeDatetime] [datetime] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NULL,
[TableBusinessKey] [nvarchar] (255) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [audit].[MergeLogDetails] ADD CONSTRAINT [PK_audit_MergeLogDetails] PRIMARY KEY CLUSTERED  ([MergeLogDetailId]) ON [PRIMARY]
GO
