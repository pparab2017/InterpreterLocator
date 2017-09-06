<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/masters/BlankMasterAlt.master" CodeFile="Shift.aspx.cs" Inherits="Shift" %>


<asp:Content ContentPlaceHolderID="cphBreadCrumb" runat="server">
    <a href="InterpreterManagerMainGUI.aspx"> Home </a> > Shift Edit/Upload
</asp:Content>

<asp:Content ID="anything" runat="server" ContentPlaceHolderID="cphMain">

      <h2>Shift Edit</h2>
            <br />
    <asp:Panel runat="server" ID="pnlgrid">
  <asp:GridView ID="tet" runat="server"
       GridLines="None" DataKeyNames="ShiftID,ShiftName,From,To,DayName,FirstName,LastName" 
       OnSelectedIndexChanging="tet_SelectedIndexChanging" CssClass="table table-hover"
       AutoGenerateColumns="false"
      >
       <Columns>
                   <asp:CommandField ShowSelectButton="True" HeaderText="Edit" />
                   <asp:BoundField  DataField="FirstName" HeaderText ="First Name"  />
                   <asp:BoundField DataField="LastName" HeaderText ="Last Name"  />
                     <asp:BoundField DataField="ShiftName" HeaderText ="Shift Name"  />
           <asp:BoundField DataField="From" HeaderText ="Start time"  />
           <asp:BoundField DataField="To" HeaderText ="End Time"  />
           <asp:BoundField DataField="DayName" HeaderText ="Day"  />
                   </Columns>


  </asp:GridView>

         <h2>Choose file for upload</h2>
            <hr />
          <div class="row">
              
        <div class="col-md-4">
           
    <asp:FileUpload runat="server" ID="fileUpload" CssClass="btn btn-default" />
        </div> <div class="col-md-4">
    <asp:Button runat="server" ID="btnUpload" CssClass="btn btn-success" Text="Upload" OnClick="btnUpload_Click" />
    </div></div>
        </asp:Panel>

    <asp:Panel runat="server" ID="pnlEdit" Visible="false">

        <div class="row">

            <div class="col-md-4"><b>Shift Name</b></div>
            <div class="col-md-6"><asp:TextBox runat="server" CssClass="form-control" ID="txtShiftName" ></asp:TextBox>
                <br />
            </div>
           
             <div class="col-md-4"><b>Shift start time</b></div>
            <div class="col-md-6"><asp:TextBox runat="server"  CssClass="form-control"  ID="txtShartTime" ></asp:TextBox><br /></div>

             <div class="col-md-4"><b>Shift end time</b></div>
            <div class="col-md-6"><asp:TextBox runat="server"  CssClass="form-control"  ID="txtEndTime" ></asp:TextBox><br /></div>

             <div class="col-md-4"><b>Shift day</b></div>
            <div class="col-md-6"><asp:TextBox runat="server"  CssClass="form-control"  ID="txtShiftDay" ></asp:TextBox><br /></div>
       
             <div class="col-md-10">
            <asp:Button runat="server" ID="btnUpdate" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                 <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click" />
            </div>
             </div>
    </asp:Panel>
  
 </asp:Content>