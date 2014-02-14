Description:
 
This application is for a healthcare organization's appointments. 
In the  Appointment web application the user can view the days appointments, 
as  well as their associated patients and doctors. Users can also check each  
patient in sending the doctor a message.



User Reqs:

 
1. Need list of all of todays appointments.
 
2. Must be able to notify Dr. of patients arrival and readiness.



Tools:

 Use C#, SQL, & ASP.NET; 
 SMS svc such as Twilio



DB:

 
Contacts: ContactId(identity), FirstName, LastName 
 
Patients: PatientId(identity), ContactId
 
Doctors: DoctorId(identity), ContactId
 
PhoneNumbers: PhoneId(identity), ContactId, PhoneNum
 
Appointments: AppointmentId(identity), PatientId, DoctorId, Date/Time, Status(bit)



Web Interface:

 
Present all appointments for the day. Have a patient checkin feature. 
Should have it so the appointments in the database are updated to todays 
date and have the web interface only  
 show todays list of patients.



Notifications:

 When a user clicks the "Check In" link, the relevant doctor 
is sent a text msg advising them of the patients arrival.