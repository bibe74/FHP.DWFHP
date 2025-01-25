CREATE TABLE [Staging].[bCustomerADUser]
(
[CustomerKey] [int] NOT NULL,
[ADUserKey] [int] NOT NULL,
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[bCustomerADUser] ADD CONSTRAINT [PK_Staging_bCustomerADUser] PRIMARY KEY CLUSTERED  ([CustomerKey], [ADUserKey]) ON [PRIMARY]
GO
