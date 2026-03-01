using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Temporarily hardcoded for testing. 
                // Later, this will be: lblUsername.Text = Session["Username"].ToString();
                lblUsername.Text = "Member";
            }
        }
    }
}