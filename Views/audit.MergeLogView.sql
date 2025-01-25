SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [audit].[MergeLogView]
AS
SELECT
    CAST(MLD.MergeDatetime AS DATE) AS MergeDate,
    MLD.SchemaName,
    MLD.TableName,
    SUM(CASE WHEN MLD.MergeAction = 'INSERT' THEN 1 ELSE NULL END) AS InsertCount,
    SUM(CASE WHEN MLD.MergeAction = 'UPDATE' THEN 1 ELSE NULL END) AS UpdateCount,
    SUM(CASE WHEN MLD.MergeAction = 'DELETE' THEN 1 ELSE NULL END) AS DeleteCount

FROM audit.MergeLogDetails MLD
GROUP BY CAST(MLD.MergeDatetime AS DATE),
    MLD.SchemaName,
    MLD.TableName;
GO
