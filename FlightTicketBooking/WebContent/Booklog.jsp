<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="java.sql.*"%>
<%
	Connection conn= null;
	ResultSet  rset=null;
	String error_msg="";
	String Passport_number=request.getParameter("Passport_number");
	System.out.println(Passport_number);	
	String Passenger_email=request.getParameter("Passenger_email");

	System.out.println("passing param");	
	try{
		if (conn == null) {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager
					.getConnection(
							"jdbc:mysql://cs4111.cf7twhrk80xs.us-west-2.rds.amazonaws.com:3306/cs4111",
							"sd2810", "26842810");
			System.out.println("connecting");		
		}
		String sqlstmt="select T.depart_airport,T.arrive_airport,Tc.airline, Tc.flight_number, Tc.depart_time  from Trip T ,Trip_consists Tc where T.tripid=Tc.tripid and T.tripid in (select tripid from Book_trip where passport_number=?) ";
		PreparedStatement stmt=conn.prepareStatement(sqlstmt);
		stmt.setString(1,Passport_number);
		rset=stmt.executeQuery();
		System.out.println("query done");	


}catch(SQLException e){
	error_msg = e.getMessage();
	if( conn != null ) {
	conn.close();
	}
	
}
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
@import
"bootstrap.css";
</style>
<title>Insert title here</title>
</head>
<body>
	 <table class='table table-bordered'>
	 <thead>
	 <tr><td class='text-info'>Depart Airport</td><td class='text-info'>Arrive Airport</td><td class='text-info'>Airline</td><td class='text-info'>Flight Number</td><td class='text-info'>Depart Time</td></tr>
	 </thead>
<%
	while(rset.next()){
	out.print( "<tr><td class='text-primary'>"+rset.getString(1)+"</td><td class='text-primary'>"+rset.getString(2)+"</td><td class='text-primary'>"+rset.getString(3)+"</td><td class='text-primary'>"+rset.getString(4)+"</td><td class='text-primary'>"+rset.getString(5)+"</td></tr>");
	 
}
%>
</table>


</body>
</html>