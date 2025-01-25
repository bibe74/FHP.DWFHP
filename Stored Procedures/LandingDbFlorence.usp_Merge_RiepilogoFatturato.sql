SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [LandingDbFlorence].[usp_Merge_RiepilogoFatturato]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO LandingDbFlorence.RiepilogoFatturato AS DST
USING LandingDbFlorence.RiepilogoFatturatoView AS SRC
ON SRC.CODSOCIETA = DST.CODSOCIETA
    AND SRC.DATA = DST.DATA
    AND SRC.CODCLI = DST.CODCLI
    AND SRC.CODART = DST.CODART
WHEN NOT MATCHED
    THEN INSERT (
        CODSOCIETA,
        DATA,
        CODCLI,
        CODART,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        QTAFATT,
        IMPFATT
    )
    VALUES (
        SRC.CODSOCIETA,
        SRC.DATA,
        SRC.CODCLI,
        SRC.CODART,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        SRC.DatetimeInserted,
        SRC.DatetimeUpdated,
        SRC.DatetimeDeleted,
        SRC.QTAFATT,
        SRC.IMPFATT
    )
WHEN MATCHED AND SRC.ChangeHashKey <> DST.ChangeHashKey
    THEN UPDATE SET
        DST.ChangeHashKey = SRC.ChangeHashKey,
        DST.DatetimeUpdated = SRC.DatetimeUpdated,
        DST.QTAFATT = SRC.QTAFATT,
        DST.IMPFATT = SRC.IMPFATT
WHEN NOT MATCHED BY SOURCE
    THEN UPDATE SET
        DST.DatetimeDeleted = CURRENT_TIMESTAMP
OUTPUT N'LandingDbFlorence' AS SchemaName,
    N'RiepilogoFatturato' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    COALESCE(Inserted.CODSOCIETA, Deleted.CODSOCIETA) AS DivisionBusinessKey,
    CONCAT(
        CONVERT(NVARCHAR(10), COALESCE(Inserted.DATA, Deleted.DATA), 103),
        N' ', COALESCE(Inserted.CODCLI, Deleted.CODCLI),
        N' ', COALESCE(Inserted.CODART, Deleted.CODART)
    ) AS TableBusinessKey
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
