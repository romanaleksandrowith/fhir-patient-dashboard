# Patient Visit Funnel Dashboard (FHIR API)

## Overview
Pilot analytics project based on open FHIR API data.

Goal: build a patient funnel from scheduled appointment to actual visit.

## Data source
Open FHIR API (HAPI FHIR test server)

Resources used:
- Patient
- Appointment
- Encounter
- Practitioner

## Architecture
FHIR API → Python ETL → SQLite → SQL mart → Analytics

## What was done
- extracted healthcare data from open API
- normalized nested JSON resources
- loaded data into SQLite staging tables
- built analytical mart `mart_patient_visit_funnel_v2`
- matched appointments with nearest encounters
- calculated KPIs for patient visit funnel

## Business logic
- Appointment = patient scheduled a visit
- Encounter with status `finished` = visit completed

## Key metrics
- Appointments: **1852**
- Unique patients: **328**
- Completed visits: **129**
- Conversion rate: **6.97%**

## Main insight
A simple join between appointments and encounters overstated conversion.
After matching each appointment to the nearest encounter, the conversion dropped to a more realistic level.

## Tech stack
- Python
- Requests
- Pandas
- SQLite
- SQL

## Repository structure
- `src/` — ETL scripts
- `sql/` — DDL, mart, analytics
- `screenshots/` — preview images
- `output/` — exported mart sample

## 🔍 Data Challenge

One of the main challenges was incorrect data matching.

A naive join between appointments and encounters produced a conversion rate of ~47%, which was unrealistic.

After implementing time-based matching and selecting the closest encounter per appointment, the conversion dropped to ~7%, reflecting a more accurate patient behavior.

## 📈 Business Value

This approach can be used in real clinics to:
- track patient conversion
- identify no-show patterns
- evaluate doctor performance
- improve scheduling efficiency

## 🚀 Next Steps

- add no-show analysis
- cohort analysis of returning patients
- revenue integration

## Preview
![Dashboard Preview](screenshots/dashboard-preview.png)
