using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OfficeOpenXml;
using System.Data;
using Entities;
using Business;

public partial class Shift : System.Web.UI.Page
{
    private int _shiftID
    {
        get
        {
            return (int)ViewState["shiftID"];
        }
        set
        {
            ViewState["shiftID"] = value;
        }
    }

    private string _oldRecord
    {
        get
        {
            return (string)ViewState["oldRecord"];
        }
        set
        {
            ViewState["oldRecord"] = value;
        }
    }

    private string _selectedUserName
    {
        get
        {
            return (string)ViewState["selectedUserName"];
        }
        set
        {
            ViewState["selectedUserName"] = value;
        }
    }

    private void bindGrid()
    {
        List<shift> allShifts = ShiftController.getAllShifts();
        tet.DataSource = allShifts;
        tet.DataBind();
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {

            if (SessionManager.GetCurrentUser().EmployeeType != Entities.EmplpyeeType.INTERPRETERMANAGER)
            {
                Response.Redirect("Default.aspx");
            }
            bindGrid();


        }
    }


    protected void tet_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

        GridViewRow row = tet.Rows[e.NewSelectedIndex];
        int shiftID = Convert.ToInt32(tet.DataKeys[e.NewSelectedIndex].Values[0].ToString());
        string ShiftName = (tet.DataKeys[e.NewSelectedIndex].Values[1].ToString());
        string From = (tet.DataKeys[e.NewSelectedIndex].Values[2].ToString());
        string to = (tet.DataKeys[e.NewSelectedIndex].Values[3].ToString());
        string dayname = (tet.DataKeys[e.NewSelectedIndex].Values[4].ToString());
        string firstname = (tet.DataKeys[e.NewSelectedIndex].Values[5].ToString());
        string lastname = (tet.DataKeys[e.NewSelectedIndex].Values[6].ToString());
        _shiftID = shiftID;

        txtShiftName.Text = ShiftName;
        txtShartTime.Text = From;
        txtEndTime.Text = to;
        txtShiftDay.Text = dayname;

        _selectedUserName = firstname + " " + lastname;
        _oldRecord = "ID:" + shiftID + " From time:"  +  From + " to time:" + to + " Day name:" + dayname + " Employee Name" + firstname + " " + lastname;

        pnlgrid.Visible = false;
        pnlEdit.Visible = true;

    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {

        if (fileUpload.HasFile)
        {
            if (Path.GetExtension(fileUpload.FileName) == ".xlsx")
            {
                ExcelPackage package = new ExcelPackage(fileUpload.FileContent);
                DataTable dt = package.ToDataTable();
               

                List<shift> toInsert = new List<shift>();
                foreach (DataRow row in dt.Rows)
                {
                    shift toAdd = new shift();
                    toAdd.ShiftName = row["ShiftName"].ToString();
                    toAdd.From = Convert.ToDateTime (row["Start_time"]);
                    toAdd.To = Convert.ToDateTime(row["End_time"]);
                    toAdd.DayName = row["DayOfWeek"].ToString();
                    toAdd.UserName = row["username"].ToString();
                    toInsert.Add(toAdd);
                }

               

                ShiftController.InsertShifts(toInsert);
               
                bindGrid();

            }
        }

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        shift toUpdate = new shift();
        toUpdate.ShiftID = _shiftID;
        toUpdate.ShiftName = txtShiftName.Text;
        toUpdate.From = Convert.ToDateTime(txtShartTime.Text);
        toUpdate.To = Convert.ToDateTime(txtEndTime.Text);
        toUpdate.DayName = txtShiftDay.Text;

        string newrecord = "ID:" + _shiftID + " From time:" + txtShartTime.Text + " to time:"
          + txtEndTime.Text + " Day name:" + txtShiftDay.Text + " Employee Name" + _selectedUserName;

        Log toAppend = new Log();
        toAppend.UserName = _selectedUserName;
        toAppend.ManagerID = SessionManager.GetCurrentUser().EmployeId;
        toAppend.OldRecord = _oldRecord;
        toAppend.Type = "Update";
        toAppend.NewRecord = newrecord;

        ShiftUpdateFacade.UpdateShifts(toUpdate, toAppend);



        bindGrid();
        pnlgrid.Visible = true;
        pnlEdit.Visible = false;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        pnlgrid.Visible = true;
        pnlEdit.Visible = false;
    }
}