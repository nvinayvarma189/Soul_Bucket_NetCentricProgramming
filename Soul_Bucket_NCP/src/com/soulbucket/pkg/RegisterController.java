package com.soulbucket.pkg;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;


public class RegisterController extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String First_name=request.getParameter("First_name");
		String Last_name=request.getParameter("Last_name");
		String Phn_number=request.getParameter("Phn_number");
		String Email=request.getParameter("Email");
		String Password=request.getParameter("Password");
		int user_id_int = 0;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		 // loads driver
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/SoulBucket?useSSL=false", "username", "password"); // gets a new connection
			
			Statement st=conn.createStatement();
			int i=st.executeUpdate("insert into user_details(f_name,l_name,phone_num,email, password)values('"+First_name+"','"+Last_name+"','"+Phn_number+"','"+Email+"','"+Password+"')");
			
			ResultSet rs = null;
			rs = st.executeQuery("SELECT AUTO_INCREMENT from information_schema.tables where table_schema=\"SoulBucket\" and table_name=\"user_details\";");
			
//			System.out.println(rs.next());
			
//			System.out.println(rs.getString("AUTO_INCREMENT"));
			
			if (rs.next())
				user_id_int = Integer.valueOf(rs.getString("AUTO_INCREMENT"));
			
			System.out.println(user_id_int);
			
			user_id_int = user_id_int - 1;
			String User_id = Integer.toString(user_id_int);
			
			HttpSession session = request.getSession();
			
			session.setAttribute("First_name", First_name);
			session.setAttribute("User_id", User_id);
			
			response.sendRedirect("Dashboard");
			
			System.out.println("Data is successfully inserted!");
		} 
		
		catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		

	}
	

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			RequestDispatcher view = request.getRequestDispatcher("register.html");

	        view.forward(request, response);
		return;
//			response.sendRedirect("/register.html");
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}