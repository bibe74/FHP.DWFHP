SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [LandingDbFlorence].[usp_Merge_AnagraficaProdotti]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO LandingDbFlorence.AnagraficaProdotti AS DST
USING LandingDbFlorence.AnagraficaProdottiView AS SRC
ON SRC.CODSOCIETA = DST.CODSOCIETA AND SRC.CODART_F = DST.CODART_F
WHEN NOT MATCHED
    THEN INSERT (
        CODSOCIETA,
        CODART_F,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        DESART1,
        DESC_ART,
        COD_LIV_3,
        DESC_LIV_3,
        COD_LIV_2,
        DESC_LIV_2,
        COD_LIV_1,
        DESC_LIV_1
    )
    VALUES (
        SRC.CODSOCIETA,
        SRC.CODART_F,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        SRC.DatetimeInserted,
        SRC.DatetimeUpdated,
        SRC.DatetimeDeleted,
        SRC.DESART1,
        SRC.DESC_ART,
        SRC.COD_LIV_3,
        SRC.DESC_LIV_3,
        SRC.COD_LIV_2,
        SRC.DESC_LIV_2,
        SRC.COD_LIV_1,
        SRC.DESC_LIV_1
    )
WHEN MATCHED AND SRC.ChangeHashKey <> DST.ChangeHashKey
    THEN UPDATE SET
        DST.ChangeHashKey = SRC.ChangeHashKey,
        DST.DatetimeUpdated = SRC.DatetimeUpdated,
        DST.DESART1 = SRC.DESART1,
        DST.DESC_ART = SRC.DESC_ART,
        DST.COD_LIV_3 = SRC.COD_LIV_3,
        DST.DESC_LIV_3 = SRC.DESC_LIV_3,
        DST.COD_LIV_2 = SRC.COD_LIV_2,
        DST.DESC_LIV_2 = SRC.DESC_LIV_2,
        DST.COD_LIV_1 = SRC.COD_LIV_1,
        DST.DESC_LIV_1 = SRC.DESC_LIV_1
WHEN NOT MATCHED BY SOURCE
    THEN UPDATE SET
        DST.DatetimeDeleted = CURRENT_TIMESTAMP
OUTPUT N'LandingDbFlorence' AS SchemaName,
    N'AnagraficaProdotti' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    COALESCE(Inserted.CODSOCIETA, Deleted.CODSOCIETA) AS DivisionBusinessKey,
    COALESCE(Inserted.CODART_F, Deleted.CODART_F) AS TableBusinessKey
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
