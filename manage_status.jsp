<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Status</title>

<link rel="stylesheet" href="style.css">

<style>

body{
    font-family: Arial;
    text-align: center;
}

.container{
    width: 40%;
    margin: auto;
    margin-top: 80px;
    background:#b39ddb;
    padding: 25px;
    border-radius: 10px;
}

select{
    padding: 10px;
    width: 60%;
    font-size: 16px;
}

button{
    padding: 10px 25px;
    margin-top: 20px;
    font-size: 16px;
    cursor: pointer;
}

</style>

</head>

<body class="manage-page">

<%

String floor = request.getParameter("floor");
String day   = request.getParameter("day");
String hall  = request.getParameter("hall");
String slot  = request.getParameter("slot");

/* WHEN UPDATE BUTTON IS CLICKED */

if(request.getParameter("status") != null){

String status = request.getParameter("status");

Connection con = null;

try{

Class.forName("com.mysql.cj.jdbc.Driver");

con =
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/cams_db",
"root",
""
);

/* CHECK IF RECORD EXISTS */

PreparedStatement check =
con.prepareStatement(
"SELECT id FROM classroom_status WHERE floor=? AND day=? AND hall=? AND slot=?"
);

check.setString(1,floor);
check.setString(2,day);
check.setString(3,hall);
check.setString(4,slot);

ResultSet rs =
check.executeQuery();

if(rs.next()){

/* UPDATE EXISTING */

PreparedStatement update =
con.prepareStatement(
"UPDATE classroom_status SET status=? WHERE floor=? AND day=? AND hall=? AND slot=?"
);

update.setString(1,status);
update.setString(2,floor);
update.setString(3,day);
update.setString(4,hall);
update.setString(5,slot);

update.executeUpdate();

update.close();

}
else{

/* INSERT NEW (id auto-generated) */

PreparedStatement insert =
con.prepareStatement(
"INSERT INTO classroom_status (floor, day, hall, slot, status) VALUES (?,?,?,?,?)"
);

insert.setString(1,floor);
insert.setString(2,day);
insert.setString(3,hall);
insert.setString(4,slot);
insert.setString(5,status);

insert.executeUpdate();

insert.close();

}

rs.close();
check.close();

con.close();

/* GO BACK TO TIMETABLE */

response.sendRedirect(
"timetable.jsp?floor=" + floor
);

return;

}
catch(Exception e){

out.println("<h3>Error:</h3>");
out.println(e.getMessage());

}

}

%>

<div class="container">

<h2>Manage Status</h2>

<p>

Floor:
<b><%= floor %></b>

<br><br>

Day:
<b><%= day %></b>

<br><br>

Hall:
<b><%= hall %></b>

<br><br>

Slot:
<b><%= slot %></b>

</p>

<form method="post">

<input type="hidden" name="floor" value="<%= floor %>">
<input type="hidden" name="day" value="<%= day %>">
<input type="hidden" name="hall" value="<%= hall %>">
<input type="hidden" name="slot" value="<%= slot %>">

<br>

<select name="status">

<option value="BUSY">
Occupied
</option>

<option value="FREE">
Free
</option>

</select>

<br>

<button type="submit">

Update Status

</button>

</form>

</div>

</body>
</html>