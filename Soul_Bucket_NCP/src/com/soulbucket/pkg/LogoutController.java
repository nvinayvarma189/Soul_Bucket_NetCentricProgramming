package com.soulbucket.pkg;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;  



public class LogoutController extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			
			HttpSession session=request.getSession();  
            
			System.out.println(session);
			System.out.println(session.getAttribute("Email"));
			System.out.println("l1");
			
			session.invalidate();
			
//			System.out.println(session);
//			System.out.println(session.getAttribute("Email"));
//			System.out.println("l2");
            
            
			
			response.sendRedirect("Home");
	        
            
            
		return;
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}