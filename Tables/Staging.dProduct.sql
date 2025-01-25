CREATE TABLE [Staging].[dProduct]
(
[DivisionKey] [tinyint] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[ProductBusinessKey] [nvarchar] (18) COLLATE Latin1_General_CI_AS NOT NULL,
[HistoricalHashKey] [varbinary] (20) NOT NULL,
[ChangeHashKey] [varbinary] (20) NOT NULL,
[ProductDescription] [nvarchar] (80) COLLATE Latin1_General_CI_AS NOT NULL,
[ProductDescription2] [nvarchar] (80) COLLATE Latin1_General_CI_AS NOT NULL,
[PPHyerarchyCode] [nvarchar] (12) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel1Description] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel2Description] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[PPLevel3Description] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[dProduct] ADD CONSTRAINT [PK_Staging_dProduct] PRIMARY KEY CLUSTERED  ([DivisionBusinessKey], [ProductBusinessKey]) ON [PRIMARY]
GO
