<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,javax.servlet.*,javax.servlet.http.*"%>

<%
String First_name=request.getParameter("First_name");
String Last_name=request.getParameter("Last_name");
String Phn_number=request.getParameter("Phn_number");
String Email=request.getParameter("Email");
String Password=request.getParameter("Password");

try
{
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/SoulBucket?useSSL=false", "roronoa_mysql", "Livingisfine@189");
Statement st=conn.createStatement();

int i=st.executeUpdate("insert into user_details(f_name,l_name,phone_num,email, password)values('"+First_name+"','"+Last_name+"','"+Phn_number+"','"+Email+"','"+Password+"')");
out.println("Data is successfully inserted!");
}
catch(Exception e)
{
System.out.print(e);
e.printStackTrace();
}
%>