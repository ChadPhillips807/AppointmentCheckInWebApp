using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Twilio;

/// <summary>
/// Summary description for Notifier
/// </summary>
    public class Notifier
    {
        // TODO:
        // Construct the MESSAGE and add the ToPhoneNumber
        // in the WebApp to make the call
    
        private TwilioRestClient twilioRestClient;
    
        private string AccountSid = "<YOUR_ACCOUNT_SID>";
        private string AuthToken = "<YOUR_AUTH_TOKEN>";
    
        // Using this default number that Twilio assigned.
        private string fromPhoneNum = "<YOUR_ASSIGNED_TWILIO_NUMBER>";
    
        //public string Message { get; set; }
        //public string ToPhoneNum { get; set; }// This is the Doctor's phone number.
    
        public Notifier(TextInfo doctorText)//string toPhoneNum, string message)
        {
            string toPhoneNum = doctorText.PhoneNum;
            string time = doctorText.AppointmentTime;
            string patient = doctorText.Patient;

            string message = string.Format("{0} is here for their {1} appointment.", patient, time);
            
            SendNotification(toPhoneNum, message);
        }
    
        /// <summary>
        /// SendNotification instantiates the TwilioRestClient using the
        /// Twilio AccountSid and AuthToken as parameters. It then sends
        /// a message using the TwilioRestClient.SendSmsMessage() method. 
        /// </summary>
        public void SendNotification(string toPhoneNum, string message)
        {
            twilioRestClient = new TwilioRestClient(AccountSid, AuthToken);
            twilioRestClient.SendSmsMessage(fromPhoneNum, toPhoneNum, message);
        }
    }
