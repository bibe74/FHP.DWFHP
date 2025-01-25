SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Dim].[usp_Merge_ADUser]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO Dim.ADUser AS TGT
USING Staging.dADUser AS SRC ON (
    SRC.ADDomain = TGT.ADDomain
    AND SRC.ADUser = TGT.ADUser
)
WHEN NOT MATCHED
    THEN INSERT (
        ADDomain,
		ADUser,
        --ADUserKey,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        IsRowValid,
		UserType
    )
    VALUES (
        SRC.ADDomain,
        SRC.ADUser,
		--ADUserKey,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP,
        CAST('19000101' AS DATETIME),
        CAST(1 AS BIT),
        SRC.UserType
    )
WHEN MATCHED AND TGT.ChangeHashKey <> SRC.ChangeHashKey
    THEN UPDATE SET
        TGT.ChangeHashKey = SRC.ChangeHashKey,
        TGT.DatetimeUpdated = CURRENT_TIMESTAMP,
		TGT.UserType = SRC.UserType
--WHEN NOT MATCHED BY SOURCE THEN DELETE
OUTPUT N'Dim' AS SchemaName,
    N'ADUser' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    N'' AS DivisionBusinessKey,
    COALESCE(Inserted.ADDomain, Deleted.ADDomain) + N'\' + COALESCE(Inserted.ADUser, Deleted.ADUser) AS TableBusinessKey
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
    N'ADUser' AS TableName,
    'DELETE' AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    N'' AS DivisionBusinessKey,
    DST.ADDomain + N'\' + DST.ADUser AS TableBusinessKey

FROM Dim.ADUser DST
LEFT JOIN Staging.dADUser SRC ON SRC.ADDomain = DST.ADDomain AND SRC.ADUser = DST.ADUser
WHERE DST.ADUserKey > 0
    AND DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.ADUser IS NULL;

UPDATE DST
    SET DST.IsRowValid = CAST(0 AS BIT),
    DST.DatetimeDeleted = CURRENT_TIMESTAMP

FROM Dim.ADUser DST
LEFT JOIN Staging.dADUser SRC ON SRC.ADDomain = DST.ADDomain AND SRC.ADUser = DST.ADUser
WHERE DST.ADUserKey > 0
    AND DST.IsRowValid = CAST(1 AS BIT)
    AND SRC.ADUser IS NULL;

END;
GO
