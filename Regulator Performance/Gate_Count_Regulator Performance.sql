SELECT OBJECT_NO, COUNT(*) AS "NUMBER OF GATES" FROM

(

SELECT DISTINCT OBJECT_NO, TAG_DESC FROM

(

SELECT OBJECT_NO, TAG_NAME, TAG_DESC, TAG_VALUE FROM sc_tag WHERE tag_desc like 'Gate __ Position' OR tag_desc like 'Gate _ Position' 

) 

)

WHERE OBJECT_NO is NOT NULL

GROUP BY OBJECT_NO

ORDER BY COUNT(*) DESC