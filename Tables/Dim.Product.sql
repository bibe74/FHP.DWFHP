CREATE TABLE [Dim].[Product]
(
[DivisionKey] [tinyint] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[ProductBusinessKey] [nvarchar] (18) COLLATE Latin1_General_CI_AS NOT NULL,
[ProductKey] [int] NOT NULL CONSTRAINT [DFT_Dim_Product_ProductKey] DEFAULT (NEXT VALUE FOR [dbo].[seq_Product]),
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NOT NULL,
[IsRowValid] [bit] NOT NULL,
[ProductDescription] [nvarchar] (80) COLLATE Latin1_General_CI_AS NOT NULL,
[ProductDescription2] [nvarchar] (80) COLLATE Latin1_General_CI_AS NOT NULL,
[PPHyerarchyCode] [nvarchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel1Description] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel2Description] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel3Description] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dim].[Product] ADD CONSTRAINT [PK_Dim_Product] PRIMARY KEY CLUSTERED  ([ProductKey]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Dim_Product_DivisionBusinessKey_ProductBusinessKey] ON [Dim].[Product] ([DivisionBusinessKey], [ProductBusinessKey]) ON [PRIMARY]
GO
ALTER TABLE [Dim].[Product] ADD CONSTRAINT [FK_Dim_Product_DivisionKey] FOREIGN KEY ([DivisionKey]) REFERENCES [Dim].[Division] ([DivisionKey])
GO
