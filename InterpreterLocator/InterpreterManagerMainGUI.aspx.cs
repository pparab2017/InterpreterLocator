using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class InterpreterManagerMainGUI : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(SessionManager.GetCurrentUser().EmployeeType != Entities.EmplpyeeType.INTERPRETERMANAGER)
        {
            Response.Redirect("Default.aspx");
        }
    }
}