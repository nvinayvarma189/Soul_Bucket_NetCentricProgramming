<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Insert title here</title>
<%@page import="java.sql.*"%>
</head>
<body>


<% 
String connectionURL = "jdbc:mysql://localhost/test"; 
Connection connection = null; 
Class.forName("com.mysql.jdbc.Driver").newInstance();
%>

<table border="1">
<tr>
<td>ID</td>
<td>Name</td>

</tr>

<% 
try {
connection = DriverManager.getConnection(connectionURL, "roronoa_mysql", "Livingisfine@189");

out.println("Successfully connected to " + "MySQL server using TCP/IP...");

Statement statement = null;
ResultSet resultSet = null;

statement=connection.createStatement();
String sql ="select * from student";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>

<tr>
<td><%=resultSet.getString("id") %></td>
<td><%=resultSet.getString("name") %></td>
</tr>
<%
	}

}

catch(Exception ex){
out.println(ex);
}
%>

</table>
</body>
</html>