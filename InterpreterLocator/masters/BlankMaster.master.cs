using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;



public partial class BlankMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
     
      //  litEmployeeName.Text = SessionManager.GetCurrentUser().FullName;
        lblAppInfo.Text = "a system used to connect";

        Page.Header.DataBind();
        if (!Page.IsPostBack)
        {
            if (ConfigurationManager.AppSettings["AllowImpersonation"] != null)
            {
                if (ConfigurationManager.AppSettings["AllowImpersonation"] != string.Empty)
                {
                    bool allowImpersonation = bool.Parse(ConfigurationManager.AppSettings["AllowImpersonation"]);

                    if (!allowImpersonation)
                    {

                        //liImpersonate.Visible = false;
                    }
                }
            }

       


           
        }
    }
}

