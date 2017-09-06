<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/masters/BlankMaster.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content runat="server" ID="loginContent" ContentPlaceHolderID="cphMain">

    <div class="container-fluid">


   <div class="col-md-offset-3 col-lg-6" style="background-color:white; border-radius: 5px; -webkit-box-shadow: 0px 0px 26px -3px rgba(0,0,0,0.75);
-moz-box-shadow: 0px 0px 26px -3px rgba(0,0,0,0.75);
box-shadow: 0px 0px 26px -3px rgba(0,0,0,0.75);

 position:absolute; margin-top:-50px
; padding:20px">
        
       <div class="container-fluid">


            <div class="form-group">
    <h4> User name: </h4>
   <asp:TextBox runat="server" CssClass="form-control" ID="txtUserName" ></asp:TextBox>

                <asp:Label runat="server" ID="lblusername" ></asp:Label>
  </div>


          

              
        

               <asp:Button runat="server" ID="btnLogin" Text="Login" CssClass="btn btn-success btn-lg" OnClick="btnLogin_Click" />
          
     

        </div>
    </div>
    </div>

</asp:Content>
