-- CHANGING THE QUERY

-- OUTLET DEFECTS
 WITH DEFECTS AS (
SELECT
	 DEF.[ASSET] AS ASSET_ID
	,ASS.ASSET_RID AS SYSTEM_ID
	,RESULTING_WORK_ORDER_INTERNAL AS RESULTING_TASK_NUMBER
	,CASE  [STAGE__CODE] 
		WHEN 'A' THEN 'ACTIONED' 
		WHEN'C' THEN 'CANCELLED' 
		WHEN 'R' THEN 'RECORDED' 
		WHEN 'W' THEN 'COMPLETED' 
		END 
		AS STAGE
	,[COMMENTS] AS COMMENT
	,[CREATED_BY] AS CREATED_BY
	,DEF.DATE_CREATED AS CREATE_DATE
	--,COMPLETION_DATE AS COMPLETE_DATE  --- New addition
	,IIF(COMPLETION_DATE IS NULL AND STAGE__CODE NOT IN ('W') ,GETDATE(), COMPLETION_DATE) AS COMPLETE_DATE
	,(SELECT COUNT(DISTINCT Short_Description) from [T1_IMPORTS].[DBO].[Assets_Outlets]) AS OUTLET_COUNT  -- Unique asset-ids 
FROM [T1_IMPORTS].[DBO].[WORKS_DEFECTS] DEF
LEFT JOIN [T1_IMPORTS].[DBO].[ASSETS_OPERATIONAL_ASSETS] ASS 
	ON DEF.ASSET = ASS.SHORT_DESCRIPTION
WHERE   
	ASSET_OUT_OF_SERVICE = 'Y' AND 
	STAGE__CODE NOT IN ('C')  AND
    DEFECT = 'METERING DEFECT' 
   AND (COMPLETION_DATE >'2015-07-01' OR COMPLETION_DATE IS NULL)
   --AND NOT(COMPLETION_DATE IS NULL AND STAGE__CODE IN ('W'))
),

-- FIRST DAY OF EACH MONTH
FIRST_DAYS_OF_THE_MONTH AS (
	SELECT 
		DATEADD(DAY, 1, EOMONTH('2015-07-01', -1)) AS MONTH_START  -- CALCULATES MONTH START FOR ANY START DATE - NOT JUST 2019-07-01 ;)
    UNION ALL
	SELECT 
		DATEADD(DAY, 1, EOMONTH(MONTH_START)) MONTH_START -- ADD 1 DAY TO END OF PREVIOUS MONTH 
    FROM FIRST_DAYS_OF_THE_MONTH 
    WHERE MONTH_START <  GETDATE()  -- GET ALL MONTHS UP UNTIL CURRENT MONTH
),


MONTHS AS (
	SELECT 
		CONVERT(DATETIME, MONTH_START) AS MONTH_START
		, DATEADD(SECOND, -1, CONVERT(DATETIME, DATEADD(DAY, 1, EOMONTH(MONTH_START)))) AS MONTH_END
		,CAST(DATEDIFF(DAY, MONTH_START, EOMONTH(MONTH_START)) AS INT) + 1 AS DAYS_PER_MONTH
	FROM FIRST_DAYS_OF_THE_MONTH
)


SELECT 
	*
	,DAY( -- NUMBER OF DAYS TASK WAS OPEN IN THE GIVEN MONTH
		IIF (COMPLETE_DATE>  MONTH_END, MONTH_END, COMPLETE_DATE) 
		- 
		IIF(CREATE_DATE <  MONTH_START, MONTH_START , CREATE_DATE)
		) AS "DAYS OPEN"
	,DAYS_PER_MONTH AS NUMBER_OF_DAYS
  	,DAYS_PER_MONTH * OUTLET_COUNT AS POTENTIAL_UP
	,ROUND(100.*DAY(
		IIF(COMPLETE_DATE > MONTH_END, MONTH_END, COMPLETE_DATE)
		-
		IIF(CREATE_DATE< MONTH_START, MONTH_START, CREATE_DATE)
		)/DAYS_PER_MONTH, 2)  AS PERCENTAGE 
FROM DEFECTS 
INNER JOIN MONTHS ON 
	CREATE_DATE <= MONTH_END AND
	COMPLETE_DATE >= MONTH_START

	ORDER BY COMPLETE_DATE DESC