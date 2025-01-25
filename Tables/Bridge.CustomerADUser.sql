CREATE TABLE [Bridge].[CustomerADUser]
(
[CustomerKey] [int] NOT NULL,
[ADUserKey] [int] NOT NULL,
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NOT NULL,
[IsRowValid] [bit] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Bridge].[CustomerADUser] ADD CONSTRAINT [PK_Bridge_CustomerADUser] PRIMARY KEY CLUSTERED  ([CustomerKey], [ADUserKey]) ON [PRIMARY]
GO
ALTER TABLE [Bridge].[CustomerADUser] ADD CONSTRAINT [FK_Bridge_CustomerADUser_ADUser] FOREIGN KEY ([ADUserKey]) REFERENCES [Dim].[ADUser] ([ADUserKey])
GO
ALTER TABLE [Bridge].[CustomerADUser] ADD CONSTRAINT [FK_Bridge_CustomerADUser_CustomerKey] FOREIGN KEY ([CustomerKey]) REFERENCES [Dim].[Customer] ([CustomerKey])
GO
