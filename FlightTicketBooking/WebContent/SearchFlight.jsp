<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">


<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">

<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.js"></script>
<title>SearchFlight</title>
<style type="text/css">

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
        list-style:none;/*无列表符号*/
        float:left;/*向右伸展*/
        margin:0px 60px 0px 0px;/*相邻列表之间的距离*/
    }
    /*左侧部分之超链接*/
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
<script>
	
</script>

</head>
<body>

	<div id="container">
		<div id="banner"></div>
		<div id="links"></div>
		<div id="content">
		<h1>Flight Ticket Searching</h1>
			<div id="content_left">
			   
				<form id="Passenger_login"
					class="form-group has-success has-feedback" action="./Booklog.jsp" method="POST">
             
					Passport Number: <input name="Passport_number" type="text" class="form-control"> 
					E-mail: <input name="Passenger_email" type="text" class="form-control">
					<br/>
					<button type="submit" class="btn btn-primary" id="User_login">Booking History</button>
				</form>
				<p>
					<font size=1 class="text-info">Enter in your passport number and e-mail
					 to view your booking history </font>
				</p>
				 <img src="EZpic.jpg"/>
			</div>

			<div id="content_right">
				<form id="Flight_search" class="form-group has-success has-feedback"
					action="./SearchResult.jsp" method="POST">

					Departure City: <input id="dept_city_for_search" type="text"
						name="dept_city" class="form-control"> Arrival City: <input
						id="arr_city_for_search" type="text" name="arr_city"
						class="form-control"> Departure Date:<input type="text"
						id="dept_date_for_search" class="form-control" name="dept_date">

					<div class="checkbox">

						<div>
							<input type="radio" id="nonestop" value="0"
								name="transfer_or_not">
							<p class="text-info">None-Stop</p>
						</div>
						<div>
							<input type="radio" id="onestop" value="1"
								name="transfer_or_not">
							<p class="text-info">One-Stop</p>
						</div>

					</div>
					<button id="flight_search_submit" type="submit"
						class="btn btn-primary">Search</button>
				</form>
			</div>

		</div>
	</div>
	<div id="footer"></div>



</body>
</html>