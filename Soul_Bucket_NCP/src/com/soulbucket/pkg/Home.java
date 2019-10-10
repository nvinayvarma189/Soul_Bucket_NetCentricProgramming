package com.soulbucket.pkg;

import java.io.IOException;
import java.sql.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;



public class Home extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
//		response.sendRedirect("login.html");
		
		 RequestDispatcher rd = request.getRequestDispatcher("home.html");      
		    rd.forward(request, response);
		      
		return;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
 
}