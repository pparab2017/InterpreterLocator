using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using Business;


public partial class BlankMasterAlt : System.Web.UI.MasterPage
{
 
    protected void Page_Load(object sender, EventArgs e)
    {
       
            litEmployeeName.Text = SessionManager.GetCurrentUser().FullName;


            Page.Header.DataBind();
            if (!Page.IsPostBack)
            {
                
                

    

            }

        
            
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        EmployeeController.logout(SessionManager.GetCurrentUser().EmployeId);
        Response.Redirect("default.aspx");
    }
}
