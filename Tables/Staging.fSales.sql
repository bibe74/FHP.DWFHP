CREATE TABLE [Staging].[fSales]
(
[DivisionKey] [tinyint] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[DateKey] [int] NOT NULL,
[CustomerKey] [int] NOT NULL,
[CustomerBusinessKey] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[ProductKey] [int] NOT NULL,
[ProductBusinessKey] [nvarchar] (18) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[SalesQuantity] [decimal] (18, 2) NOT NULL,
[SalesAmount] [decimal] (18, 2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[fSales] ADD CONSTRAINT [PK_Staging_fSales] PRIMARY KEY CLUSTERED  ([DivisionBusinessKey], [DateKey], [CustomerBusinessKey], [ProductBusinessKey]) ON [PRIMARY]
GO
