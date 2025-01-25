SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [Staging].[usp_Reload_dCustomer]
AS
BEGIN

SET NOCOUNT ON;

TRUNCATE TABLE Staging.dCustomer;

INSERT INTO Staging.dCustomer
(
    DivisionKey,
    DivisionBusinessKey,
    CustomerBusinessKey,
    HistoricalHashKey,
    ChangeHashKey,
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
SELECT
    DivisionKey,
    DivisionBusinessKey,
    CustomerBusinessKey,
    HistoricalHashKey,
    ChangeHashKey,
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

FROM Staging.dCustomerView;

END;
GO
