CREATE TABLE [Dim].[Customer]
(
[DivisionKey] [tinyint] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[CustomerBusinessKey] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[CustomerKey] [int] NOT NULL CONSTRAINT [DFT_Dim_Customer_CustomerKey] DEFAULT (NEXT VALUE FOR [dbo].[seq_Customer]),
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[DatetimeInserted] [datetime] NOT NULL,
[DatetimeUpdated] [datetime] NOT NULL,
[DatetimeDeleted] [datetime] NOT NULL,
[IsRowValid] [bit] NOT NULL,
[RegionalKeyAccount] [varchar] (3) COLLATE Latin1_General_CI_AS NOT NULL,
[StartDate] [date] NOT NULL,
[EndDate] [date] NOT NULL,
[Customer] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[KeyAccountCode] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[KeyAccountDescription] [nvarchar] (101) COLLATE Latin1_General_CI_AS NOT NULL,
[RegionalKeyAccountDescription] [nvarchar] (101) COLLATE Latin1_General_CI_AS NOT NULL,
[CustomerStatisticCode] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[PPHyerarchyCode] [nvarchar] (10) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel1Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel2Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel3Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel4Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel5Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel6Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel7Description] [nvarchar] (35) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dim].[Customer] ADD CONSTRAINT [PK_Dim_Customer] PRIMARY KEY CLUSTERED  ([CustomerKey]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Dim_Customer_DivisionBusinessKey_CustomerBusinessKey] ON [Dim].[Customer] ([DivisionBusinessKey], [CustomerBusinessKey]) ON [PRIMARY]
GO
ALTER TABLE [Dim].[Customer] ADD CONSTRAINT [FK_Dim_Customer_DivisionKey] FOREIGN KEY ([DivisionKey]) REFERENCES [Dim].[Division] ([DivisionKey])
GO
