<%@ Page Language="C#" MasterPageFile="~/masters/BlankMasterAlt.master"  AutoEventWireup="true" CodeFile="MapEdit.aspx.cs" Inherits="MapEdit" %>


<asp:Content ContentPlaceHolderID="cphBreadCrumb" runat="server">
    <a href="InterpreterManagerMainGUI.aspx"> Home </a> > Edit Maps
</asp:Content>


<asp:Content runat="server" ContentPlaceHolderID="cphMain" ID="anything">

    <h2>Map Edit page</h2>
    <br />
    <asp:Panel runat="server" ID="all">
   <asp:GridView runat="server" CssClass="table table-hover"
       GridLines="None" ID="grdMapEdit" DataKeyNames="MapID,Path" 
       OnSelectedIndexChanging="grdMapEdit_SelectedIndexChanging"
       AutoGenerateColumns="false" >

       <Columns>
                   <asp:CommandField ShowSelectButton="True" HeaderText="Edit" />
                   <asp:BoundField  DataField="SrcName" HeaderText ="Source Name"  />
                   <asp:BoundField DataField="DscName" HeaderText ="Destination Name"  />
                     <asp:BoundField DataField="Path" HeaderText ="Path"  />
                   </Columns>
   </asp:GridView>
        </asp:Panel>

    <asp:Panel runat="server" ID="editMode" Visible="false">
        <div class="row">
            <div class="col-md-2"> Enter the New path: </div>
            <div class="col-md-6"> <asp:TextBox CssClass="form-control" runat="server" ID="txtPath"></asp:TextBox></div>
            <div class="col-md-10">

                <asp:Button runat="server" ID="btnUpdate" Text="Update" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                 <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click" />
            </div>
        </div>
    </asp:Panel>

 </asp:Content>
