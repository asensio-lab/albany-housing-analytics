ALTER TABLE BGJunctTract
    DROP CONSTRAINT IF EXISTS FK_BGJunctTract_BlockGroup
GO

ALTER TABLE BGJunctTract
    DROP CONSTRAINT IF EXISTS FK_BGJunctTract_Tract
GO

DROP TABLE IF EXISTS dbo.BGJunctTract
GO

DROP TABLE IF EXISTS dbo.Tract
GO

CREATE TABLE [dbo].[Tract](
[TractID] [INT] NOT NULL,
[GEO.id] [VARCHAR](255) NULL,
[GEO.id2] [VARCHAR](255) NULL,
[Tract] [INT] NULL,
[County] [VARCHAR](255) NULL,
[Year] [INT] NULL,
[HTotal] [FLOAT] NULL,
[FTotal] [FLOAT] NULL,
[MTotal] [FLOAT] NULL,
[NfTotal] [FLOAT] NULL,
[HIncomeLessThan10k] [FLOAT] NULL,
[FIncomeLessThan10k] [FLOAT] NULL,
[MIncomeLessThan10k] [FLOAT] NULL,
[NfIncomeLessThan10k] [FLOAT] NULL,
[HIncome10kTo14999] [FLOAT] NULL,
[FIncome10kTo14999] [FLOAT] NULL,
[MIncome10kTo14999] [FLOAT] NULL,
[NfIncome10kTo14999] [FLOAT] NULL,
[HIncome15kTo24999] [FLOAT] NULL,
[FIncome15kTo24999] [FLOAT] NULL,
[MIncome15kTo24999] [FLOAT] NULL,
[NfIncome15kTo24999] [FLOAT] NULL,
[HIncome25kTo34999] [FLOAT] NULL,
[FIncome25kTo34999] [FLOAT] NULL,
[MIncome25kTo34999] [FLOAT] NULL,
[NfIncome25kTo34999] [FLOAT] NULL,
[HIncome35kTo49999] [FLOAT] NULL,
[FIncome35kTo49999] [FLOAT] NULL,
[MIncome35kTo49999] [FLOAT] NULL,
[NfIncome35kTo49999] [FLOAT] NULL,
[HIncome50kTo74999] [FLOAT] NULL,
[FIncome50kTo74999] [FLOAT] NULL,
[MIncome50kTo74999] [FLOAT] NULL,
[NfIncome50kTo74999] [FLOAT] NULL,
[HIncome75kTo99999] [FLOAT] NULL,
[FIncome75kTo99999] [FLOAT] NULL,
[MIncome75kTo99999] [FLOAT] NULL,
[NfIncome75kTo99999] [FLOAT] NULL,
[HIncome100kTo149999] [FLOAT] NULL,
[FIncome100kTo149999] [FLOAT] NULL,
[MIncome100kTo149999] [FLOAT] NULL,
[NfIncome100kTo149999] [FLOAT] NULL,
[HIncome150kTo199999] [FLOAT] NULL,
[FIncome150kTo199999] [FLOAT] NULL,
[MIncome150kTo199999] [FLOAT] NULL,
[NfIncome150kTo199999] [FLOAT] NULL,
[HIncome200kOrMore] [FLOAT] NULL,
[FIncome200kOrMore] [FLOAT] NULL,
[MIncome200kOrMore] [FLOAT] NULL,
[NfIncome200kOrMore] [FLOAT] NULL,
[HIncomeMedian] [FLOAT] NULL,
[FIncomeMedian] [FLOAT] NULL,
[MIncomeMedian] [FLOAT] NULL,
[NfIncomeMedian] [FLOAT] NULL,
[HIncomeMean] [FLOAT] NULL,
[FIncomeMean] [FLOAT] NULL,
[MIncomeMean] [FLOAT] NULL,
[NfIncomeMean] [FLOAT] NULL,
[TotalPopulation] [FLOAT] NULL,
[MaleTotal] [FLOAT] NULL,
[FemaleTotal] [FLOAT] NULL,
[TotalAgeUnder5] [FLOAT] NULL,
[MaleAgeUnder5] [FLOAT] NULL,
[FemaleAgeUnder5] [FLOAT] NULL,
[TotalAge5To9] [FLOAT] NULL,
[MaleAge5To9] [FLOAT] NULL,
[FemaleAge5To9] [FLOAT] NULL,
[TotalAge10To14] [FLOAT] NULL,
[MaleAge10To14] [FLOAT] NULL,
[FemaleAge10To14] [FLOAT] NULL,
[TotalAge15To19] [FLOAT] NULL,
[MaleAge15To19] [FLOAT] NULL,
[FemaleAge15To19] [FLOAT] NULL,
[TotalAge20To24] [FLOAT] NULL,
[MaleAge20To24] [FLOAT] NULL,
[FemaleAge20To24] [FLOAT] NULL,
[TotalAge25To29] [FLOAT] NULL,
[MaleAge25To29] [FLOAT] NULL,
[FemaleAge25To29] [FLOAT] NULL,
[TotalAge30To34] [FLOAT] NULL,
[MaleAge30To34] [FLOAT] NULL,
[FemaleAge30To34] [FLOAT] NULL,
[TotalAge35To39] [FLOAT] NULL,
[MaleAge35To39] [FLOAT] NULL,
[FemaleAge35To39] [FLOAT] NULL,
[TotalAge40To44] [FLOAT] NULL,
[MaleAge40To44] [FLOAT] NULL,
[FemaleAge40To44] [FLOAT] NULL,
[TotalAge45To49] [FLOAT] NULL,
[MaleAge45To49] [FLOAT] NULL,
[FemaleAge45To49] [FLOAT] NULL,
[TotalAge50To54] [FLOAT] NULL,
[MaleAge50To54] [FLOAT] NULL,
[FemaleAge50To54] [FLOAT] NULL,
[TotalAge55To59] [FLOAT] NULL,
[MaleAge55To59] [FLOAT] NULL,
[FemaleAge55To59] [FLOAT] NULL,
[TotalAge60To64] [FLOAT] NULL,
[MaleAge60To64] [FLOAT] NULL,
[FemaleAge60To64] [FLOAT] NULL,
[TotalAge65To69] [FLOAT] NULL,
[MaleAge65To69] [FLOAT] NULL,
[FemaleAge65To69] [FLOAT] NULL,
[TotalAge70To74] [FLOAT] NULL,
[MaleAge70To74] [FLOAT] NULL,
[FemaleAge70To74] [FLOAT] NULL,
[TotalAge75To79] [FLOAT] NULL,
[MaleAge75To79] [FLOAT] NULL,
[FemaleAge75To79] [FLOAT] NULL,
[TotalAge80To84] [FLOAT] NULL,
[MaleAge80To84] [FLOAT] NULL,
[FemaleAge80To84] [FLOAT] NULL,
[TotalAge85AndOver] [FLOAT] NULL,
[MaleAge85AndOver] [FLOAT] NULL,
[FemaleAge85AndOver] [FLOAT] NULL,
[NonHispanic] [FLOAT] NULL,
[NonHispanicWhite] [FLOAT] NULL,
[NonHispanicBlack] [FLOAT] NULL,
[NonHispanicNative] [FLOAT] NULL,
[NonHispanicAsian] [FLOAT] NULL,
[NonHispanicPacificIslander] [FLOAT] NULL,
[NonHispanicOtherRace] [FLOAT] NULL,
[NonHispanic2Plus] [FLOAT] NULL,
[NonHispanic2PlusIncOther] [FLOAT] NULL,
[NonHispanic2PlusExcOther] [FLOAT] NULL,
[Hispanic] [FLOAT] NULL,
[HispanicWhite] [FLOAT] NULL,
[HispanicBlack] [FLOAT] NULL,
[HispanicNative] [FLOAT] NULL,
[HispanicAsian] [FLOAT] NULL,
[HispanicPacificIslander] [FLOAT] NULL,
[HispanicOtherRace] [FLOAT] NULL,
[Hispanic2Plus] [FLOAT] NULL,
[Hispanic2PlusIncOther] [FLOAT] NULL,
[Hispanic2PlusExcOther] [FLOAT] NULL,
[Total16AndOver] [FLOAT] NULL,
[LFPRate16AndOver] [FLOAT] NULL,
[EmpRatio16AndOver] [FLOAT] NULL,
[UnempRate16AndOver] [FLOAT] NULL,
[TotalAge16To19] [FLOAT] NULL,
[LFPRateAge16To19] [FLOAT] NULL,
[EmpRatioAge16To19] [FLOAT] NULL,
[UnempRateAge16To19] [FLOAT] NULL,
[TotalAge20To24.1] [FLOAT] NULL,
[LFPRateAge20To24] [FLOAT] NULL,
[EmpRatioAge20To24] [FLOAT] NULL,
[UnempRateAge20To24] [FLOAT] NULL,
[TotalAge25To29.1] [FLOAT] NULL,
[LFPRateAge25To29] [FLOAT] NULL,
[EmpRatioAge25To29] [FLOAT] NULL,
[UnempRateAge25To29] [FLOAT] NULL,
[TotalAge30To34.1] [FLOAT] NULL,
[LFPRateAge30To34] [FLOAT] NULL,
[EmpRatioAge30To34] [FLOAT] NULL,
[UnempRateAge30To34] [FLOAT] NULL,
[TotalAge35To44] [FLOAT] NULL,
[LFPRateAge35To44] [FLOAT] NULL,
[EmpRatioAge35To44] [FLOAT] NULL,
[UnempRateAge35To44] [FLOAT] NULL,
[TotalAge45To54] [FLOAT] NULL,
[LFPRateAge45To54] [FLOAT] NULL,
[EmpRatioAge45To54] [FLOAT] NULL,
[UnempRateAge45To54] [FLOAT] NULL,
[TotalAge55To59.1] [FLOAT] NULL,
[LFPRateAge55To59] [FLOAT] NULL,
[EmpRatioAge55To59] [FLOAT] NULL,
[UnempRateAge55To59] [FLOAT] NULL,
[TotalAge60To64.1] [FLOAT] NULL,
[LFPRateAge60To64] [FLOAT] NULL,
[EmpRatioAge60To64] [FLOAT] NULL,
[UnempRateAge60To64] [FLOAT] NULL,
[TotalAge65To74] [FLOAT] NULL,
[LFPRateAge65To74] [FLOAT] NULL,
[EmpRatioAge65To74] [FLOAT] NULL,
[UnempRateAge65To74] [FLOAT] NULL,
[TotalAge75AndOver] [FLOAT] NULL,
[LFPRateAge75AndOver] [FLOAT] NULL,
[EmpRatioAge75AndOver] [FLOAT] NULL,
[UnempRateAge75AndOver] [FLOAT] NULL,
[TotalWhite] [FLOAT] NULL,
[LFPRateWhite] [FLOAT] NULL,
[EmpRatioWhite] [FLOAT] NULL,
[UnempRateWhite] [FLOAT] NULL,
[TotalBlack] [FLOAT] NULL,
[LFPRateBlack] [FLOAT] NULL,
[EmpRatioBlack] [FLOAT] NULL,
[UnempRateBlack] [FLOAT] NULL,
[TotalNative] [FLOAT] NULL,
[LFPRateNative] [FLOAT] NULL,
[EmpRatioNative] [FLOAT] NULL,
[UnempRateNative] [FLOAT] NULL,
[TotalAsian] [FLOAT] NULL,
[LFPRateAsian] [FLOAT] NULL,
[EmpRatioAsian] [FLOAT] NULL,
[UnempRateAsian] [FLOAT] NULL,
[TotalPacificIslander] [FLOAT] NULL,
[LFPRatePacificIslander] [FLOAT] NULL,
[EmpRatioPacificIslander] [FLOAT] NULL,
[UnempRatePacificIslander] [FLOAT] NULL,
[TotalOtherRace] [FLOAT] NULL,
[LFPRateOtherRace] [FLOAT] NULL,
[EmpRatioOtherRace] [FLOAT] NULL,
[UnempRateOtherRace] [FLOAT] NULL,
[Total2Plus] [FLOAT] NULL,
[LFPRate2Plus] [FLOAT] NULL,
[EmpRatio2Plus] [FLOAT] NULL,
[UnempRate2Plus] [FLOAT] NULL,
[TotalHispanic] [FLOAT] NULL,
[LFPRateHispanic] [FLOAT] NULL,
[EmpRatioHispanic] [FLOAT] NULL,
[UnempRateHispanic] [FLOAT] NULL,
[TotalWhiteNonHispanic] [FLOAT] NULL,
[LFPRateWhiteNonHispanic] [FLOAT] NULL,
[EmpRatioWhiteNonHispanic] [FLOAT] NULL,
[UnempRateWhiteNonHispanic] [FLOAT] NULL,
[Total20To64] [FLOAT] NULL,
[LFPRate20To64] [FLOAT] NULL,
[EmpRatio20To64] [FLOAT] NULL,
[UnempRate20To64] [FLOAT] NULL,
[Total20To64Male] [FLOAT] NULL,
[LFPRate20To64Male] [FLOAT] NULL,
[EmpRatio20To64Male] [FLOAT] NULL,
[UnempRate20To64Male] [FLOAT] NULL,
[Total20To64Female] [FLOAT] NULL,
[LFPRate20To64Female] [FLOAT] NULL,
[EmpRatio20To64Female] [FLOAT] NULL,
[UnempRate20To64Female] [FLOAT] NULL,
[Total20To64FemaleChildrenUnder18] [FLOAT] NULL,
[LFPRate20To64FemaleChildrenUnder18] [FLOAT] NULL,
[EmpRatio20To64FemaleChildrenUnder18] [FLOAT] NULL,
[UnempRate20To64FemaleChildrenUnder18] [FLOAT] NULL,
[Total20To64FemaleChildrenUnder6] [FLOAT] NULL,
[LFPRate20To64FemaleChildrenUnder6] [FLOAT] NULL,
[EmpRatio20To64FemaleChildrenUnder6] [FLOAT] NULL,
[UnempRate20To64FemaleChildrenUnder6] [FLOAT] NULL,
[Total20To64FemaleChildrenUnder6And6To17] [FLOAT] NULL,
[LFPRate20To64FemaleChildrenUnder6And6To17] [FLOAT] NULL,
[EmpRatio20To64FemaleChildrenUnder6And6To17] [FLOAT] NULL,
[UnempRate20To64FemaleChildrenUnder6And6To17] [FLOAT] NULL,
[Total20To64FemaleChildren6To17] [FLOAT] NULL,
[LFPRate20To64FemaleChildren6To17] [FLOAT] NULL,
[EmpRatio20To64FemaleChildren6To17] [FLOAT] NULL,
[UnempRate20To64FemaleChildren6To17] [FLOAT] NULL,
[TotalBPL] [FLOAT] NULL,
[LFPRateBPL] [FLOAT] NULL,
[EmpRatioBPL] [FLOAT] NULL,
[UnempRateBPL] [FLOAT] NULL,
[TotalAPL] [FLOAT] NULL,
[LFPRateAPL] [FLOAT] NULL,
[EmpRatioAPL] [FLOAT] NULL,
[UnempRateAPL] [FLOAT] NULL,
[TotalDisabled] [FLOAT] NULL,
[LFPRateDisabled] [FLOAT] NULL,
[EmpRatioDisabled] [FLOAT] NULL,
[UnempRateDisabled] [FLOAT] NULL,
[TotalEdu25To64] [FLOAT] NULL,
[LFPRateEdu25To64] [FLOAT] NULL,
[EmpRatioEdu25To64] [FLOAT] NULL,
[UnempRateEdu25To64] [FLOAT] NULL,
[TotalEdu25To64LessHS] [FLOAT] NULL,
[LFPRateEdu25To64LessHS] [FLOAT] NULL,
[EmpRatioEdu25To64LessHS] [FLOAT] NULL,
[UnempRateEdu25To64LessHS] [FLOAT] NULL,
[TotalEdu25To64HS] [FLOAT] NULL,
[LFPRateEdu25To64HS] [FLOAT] NULL,
[EmpRatioEdu25To64HS] [FLOAT] NULL,
[UnempRateEdu25To64HS] [FLOAT] NULL,
[TotalEdu25To64SomeCollege] [FLOAT] NULL,
[LFPRateEdu25To64SomeCollege] [FLOAT] NULL,
[EmpRatioEdu25To64SomeCollege] [FLOAT] NULL,
[UnempRateEdu25To64SomeCollege] [FLOAT] NULL,
[TotalEdu25To64Bachelors] [FLOAT] NULL,
[LFPRateEdu25To64Bachelors] [FLOAT] NULL,
[EmpRatioEdu25To64Bachelors] [FLOAT] NULL,
[UnempRateEdu25To64Bachelors] [FLOAT] NULL,

    CONSTRAINT [PK_TractID] PRIMARY KEY CLUSTERED
    (
        [TractID] asc
    )
) ON [PRIMARY]
GO

BULK INSERT Tract
FROM 'Tract_v04.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV')
GO
