use entridemo;

create  table  Patients (PatientID varchar(10), PatientName varchar(50), Age int, Gender varchar(10), AdmissionDate varchar(15))

alter table patients add column (DoctorAssigned varchar(50));

