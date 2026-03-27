create table stg_patients (
    patient_id text primary key,
    family text,
    given text,
    full_name text,
    gender text,
    birth_date text
);

create table stg_practitioners (
    practitioner_id text primary key,
    full_name text
);

create table stg_appointments (
    appointment_id text primary key,
    status text,
    start_dt text,
    end_dt text,
    patient_id text,
    practitioner_id text
);

create table stg_encounters (
    encounter_id text primary key,
    status text,
    start_dt text,
    end_dt text,
    patient_id text,
    practitioner_id text
);