<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>

<title>Login</title>

<link rel="stylesheet" href="style.css">

</head>

<body class="login-page">

<div class="center-wrapper">

<div class="login-box">

<h2>Login</h2>

<%

String email = request.getParameter("email");
String password = request.getParameter("password");

if(email != null && password != null){

    try{

        String dbURL = "jdbc:mysql://localhost:3306/cams_db";
        String dbUser = "root";
        String dbPass = "";

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection con =
        DriverManager.getConnection(
        dbURL,
        dbUser,
        dbPass
        );

        PreparedStatement ps =
        con.prepareStatement(
        "SELECT * FROM users WHERE email=? AND password=?"
        );

        ps.setString(1,email);
        ps.setString(2,password);

        ResultSet rs =
        ps.executeQuery();

        if(rs.next()){

            session.setAttribute(
            "email",
            email
            );

            response.sendRedirect(
            "dashboard.jsp"
            );

        }
        else{

            out.println(
            "<p style='color:red'>Invalid Login</p>"
            );

        }

        rs.close();
        ps.close();
        con.close();

    }

    catch(Exception e){

        out.println(
        "<p style='color:red'>Error: "
        + e.getMessage()
        + "</p>"
        );

    }

}

%>

<form method="post" action="login.jsp">

<input
type="email"
name="email"
placeholder="Enter Email"
required>

<input
type="password"
name="password"
placeholder="Enter Password"
required>

<button class="btn" type="submit">

Login

</button>

</form>

</div>

</div>

</body>
</html>