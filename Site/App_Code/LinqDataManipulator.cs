using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LinqDataManipulator
/// </summary>
public class LinqDataManipulator
{
    // The DataContext Object is used to connect to the HealthcareDB database.
    private HealthcareDBDataContext healthcareDBContext;

    public LinqDataManipulator()
    {

    }

    public IQueryable GetNotCheckedInAppointments()
    {
        try
        {
            healthcareDBContext = new HealthcareDBDataContext();

            // appointments will hold a query that contains all appointments for today.
            // need to get the doctor name patient name and the doctors number.
            var appointments = from a in healthcareDBContext.Appointments
                               where a.DateTime.Date == DateTime.Today
                               && a.Status == false
                               select new
                               {
                                   Id = a.AppointmentId,
                                   Time = a.DateTime.TimeOfDay.Hours + ":" + a.DateTime.TimeOfDay.Minutes,
                                   Patient = a.Patient.Contact.FirstName + " " + a.Patient.Contact.LastName,
                                   Doctor = a.Doctor.Contact.FirstName + " " + a.Doctor.Contact.LastName
                                   //checkedIn = a.Status
                               };

            //return todaysAppointments;
            return appointments;
        }
        catch (Exception)
        {

            throw;
        }
    }

    public IQueryable GetCheckedInAppointments()
    {
        try
        {
            healthcareDBContext = new HealthcareDBDataContext();

            // appointments will hold a query that contains all appointments for today.
            // need to get the doctor name patient name and the doctors number.
            var appointments = from a in healthcareDBContext.Appointments
                               where a.DateTime.Date == DateTime.Today
                               && a.Status == true
                               select new
                               {
                                   Id = a.AppointmentId,
                                   Time = a.DateTime.TimeOfDay.Hours + ":" + a.DateTime.TimeOfDay.Minutes,
                                   Patient = a.Patient.Contact.FirstName + " " + a.Patient.Contact.LastName,
                                   Doctor = a.Doctor.Contact.FirstName + " " + a.Doctor.Contact.LastName
                                   //checkedIn = a.Status
                               };

            //return todaysAppointments;
            return appointments;
        }
        catch (Exception)
        {

            throw;
        }
    }
    /// <summary>
    /// This method will update the Appointments table
    /// when the checked in status is changed to true.
    /// </summary>
    public void UpdateAppointments(int appointmentId)
    {

        healthcareDBContext = new HealthcareDBDataContext();

        // Retrieve the appointment equal to the Id parameter passed into the method.   
        var appointment = (from a in healthcareDBContext.Appointments
                           where a.AppointmentId == appointmentId
                           select a).First();

        try
        {
            // Check if status is not true meaning the patient
            // is not yet checked in, in the Appointments table
            if (!appointment.Status)
            {
                // Set status to true
                appointment.Status = true;
                healthcareDBContext.SubmitChanges();
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    /// <summary>
    /// MakeAllAppointmentsToday() 
    /// </summary>
    public void MakeAllAppointmentsTodaysDate()
    {
        healthcareDBContext = new HealthcareDBDataContext();

        // Retrieve all appointments   
        var appointments = from a in healthcareDBContext.Appointments
                           select a;

        // Change the date to today foreach appointment in the DB
        foreach (var appointment in appointments)
        {
            appointment.DateTime = DateTime.Today;
        }
    }

    public TextInfo CreateText(int appointmentId)
    {
        // TextInfo holds the data required to make the
        // doctor's patient checked in text message.
        TextInfo textInfo = new TextInfo();

        healthcareDBContext = new HealthcareDBDataContext();

        var callInfo = from a in healthcareDBContext.Appointments
                       where a.AppointmentId == appointmentId
                       select new
                       {
                           patient = a.Patient.Contact.FirstName + " " + a.Patient.Contact.LastName,
                           appTime = a.DateTime.TimeOfDay.Hours + ":" + a.DateTime.TimeOfDay.Minutes,
                           phone = a.Doctor.Contact.PhoneNumbers
                       };

        textInfo.AppointmentTime = callInfo.First().appTime.ToString();
        textInfo.Patient = callInfo.First().patient;
        textInfo.PhoneNum = callInfo.First().phone.First().PhoneNum;

        return textInfo;

    }

    /// <summary>
    /// Use this method to change the patients check in 
    /// status to false.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    public void UncheckInPatients()
    {
        healthcareDBContext = new HealthcareDBDataContext();

        var appointments = from a in healthcareDBContext.Appointments
                           select a;

        foreach (var appointment in appointments)
        {
            appointment.Status = false;
            healthcareDBContext.SubmitChanges();
        }
    }

}

