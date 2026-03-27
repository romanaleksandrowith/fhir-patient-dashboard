drop table if exists mart_patient_visit_funnel_v2;

create table mart_patient_visit_funnel_v2 as
with matched as (
    select
        a.appointment_id,
        a.patient_id,
        a.practitioner_id,
        a.start_dt as appointment_start_dt,
        e.encounter_id,
        e.status as encounter_status,
        e.start_dt as encounter_start_dt,
        abs(strftime('%s', e.start_dt) - strftime('%s', a.start_dt)) as time_diff,
        row_number() over (
            partition by a.appointment_id
            order by abs(strftime('%s', e.start_dt) - strftime('%s', a.start_dt))
        ) as rn
    from stg_appointments a
    left join stg_encounters e
        on a.patient_id = e.patient_id
)
select
    a.appointment_id,
    a.patient_id,
    p.full_name as patient_name,
    a.practitioner_id,
    pr.full_name as practitioner_name,
    a.status as appointment_status,
    a.start_dt as appointment_start_dt,
    m.encounter_id,
    m.encounter_status,
    m.encounter_start_dt,
    case
        when m.encounter_status = 'finished' then 1
        else 0
    end as visit_completed_flag
from stg_appointments a
left join matched m
    on a.appointment_id = m.appointment_id
   and m.rn = 1
left join stg_patients p
    on a.patient_id = p.patient_id
left join stg_practitioners pr
    on a.practitioner_id = pr.practitioner_id;