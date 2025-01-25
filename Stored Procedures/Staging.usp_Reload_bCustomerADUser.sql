SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Staging].[usp_Reload_bCustomerADUser]
AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE Staging.bCustomerADUser;

INSERT INTO Staging.bCustomerADUser
(
    CustomerKey,
    ADUserKey,
    HistoricalHashKey,
    ChangeHashKey
)
SELECT
    CustomerKey,
    ADUserKey,
    HistoricalHashKey,
    ChangeHashKey

FROM Staging.bCustomerADUserView;

END;
GO
