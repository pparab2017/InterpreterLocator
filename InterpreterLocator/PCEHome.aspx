<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/masters/BlankMasterAlt.master" CodeFile="PCEHome.aspx.cs" Inherits="PCEHome" %>

<asp:Content runat="server" ContentPlaceHolderID="cphMain" ID="anything">
     <asp:HiddenField runat="server" ID="hdnRoomId" Value="" />
     <asp:HiddenField runat="server" ID="hdnSentMsgID" Value="" />
      <asp:HiddenField runat="server" ID="hdnSelectedInterPreter" Value="" />

    <asp:HiddenField runat="server" ID="hdnSource" Value="" />

    <h2>PCE Home page</h2>
    <hr />

    <div class="row" id="selectInterpreter">
       <div class="col-sm-2"><h5>Select Interpreter:</h5> </div>
        <div class="col-sm-6"><select  ID="ddlInterpreterList" class="form-control"></select> 
        
          
        </div>
        <div class="col-sm-2">   <input type="button" class="btn btn-success" onclick ="generateNext()" value="Next" /></div>
    </div>

    <div id="blockdiv" style="width:100%;height:125%; top:0px;left:0px;  background: rgba(76, 175, 80, 0.3) ; position: absolute;z-index:99;"> </div>
    <div class="row" id="sendDiv" style="position:absolute; margin-left:10%; z-index:999" >
        <div class="panel panel-default">
  <div class="panel-heading"><b>Send Message</b></div>
  <div class="panel-body">
      <div class="col-sm-4"> <b>Interpreter: </b> </div>
      <div class="col-sm-8"> <label id="lblInterpreter" ></label></div>

       <div class="col-sm-4">   <b>Message:</b> </div>
      <div class="col-sm-8"> <textarea class="form-control"  id="msgtext" ></textarea></div>
     
      <div class="col-sm-5">
            <input type="button" class="btn btn-success" onclick ="sendMessage()" value="Send" />

           <input type="button" class="btn btn-danger" onclick ="canclesend()" value="Cancel" />
      </div>
  </div>
