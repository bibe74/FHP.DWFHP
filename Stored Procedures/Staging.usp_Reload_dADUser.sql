SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Staging].[usp_Reload_dADUser]
AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE Staging.dADUser;

INSERT INTO Staging.dADUser
(
    ADDomain,
    ADUser,
    HistoricalHashKey,
    ChangeHashKey,
    UserType
)
SELECT
    ADDomain,
    ADUser,
    HistoricalHashKey,
    ChangeHashKey,
    UserType

FROM Staging.dADUserView;

END;
GO
