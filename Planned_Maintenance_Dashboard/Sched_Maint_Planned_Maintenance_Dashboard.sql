select 
    tp.collection_desc           as test_point_collection,
    tp.test_point_desc           as test_point_name,
    tp.collected_at              as test_point_date,
    tp.test_point_value          as test_point_value,
    sm.*
from 
    t1.scheduled_maintenance_log sm
join t1.asset_test_point tp 
    on tp.work_no = sm.work_no 
        and tp.asset_no = sm.asset_no
 
where
    tp.collection_code ~ '(REG|MET).INSP'
order by
    tp.collected_at desc, sm.work_no, sm.asset_no, tp.test_point_no