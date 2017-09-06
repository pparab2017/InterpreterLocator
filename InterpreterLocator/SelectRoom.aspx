<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/masters/BlankMasterAlt.master" CodeFile="SelectRoom.aspx.cs" Inherits="Home" %>

<asp:Content runat="server" ContentPlaceHolderID="cphMain" ID="anything">

    
    <asp:HiddenField runat="server" ID="hdnRoomId" Value="" />
  
    <h2>Select Room</h2>
    <hr />
    <div class="panel panel-success">
  <div class="panel-heading"><b>Select your Room</b></div>
  <div class="panel-body">
      
       

      <div class="form-group">
     <asp:DropDownList ID="ddlRoom" AutoPostBack="true"  CssClass="form-control" runat="server" ></asp:DropDownList>
  </div>

      <asp:Button ID="btnSelectRoom" CssClass="btn btn-success" runat="server" Text="Okay" OnClick="btnSelectRoom_Click" />
  </div>
</div>


    
 
</asp:Content>