<!DOCTYPE html>
<html>
<head>

<title>Dashboard</title>

<link rel="stylesheet" href="style.css">

</head>

<body class="dashboard-page">

<div class="container slide">

<h1>Welcome to Classroom Availability System</h1>

<div class="card">

<h2>Select Floor</h2>

<div class="floor-buttons">

<form action="timetable.jsp" method="get">
<input type="hidden" name="floor" value="1">
<button type="submit">
First Floor
</button>
</form>

<form action="timetable.jsp" method="get">
<input type="hidden" name="floor" value="2">
<button type="submit">
Second Floor
</button>
</form>

<form action="timetable.jsp" method="get">
<input type="hidden" name="floor" value="3">
<button type="submit">
Third Floor
</button>
</form>

</div>

<br>

<form action="login.jsp">

<button>
Logout
</button>

</form>

</div>

</div>

</body>
</html>