<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
Connection conn = null;
ResultSet rset = null;
String error_msg = "";
String dept_city = request.getParameter("dept_city");
String arr_city = request.getParameter("arr_city");
String dept_date = request.getParameter("dept_date");
System.out.println(dept_city);
System.out.println(arr_city);
System.out.println(dept_date);
int transfer_or_not = Integer.parseInt(request.getParameter("transfer_or_not"));
System.out.println("transfer_or_not");	
System.out.println(transfer_or_not);

if(transfer_or_not==0) {
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

String sqlstmt = "SELECT T.tripid,F.airline,F.flight_number,A1.city,F.depart_airport,F.depart_time,A2.city,F.arrive_airport,"
		+ "F.arrive_time,T.economy_price,T.business_price,T.first_class_price,F.duration_time,F.type,F.economy_available_number,F.business_available_number,F.first_class_available_number "
		+ "FROM Trip T,Airport A1,Airport A2,Trip_consists Tc, Flight F "
		+ "WHERE F.depart_airport=A1.airport AND F.arrive_airport=A2.airport AND A1.city=? AND A2.city=? AND "
		+ "T.tripid=Tc.tripid AND F.flight_number=Tc.flight_number AND F.airline=Tc.airline AND F.depart_time=Tc.depart_time AND "
		+ "T.depart_airport=F.depart_airport and T.arrive_airport=F.arrive_airport AND "
		+ "F.depart_time LIKE ?;";
		


PreparedStatement stmt = conn.prepareStatement(sqlstmt);
stmt.setString(1, dept_city);
stmt.setString(2, arr_city);
stmt.setString(3, dept_date+" __:__:__");
System.out.println(stmt);
rset = stmt.executeQuery();
System.out.println("getting result from db");
} catch (SQLException e) {
System.out.println("error coming.");
error_msg = e.getMessage();
System.out.println(error_msg);
if( conn != null ) {
conn.close();
}
}
}
else{
	try {
		if (conn == null) {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager
					.getConnection(
							"jdbc:mysql://cs4111.cf7twhrk80xs.us-west-2.rds.amazonaws.com:3306/cs4111",
							"sd2810", "26842810");
			System.out.println("connecting");		
		}

	String sqlstmt = "SELECT T.tripid,F1.airline,F1.flight_number,A1.city,F1.depart_airport,F1.depart_time,A3.city,F1.arrive_airport,"
			+ "F1.arrive_time,F2.airline,F2.flight_number,A3.city,F2.depart_airport,F2.depart_time,A2.city,"
			+ "F2.arrive_airport,F2.arrive_time,"
			+ "T.economy_price,"
			+ "T.business_price,"
			+ "T.first_class_price "
			+ "FROM Flight F1,Flight F2,Trip_consists S1,Trip_consists S2,Trip T,Airport A1,Airport A2,Airport A3 "
			+ "WHERE T.tripid=S1.tripid AND T.tripid=S2.tripid AND "
			+ "S1.flight_number=F1.flight_number AND S1.airline=F1.airline AND S1.depart_time=F1.depart_time AND "
			+ "S2.flight_number=F2.flight_number AND S2.airline=F2.airline AND S2.depart_time=F2.depart_time AND "
			+ "F1.arrive_time<F2.depart_time AND F1.depart_time LIKE ? AND A3.airport=F1.arrive_airport AND "
			+ "A1.airport=F1.depart_airport AND A1.city=? AND A2.airport=F2.arrive_airport AND A2.city=?;";
	
	PreparedStatement stmt = conn.prepareStatement(sqlstmt);
	stmt.setString(1, dept_date+" __:__:__");
	stmt.setString(2, dept_city);
	stmt.setString(3, arr_city);
	rset = stmt.executeQuery();
	System.out.println("getting result from db");		
	} catch (SQLException e) {
		System.out.println("error is coming");
	error_msg = e.getMessage();
	System.out.println(error_msg);
	if( conn != null ) {
	conn.close();
	}
	}
}

