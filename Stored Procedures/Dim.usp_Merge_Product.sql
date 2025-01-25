SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Dim].[usp_Merge_Product]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO Dim.Product AS TGT
USING Staging.dProduct AS SRC ON (
    SRC.DivisionBusinessKey = TGT.DivisionBusinessKey
    AND SRC.ProductBusinessKey = TGT.ProductBusinessKey
)
WHEN NOT MATCHED
    THEN INSERT (
        DivisionKey,
        DivisionBusinessKey,
        ProductBusinessKey,
        --ProductKey,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        IsRowValid,
        ProductDescription,
        ProductDescription2,
        PPHyerarchyCode,
        PPLevel1Description,
        PPLevel2Description,
        PPLevel3Description
    )
    VALUES (
        SRC.DivisionKey,
        SRC.DivisionBusinessKey,
        SRC.ProductBusinessKey,
        --ProductKey,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        CAST('19000101' AS DATETIME),
        CAST(1 AS BIT),
        SRC.ProductDescription,
        SRC.ProductDescription2,
        SRC.PPHyerarchyCode,
        SRC.PPLevel1Description,
        SRC.PPLevel2Description,
        SRC.PPLevel3Description
    )
WHEN MATCHED AND TGT.ChangeHashKey <> SRC.ChangeHashKey
    THEN UPDATE SET
        TGT.ChangeHashKey = SRC.ChangeHashKey,
        TGT.DatetimeUpdated = CURRENT_TIMESTAMP,
        TGT.ProductDescription = SRC.ProductDescription,
        TGT.ProductDescription2 = SRC.ProductDescription2,
        TGT.PPHyerarchyCode = SRC.PPHyerarchyCode,
        TGT.PPLevel1Description = SRC.PPLevel1Description,
        TGT.PPLevel2Description = SRC.PPLevel2Description,
        TGT.PPLevel3Description = SRC.PPLevel3Description
--WHEN NOT MATCHED BY SOURCE THEN DELETE
OUTPUT N'Dim' AS SchemaName,
    N'Product' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    COALESCE(Inserted.DivisionBusinessKey, Deleted.DivisionBusinessKey) AS DivisionBusinessKey,
    COALESCE(Inserted.ProductBusinessKey, Deleted.ProductBusinessKey) AS TableBusinessKey
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
    N'Dim' AS SchemaName,
    N'Product' AS TableName,
    'DELETE' AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    DST.DivisionBusinessKey,
    DST.ProductBusinessKey AS TableBusinessKey

FROM Dim.Product DST
LEFT JOIN Staging.dProduct SRC ON SRC.DivisionBusinessKey = DST.DivisionBusinessKey AND SRC.ProductBusinessKey = DST.ProductBusinessKey
WHERE DST.ProductKey > 0
    AND DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.ProductBusinessKey IS NULL;

UPDATE DST
    SET DST.IsRowValid = CAST(0 AS BIT),
    DST.DatetimeDeleted = CURRENT_TIMESTAMP

FROM Dim.Product DST
LEFT JOIN Staging.dProduct SRC ON SRC.DivisionBusinessKey = DST.DivisionBusinessKey AND SRC.ProductBusinessKey = DST.ProductBusinessKey
WHERE DST.ProductKey > 0
    AND DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.ProductBusinessKey IS NULL;

END;
GO
