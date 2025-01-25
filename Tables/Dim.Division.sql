CREATE TABLE [Dim].[Division]
(
[DivisionKey] [tinyint] NOT NULL,
[DivisionBusinessKey] [char] (4) COLLATE Latin1_General_CI_AS NOT NULL,
[DivisionDescription] [nvarchar] (20) COLLATE Latin1_General_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Dim].[Division] ADD CONSTRAINT [PK_Dim_Division] PRIMARY KEY CLUSTERED  ([DivisionKey]) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Dim_Division_DivisionBusinessKey] ON [Dim].[Division] ([DivisionBusinessKey]) ON [PRIMARY]
GO
