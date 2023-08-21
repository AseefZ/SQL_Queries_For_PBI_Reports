/*

Previous Query

SELECT o.object_no "Object No", o.object_name, ot.OBJECT_TYPE, OBJECT_DESC, v117.attribute_value "Asset Code" FROM OBJECT o
LEFT OUTER JOIN object_attr_value v117 ON v117.object_no = o.object_no
AND v117.attribute_type = 117
AND v117.DATE_RETIRED IS NULL
JOIN OBJECT_TYPE ot on o.OBJECT_TYPE = ot.OBJECT_TYPE
AND ot.OBJECT_DESC IN ('REGULATOR', 'HYBRID_R', 'OFFTAKE', 'SLIPMETER R', 'SLIPGATE R', 'FLUMEGATE R', 'MULTIGATE_R', 'BLADEMETER R', 'BRIDGE')

*/


SELECT o.object_no "Object No", o.object_name, ot.OBJECT_TYPE, OBJECT_DESC, v117.attribute_value "Asset Code" FROM OBJECT o

LEFT OUTER JOIN object_attr_value v117 ON v117.object_no = o.object_no
AND v117.attribute_type = 117
AND v117.DATE_RETIRED IS NULL
JOIN OBJECT_TYPE ot on o.OBJECT_TYPE = ot.OBJECT_TYPE
AND ot.OBJECT_DESC IN ('REGULATOR', 'HYBRID_R', 'OFFTAKE', 'SLIPMETER R', 'SLIPGATE R', 'FLUMEGATE R', 'MULTIGATE_R', 'BLADEMETER R', 'BRIDGE')

where (LOWER(v117.attribute_value) NOT LIKE '%dummy%' AND LOWER(v117.attribute_value) NOT LIKE '%?%' AND LOWER(v117.attribute_value) IS NOT NULL AND LOWER(v117.attribute_value) NOT LIKE '%reduc%'
AND LOWER(v117.attribute_value) NOT LIKE '%import%' AND LOWER(v117.attribute_value) NOT LIKE '%tempo%')




