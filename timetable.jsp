<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<title>Floor Timetable</title>

<link rel="stylesheet" href="style.css">

<style>

body{
    font-family: Arial;
    text-align:center;

}

.slide{
    display:none;
}

table{
    margin:20px auto;
    border-collapse:collapse;
    width:70%;
}

th, td{
    border:1px solid black;
    padding:10px;
}

th{
    background:#007BFF;
    color:white;
}

.free{
    color:green;
    font-weight:bold;
}

.occupied{
    color:red;
    font-weight:bold;
}

button{
    padding:10px 20px;
    margin:20px;
}

</style>

</head>

<body class="timetable-page">

<%

String floor = request.getParameter("floor");
if(floor == null) floor = "1";

/* FIXED DATA */

String[] halls = {
"Hall 1",
"Hall 2",
"Hall 3"
};

String[] days = {
"Monday",
"Tuesday",
"Wednesday",
"Thursday",
"Friday"
};

/* FIXED TIMETABLE */

String[][][] timetable = {

/* Monday */

{
{"Math","C++","FREE"},
{"Python","FREE","English"},
{"FREE","Computer","DBMS"}
},

/* Tuesday */

{
{"Python","Math","FREE"},
{"English","FREE","Computer"},
{"FREE","DBMS","Java"}
},

/* Wednesday */

{
{"Math","Python","FREE"},
{"Computer","FREE","C++"},
{"FREE","English","DBMS"}
},

/* Thursday */

{
{"English","Math","FREE"},
{"C++","FREE","Python"},
{"FREE","Computer","Java"}
},

/* Friday */

{
{"DBMS","C++","FREE"},
{"Math","FREE","English"},
{"FREE","Computer","Python"}
}

};

out.println("<h2>Timetable for Floor " + floor + "</h2>");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con =
DriverManager.getConnection(
"jdbc:mysql://localhost:3306/cams_db",
"root",
""
);

/* LOOP DAYS */

for(int d=0; d<days.length; d++){

String day = days[d];

out.println("<div class='slide'>");

out.println("<h3>" + day + "</h3>");

out.println("<table>");

out.println(
"<tr>" +
"<th>Hall</th>" +
"<th>9-10</th>" +
"<th>10-11</th>" +
"<th>11-12</th>" +
"</tr>"
);

/* LOOP HALLS */

for(int h=0; h<halls.length; h++){

String hall = halls[h];

out.println("<tr>");
out.println("<td>" + hall + "</td>");

/* LOOP SLOTS */

for(int s=0; s<3; s++){

String value =
timetable[d][h][s];

/* CHECK DATABASE */

PreparedStatement ps =
con.prepareStatement(
"SELECT status FROM classroom_status WHERE floor=? AND day=? AND hall=? AND slot=?"
);

ps.setString(1,floor);
ps.setString(2,day);
ps.setString(3,hall);
ps.setInt(4,s);

ResultSet rs =
ps.executeQuery();

String status = "FREE";

if(rs.next()){
status = rs.getString("status");
}

rs.close();
ps.close();

/* DISPLAY */

if(value.equals("FREE")){

if(status.equals("BUSY")){

out.println(
"<td>" +
"<a href='manage_status.jsp?" +
"floor=" + floor +
"&day=" + day +
"&hall=" + hall +
"&slot=" + s +
"'>" +
"<span class='occupied'>" +
"Occupied" +
"</span>" +
"</a>" +
"</td>"
);

}
else{

out.println(
"<td>" +
"<a href='manage_status.jsp?" +
"floor=" + floor +
"&day=" + day +
"&hall=" + hall +
"&slot=" + s +
"'>" +
"<span class='free'>" +
"FREE" +
"</span>" +
"</a>" +
"</td>"
);

}

}
else{

out.println("<td>" + value + "</td>");

}

}

out.println("</tr>");

}

out.println("</table>");
out.println("</div>");

}

con.close();

%>

<button onclick="changeSlide(-1)">
Previous
</button>

<button onclick="changeSlide(1)">
Next
</button>

<script>

let slideIndex = 0;

showSlide(slideIndex);

function showSlide(n){

let slides =
document.getElementsByClassName("slide");

for(let i=0;i<slides.length;i++){
slides[i].style.display = "none";
}

slides[n].style.display = "block";

}

function changeSlide(n){

let slides =
document.getElementsByClassName("slide");

slideIndex += n;

if(slideIndex >= slides.length)
slideIndex = 0;

if(slideIndex < 0)
slideIndex = slides.length - 1;

showSlide(slideIndex);

}

</script>

</body>
</html>