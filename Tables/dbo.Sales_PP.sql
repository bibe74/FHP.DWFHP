CREATE TABLE [dbo].[Sales_PP]
(
[COD] [int] NOT NULL,
[DIV] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Cognome] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Nome] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[AD] [nvarchar] (50) COLLATE Latin1_General_CI_AS NULL,
[CODPADRE] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL,
[Cognome2] [nvarchar] (50) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
