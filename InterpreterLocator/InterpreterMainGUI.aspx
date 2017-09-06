<%@ Page Language="C#" MasterPageFile="~/masters/BlankMasterAlt.master" AutoEventWireup="true" CodeFile="InterpreterMainGUI.aspx.cs" Inherits="InterpreterMainGUI" %>

<asp:Content runat="server"  ID="whatever" ContentPlaceHolderID="cphMain">
     <asp:HiddenField runat="server" ID="hdnRoomId" Value="" />
     <asp:HiddenField runat="server" ID="hdnSource" Value="" />
    <asp:HiddenField runat="server" ID="hdnCurrntsentID" Value="" />

        <asp:HiddenField runat="server" ID="selectedMsg" Value="" />
    <asp:HiddenField runat="server" ID="selectedMsgName" Value="" />


       <asp:HiddenField runat="server" ID="d" Value="" />

          <asp:HiddenField runat="server" ID="droom" Value="" />

      <h2>Interpreter Home page</h2>
    <hr />
     <div class="row" id="selectRequest">
       <div class="col-sm-2"><h5>Select Request:</h5> </div>
        <div class="col-sm-6"><select  ID="ddlmessageList" class="form-control"></select> 
        
          
        </div>
        <div class="col-sm-2">   <input type="button" class="btn btn-success" onclick ="generateNext()" value="Next" /></div>
    </div>


    <div class="row" id="resend">

       <div class="col-sm-8"> <b><p>Message response sent!</p></b></div>
         <div class="col-sm-4"> <input type="button" class="btn btn-success" onclick ="genrateResend()" value="Send New response" /></div>
    </div>

    <div id="blockdiv" style="width:100%;height:125%; top:0px;left:0px;  background: rgba(76, 175, 80, 0.3) ; position: absolute;z-index:99;"> </div>
    
     <div class="row" id="sendDiv"  style="position:absolute; z-index:999" >

         <div class="panel panel-info" style="width:90%">
  <div class="panel-heading">Send Response</div>
               <div class="panel-body">
                   <div class="col-sm-4" style="padding:5px"> <b>Request Selected:</b> </div>
                   <div class="col-md-6" style="padding:5px"> <label id="lblto" ></label></div>

                   <div class="col-sm-4" style="padding:5px"> <b>System ETA: </b></div>
                   <div class="col-sm-6" style="padding:5px"> 5 minutes </div>

                   <div class="col-sm-4" style="padding:5px">   <b>Your ETA:</b> </div>
                   <div class="col-sm-6" style="padding:5px"> <input type="text" class="form-control"  id="youETA"/></div>

                   <div class="col-sm-4" style="padding:5px"> <b>Your reply:</b> </div>
                   <div class="col-sm-6" style="padding:5px"><input type="text" class="form-control" id="youReply"/></div>

                   <div class ="col-sm-8">
                        <input type="button" id="SendReplay" class="btn btn-success" onclick="sendReply()" name="Send" value="Send" />
                        
                    <input type="button" class="btn btn-danger" id="btnnext" onclick="cancel()" value="Cancel"  name="Cancel"/>
                   
                   </div>

                  

                   </div>
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
     
              <h3> Your shifts: </h3>
             <br />

             <asp:GridView runat="server" ID="gvmyShifts" AutoGenerateColumns="false"
                 CssClass="table table-hover" GridLines="None"
                 >
                 <Columns>
                  <asp:BoundField DataField="DayName" HeaderText ="Day"  />
                     <asp:BoundField DataField="ShiftName" HeaderText ="Shift Name"  />
          
          
                   </Columns>

             </asp:GridView>

        </div></div>

   

   
   
  
    

   
    <script type="text/javascript">

        function cancel()
        {
            $("#blockdiv").hide();
            $("#sendDiv").hide();
        }

        function genrateResend()
        {

            $("#youETA").val("");
            $("#youReply").val("");

            $("#lblto").text($("#" + '<%= selectedMsgName.ClientID %>').val());
            $("#blockdiv").show();
            $("#sendDiv").show();

        }

        function generateNext()
        {
            $("#youETA").val("");
            $("#youReply").val("");

            //selectedMsg
            $("#" + '<%= selectedMsg.ClientID %>').val(parseInt($('#ddlmessageList').val().split("|")[0]));
            $("#" + '<%= selectedMsgName.ClientID %>').val($("#ddlmessageList option:selected").text());

            $("#" + '<%= d.ClientID %>').val($('#ddlmessageList').val().split("|")[2]);
            $("#" + '<%= droom.ClientID %>').val($('#ddlmessageList').val().split("|")[1]);
            //selectedMsgName
            $("#lblto").text($("#ddlmessageList option:selected").text());
            $("#blockdiv").show();
            $("#sendDiv").show();
        }

        function drawsvgpath(path)
        {
            var pathArray = path.split("-");
            var myMap = document.getElementById("SVG");
            //alert(myMap);
            var svgDoc = myMap.contentDocument;
            var canvas = svgDoc.getElementById("svg2");
            for (var i = 0; i < pathArray.length - 1 ; i++)
            {
              
                var myRoom = svgDoc.getElementById("Point" + pathArray[i]);
                var myRoom1 = svgDoc.getElementById("Point" + pathArray[i+1]);

                canvas.appendChild(SetLine(myRoom.getAttribute("cx"), myRoom.getAttribute("cy"),
                    myRoom1.getAttribute("cx"), myRoom1.getAttribute("cy"), "#008000", "#008000", "5", "4 4"));

            }
            

            
            //  alert(svgDoc);
           // var myRoom = svgDoc.getElementById(g);


        }
        function drawPath(src,des)
        {
             $.ajax({
                 type: "POST",
                 dataType: 'json',
                 contentType: "application/json; charset=utf-8",
                 url: "GetInterpreter.asmx/getMap",
                 data: "{'src' : '" + src + "'" + ",'des' : '" + des + "'}",
                 success: function (data) {

                     drawsvgpath(data.d);
                     //alert(data.d);
                  
                     //hdnCurrntsentID

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

        function checkCancle()
        {
            var oldID = parseInt($("#" + '<%= selectedMsg.ClientID %>').val());
            $.ajax({
                type: "POST",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                url: "GetMessages.asmx/CancelMessageResponse",
                data: "{'oldID' : '" + oldID + "'}",
                success: function (data) {
                    $("#reply tr").remove();
                   // alert(data.d);
                    if(data.d)
                    {
                         $("#selectRequest").show();
                         $("#resend").hide();
                         removePath();
                    }
                    // $("#selectRequest").show();
                    // $("#resend").hide();
                   


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

        function removePath()
        {
            var myMap = document.getElementById("SVG");
            //alert(myMap);
            var svgDoc = myMap.contentDocument;
            var canvas = svgDoc.getElementById("svg2");
            //  alert(svgDoc);

            var groups = canvas.getElementsByTagName("line");
            for (var i = 0; i < groups.length; i++) {
              
                    canvas.removeChild(groups[i]);
                

            }
        }

       

        function setCancelResponse()
        {
            window.setInterval(function () {

                checkCancle();
            }, 2000);
        }

        function sendReply()
        {
            var oldMsgID = parseInt($("#" + '<%= selectedMsg.ClientID %>').val());
            var msgText = $("#youReply").val() + " | Estimated time: " + (parseInt($("#youETA").val()) + 5);
            var sourceId = parseInt($("#" + '<%= hdnSource.ClientID %>').val());
            var desitinationID = parseInt($("#" + '<%= droom.ClientID %>').val());

            var desitinationempID = parseInt($("#" + '<%= d.ClientID %>').val());
            var sourceRoom = $("#" + '<%= hdnRoomId.ClientID %>').val();
                //

            //alert(oldMsgID);
           // alert(desitinationID);
           // alert(msgText);
            $.ajax({
                 type: "POST",
                 dataType: 'json',
                 contentType: "application/json; charset=utf-8",
                 url: "GetMessages.asmx/sendMessage",
                 data: "{'srcID' : '" + sourceId + "'" + ",'dstID' : '" + desitinationempID + "'" + ",'message' : '" + msgText + "'" + ",'oldmsgID' : '" + oldMsgID + "'}",
                 success: function (data) {

                     //alert(data.d);
                     $("#" + '<%= hdnCurrntsentID.ClientID %>').val($('#ddlmessageList').val());
                     $("#ddlmessageList option[value='" + $('#ddlmessageList').val() + "']").remove();
                     //hdnCurrntsentID
                     setCancelResponse();
                     drawPath(sourceRoom, desitinationID);

                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     if (textStatus == 'Unauthorized') {
                         alert('custom message. Error: ' + errorThrown);
                     } else {
                         alert('custom message. Error: ' + errorThrown);
                     }
                 }
             });

            $("#blockdiv").hide();
            $("#sendDiv").hide();

            $("#selectRequest").hide();
            $("#resend").show();
        }

        window.setInterval(function () {
            //   alert("hello there ")
            setMessages();
        }, 3000);


        function BindMesageDropDown(d)
        {
            for (var i = 0; i < d.length; i++) {

                var exists = false;
                var length = $('#ddlmessageList > option').length;
                var counter = 0;
                if (length != 0) {

                    $('#ddlmessageList option').each(function () {
                        if (this.value == d[i].EmployeId) {
                            counter = counter + 1;

                        }

                    });
                }
                if (counter == 0) {
                    $("#ddlmessageList").append($("<option></option>").val(d[i].MessageID + "|" + d[i].FromRoomID + "|" + d[i].SourceID).html(d[i].FromFirstName + ": " + d[i].MessageText));
                }

            }
        }

        function setMessages()
        {
              var source = parseInt( $("#" + '<%= hdnSource.ClientID %>').val());

            $.ajax({
                type: "POST",
                dataType: 'json',
                contentType: "application/json; charset=utf-8",
                url: "GetMessages.asmx/GetMessagesByUserID",
                data: "{'srcID' : '" + source  + "'}",
                success: function (data) {
                    var d = data.d;
                   // alert(d);
                    BindMesageDropDown(d);
                },
            });
        }

        window.onload = function () {

            $("#blockdiv").hide();
            $("#sendDiv").hide();
            $("#resend").hide();
            var hv = $("#" + '<%= hdnRoomId.ClientID %>').val();

            var g = GetRoomMyWay(hv);

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


            
        }

        function GetRoomMyWay(hv) {
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
    </script>

</asp:Content>