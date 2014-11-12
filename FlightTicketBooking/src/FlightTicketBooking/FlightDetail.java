package FlightTicketBooking;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.*;
/**
 * Servlet implementation class Flight_detail
 */
@WebServlet("/FlightDetail")
public class FlightDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Connection conn;
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException cnfe) {
		}
	}

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlightDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter pw = response.getWriter();
		String tripid=request.getParameter("tripid");
		String airline=request.getParameter("airline");
		String flight_number=request.getParameter("flight_number");
		String depart_city=request.getParameter("depart_city");
		String depart_airport=request.getParameter("depart_airport");
		String depart_time=request.getParameter("depart_time");
		String arrive_city=request.getParameter("arrive_city");
		String arrive_airport=request.getParameter("arrive_airport");
		String arrive_time=request.getParameter("arrive_time");
		String economy_price=request.getParameter("economy_price");
		String business_price=request.getParameter("business_price");
		String first_class_price=request.getParameter("first_class_price");
		String duration_time=request.getParameter("duration_time");
		String type=request.getParameter("type");
		String economy_number=request.getParameter("economy_number");
		String business_number=request.getParameter("business_number");
		String first_class_number=request.getParameter("first_class_number");
		System.out.println(duration_time);
		String e="";
		String b="";
		String f="";
		if (Integer.parseInt(economy_number)<=0){
			e="disabled";
		}
		if (Integer.parseInt(business_number)<=0){
			b="disabled";
		}
		if (Integer.parseInt(first_class_number)<=0){
			f="disabled";
		}
		String result="<table class='table table-bordered'>"
				+"<tr><td>Trip ID</td><td>"+tripid+"</td></tr></table>";
		/**
				+"<h5>Airline:"+airline+"</h5>"
				+"<h5>Flight Number:"+flight_number+"</h5>"
				+"<h5>Departure City:"+depart_city+"</h5>"
				+"<h5>Departure Airport:"+depart_airport+"</h5>"
				+"<h5>Departure Time:"+depart_time+"</h5>"
				+"<h5>Arrival City:"+arrive_city+"</h5>"
				+"<h5>Arrival Airport:"+arrive_airport+"</h5>"
				+"<h5>Arrival Time:"+arrive_time+"</h5>"
				+"<h5>Duration Time:"+String.valueOf(Integer.valueOf(duration_time)/60)+"hours "+String.valueOf(Integer.parseInt(duration_time)%60)+"minutes</h5>"
				+"<h5>Aircraft:"+type+"</h5>"
				+"<h5>Economy Seat Price:"+economy_price+"</h5>"
				+"<h5>Economy Seat Number:"+economy_number+"</h5>"
				+"<h5>Business Seat Price:"+business_price+"</h5>"
				+"<h5>Business Seat Number:"+business_number+"</h5>"
				+"<h5>First Class Seat Price:"+first_class_price+"</h5>"
				+"<h5>First Class Seat Number:"+first_class_number+"</h5>"
				
				+"<form id='flight_detail' class='form-group has-success has-feedback' action='./Book' method='POST'>"
				+"Passenger Name: <input id='passenger_name' type='text' name='passenger_name' class='form-control'>"
				+"Passport Number: <input id='passport_number' type='text' name='passport_number' class='form-control'>"
				+"E-mail: <input id='email' type='text' name='email' class='form-control'>"
				+"Phone Number: <input id='phone_number' type='text' name='phone_number' class='form-control'>"
				+"<div class='checkbox'><div><input type='radio' id='economy' value='0' name='class' "+e+"><p>Economy Class</p></div>"
				+"<div><input type='radio' id='business' value='1' name='class' "+b+"><p>Business Class</p></div>"
				+"<div><input type='radio' id='first' value='2' name='class' "+f+"><p>First Class</p></div></div>"
				+"<button id='book_ticket' type='submit' class='btn btn-primary'>Book</button></form>";
				**/
		pw.print(result);
		pw.close();
		
		
		/**
		String Airline = request.getParameter("Airline");
		String Flight_number = request.getParameter("Flightnumber");
		String Dept_time = request.getParameter("Depttime");
		System.out.println("depttime:"+Dept_time);
		PrintWriter pw = response.getWriter();
		System.out.println("load form variables");
		try {
			if (conn == null) {
				// Edit the following to use your endpoint, database name,
				// username, and password
				conn = DriverManager
						.getConnection(
								"jdbc:mysql://cs4111.cf7twhrk80xs.us-west-2.rds.amazonaws.com:3306/cs4111",
								"sd2810", "26842810");
				System.out.println("connecting to db");
			}
			
			
			
			String sqlstmt="select T.economy_price, T.business_price,T.first_class_price, "
					+ "F.economy_available_number,F.business_available_number, F.first_class_available_number "+
					"from Trip T, Flight F "+ 
					"where T.tripid = "+
					"(select tripid "
					+"from Trip_consists "
					+"where airline=? and flight_number=? and depart_time=?) and "
					+" F.airline=? and F.flight_number=? and F.depart_time=? ";
			
			PreparedStatement stmt = conn.prepareStatement(sqlstmt);
			stmt.setString(1, Airline);
			stmt.setString(2, Flight_number);
			stmt.setString(3, Dept_time);
			stmt.setString(4, Airline);
			stmt.setString(5, Flight_number);
			stmt.setString(6, Dept_time);
			ResultSet rset = stmt.executeQuery();
			String Result="";
			String Econ_price="";
			String Busi_price="";
			String First_price="";
			String Econ_available_number="";
			String Busi_available_number="";
			String First_available_number="";
			
			while(rset.next()){
			 Econ_price=rset.getString(1);
			 Busi_price=rset.getString(2);
			 First_price=rset.getString(3);
			 Econ_available_number=rset.getString(4);
			 Busi_available_number=rset.getString(5);
			 First_available_number=rset.getString(6);

			}
			
			Result="<table class='table table-bordered'>"
					+ "<tr><td class='text-primary'> Econ_price</td>"+ "<td class='text-primary'>Econ_available_number</td>"
					+ "<td class='text-primary'>"+ "Busi_price</td>"	+ "<td class='text-primary'>Busi_available_number</td>"
					+ "<td class='text-primary'>First_price</td>"   +	"<td class='text-primary'> First_available_number</td></tr>";
				
				
			Result=Result+"<tr><td class='text-primary'>"+Econ_price+"</td><td class='text-primary'>"+Econ_available_number+"</td><td class='text-primary'>"+Busi_price+"</td>"
					+"<td class='text-primary'>"+Busi_available_number+"</td><td class='text-primary'>"+First_price+"</td>"
					+"<td class='text-primary'>"+ First_available_number+"</td></tr></table>";
			
		
			pw.print(Result);
			System.out.println("writeback");
	}catch (SQLException e) {
		pw.println(e.getMessage());
	}
	pw.close();
	**/

}
	
}
	
	
