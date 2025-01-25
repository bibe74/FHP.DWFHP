SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Fact].[usp_Merge_Sales]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO Fact.Sales AS TGT
USING Staging.fSales AS SRC ON (
    SRC.DivisionBusinessKey = TGT.DivisionBusinessKey
    AND SRC.DateKey = TGT.DateKey
    AND SRC.CustomerBusinessKey = TGT.CustomerBusinessKey
    AND SRC.ProductBusinessKey = TGT.ProductBusinessKey
)
WHEN NOT MATCHED
    THEN INSERT (
        DivisionKey,
        DivisionBusinessKey,
        DateKey,
        CustomerKey,
		CustomerBusinessKey,
        ProductKey,
        ProductBusinessKey,
        --FatturatoKey,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        IsRowValid,
        SalesQuantity,
        SalesAmount
    )
    VALUES (
        SRC.DivisionKey,
        SRC.DivisionBusinessKey,
        SRC.DateKey,
        SRC.CustomerKey,
		SRC.CustomerBusinessKey,
        SRC.ProductKey,
        SRC.ProductBusinessKey,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        CAST('19000101' AS DATETIME),
        CAST(1 AS BIT),
        SRC.SalesQuantity,
        SRC.SalesAmount
    )
WHEN MATCHED AND TGT.ChangeHashKey <> SRC.ChangeHashKey
    THEN UPDATE SET
        TGT.ChangeHashKey = SRC.ChangeHashKey,
        TGT.DatetimeUpdated = CURRENT_TIMESTAMP,
        TGT.SalesQuantity = SRC.SalesQuantity,
        TGT.SalesAmount = SRC.SalesAmount
--WHEN NOT MATCHED BY SOURCE THEN DELETE
OUTPUT N'Fact' AS SchemaName,
    N'Sales' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    COALESCE(Inserted.DivisionBusinessKey, Deleted.DivisionBusinessKey) AS DivisionBusinessKey,
    CONCAT(
        CONVERT(NVARCHAR(10), COALESCE(Inserted.DateKey, Deleted.DateKey), 103),
        N' ', COALESCE(Inserted.CustomerBusinessKey, Deleted.CustomerBusinessKey),
        N' ', COALESCE(Inserted.ProductBusinessKey, Deleted.ProductBusinessKey)
    )
    INTO audit.MergeLogDetails (
        SchemaName,
        TableName,
        MergeAction,
        MergeDatetime,
        DivisionBusinessKey,
        TableBusinessKey
    );

END;
GO
