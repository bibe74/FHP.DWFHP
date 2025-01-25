CREATE TABLE [Dim].[ADUser]
(
[ADDomain] [nvarchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[ADUser] [nvarchar] (40) COLLATE Latin1_General_CI_AS NOT NULL,
[ADUserKey] [int] NOT NULL CONSTRAINT [DFT_Dim_ADUser_ADUserKey] DEFAULT (NEXT VALUE FOR [dbo].[seq_ADUser]),
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NOT NULL,
[IsRowValid] [bit] NOT NULL,
[UserType] [nvarchar] (14) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dim].[ADUser] ADD CONSTRAINT [PK_Dim_ADUser] PRIMARY KEY CLUSTERED  ([ADUserKey]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Dim_ADUser_DivisionBusinessKey_ADUserBusinessKey] ON [Dim].[ADUser] ([ADDomain], [ADUser]) ON [PRIMARY]
GO
