using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace FitHome
{
    // Make sure the class name matches the 'Inherits' in the Master page
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // leave this empty for now
        }

        // trigger when the admin clicks the logout button on navbar
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // clear the login memory (session) so no one can press 'back' to enter again
            Session.Clear();
            Session.Abandon();

            // kick the user back to the login page
            Response.Redirect("AdminLogin.aspx");
        }
    }
}