SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Dim].[usp_Merge_Customer]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO Dim.Customer AS TGT
USING Staging.dCustomer AS SRC ON (
    SRC.DivisionBusinessKey = TGT.DivisionBusinessKey
    AND SRC.CustomerBusinessKey = TGT.CustomerBusinessKey
)
WHEN NOT MATCHED
    THEN INSERT (
        DivisionKey,
        DivisionBusinessKey,
        CustomerBusinessKey,
        --CustomerKey,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        IsRowValid,
        RegionalKeyAccount,
        StartDate,
        EndDate,
        Customer,
        KeyAccountCode,
        KeyAccountDescription,
        RegionalKeyAccountDescription,
        CustomerStatisticCode,
        PPHyerarchyCode,
        PPLevel1Description,
        PPLevel2Description,
        PPLevel3Description,
        PPLevel4Description,
        PPLevel5Description,
        PPLevel6Description,
        PPLevel7Description
    )
    VALUES (
        SRC.DivisionKey,
        SRC.DivisionBusinessKey,
        SRC.CustomerBusinessKey,
		--CustomerKey,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        CAST('19000101' AS DATETIME),
        CAST(1 AS BIT),
        SRC.RegionalKeyAccount,
        SRC.StartDate,
        SRC.EndDate,
        SRC.Customer,
        SRC.KeyAccountCode,
        SRC.KeyAccountDescription,
        SRC.RegionalKeyAccountDescription,
        SRC.CustomerStatisticCode,
        SRC.PPHyerarchyCode,
        SRC.PPLevel1Description,
        SRC.PPLevel2Description,
        SRC.PPLevel3Description,
        SRC.PPLevel4Description,
        SRC.PPLevel5Description,
        SRC.PPLevel6Description,
        SRC.PPLevel7Description
    )
WHEN MATCHED AND TGT.ChangeHashKey <> SRC.ChangeHashKey
    THEN UPDATE SET
        TGT.ChangeHashKey = SRC.ChangeHashKey,
        TGT.DatetimeUpdated = CURRENT_TIMESTAMP,
		TGT.RegionalKeyAccount = SRC.RegionalKeyAccount,
		TGT.StartDate = SRC.StartDate,
		TGT.EndDate = SRC.EndDate,
		TGT.Customer = SRC.Customer,
		TGT.KeyAccountCode = SRC.KeyAccountCode,
		TGT.KeyAccountDescription = SRC.KeyAccountDescription,
		TGT.RegionalKeyAccountDescription = SRC.RegionalKeyAccountDescription,
		TGT.CustomerStatisticCode = SRC.CustomerStatisticCode,
		TGT.PPHyerarchyCode = SRC.PPHyerarchyCode,
		TGT.PPLevel1Description = SRC.PPLevel1Description,
		TGT.PPLevel2Description = SRC.PPLevel2Description,
		TGT.PPLevel3Description = SRC.PPLevel3Description,
		TGT.PPLevel4Description = SRC.PPLevel4Description,
		TGT.PPLevel5Description = SRC.PPLevel5Description,
		TGT.PPLevel6Description = SRC.PPLevel6Description,
		TGT.PPLevel7Description = SRC.PPLevel7Description
--WHEN NOT MATCHED BY SOURCE THEN DELETE
OUTPUT N'Dim' AS SchemaName,
    N'Customer' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    COALESCE(Inserted.DivisionBusinessKey, Deleted.DivisionBusinessKey) AS DivisionBusinessKey,
    COALESCE(Inserted.CustomerBusinessKey, Deleted.CustomerBusinessKey) AS TableBusinessKey
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
    N'Customer' AS TableName,
    'DELETE' AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    DST.DivisionBusinessKey,
    DST.CustomerBusinessKey AS TableBusinessKey

FROM Dim.Customer DST
LEFT JOIN Staging.dCustomer SRC ON SRC.DivisionBusinessKey = DST.DivisionBusinessKey AND SRC.CustomerBusinessKey = DST.CustomerBusinessKey
WHERE DST.CustomerKey > 0
    AND DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.CustomerBusinessKey IS NULL;

UPDATE DST
    SET DST.IsRowValid = CAST(0 AS BIT),
    DST.DatetimeDeleted = CURRENT_TIMESTAMP

FROM Dim.Customer DST
LEFT JOIN Staging.dCustomer SRC ON SRC.DivisionBusinessKey = DST.DivisionBusinessKey AND SRC.CustomerBusinessKey = DST.CustomerBusinessKey
WHERE DST.CustomerKey > 0
    AND DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.CustomerBusinessKey IS NULL;

END;
GO
