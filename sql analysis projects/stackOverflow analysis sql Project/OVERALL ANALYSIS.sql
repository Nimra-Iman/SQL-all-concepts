CREATE SCHEMA STACKOVERFLOW;
USE STACKOVERFLOW;


CREATE TABLE survey_results_2024 (
    ResponseId INT,
    MainBranch TEXT,
    Age TEXT,
    Employment TEXT,
    RemoteWork TEXT,
    `Check` TEXT,
    CodingActivities TEXT,
    EdLevel TEXT,
    LearnCode TEXT,
    LearnCodeOnline TEXT,
    TechDoc TEXT,
    YearsCode TEXT,
    YearsCodePro TEXT,
    DevType TEXT,
    OrgSize TEXT,
    PurchaseInfluence TEXT,
    BuyNewTool TEXT,
    BuildvsBuy TEXT,
    TechEndorse TEXT,
    Country TEXT,
    Currency TEXT,
    CompTotal TEXT,
    LanguageHaveWorkedWith TEXT,
    LanguageWantToWorkWith TEXT,
    LanguageAdmired TEXT,
    DatabaseHaveWorkedWith TEXT,
    DatabaseWantToWorkWith TEXT,
    DatabaseAdmired TEXT,
    PlatformHaveWorkedWith TEXT,
    PlatformWantToWorkWith TEXT,
    PlatformAdmired TEXT,
    WebframeHaveWorkedWith TEXT,
    WebframeWantToWorkWith TEXT,
    WebframeAdmired TEXT,
    EmbeddedHaveWorkedWith TEXT,
    EmbeddedWantToWorkWith TEXT,
    EmbeddedAdmired TEXT,
    MiscTechHaveWorkedWith TEXT,
    MiscTechWantToWorkWith TEXT,
    MiscTechAdmired TEXT,
    ToolsTechHaveWorkedWith TEXT,
    ToolsTechWantToWorkWith TEXT,
    ToolsTechAdmired TEXT,
    NEWCollabToolsHaveWorkedWith TEXT,
    NEWCollabToolsWantToWorkWith TEXT,
    NEWCollabToolsAdmired TEXT,
    `OpSysPersonal use` TEXT,
    `OpSysProfessional use` TEXT,
    OfficeStackAsyncHaveWorkedWith TEXT,
    OfficeStackAsyncWantToWorkWith TEXT,
    OfficeStackAsyncAdmired TEXT,
    OfficeStackSyncHaveWorkedWith TEXT,
    OfficeStackSyncWantToWorkWith TEXT,
    OfficeStackSyncAdmired TEXT,
    AISearchDevHaveWorkedWith TEXT,
    AISearchDevWantToWorkWith TEXT,
    AISearchDevAdmired TEXT,
    NEWSOSites TEXT,
    SOVisitFreq TEXT,
    SOAccount TEXT,
    SOPartFreq TEXT,
    SOHow TEXT,
    SOComm TEXT,
    AISelect TEXT,
    AISent TEXT,
    AIBen TEXT,
    AIAcc TEXT,
    AIComplex TEXT,
    `AIToolCurrently Using` TEXT,
    `AIToolInterested in Using` TEXT,
    `AIToolNot interested in Using` TEXT,
    `AINextMuch more integrated` TEXT,
    AINextNoChange TEXT,
    AINextMoreIntegrated TEXT,
    AINextLessIntegrated TEXT,
    AINextMuchLessIntegrated TEXT,
    AIThreat TEXT,
    AIEthics TEXT,
    AIChallenges TEXT,
    TBranch TEXT,
    ICorPM TEXT,
    WorkExp TEXT,
    Knowledge_1 TEXT,
    Knowledge_2 TEXT,
    Knowledge_3 TEXT,
    Knowledge_4 TEXT,
    Knowledge_5 TEXT,
    Knowledge_6 TEXT,
    Knowledge_7 TEXT,
    Knowledge_8 TEXT,
    Knowledge_9 TEXT,
    Frequency_1 TEXT,
    Frequency_2 TEXT,
    Frequency_3 TEXT,
    TimeSearching TEXT,
    TimeAnswering TEXT,
    Frustration TEXT,
    ProfessionalTech TEXT,
    ProfessionalCloud TEXT,
    ProfessionalQuestion TEXT,
    Industry TEXT,
    JobSatPoints_1 TEXT,
    JobSatPoints_4 TEXT,
    JobSatPoints_5 TEXT,
    JobSatPoints_6 TEXT,
    JobSatPoints_7 TEXT,
    JobSatPoints_8 TEXT,
    JobSatPoints_9 TEXT,
    JobSatPoints_10 TEXT,
    JobSatPoints_11 TEXT,
    SurveyLength TEXT,
    SurveyEase TEXT,
    ConvertedCompYearly TEXT,
    JobSat TEXT
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/survey_results_public.csv'
INTO TABLE survey_results_2024
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

-- 1- How many total responses were recorded in the survey?
select count(ResponseId) from survey_results_2024;

-- 2- What are the top 10 countries by number of respondents?
SET SQL_SAFE_UPDATES = 0;
UPDATE survey_results_2024 SET country = 'UNKNOWN-COUNTRY' WHERE country = 'NA';

select country, count(ResponseId) as respondents 
from survey_results_2024
 group by country order by respondents desc limit 10;

-- 3- How many respondents have used JavaScript in the past year?
SELECT 
    (SUM(LanguageHaveWorkedWith LIKE '%JavaScript%') / COUNT(LanguageHaveWorkedWith) * 100)
AS HIGHEST_JS_USERS
FROM
    survey_results_2024; 

-- LanguageHaveWorkedWith = 'JavaScript' GIVE EITHER TRUE OR FALSE AND WRITING SUM WILL
-- GIVE THE COUNT OF VALUES WHERE TRUE APPEARS

-- 4-  How many developers have a Stack Overflow account?
select (sum(SOAccount = 'Yes')/count(SOAccount)*100) from survey_results_2024;


-- 5- Which developer types are most common in each country?

-- 6 -  What are the most used databases among respondents?

WITH RECURSIVE split_cte AS (
  SELECT
    ResponseId,
    SUBSTRING_INDEX(DatabaseHaveWorkedWith, ';', 1) AS db,
    substring(DatabaseHaveWorkedWith, locate(';',DatabaseHaveWorkedWith)+1) AS remaining
  FROM survey_results_2024
  WHERE DatabaseHaveWorkedWith IS NOT NULL

  UNION ALL

  SELECT
    ResponseId,
    TRIM(SUBSTRING_INDEX(remaining, ';', 1)) AS db,
    SUBSTRING(remaining, LOCATE(';', remaining)+1)	AS remaining
  FROM split_cte
  WHERE remaining LIKE '%;%' 
)
-- Final result
SELECT db, COUNT(*) AS usage_count
FROM split_cte
WHERE db IS NOT NULL AND db != ''
GROUP BY db
ORDER BY usage_count DESC;



-- 7 -  Which languages are most admired vs. most desired?

-- 1- BOTH LanguageHaveWorkedWith(ADMIRED) AND LanguageWantToWorkWith(DESIRED) HAVE
-- SEMICOLON SEPARATED VALUES. WE FIRST SEPARATE THE VALUES INTO MULTIPLE ROWS (Y 
-- ESY HUA K HM N RECURSIVE CTE K ZRYE ; S PHLY JO VALUE THOI VO UTHA LI OR LANGUAGE M DAAL 
-- DI OR BAKI SARI VALUE KO REMAINAING M DAAL DIA OR Y US TIME TK HOTA GYA
-- JAB TK SAARI ROWS KI MULTIPLE VALUES ALEHDA NHIO HO GI, Y HM N ADMIRED AND
-- DESIRED DONO K SAATH KIA)

-- 2- PHIR ADMIRED AND DESIRED DONO M JUST COUNT KR LIA GROUP BY LGA KR 
-- 3- PHIR FULL OUTER JOIN SQL M ALLOWED NHI H IS LOYE LEFT JOIN AND 
-- RIGHT JOIN LGA KR FUL OUTER VALA KAAM KIA AND DONO KO UNION S MILA DIA 

WITH RECURSIVE ADMIRED AS (
    SELECT 
        TRIM(substring_index(LanguageHaveWorkedWith, ';', 1)) AS AD_LANGUAGE, 
        CASE 
            WHEN LOCATE(';', LanguageHaveWorkedWith) > 0 
            THEN SUBSTRING(LanguageHaveWorkedWith, LOCATE(';', LanguageHaveWorkedWith) + 1) 
            ELSE '' 
        END AS REMAINING
    FROM survey_results_2024
    WHERE LanguageHaveWorkedWith IS NOT NULL AND LanguageHaveWorkedWith != ''
    
    UNION ALL 
    
    SELECT 
        TRIM(SUBSTRING_INDEX(REMAINING, ';', 1)) AS AD_LANGUAGE,
        CASE 
            WHEN LOCATE(';', REMAINING) > 0 
            THEN SUBSTRING(REMAINING, LOCATE(';', REMAINING) + 1) 
            ELSE '' 
        END AS REMAINING 
    FROM ADMIRED 
    WHERE REMAINING != ''
),

DESIRED AS (
    SELECT 
        TRIM(substring_index(LanguageWantToWorkWith, ';', 1)) AS DE_LANGUAGE, 
        CASE 
            WHEN LOCATE(';', LanguageWantToWorkWith) > 0 
            THEN SUBSTRING(LanguageWantToWorkWith, LOCATE(';', LanguageWantToWorkWith) + 1) 
            ELSE '' 
        END AS REMAINING
    FROM survey_results_2024
    WHERE LanguageWantToWorkWith IS NOT NULL AND LanguageWantToWorkWith != ''
    
    UNION ALL
    
    SELECT 
        TRIM(SUBSTRING_INDEX(REMAINING, ';', 1)) AS DE_LANGUAGE,
        CASE 
            WHEN LOCATE(';', REMAINING) > 0 
            THEN SUBSTRING(REMAINING, LOCATE(';', REMAINING) + 1) 
            ELSE '' 
        END AS REMAINING 
    FROM DESIRED 
    WHERE REMAINING != ''
),

ADMIRED_COUNT AS (
    SELECT 
        AD_LANGUAGE, 
        COUNT(AD_LANGUAGE) AS COUNT_WORKED 
    FROM ADMIRED 
    GROUP BY AD_LANGUAGE
),

DESIRED_COUNT AS (
    SELECT 
        DE_LANGUAGE, 
        COUNT(DE_LANGUAGE) AS COUNT_WANT_WORK 
    FROM DESIRED
    GROUP BY DE_LANGUAGE
)
-- Part 1: All admired + desired match
SELECT ADMIRED_COUNT.AD_LANGUAGE, ADMIRED_COUNT.COUNT_WORKED, DESIRED_COUNT.COUNT_WANT_WORK
FROM ADMIRED_COUNT LEFT JOIN DESIRED_COUNT 
ON ADMIRED_COUNT.AD_LANGUAGE = DESIRED_COUNT.DE_LANGUAGE
UNION 
-- Part 2: All desired NOT matched in admired
SELECT DESIRED_COUNT.DE_LANGUAGE, DESIRED_COUNT.COUNT_WANT_WORK, 
ADMIRED_COUNT.COUNT_WORKED
FROM DESIRED_COUNT RIGHT JOIN ADMIRED_COUNT 
ON DESIRED_COUNT.DE_LANGUAGE = ADMIRED_COUNT.AD_LANGUAGE
WHERE ADMIRED_COUNT.AD_LANGUAGE IS NULL -- Y IS LIYE KIA Q K RESULT M 
-- DUPLICATED VALUES A RHI THI, ACTUALLY FLIPPED VALUES Q K 1ST LEFT JOIN S 
-- ADMIRED VALI SAARI AND DESIRED VALI MATCHING A RHI THI AND RIGHT JOIN S 
-- DESIRED VALI SAARI AND ADMIRED VALI MATCHING A RHI THI, JO K DUPLICATED VLUE SHOWS
-- KR RHI THI, IS LIYE HM N Y LINE LIKHI K JUST VO HI LANGUAGES SHOW HO JO PART1 M
-- MISS HO GI THI
ORDER BY COUNT_WANT_WORK DESC;
-- ----------------------------------


-- Q8 - What are the average and median salaries for different countries?
SELECT DevType, AVG(CompTotal) as avg_salary FROM survey_results_2024 where 
country = 'Ukraine'
GROUP BY
 DevType order by
avg_salary desc;

-- ------------------









