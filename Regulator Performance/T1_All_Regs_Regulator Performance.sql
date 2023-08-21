SELECT x.ASSET_ID FROM 

(SELECT 
AR.[SHORT_DESCRIPTION]

,AC.[Attribute_1_Level_4_Descriptio] as 'Sub Type'
, CASE WHEN (Len(AR.[SHORT_DESCRIPTION]) - Len(Replace(AR.[SHORT_DESCRIPTION], '-', ''))) > 2 
 
THEN LEFT(AR.[SHORT_DESCRIPTION], CHARINDEX('-', AR.[SHORT_DESCRIPTION]) - 1) + '-' + SUBSTRING(AR.[SHORT_DESCRIPTION],LEN(LEFT(AR.[SHORT_DESCRIPTION],CHARINDEX('-', AR.[SHORT_DESCRIPTION])+1)),LEN(AR.[SHORT_DESCRIPTION]) - 
 
LEN(LEFT(AR.[SHORT_DESCRIPTION],CHARINDEX('-', AR.[SHORT_DESCRIPTION]))) - LEN(RIGHT(AR.[SHORT_DESCRIPTION],CHARINDEX('-', (REVERSE(AR.[SHORT_DESCRIPTION])))))) ELSE AR.[SHORT_DESCRIPTION] END AS "Asset_ID"

FROM [T1_Imports].[dbo].[Assets_Regulators] as AR

left join [T1_Imports].[dbo].[Assets_Attributes_Classification] AS AC on AC.Asset_internal = AR.ASSET
 
WHERE 

AC.[Attribute_1_Level_4_Descriptio] in ('Access Culvert Regulator', 'Access Bridge Regulator', 'Road Bridge Regulator', 'Road Culvert Regulator', 'Offtake', 'Regulator', 'Escape')

AND AR.[SHORT_DESCRIPTION] IS NOT NULL
)


AS x

GROUP BY x.ASSET_ID
ORDER BY x.ASSET_ID ASC