</div>


    </div>

    <div class="row" id="response" >
        <div class="col-sm-8">
            <b><p id="waiting"> Waiting for interpreter to reply...</p></b>
            <table id="reply" class="table">


            </table>
        </div>
        <div class="col-sm-4">
            <input  type="button" onclick="CancelRequest()"  class="btn btn-danger" id="btnCancelRequest" value="Cancel Request"/>

            <input  type="button" onclick="CancelRequest()"  class="btn btn-primary" id="btnComplete" value="Complete Request"/>
        </div>
    </div>
    
    <div class="row" style="margin-top:20px" >
        <div class="col-md-8">

     <div class="panel panel-success">
  <div class="panel-heading"><b>Map</b></div>
  <div class="panel-body">
    <object data="assets/img/mymap.svg" id ="SVG" style="width:100%; height:100%"></object>

      </div></div>
         </div>
         <div class="col-md-1">
             </div>

         <div class="col-md-3" style="border-left:1px solid #ddd; height:500px">
            <h3> Notice: </h3>
             <hr />

      All the room will be under maintainance from 4 - 5 pm today
     

        </div></div>

  
   


   
     <script type="text/javascript">
         window.setInterval(function () {
          
             SetInterpreter();
         }, 3000);
     

         function CancelRequest()
         {
             var oldID =  $("#" + '<%= hdnSentMsgID.ClientID %>').val();
             $.ajax({
                 type: "POST",
                 dataType: 'json',
                 contentType: "application/json; charset=utf-8",
                 url: "GetMessages.asmx/CancelMessage",
                 data: "{'oldID' : '" + oldID + "'}",
                 success: function (data) {
                     $("#reply tr").remove();
                     // alert(data.d);
                     
                     $("#selectInterpreter").show();
                     $("#response").hide();
                     $("#waiting").text("Recieved Response");

                     window.clearInterval(response);
                      $("#" + '<%= hdnSentMsgID.ClientID %>').val("");
                     
                   
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     if (textStatus == 'Unauthorized') {
                         alert('custom message. Error: ' + errorThrown);
                     } else {
                         alert('custom message. Error: ' + errorThrown);
                     }
                 }
             });
         }

       

         //<![CDATA[

         function canclesend()
         {
             $("#blockdiv").hide();
             $("#sendDiv").hide();
         }

         function generateNext()
         {
             $("#msgtext").val('');
             $("#blockdiv").show();
             $("#sendDiv").show();

             //hdnSelectedInterPreter
             $("#" + '<%= hdnSelectedInterPreter.ClientID %>').val($("#ddlInterpreterList option:selected").val());
             $("#lblInterpreter").text($("#ddlInterpreterList option:selected").text());

               // + $("#ddlInterpreterList option:selected").val());
             
             $('#ddlInterpreterList').val()
         }


         function GetResponse()
         {
             var oldID =  $("#" + '<%= hdnSentMsgID.ClientID %>').val();
             var trHTML ="";
              $.ajax({
                 type: "POST",
                 dataType: 'json',
                 contentType: "application/json; charset=utf-8",
                 url: "GetMessages.asmx/GetResponseForMe",
                 data: "{'oldID' : '" + oldID + "'}",
                 success: function (data) {
                     $("#reply tr").remove();
                     // alert(data.d);
                     var d = data.d;
                     for (var i = 0; i < d.length; i++) {

                         trHTML += '<tr><td>' + d[i].FromFirstName + '</td><td>' + d[i].MessageText + '</td></tr>';


                     }
                     if (d.length > 0) {
                         $("#waiting").text("Recieved Response");
                     }
                     jQuery("label[for='myalue']").html("asd");
                     $('#reply').append(trHTML);
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     if (textStatus == 'Unauthorized') {
                         //alert('custom message. Error: ' + errorThrown);
                     } else {
                        // alert('custom message. Error: ' + errorThrown);
                     }
                 }
             });
         }


         var response;
         function StartListningForResponse()
         {
             response=     window.setInterval(function () {

                 GetResponse();
             }, 3000);
         }

         function sendMessage()
         {
             var selectedInterpreter =parseInt(  $("#" + '<%= hdnSelectedInterPreter.ClientID %>').val());
             var msgText = $("#msgtext").val();
             var source = parseInt( $("#" + '<%= hdnSource.ClientID %>').val());
             //alert(selectedInterpreter + " " + msgText + " " + source);
             $.ajax({
                 type: "POST",
                 dataType: 'json',
                 contentType: "application/json; charset=utf-8",
                 url: "GetInterpreter.asmx/sendMessage",
                 data: "{'srcID' : '" + source + "'" + ",'dstID' : '" + selectedInterpreter + "'" + ",'message' : '" + msgText + "'}",
                 success: function (data) {

                     //alert(data.d);
                   
                     $("#" + '<%= hdnSentMsgID.ClientID %>').val(data.d);

                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     if (textStatus == 'Unauthorized') {
                        // alert('custom message. Error: ' + errorThrown);
                     } else {
                        // alert('custom message. Error: ' + errorThrown);
                     }
                 }
             });

             $("#blockdiv").hide();
             $("#sendDiv").hide();

             $("#selectInterpreter").hide();
             $("#response").show();

             StartListningForResponse();
             //alert("clicked");



         }

         function bindDropDown(d) {
             for (var i = 0; i < d.length; i++) {

                 var exists = false;
                 var length = $('#ddlInterpreterList > option').length;
                 var counter = 0;
                 if (length != 0) {
                     
                     $('#ddlInterpreterList option').each(function () {
                         if (this.value == d[i].EmployeId) {
                             counter = counter + 1;

                         }
                       
                     });
                 }
                 if (counter == 0)
                 {
                     $("#ddlInterpreterList").append($("<option></option>").val(d[i].EmployeId).html(d[i].FullName));
                 }
                 
             }


             $('#ddlInterpreterList option').each(function () {
                 var cnt = 0;
                 for (var i = 0; i < d.length; i++) {
                     if (this.value == d[i].EmployeId) {
                         cnt = cnt + 1;

                     }

                 }
                 if (cnt == 0) {
                     $("#ddlInterpreterList option[value='" + this.value + "']").remove();

                    // $("#ddlInterpreterList").append($("<option></option>").val(d[i].EmployeId).html(d[i].FullName));
                 }
               

             });
         }


         function GetRoomMyWay(hv)
         {
             var g = "";
             if (hv == 1) {
                 g = "PointA";
             }
             else if (hv == 2) {
                 g = "PointC";
             }
             else if (hv == 3) {
                 g = "PointF";
             }
             else if (hv == 4) {
                 g = "PointJ";
             }
             else if (hv == 5) {
                 g = "PointG";
             }
             return g;
         }

      window.onload = function () {
          $("#sendDiv").hide();
          $("#blockdiv").hide();
          $("#response").hide();
          var hv = $("#" + '<%= hdnRoomId.ClientID %>').val();

          var g = GetRoomMyWay(hv);
        //  alert(g);
         
        
          var myMap = document.getElementById("SVG");
          //alert(myMap);
          var svgDoc = myMap.contentDocument;
          var canvas = svgDoc.getElementById("svg2");
        //  alert(svgDoc);
          var myRoom = svgDoc.getElementById(g);
          canvas.appendChild(
               Setrect(Math.abs(myRoom.getAttribute("cx")), Math.abs(myRoom.getAttribute("cy")), 3, 3, "myPlace", 150, 30, "#fff", "#0f0", 2)
              );

          var rect = document.getElementById("myPlace");
          canvas.appendChild(SetLabel(parseInt(myRoom.getAttribute("cx")) + 8, parseInt(myRoom.getAttribute("cy")) + 22, "sans-serif", "20", "#000", "#000", "1", "You are here!", "#fff"));
          // alert(myRoom.getAttribute("cx"));

         
          
      }

      

         function SetInterpreter()
         {
             $.ajax({
                 type: "POST",
                 dataType: 'json',
                 contentType: "application/json; charset=utf-8",
                 url: "GetInterpreter.asmx/GetInterpreterList",
                 data: "",
                 success: function (data) {

                     
                   

                       //alert(data.d);
                     var d = data.d;
                     bindDropDown(d);
                     var  t = data.d;

                  

                     var myMap = document.getElementById("SVG");
                     //alert(myMap);
                     var svgDoc = myMap.contentDocument;
                     var canvas = svgDoc.getElementById("svg2");
                     //  alert(svgDoc);
                    


                     var groups = canvas.getElementsByTagName("rect");
                     var text = canvas.getElementsByTagName("text");
                     for (var i = 0; i < text.length; i++) {
                         var t = text[i].getAttribute("id");
                         if (t.indexOf("lblinterpreter") != -1) {
                             canvas.removeChild(text[i]);
                         }
                     }

                     for (var i = 0; i < groups.length; i++) {
                         var h = groups[i].getAttribute("id");
                         if (h.indexOf("interpreter") != -1) {
                             canvas.removeChild(groups[i]);
                         }

                     }

                     for (var i = 0; i < d.length; i++) {
                          //alert(d[i].LastName);
                         
                          var room = GetRoomMyWay(d[i].RoomID)

                          var myRoom = svgDoc.getElementById(room);
                             canvas.appendChild(
                                  Setrect(Math.abs(myRoom.getAttribute("cx")), Math.abs(myRoom.getAttribute("cy")), 3, 3, "interpreter" + d[i].EmployeId, 150, 30, "#fff", "#00f", 2)
                                 );
                         

                         // var rect = document.getElementById("myPlace");
                        
                             canvas.appendChild(SetLabel(parseInt(myRoom.getAttribute("cx")) + 8, parseInt(myRoom.getAttribute("cy")) + 22, "sans-serif", "20", "#000", "#000", "1", d[i].FirstName + " " + d[i].LastName, "lblinterpreter" + d[i].EmployeId));
                             // alert(myRoom.getAttribute("cx"));
                       

                     }


                 },
             });
         }

        //]]>
    </script>
    </asp:Content>
