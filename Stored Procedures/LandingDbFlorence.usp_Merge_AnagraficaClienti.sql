SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [LandingDbFlorence].[usp_Merge_AnagraficaClienti]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO LandingDbFlorence.AnagraficaClienti AS DST
USING LandingDbFlorence.AnagraficaClientiView AS SRC
ON SRC.CODSOCIETA = DST.CODSOCIETA AND SRC.CODCLI_F = DST.CODCLI_F
WHEN NOT MATCHED
    THEN INSERT (
        CODSOCIETA,
        CODCLI_F,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        CODUTENTEPADRE,
        DESCR,
        DATAINI,
        DATAFINE,
        RAGSOC1,
        CODAGENTE,
        CODCLI_STATISTICO,
        LIV1,
        LIV1_DESCR,
        LIV2,
        LIV2_DESCR,
        LIV3,
        LIV3_DESCR,
        LIV4,
        LIV4_DESCR,
        LIV5,
        LIV5_DESCR,
        LIV6,
        LIV6_DESCR,
        LIV7,
        LIV7_DESCR
    )
    VALUES (
        SRC.CODSOCIETA,
        SRC.CODCLI_F,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        SRC.DatetimeInserted,
        SRC.DatetimeUpdated,
        SRC.DatetimeDeleted,
        SRC.CODUTENTEPADRE,
        SRC.DESCR,
        SRC.DATAINI,
        SRC.DATAFINE,
        SRC.RAGSOC1,
        SRC.CODAGENTE,
        SRC.CODCLI_STATISTICO,
        SRC.LIV1,
        SRC.LIV1_DESCR,
        SRC.LIV2,
        SRC.LIV2_DESCR,
        SRC.LIV3,
        SRC.LIV3_DESCR,
        SRC.LIV4,
        SRC.LIV4_DESCR,
        SRC.LIV5,
        SRC.LIV5_DESCR,
        SRC.LIV6,
        SRC.LIV6_DESCR,
        SRC.LIV7,
        SRC.LIV7_DESCR
    )
WHEN MATCHED AND SRC.ChangeHashKey <> DST.ChangeHashKey
    THEN UPDATE SET
      DST.ChangeHashKey = SRC.ChangeHashKey,
      DST.DatetimeUpdated = SRC.DatetimeUpdated,
      DST.CODUTENTEPADRE = SRC.CODUTENTEPADRE,
      DST.DESCR = SRC.DESCR,
      DST.DATAINI = SRC.DATAINI,
      DST.DATAFINE = SRC.DATAFINE,
      DST.RAGSOC1 = SRC.RAGSOC1,
      DST.CODAGENTE = SRC.CODAGENTE,
      DST.CODCLI_STATISTICO = SRC.CODCLI_STATISTICO,
      DST.LIV1 = SRC.LIV1,
      DST.LIV1_DESCR = SRC.LIV1_DESCR,
      DST.LIV2 = SRC.LIV2,
      DST.LIV2_DESCR = SRC.LIV2_DESCR,
      DST.LIV3 = SRC.LIV3,
      DST.LIV3_DESCR = SRC.LIV3_DESCR,
      DST.LIV4 = SRC.LIV4,
      DST.LIV4_DESCR = SRC.LIV4_DESCR,
      DST.LIV5 = SRC.LIV5,
      DST.LIV5_DESCR = SRC.LIV5_DESCR,
      DST.LIV6 = SRC.LIV6,
      DST.LIV6_DESCR = SRC.LIV6_DESCR,
      DST.LIV7 = SRC.LIV7,
      DST.LIV7_DESCR = SRC.LIV7_DESCR
WHEN NOT MATCHED BY SOURCE
    THEN UPDATE SET
        DST.DatetimeDeleted = CURRENT_TIMESTAMP
OUTPUT N'LandingDbFlorence' AS SchemaName,
    N'AnagraficaClienti' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    COALESCE(Inserted.CODSOCIETA, Deleted.CODSOCIETA) AS DivisionBusinessKey,
    COALESCE(Inserted.CODCLI_F, Deleted.CODCLI_F) AS TableBusinessKey
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
