use entridemo;

create  table  Patients (PatientID varchar(10), PatientName varchar(50), Age int, Gender varchar(10), AdmissionDate varchar(15))

alter table patients add column (DoctorAssigned varchar(50));

rename table patients to patients_info;
insert into patients_info (patientID,patientName,Age,Gender,AdmissionDate,DoctorAssigned) values ('PA101','ragul',32,'Male','22-12-2025','yes');

truncate table patients_info;
select * from patients_info;
drop table patients_info;