WITH obj AS
  (SELECT sp.object_no,
    sp.object_name,
    prop.object_name auth_object_name,
    spot.object_label
  FROM object auth
  JOIN object_type aot
  ON aot.object_type = auth.object_type
  JOIN object prop
  ON prop.object_no = auth.link_object_no
  JOIN object sp
  ON auth.abut_no = sp.abut_no
  JOIN object_type spot
  ON spot.object_type = sp.object_type
  AND spot.concatenated_desc LIKE 'NODE.SERVICE POINT%'
  AND prop.object_name IS NOT NULL 
  )
SELECT o.object_no "Object No",
  o.object_name "Outlet No",
  v117.attribute_value "Asset Code",
  o.auth_object_name "Property",
  o.object_label "Type",
  v263.attribute_value "Meter Type",
  v33.attribute_value "Serial No",
  v30.attribute_value "Min Flow",
  v31.attribute_value "Max Flow",
  v65.attribute_value "Order Rate Decimal Places",
  v10039.attribute_value "Outlet Billing Type",
  DECODE(v10036.attribute_value,'Y','Yes','N','No','') "Connection Charge Outlet",
  v20004.attribute_value "T1 ID",
  v20020.attribute_value "System ID",
v20024.attribute_value "Design size"
FROM obj o
LEFT OUTER JOIN link_object lo
ON lo.object_no       = o.object_no
AND lo.link_object_no = ''
LEFT OUTER JOIN object_attr_value v117
ON v117.object_no       = o.object_no
AND v117.attribute_type = 117
AND v117.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v263
ON v263.OBJECT_NO       = o.object_no
AND v263.attribute_type = 263
AND v263.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v33
ON v33.OBJECT_NO       = o.object_no
AND v33.attribute_type = 33
AND v33.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v30
ON v30.OBJECT_NO       = o.object_no
AND v30.attribute_type = 30
AND v30.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v31
ON v31.OBJECT_NO       = o.object_no
AND v31.attribute_type = 31
AND v31.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v65
ON v65.OBJECT_NO       = o.object_no
AND v65.attribute_type = 65
AND v65.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v10039
ON v10039.OBJECT_NO       = o.object_no
AND v10039.attribute_type = 10039
AND v10039.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v10036
ON v10036.OBJECT_NO       = o.object_no
AND v10036.attribute_type = 10036
AND v10036.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v20004
ON v20004.OBJECT_NO       = o.object_no
AND v20004.attribute_type = 20004
AND v20004.date_retired  IS NULL
LEFT OUTER JOIN object_attr_value v20020
ON v20020.OBJECT_NO       = o.object_no
AND v20020.attribute_type = 20020
AND v20020.date_retired  IS NULL
left outer join object_attr_value v20024
on v20024.OBJECT_NO       = o.object_no
and v20024.attribute_type= 20024
AND v20024.date_retired  IS NULL

order by 2