select 
dl.asset_no,
asset_name as asset_id,
dt.defect_code as defect_code,
work_status as defect_stage, 
defect_comment as comment,
defect_identified_at as created_at,
work_completed_at as completed_at
from t1.defect_log dl
join t1.defect_type dt on dl.defect_type = dt.defect_desc
where work_status <> 'Cancelled'
