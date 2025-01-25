SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Bridge].[usp_Merge_CustomerADUser]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO Bridge.CustomerADUser AS TGT
USING Staging.bCustomerADUser AS SRC ON (
	SRC.CustomerKey = TGT.CustomerKey
    AND SRC.ADUserKey = TGT.ADUserKey
)
WHEN NOT MATCHED
    THEN INSERT (
		CustomerKey,
		ADUserKey,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        IsRowValid
    )
    VALUES (
		SRC.CustomerKey,
        SRC.ADUserKey,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        CAST('19000101' AS DATETIME),
        CAST(1 AS BIT)
    )
WHEN MATCHED AND TGT.ChangeHashKey <> SRC.ChangeHashKey
    THEN UPDATE SET
        TGT.ChangeHashKey = SRC.ChangeHashKey,
        TGT.DatetimeUpdated = CURRENT_TIMESTAMP
WHEN NOT MATCHED BY SOURCE THEN DELETE
OUTPUT N'Bridge' AS SchemaName,
    N'CustomerADUser' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    N'' AS DivisionBusinessKey,
    CONVERT(NVARCHAR(10), COALESCE(Inserted.CustomerKey, Deleted.CustomerKey)) + ' ' + CONVERT(NVARCHAR(10), COALESCE(Inserted.ADUserKey, Deleted.ADUserKey)) AS TableBusinessKey
    INTO audit.MergeLogDetails (
        SchemaName,
        TableName,
        MergeAction,
        MergeDatetime,
        DivisionBusinessKey,
        TableBusinessKey
    );

INSERT INTO audit.MergeLogDetails
(
    SchemaName,
    TableName,
    MergeAction,
    MergeDatetime,
    DivisionBusinessKey,
    TableBusinessKey
)
SELECT
    N'Bridge' AS SchemaName,
    N'CustomerADUser' AS TableName,
    'DELETE' AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    N'' AS DivisionBusinessKey,
    CONVERT(NVARCHAR(10), DST.CustomerKey) + ' ' + CONVERT(NVARCHAR(10), DST.ADUserKey) AS TableBusinessKey

FROM Bridge.CustomerADUser DST
LEFT JOIN Staging.bCustomerADUser SRC ON SRC.CustomerKey = DST.CustomerKey AND SRC.ADUserKey = DST.ADUserKey
WHERE DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.CustomerKey IS NULL;

UPDATE DST
    SET DST.IsRowValid = CAST(0 AS BIT),
    DST.DatetimeDeleted = CURRENT_TIMESTAMP

FROM Bridge.CustomerADUser DST
LEFT JOIN Staging.bCustomerADUser SRC ON SRC.CustomerKey = DST.CustomerKey AND SRC.ADUserKey = DST.ADUserKey
WHERE DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.CustomerKey IS NULL;

END;
GO
