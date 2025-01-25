SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [audit].[usp_CompactMergeLog]
AS
BEGIN

SET NOCOUNT ON;

    INSERT INTO audit.MergeLog
    (
        MergeDate,
        SchemaName,
        TableName,
        InsertCount,
        UpdateCount,
        DeleteCount
    )
    SELECT
        MergeDate,
        SchemaName,
        TableName,
        InsertCount,
        UpdateCount,
        DeleteCount
    FROM audit.MergeLogView;

    TRUNCATE TABLE audit.MergeLogDetails;

END;
GO
