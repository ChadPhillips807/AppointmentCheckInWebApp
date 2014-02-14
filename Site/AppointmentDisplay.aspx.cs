using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppointmentDisplay : System.Web.UI.Page
{
    // This holds the AppointmentId of the appointment being checked in.
    private int appointmentId;
    private LinqDataManipulator apps;

    // appointments will hold the result of the GetAppointments() method's query
    IQueryable notCheckedInAppointments;
    IQueryable checkedInAppointments;

    // Variables for the Twilio text to the doctor
    TextInfo doctorText;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        // Declare and instantiate the AppointmentRetriever.cs class to get the linq queries inside
        apps = new LinqDataManipulator();

        try
        {
            notCheckedInAppointments = apps.GetNotCheckedInAppointments();
            checkedInAppointments = apps.GetCheckedInAppointments();

            // Make all appointments in the Database Todays date to test the webapp
            apps.MakeAllAppointmentsTodaysDate();

            // Make the appointments IQueryable object 
            // the GridView's DataSource and then bind it.
            AppointmentsGridView.DataSource = notCheckedInAppointments;
            CheckedInGridView.DataSource = checkedInAppointments;

            AppointmentsGridView.DataBind();
            CheckedInGridView.DataBind();
        }
        catch (Exception)
        {
            
            throw;
        }      
    }

    /// <summary>
    /// Get the appointmentId from the row that was clicked
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AppointmentsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        LinqDataManipulator apps = new LinqDataManipulator();

        Notifier textDoctor;

        try
        {
            GridViewRow gvr = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);

            int RowIndex = gvr.RowIndex;

            appointmentId = Convert.ToInt32(gvr.Cells[1].Text);

            apps.UpdateAppointments(appointmentId);

            // Text the Doctor about the upcoming appointment
            doctorText = apps.CreateText(appointmentId);
            textDoctor = new Notifier(doctorText);

            Page_Load(sender, e);
        }
        catch (Exception)
        {
            
            throw;
        }

    }

    protected void ResetValuesButton_Click(object sender, EventArgs e)
    {
        LinqDataManipulator apps = new LinqDataManipulator();

        apps.UncheckInPatients();

        Page_Load(sender, e);
    }
}