%>
  

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Searching Result</title>
<style type="text/css">


 body{
        margin:50px;
        padding:0px;
        text-align:left;
        background:#e9fbff;
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
	$("button[name=detail1]").click(function() {
		var sendinfo= {"tripid":$(this).parent().siblings("td").eq(0).text(),
				"airline":$(this).parent().siblings("td").eq(1).text(),
				"flight_number":$(this).parent().siblings("td").eq(2).text(),
				"depart_city":$(this).parent().siblings("td").eq(3).text(),
				"depart_airport":$(this).parent().siblings("td").eq(4).text(),
				"depart_time":$(this).parent().siblings("td").eq(5).text(),
				"arrive_city":$(this).parent().siblings("td").eq(6).text(),
				"arrive_airport":$(this).parent().siblings("td").eq(7).text(),
				"arrive_time":$(this).parent().siblings("td").eq(8).text(),
				"economy_price":$(this).parent().siblings("td").eq(9).text(),
				"business_price":$(this).parent().siblings("td").eq(10).text(),
				"first_class_price":$(this).parent().siblings("td").eq(11).text(),
				"duration_time":$(this).parent().siblings("td").eq(12).text(),
				"type":$(this).parent().siblings("td").eq(13).text(),
				"economy_number":$(this).parent().siblings("td").eq(14).text(),
				"business_number":$(this).parent().siblings("td").eq(15).text(),
				"first_class_number":$(this).parent().siblings("td").eq(16).text()
				};
		//alert($(this).parent().siblings("#testtr").attr("value"));
		$.ajax({

			url : "${pageContext.request.contextPath}/FlightDetail",

			type : "post",

			data : sendinfo,

			dataType : "html",

			success : function(data) {

				$("#content").html(data);
				//$(this).parent().parent().siblings("#Detail").html(data);	
			
			},

			error : function(request, status, error) {
				alert("into error");
				alert(request.responseText);
				$(this).parent().parent().siblings("#detail1").html("XXX");


			},

		});

return false;
		
		
	});
	$("button[name=detail2]").click(function() {
		var sendinfo= {"tripid":$(this).parent().siblings("td").eq(0).text(),
				"airline":$(this).parent().siblings("td").eq(1).text(),
				"flight_number":$(this).parent().siblings("td").eq(2).text(),
				"depart_city":$(this).parent().siblings("td").eq(3).text(),
				"depart_airport":$(this).parent().siblings("td").eq(4).text(),
				"depart_time":$(this).parent().siblings("td").eq(5).text(),
				"arrive_city":$(this).parent().siblings("td").eq(6).text(),
				"arrive_airport":$(this).parent().siblings("td").eq(7).text(),
				"arrive_time":$(this).parent().siblings("td").eq(8).text(),
				"economy_price":$(this).parent().siblings("td").eq(9).text(),
				"business_price":$(this).parent().siblings("td").eq(10).text(),
				"first_class_price":$(this).parent().siblings("td").eq(11).text(),
				"duration_time":$(this).parent().siblings("td").eq(12).text(),
				"type":$(this).parent().siblings("td").eq(13).text(),
				"economy_number":$(this).parent().siblings("td").eq(14).text(),
				"business_number":$(this).parent().siblings("td").eq(15).text(),
				"first_class_number":$(this).parent().siblings("td").eq(16).text()
				};
		//alert($(this).parent().siblings("#testtr").attr("value"));
		$.ajax({

			url : "${pageContext.request.contextPath}/FlightDetail",

			type : "post",

			data : sendinfo,

			dataType : "html",

			success : function(data) {

				$("#content").html(data);
				//$(this).parent().parent().siblings("#Detail").html(data);	
			
			},

			error : function(request, status, error) {
				alert("into error");
				alert(request.responseText);
				$(this).parent().parent().siblings("#detail1").html("XXX");


			},

		});

return false;
		
		
	});
});


</script>
</head>
<body>

<div class="container" style="margin-top:50px;background-color:#e9fbff">
    <h2 class="text-info"> Searching Results </h2>
	<table class='table'>
