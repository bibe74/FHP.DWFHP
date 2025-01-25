SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [LandingDbFlorence].[usp_Merge_AnagraficaTerritorio]
AS
BEGIN

SET NOCOUNT ON;

MERGE INTO LandingDbFlorence.AnagraficaTerritorio AS DST
USING LandingDbFlorence.AnagraficaTerritorioView AS SRC
ON SRC.CODSOCIETA = DST.CODSOCIETA AND SRC.CODUTENTE = DST.CODUTENTE
WHEN NOT MATCHED
    THEN INSERT (
        CODSOCIETA,
        CODUTENTE,
        HistoricalHashKey,
        ChangeHashKey,
        DatetimeInserted,
        DatetimeUpdated,
        DatetimeDeleted,
        COGNOME,
        NOME,
        CODUTENTEPADRE,
		Padre_Cognome,
		Padre_Nome
    )
    VALUES (
        SRC.CODSOCIETA,
        SRC.CODUTENTE,
        SRC.HistoricalHashKey,
        SRC.ChangeHashKey,
        SRC.DatetimeInserted,
        SRC.DatetimeUpdated,
        SRC.DatetimeDeleted,
        SRC.COGNOME,
        SRC.NOME,
        SRC.CODUTENTEPADRE,
		SRC.Padre_Cognome,
		SRC.Padre_Nome
    )
WHEN MATCHED AND SRC.ChangeHashKey <> DST.ChangeHashKey
    THEN UPDATE SET
        DST.ChangeHashKey = SRC.ChangeHashKey,
        DST.DatetimeUpdated = SRC.DatetimeUpdated,
        DST.COGNOME = SRC.COGNOME,
		DST.NOME = SRC.NOME,
		DST.CODUTENTEPADRE = SRC.CODUTENTEPADRE,
		DST.Padre_Cognome = SRC.Padre_Cognome,
		DST.Padre_Nome = DST.Padre_Nome
WHEN NOT MATCHED BY SOURCE
    THEN UPDATE SET
        DST.DatetimeDeleted = CURRENT_TIMESTAMP
OUTPUT N'LandingDbFlorence' AS SchemaName,
    N'AnagraficaTerritorio' AS TableName,
    $action AS MergeAction,
    CURRENT_TIMESTAMP AS MergeDatetime,
    COALESCE(Inserted.CODSOCIETA, Deleted.CODSOCIETA) AS DivisionBusinessKey,
    COALESCE(Inserted.CODUTENTE, Deleted.CODUTENTE) AS TableBusinessKey
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
