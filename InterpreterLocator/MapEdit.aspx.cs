using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entities;
using Business;

public partial class MapEdit : System.Web.UI.Page
{
    private int _mapID
    {
        get
        {
            return (int)ViewState["MapID"];
        }
        set
        {
            ViewState["MapID"] = value;
        }
    }
    private string _selectedPath
    {
        get
        {
            return (string)ViewState["path_selected"];
        }
        set
        {
            ViewState["path_selected"] = value;
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        if(SessionManager.GetCurrentUser().EmployeeType != Entities.EmplpyeeType.INTERPRETERMANAGER)
        {
            Response.Redirect("Default.aspx");
            List<Map> allMap = MapController.GetAllMap();
            grdMapEdit.DataSource = allMap;
            grdMapEdit.DataBind();
        }
       
    }


    private void SetEditFrom(int id)
    {
        all.Visible = false;
        editMode.Visible = true;
        txtPath.Text = _selectedPath;



    }

    protected void grdMapEdit_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
      
        GridViewRow row = grdMapEdit.Rows[e.NewSelectedIndex];
        int mapId = Convert.ToInt32(grdMapEdit.DataKeys[e.NewSelectedIndex].Values[0].ToString());
        string path = (grdMapEdit.DataKeys[e.NewSelectedIndex].Values[1].ToString());
        _mapID = mapId;
        _selectedPath = path;
        SetEditFrom(mapId);
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        all.Visible = true;
        editMode.Visible = false;
    }
}