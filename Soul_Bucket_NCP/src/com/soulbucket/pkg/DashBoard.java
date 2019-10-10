package com.soulbucket.pkg;

import java.io.IOException;

import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.json.simple.JSONArray;
//import org.json.simple.JSONObject;

public class DashBoard extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			HttpSession session=request.getSession();
			
			System.out.println(session);
			System.out.println(session.getAttribute("First_name"));
			System.out.println(session.getAttribute("User_id"));
			System.out.println("!");
			
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/SoulBucket?useSSL=false", "username", "password"); // gets a new connection
			Statement st=conn.createStatement();
			
			ResultSet rs_todo = null;
			ResultSet rs_done = null;
			
			String sql_todo = "Select * from items Where user_id='" + session.getAttribute("User_id") + "' and status='" + 0 + "'";
			String sql_done = "Select * from items Where user_id='" + session.getAttribute("User_id") + "' and status='" + 1 + "'";
			
			
			String lis1 = "", lis2 = "";
			
			rs_todo = st.executeQuery(sql_todo);
			
			while(rs_todo.next()){
				lis1 = lis1 + rs_todo.getString("item_name") +"/*break*/";
			}
			
			rs_done = st.executeQuery(sql_done);
			
			while(rs_done.next()){
				lis2 = lis2 + rs_done.getString("item_name") +"/*break*/";
			}


			if((session.getAttribute("First_name") == null)){ 
				throw new NullPointerException("First_name is null");			
			}
			
			session.setAttribute("rs_todo_list", lis1);
			session.setAttribute("rs_done_list", lis2);
			
			RequestDispatcher view = request.getRequestDispatcher("dashboard.jsp");

	        view.forward(request, response);
	        
	        return;

		 
		} catch (Exception e) {
			
			PrintWriter out=response.getWriter();
			out.println("<script type=\"text/javascript\">");
     	   out.println("alert('Please login first');");
     	   out.println("location='Login';");
     	   out.println("</script>");
     	   
     	   
			e.printStackTrace();
		}
	}

}