-- Set of query tests to
--

-- Show Error Log data in a date range
select a.type, p.created_at,e.severity,e.code,e.message,e.trace_message
from PoiLog p
left join ErrorLog e on p.`id`=e.`poi_log_id`
left join ActivityType a on a.id=p.`activity_type_id`
where p.created_at >= '2019-06-01' AND p.created_at <= '2019-06-05'


-- Show Requests within 20 seconds
select a.type, p.created_at, m.resource,m.method
from PoiLog p
left join MetricsLog m on m.`poi_log_id`=p.id
left join ActivityType a on a.id=p.`activity_type_id`
where p.created_at >= '2019-06-05 20:06:30' and p.created_at <= '2019-06-05 20:06:50'
