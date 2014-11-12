<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%
Connection conn = null;
ResultSet rset = null;
String error_msg ="";
String Tripid = request.getParameter("Tripid");
String Airline = request.getParameter("Airline");
String Flight_number = request.getParameter("Flight_number");
String Dept_time = request.getParameter("Dept_time");

System.out.println("departtime: "+Dept_time);	
System.out.println("passing param");		
try {

	if (conn == null) {
	
		// Edit the following to use your endpoint, database name,
		// username, and password
		Class.forName("com.mysql.jdbc.Driver");

		conn = DriverManager
				.getConnection(
						"jdbc:mysql://cs4111.cf7twhrk80xs.us-west-2.rds.amazonaws.com:3306/cs4111",
						"sd2810", "26842810");
		System.out.println("connecting");		
	}

	String sqlstmt="select T.economy_price, T.business_price,T.first_class_price "+
			"from Trip T "+ 
			"where T.tripid = "+
			"(select tripid "
			+"from Trip_consists "
			+"where airline=? and flight_number=? and depart_time=?) ";
	System.out.println(sqlstmt);
PreparedStatement stmt = conn.prepareStatement(sqlstmt);
stmt.setString(1, Airline);
stmt.setString(2, Flight_number);
stmt.setString(3, Dept_time);
rset = stmt.executeQuery();
System.out.println("Query done");	


System.out.println("getting result from db");		

} catch (SQLException e) {
error_msg = e.getMessage();
if( conn != null ) {
conn.close();
}
}
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
@import
"bootstrap.css";
 body{
        margin:0px;
        padding:0px;
        text-align:center;
        background:#e9fbff;
    }
    #container{
        position:relative;
        margin:0 auto;
        padding:0px;
        width:900px;
        text-align:left;
        background:url(container_bg.jpg)  repeat-y;
    }
    #banner{
        margin:0px;
        padding:0px;
        width:900px;
    }
    #banner img{
        height:50px;
        width:900px;
    }
    #links{
        font-size:20px;
        margin:-15px 0px 0px 0px;
        padding:0px;
        position:relative;
        background-color:#afdcff;
    }
    #links li{
        list-style:none;
        float:left;
        margin:0px 60px 0px 0px;
    }

    #links a:link, #nav a:visited{
        text-decoration:none;
        color:#2a4f6f;
        background-color:transparent;
    }
    
    #content{
        margin:50px 0px 0px 0px;
        width:900px;
    }
    #content_left{
        width:150px;
        position:absolute;
        top:80px;
        left:0px;
        background-color:#afdcff;
    }
    #content_left img{
        width:100px;
        height:100px;
         
        border:1px solid #0073cc;
        margin-bottom:5px;
        text-align:center;
    }
    #content_left h3{
        text-align:center;
        margin-top:0px;
    }
    #content_left p{
        text-align:justify;
        padding:0px 10px 0px 10px;
    }
    #content_right{
        left-padding:20px;
        position:absolute;
        top:80px;
        right:300px;
        width:300px;
        background-color:#afdcff;
    }
    #content_right h3{
        margin-top:10px;
        text-align:left;
    }
    #footer{
 
        width:900px;
        text-align:center;
    }

</style>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">


<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("button#Confirm").click(function(){
		var sendinfo={"Seattype": $("input[name=Seattype]:checked").val(),"Name": $("input[name=Name]").val(),"Passport": $("input[name=Passport]").val(),"Email":$("input[name=Email]").val(),"Phone":$("input[name=Phone]").val(),"Tripid":"<%=Tripid%>","Airline":"<%=Airline%>","Flightnumber":"<%=Flight_number%>","Depttime":"<%=Dept_time%>"};

		alert("click");
	
		$.ajax({
			url : "${pageContext.request.contextPath}/Book",
			type : "post",
			data : sendinfo,
			dataType : "html",
			success : function() {
				 alert("Ticket is reserved! Congrats!");
				//$("#content_rightup").html(data);
				//$(this).parent().parent().siblings("#Detail").html(data);	
			},
			error : function() {
				alert("into error");
				//$(this).parent().parent().siblings("#Detail").html("XXX");
			},

		});
		return false;
	});
});





</script>

</head>
<body>
<div id="container">
<div id="banner">
</div>
<div id="content">

<div id="content_right" >
<form id="Book_info"  class="form-group has-success has-feedback">
<p class="text-info">Choose your seat class</p>

<% 

while(rset.next()){

out.print(
"<input name='Seattype' type='radio' class='text-info' value='1'>Econ_seat<strong class='text-info'> Price:"+rset.getString(1)+"</strong><br/>"
+"<input name='Seattype' type='radio' class='text-info' value='2'>Busi_seat<strong class='text-info'> Price:" +rset.getString(2)+"</strong><br/>"
+"<input name='Seattype' type='radio' class='text-info' value='3'>First_seat<strong class='text-info'> Price:" + rset.getString(3)+ "</strong><br/>"
);
}

%>
Your Name<input name="Name" type="text" class="form-control">
Your Phone Number<input name="Phone" type="text" class="form-control">
Your PassPort Number<input name="Passport" type="text" class="form-control">
Your Email<input name="Email" type="text" class="form-control"><br/>
<button id = "Confirm" class='btn btn-primary' type="button">Confirm</button>
<a class='btn btn-primary' type="button" href="./Page1.jsp">Back to Search</a>
</form>

</div>
<div id="content_left">


</div>


</div>

</div>

</body>
</html>