select
    count(*) as appointments_cnt,
    count(distinct patient_id) as patients_cnt,
    sum(visit_completed_flag) as completed_visits_cnt,
    round(1.0 * sum(visit_completed_flag) / count(*), 4) as conversion_rate
from mart_patient_visit_funnel_v2;

select
    practitioner_name,
    count(*) as appointments_cnt,
    sum(visit_completed_flag) as completed_visits_cnt,
    round(1.0 * sum(visit_completed_flag) / count(*), 4) as conversion_rate
from mart_patient_visit_funnel_v2
group by practitioner_name
order by appointments_cnt desc;

select
    substr(appointment_start_dt, 1, 10) as visit_date,
    count(*) as appointments_cnt,
    sum(visit_completed_flag) as completed_visits_cnt,
    round(1.0 * sum(visit_completed_flag) / count(*), 4) as conversion_rate
from mart_patient_visit_funnel_v2
where appointment_start_dt is not null
group by substr(appointment_start_dt, 1, 10)
order by visit_date;