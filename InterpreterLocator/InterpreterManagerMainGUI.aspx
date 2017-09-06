<%@ Page Language="C#" MasterPageFile="~/masters/BlankMasterAlt.master" AutoEventWireup="true" CodeFile="InterpreterManagerMainGUI.aspx.cs" Inherits="InterpreterManagerMainGUI" %>
<asp:Content runat="server" ContentPlaceHolderID="cphMain" ID="anything">

  <div class="container" > 
      <h4>Home Page</h4>
      <hr />
      <p>Use the below menues to edit maps and to update/edit shifts</p>
<hr/>
 <a href="Shift.aspx"><div class="col-md-3 createNew" > 
 <p style="font-size:60px"> <span class="glyphicon glyphicon-tasks" ></span></p>
 
 Edit/Upload Shifts </div>
</a>

<a href="MapEdit.aspx">
 <div class="col-md-3 createNew"  > 


<p style="font-size:60px"> <span class="glyphicon glyphicon-map-marker" ></span></p>
 Edit Maps </div>
 </a>

 </div>

 </asp:Content>
