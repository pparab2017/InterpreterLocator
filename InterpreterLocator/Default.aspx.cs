using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Entities;
using Business;

public partial class _Default : Page
{
    private const string INTERPRETER_LOCATOR = "interpreterLocator";
    protected void Page_Load(object sender, EventArgs e)
    {


      

       // lblusername.Text = toAuth.FirstName + "," + toAuth.LastName;

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Employee toAuth = EmployeeController.GetEmployeeByUsername(txtUserName.Text.Trim());
        SessionManager.SetLoggedInUser(toAuth);
        //  return result;
        if (toAuth.EmployeeType == EmplpyeeType.INTERPRETERMANAGER)
        {
            Response.Redirect("InterpreterManagerMainGUI.aspx");
        }
        else
        {
            Response.Redirect("SelectRoom.aspx");
        }
    }
}