using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entities;
using Business;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            List<Room> allRooms = RoomController.GetAllRooms();
            ddlRoom.DataSource = allRooms;
            ddlRoom.DataValueField = "RoomId";
            ddlRoom.DataTextField = "RoomNumber";
            ddlRoom.DataBind();

        }
    }

    protected void btnSelectRoom_Click(object sender, EventArgs e)
    {
        hdnRoomId.Value = ddlRoom.SelectedValue;

        EmployeeController.selectRoom(SessionManager.GetCurrentUser().EmployeId, Int32.Parse(ddlRoom.SelectedValue));
        if (SessionManager.GetCurrentUser().EmployeeType == EmplpyeeType.PCE)
        {
            Response.Redirect("PCEHome.aspx?room=" + ddlRoom.SelectedItem.Value);
        }
        else if(SessionManager.GetCurrentUser().EmployeeType == EmplpyeeType.INTERPRETER)
        {
            Response.Redirect("InterpreterMainGUI.aspx?room=" + ddlRoom.SelectedItem.Value);
        }
     //   Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "MyRoomSettingFunction()", true);
    }
}