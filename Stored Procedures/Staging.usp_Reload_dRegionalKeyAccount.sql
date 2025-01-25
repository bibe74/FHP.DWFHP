SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Staging].[usp_Reload_dRegionalKeyAccount]
AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE Staging.dRegionalKeyAccount;

INSERT INTO Staging.dRegionalKeyAccount
(
    KeyAccountCode,
    HistoricalHashKey,
    ChangeHashKey,
    KeyAccountDescription,
    RegionalKeyAccountCode,
    RegionalKeyAccountDescription
)
SELECT
    KeyAccountCode,
    HistoricalHashKey,
    ChangeHashKey,
    KeyAccountDescription,
    RegionalKeyAccountCode,
    RegionalKeyAccountDescription

FROM Staging.dRegionalKeyAccountView;

END;
GO
