<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Initialize login status
    String loginStatus = "";
    
    // Default admin credentials
    String defaultAdminUsername = "Sanju";
    String defaultAdminPassword = "Sanju123";

    // Check if the form has been submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Check if the entered credentials match the default admin credentials
        if (username.equals(defaultAdminUsername) && password.equals(defaultAdminPassword)) {
            response.sendRedirect("adminDashboard.jsp"); // Redirect to admin dashboard
        } else {
            // Database connection details
            String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect"; // Replace with your database name
            String dbUser = "root"; // Replace with your database username
            String dbPassword = "Tejasri@2004"; // Your database password

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                
                // Update the SQL query to match the correct table
                String sql = "SELECT * FROM farmer WHERE username = ? AND password = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, username);
                statement.setString(2, password);
                ResultSet resultSet = statement.executeQuery();
                
                // If a match is found, redirect to the student's dashboard
                if (resultSet.next()) {
                    response.sendRedirect("farmerDashboard.jsp?username=" + username);
                } else {
                    loginStatus = "Invalid username or password!";
                }

                resultSet.close();
                statement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                loginStatus = "Database error occurred!";
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Login </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Add your CSS styling here */
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">farmer login</h2>
        <form action="framerlogin.jsp" method="post">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Login</button>
            </div>
            <div class="text-danger text-center mt-2">
                <%= loginStatus %>
            </div>
        </form>
        <p class="text-center mt-3">Don't have an account? <a href="signup.jsp">Sign Up</a></p>
    </div>
</body>
</html>