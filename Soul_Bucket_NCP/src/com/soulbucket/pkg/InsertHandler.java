package com.soulbucket.pkg;

import java.io.IOException;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedReader;

public class InsertHandler extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String jsonString = new String();
		
		try {
			System.out.println("came");
			
			String line = "";
		    BufferedReader reader = request.getReader();
		    while ((line = reader.readLine()) != null)
		      jsonString += line;
		    
		    System.out.println(jsonString);
		    
		    JSONObject jsonObject = new JSONObject(jsonString);
		    
		    JSONObject value1 = jsonObject.getJSONObject("value1");
		    String user_id = value1.getString("User_id_var");
		    
		    JSONObject value2 = jsonObject.getJSONObject("value2");
		    String item_name = value2.getString("value");
		    
		    System.out.println(user_id);
		    System.out.println(item_name);
		    
		    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/SoulBucket?useSSL=false", "username", "password"); // gets a new connection
			
			Statement st=conn.createStatement();
			int i=st.executeUpdate("insert into items(user_id,item_name,status)values('"+user_id+"','"+item_name+"','"+0+"')");

		
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}

}