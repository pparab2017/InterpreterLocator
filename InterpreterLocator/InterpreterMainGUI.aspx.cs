﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Business;
using Entities;

public partial class InterpreterMainGUI : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionManager.GetCurrentUser().EmployeeType != Entities.EmplpyeeType.INTERPRETER)
        {
            Response.Redirect("Default.aspx");
        }

        string v = Request.QueryString["room"];
        if (v != null)
        {

            hdnRoomId.Value = v;
        }
        hdnSource.Value = SessionManager.GetCurrentUser().EmployeId.ToString();


        if(!IsPostBack)
        {
            List<shift> myShifts = ShiftController.getShiftByUserName(SessionManager.GetCurrentUser().EmployeId);
            gvmyShifts.DataSource = myShifts;
            gvmyShifts.DataBind();
        }
    }
}