<%
	if(transfer_or_not==0){
		%>
	<tr>
	<td class="text-info">Trip ID</td>
	<td class='text-info' >Airline</td>
	<td class='text-info' >Flight Number</td>
	<td class='text-info'>Departure City</td>
	<td class='text-info'>Departure Airport</td>
	<td class='text-info'>Departure Time</td>
	<td class='text-info'>Arrival City</td>
	<td class='text-info'>Arrival Airport</td>
	<td class='text-info'>Arrival Time</td>
	<td class='text-info'>Economy Price</td>
	<td class='text-info'>Business Price</td>
	<td class='text-info'>First Class Price</td>
	<td class='text-info'>Detail</td>
	</tr>
<% 
	if(rset != null){
		System.out.println("rset not null");		
		
		while(rset.next()){

			%>
	<tr>
	<td class='text-primary'><% out.print(rset.getString(1)); %></td>
	<td class='text-primary'><% out.print(rset.getString(2));%></td>
	<td class='text-primary'><% out.print(rset.getString(3)); %></td>
	<td class='text-primary'><% out.print(rset.getString(4)); %></td>
	<td class='text-primary'><% out.print(rset.getString(5)); %></td>
	<td class='text-primary'><% out.print(rset.getString(6).split("\\.")[0]);%></td>
	<td class='text-primary'><% out.print(rset.getString(7)); %></td>
	<td class='text-primary'><% out.print(rset.getString(8)); %></td>
	<td class='text-primary'><% out.print(rset.getString(9).split("\\.")[0]); %></td>
	<td class='text-primary'><% out.print(rset.getString(10)); %></td>
	<td class='text-primary'><% out.print(rset.getString(11)); %></td>
	<td class='text-primary'><% out.print(rset.getString(12)); %></td>
	<td class='text-primary hidden'><% out.print(rset.getString(13)); %></td>
	<td class='text-primary hidden'><% out.print(rset.getString(14)); %></td>
	<td class='text-primary hidden'><% out.print(rset.getString(15)); %></td>
	<td class='text-primary hidden'><% out.print(rset.getString(16)); %></td>
	<td class='text-primary hidden'><% out.print(rset.getString(17)); %></td>
	<td><button name='detail1' type='button' class='btn btn-primary'>Detail</button></td>
	</tr>
<%
		}
			
				
	}

} else {
		%>
		<tr>
	<td class='text-info' >Trip ID</td>
	<td class='text-info' >Airline</td>
	<td class='text-info' >Flight Number</td>
	<td class='text-info'>Departure City</td>
	<td class='text-info'>Departure Airport</td>
	<td class='text-info'>Departure Time</td>
	<td class='text-info'>Arrival City</td>
	<td class='text-info'>Arrival Airport</td>
	<td class='text-info'>Arrival Time</td>
	<td class='text-info' >Airline</td>
	<td class='text-info' >Flight Number</td>
	<td class='text-info'>Departure City</td>
	<td class='text-info'>Departure Airport</td>
	<td class='text-info'>Departure Time</td>
	<td class='text-info'>Arrival City</td>
	<td class='text-info'>Arrival Airport</td>
	<td class='text-info'>Arrival Time</td>
	<td class='text-info'>Economy Price</td>
	<td class='text-info'>Business Price</td>
	<td class='text-info'>First Class Price</td>
	<td class='text-info'>Detail</td>
	</tr>
	<% 
	if(rset != null){
		System.out.println("rset not null");		
		
		while(rset.next()){
			
			%>
	<tr>
	<td class='text-primary'> <% out.print(rset.getString(1)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(2));%> </td>
	<td class='text-primary'> <% out.print(rset.getString(3)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(4)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(5)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(6).split("\\.")[0]);%> </td>
	<td class='text-primary'> <% out.print(rset.getString(7)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(8)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(9).split("\\.")[0]); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(10)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(11)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(12)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(13)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(14).split("\\.")[0]);%> </td>
	<td class='text-primary'> <% out.print(rset.getString(15)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(16)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(17).split("\\.")[0]); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(18)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(19)); %> </td>
	<td class='text-primary'> <% out.print(rset.getString(20)); %> </td>
	<td><button name='detail2' type='button' class='btn btn-primary'>Detail</button></td>
	</tr>
		
<% }
	}
		
}

%>
	</table>
	
</div>
</div>
</body>
</html>
