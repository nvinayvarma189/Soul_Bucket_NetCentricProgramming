package com.soulbucket.pkg;

import java.io.IOException;

import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

public class LoginController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Email=request.getParameter("Email");
		String Password=request.getParameter("Password");

		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/SoulBucket?useSSL=false", "username", "password"); // gets a new connection
			
			PrintWriter out = response.getWriter();
			Statement st=conn.createStatement();
			ResultSet rs = null;
			String sql = "Select * from user_details Where email='" + Email + "' and password='" + Password + "'";
			
			rs = st.executeQuery(sql);
			
			if (rs.next()) {
				HttpSession session=request.getSession(); 
				
				String User_id = rs.getString("user_id");
				String First_name = rs.getString("f_name");
				session.setAttribute("First_name", First_name);
				session.setAttribute("User_id", User_id);
				
				System.out.println(session.getAttribute("Email"));
				System.out.println(session);
				System.out.println('@');
				
				
				response.sendRedirect("Dashboard");
            } else {
            	out.println("<script type=\"text/javascript\">");
            	   out.println("alert('User or password incorrect');");
            	   out.println("location='Login';");
            	   out.println("</script>");
            }
			
			} 
				catch (ClassNotFoundException | SQLException e) {
					e.printStackTrace();
			}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			RequestDispatcher view = request.getRequestDispatcher("login.html");

	        view.forward(request, response);
		return;
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}