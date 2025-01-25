CREATE TABLE [Fact].[Sales]
(
[DivisionKey] [tinyint] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[DateKey] [int] NOT NULL,
[CustomerKey] [int] NOT NULL,
[CustomerBusinessKey] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[ProductKey] [int] NOT NULL,
[ProductBusinessKey] [nvarchar] (18) COLLATE Latin1_General_CI_AS NOT NULL,
[FatturatoKey] [int] NOT NULL CONSTRAINT [DFT_Fact_Sales_FatturatoKey] DEFAULT (NEXT VALUE FOR [dbo].[seq_Sales]),
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NOT NULL,
[IsRowValid] [bit] NOT NULL,
[SalesQuantity] [decimal] (18, 2) NOT NULL,
[SalesAmount] [decimal] (18, 2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Fact].[Sales] ADD CONSTRAINT [PK_Fact_Sales] PRIMARY KEY CLUSTERED  ([FatturatoKey]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Fact_Sales_DivisionBusinessKey_DateKey_CustomerBusinessKey_ProductBusinessKey] ON [Fact].[Sales] ([DivisionBusinessKey], [DateKey], [CustomerBusinessKey], [ProductBusinessKey]) ON [PRIMARY]
GO
ALTER TABLE [Fact].[Sales] ADD CONSTRAINT [FK_Fact_Sales_CustomerKey] FOREIGN KEY ([CustomerKey]) REFERENCES [Dim].[Customer] ([CustomerKey])
GO
ALTER TABLE [Fact].[Sales] ADD CONSTRAINT [FK_Fact_Sales_DateKey] FOREIGN KEY ([DateKey]) REFERENCES [Dim].[Date] ([DateKey])
GO
ALTER TABLE [Fact].[Sales] ADD CONSTRAINT [FK_Fact_Sales_DivisionKey] FOREIGN KEY ([DivisionKey]) REFERENCES [Dim].[Division] ([DivisionKey])
GO
ALTER TABLE [Fact].[Sales] ADD CONSTRAINT [FK_Fact_Sales_ProductKey] FOREIGN KEY ([ProductKey]) REFERENCES [Dim].[Product] ([ProductKey])
GO
