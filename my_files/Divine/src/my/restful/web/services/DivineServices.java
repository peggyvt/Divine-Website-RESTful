package my.restful.web.services;

import java.sql.*;

import javax.ws.rs.POST;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

@Path("DivineServices")
public class DivineServices {

	static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost/divine?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
   
    static final String USER = "admin";
    static final String PASS = "peggymysql2022";
    
    @GET
	@Path("/addUser/{first_name}/{surname}/{email}/{password}")
	@Produces("text/plain")
	public String addUser(@PathParam("first_name") String first_name, @PathParam("surname") String surname, @PathParam("email") String email, @PathParam("password") String password) 
	{
		Connection conn = null;
		String query_output = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			ResultSet rs1;
			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
			ps1.setString(1, email);
			rs1 = ps1.executeQuery();
			if (rs1.next()) { // check if there's user with that email
				query_output = "cannotsignup";
				return query_output;
			}
			
			PreparedStatement ps = conn.prepareStatement("INSERT INTO users (first_name, surname, email, password) VALUES (?, ?, ?, ?)");
			ps.setString(1, first_name); 
			ps.setString(2, surname); 
			ps.setString(3, email); 
			ps.setString(4, password); 
            ps.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}
	
    @GET
	@Path("/signInUser/{email}/{password}")
	@Produces("text/plain")
	public String signInUser(@PathParam("email") String email, @PathParam("password") String password) 
	{
		Connection conn = null;
		String query_output = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			ResultSet rs;
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE email = ? AND password = ?");
			ps.setString(1, email); 
			ps.setString(2, password); 
            rs = ps.executeQuery();
            if(rs.next()) {  // check if query returned results
            	query_output="res"; // user exists
            } 
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}

    @GET
	@Path("/updateUser/{first_name}/{surname}/{email}/{password}")
	@Produces("text/plain")
	public String updateUser(@PathParam("first_name") String first_name, @PathParam("surname") String surname, @PathParam("email") String email, @PathParam("password") String password) 
	{
		Connection conn = null;
		String query_output = "DONE";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			PreparedStatement ps = conn.prepareStatement("UPDATE users SET first_name = ?, surname = ?, email = ?, password = ? WHERE email = ?");
			ps.setString(1, first_name); 
			ps.setString(2, surname); 
			ps.setString(3, email); 
			ps.setString(4, password);
			ps.setString(5, email); 
            ps.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}
    
    @GET
	@Path("/deleteUser/{email}")
	@Produces("text/plain")
	public String deleteUser(@PathParam("email") String email) 
	{
		Connection conn = null;
		String query_output = "DONE";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE email = ?"); 
			ps.setString(1, email);  
            ps.executeUpdate();
            
            PreparedStatement ps1 = conn.prepareStatement("DELETE FROM cart WHERE email = ?"); 
			ps1.setString(1, email);  
            ps1.executeUpdate();
            
            PreparedStatement ps2 = conn.prepareStatement("DELETE FROM favorites WHERE email = ?"); 
			ps2.setString(1, email);  
            ps2.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}

    @GET
	@Path("/addToFavorites/{user_email}/{name}/{price}")
	@Produces("text/plain")
	public String addToFavorites(@PathParam("user_email") String user_email, @PathParam("name") String name, @PathParam("price") String price) 
	{
		Connection conn = null;
		String query_output = "DONE";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			ResultSet rs1;
			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM favorites WHERE email = ? AND name = ?");
			ps1.setString(1, user_email); 
			ps1.setString(2, name.replace("+", " "));
            rs1 = ps1.executeQuery();
            
            if(rs1.next()) {
            	return "item already there";
            }
            
            ResultSet rs2;
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM products WHERE name = ?"); // find the product in order to get its image
			ps2.setString(1, name.replace("+", " ")); 
            rs2 = ps2.executeQuery();
            String img = "";
            if (rs2.next()) {
            	img = rs2.getString("img");
            }
            
			PreparedStatement ps = conn.prepareStatement("INSERT INTO favorites (email, img, name, price) VALUES (?, ?, ?, ?)");
			ps.setString(1, user_email); 
			ps.setString(2, img); 
			ps.setString(3, name.replace("+", " ")); 
			ps.setDouble(4, Double.valueOf(price));
            ps.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}
    
    @GET
	@Path("/deleteFromFavorites/{user_email}/{name}")
	@Produces("text/plain")
	public String deleteFromFavorites(@PathParam("user_email") String user_email, @PathParam("name") String name) 
	{
		Connection conn = null;
		String query_output = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			ResultSet rs1;
			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM favorites WHERE email = ? AND name = ?");
			ps1.setString(1, user_email); 
			ps1.setString(2, name.replace("+", " ")); 
            rs1 = ps1.executeQuery();
            
            if(rs1.next()) {
    			PreparedStatement ps2 = conn.prepareStatement("DELETE FROM favorites WHERE email = ? AND name = ?");
    			ps2.setString(1, user_email); 
    			ps2.setString(2, name.replace("+", " ")); 
                ps2.executeUpdate();
                query_output = "DONE";
            	return query_output;
            }
            
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}
    
    @GET
   	@Path("/emptyFavorites/{user_email}")
   	@Produces("text/plain")
   	public String emptyFavorites(@PathParam("user_email") String user_email) 
   	{
   		Connection conn = null;
   		String query_output = "";
   		try {
   			Class.forName("com.mysql.cj.jdbc.Driver");
   			conn = DriverManager.getConnection(DB_URL, USER, PASS);
   			
   			ResultSet rs1;
   			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM favorites WHERE email = ?");
   			ps1.setString(1, user_email); 
            rs1 = ps1.executeQuery();
               
            if(rs1.next()) {
	   			PreparedStatement ps2 = conn.prepareStatement("DELETE FROM favorites WHERE email = ?");
	   			ps2.setString(1, user_email); 
	               ps2.executeUpdate();
	               query_output = "DONE";
	           	return query_output;
            }
           
   		} catch (SQLException | ClassNotFoundException e) {
   			e.printStackTrace();
   		}
   		return query_output;
   	}
    
    @GET
	@Path("/addToCart/{user_email}/{name}/{price}/{quantity}/{colour}")
	@Produces("text/plain")
	public String addToCart(@PathParam("user_email") String user_email, @PathParam("name") String name, @PathParam("price") String price, 
			@PathParam("quantity") String quantity, @PathParam("colour") String colour) 
	{
		Connection conn = null;
		String query_output = "DONE";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			ResultSet rs1;
			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM cart WHERE email = ? AND name = ?");
			ps1.setString(1, user_email); 
			ps1.setString(2, name.replace("+", " ")); 
            rs1 = ps1.executeQuery();
            
            if(rs1.next()) {
            	return "item already there";
            }
            
            ResultSet rs2;
			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM products WHERE name = ?"); // find the product in order to get its image
			ps2.setString(1, name.replace("+", " ")); 
            rs2 = ps2.executeQuery();
            String img = "";
            if (rs2.next()) {
            	img = rs2.getString("img");
            }
            
			PreparedStatement ps = conn.prepareStatement("INSERT INTO cart (email, img, name, price, quantity, colour) VALUES (?, ?, ?, ?, ?, ?)");
			ps.setString(1, user_email); 
			ps.setString(2, img); 
			ps.setString(3, name.replace("+", " ")); 
			ps.setDouble(4, Double.valueOf(price));
			ps.setInt(5, Integer.parseInt(quantity)); 
			ps.setString(6, colour); 
            ps.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}
    
    @GET
	@Path("/deleteFromCart/{user_email}/{name}")
	@Produces("text/plain")
	public String deleteFromCart(@PathParam("user_email") String user_email, @PathParam("name") String name) 
	{
		Connection conn = null;
		String query_output = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			ResultSet rs1;
			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM cart WHERE email = ? AND name = ?");
			ps1.setString(1, user_email); 
			ps1.setString(2, name.replace("+", " ")); 
            rs1 = ps1.executeQuery();
            
            if(rs1.next()) {
    			PreparedStatement ps2 = conn.prepareStatement("DELETE FROM cart WHERE email = ? AND name = ?");
    			ps2.setString(1, user_email); 
    			ps2.setString(2, name.replace("+", " ")); 
                ps2.executeUpdate();
                query_output = "DONE";
            	return query_output;
            }
            
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}
    
    @GET
   	@Path("/checkout/{user_email}")
   	@Produces("text/plain")
   	public String checkout(@PathParam("user_email") String user_email) 
   	{
   		Connection conn = null;
   		String query_output = "";
   		try {
   			Class.forName("com.mysql.cj.jdbc.Driver");
   			conn = DriverManager.getConnection(DB_URL, USER, PASS);
   			
   			ResultSet rs1;
   			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM cart WHERE email = ?");
   			ps1.setString(1, user_email); 
            rs1 = ps1.executeQuery();
            
            String product_name = "";
            int product_availability = 0;
            int new_product_availability = 0;
            int product_quantity = 0;
            
            ResultSet rs2;
            while (rs1.next()) { // for each product in cart
            	product_name = rs1.getString("name"); // get its name
            	product_quantity = Integer.parseInt(rs1.getString("quantity")); // get product's quantity that user wants to buy
            	
            	// find the product in order to get its availability and later on reduce it
    			PreparedStatement ps2 = conn.prepareStatement("SELECT * FROM products WHERE name = ?"); 
    			ps2.setString(1, product_name); 
                rs2 = ps2.executeQuery();
                
                if (rs2.next()) {
                	product_availability = rs2.getInt("availability");
	                new_product_availability = product_availability - product_quantity;
                }
	                
       			PreparedStatement ps3 = conn.prepareStatement("UPDATE products SET availability = ? WHERE name = ?");
       			
       			ps3.setInt(1, new_product_availability);
       			ps3.setString(2, product_name); 
                ps3.executeUpdate();
            }
            
   			PreparedStatement ps3 = conn.prepareStatement("DELETE FROM cart WHERE email = ?");
   			ps3.setString(1, user_email); 
               ps3.executeUpdate();
               query_output = "DONE";
           	return query_output;
           
   		} catch (SQLException | ClassNotFoundException e) {
   			e.printStackTrace();
   		}
   		return query_output;
   	}

    @GET
	@Path("/addProduct/{img}/{name}/{price}/{availability}/{collection}")
	@Produces("text/plain")
	public String addProduct(@PathParam("img") String img, @PathParam("name") String name, @PathParam("price") String price, 
			@PathParam("availability") String availability, @PathParam("collection") String collection) 
	{
		Connection conn = null;
		String query_output = "DONE";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			ResultSet rs1;
			PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM products WHERE name = ?");
			ps1.setString(1, name.replace("+", " ")); 
            rs1 = ps1.executeQuery();

            if(rs1.next()) {
            	return "product already exists";
            }
           
			PreparedStatement ps = conn.prepareStatement("INSERT INTO products (img, name, price, availability, collection) VALUES (?, ?, ?, ?, ?)");
			ps.setString(1, img.replace("+", "/")); 
			ps.setString(2, name.replace("+", " ")); 
			ps.setDouble(3, Double.valueOf(price));
			ps.setInt(4, Integer.parseInt(availability)); 
			ps.setString(5, collection); 
            ps.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}

    @GET
	@Path("/updateProduct/{img}/{name}/{price}/{availability}/{collection}")
	@Produces("text/plain")
	public String updateProduct(@PathParam("img") String img, @PathParam("name") String name, @PathParam("price") String price, 
			@PathParam("availability") String availability, @PathParam("collection") String collection) 
	{
		Connection conn = null;
		String query_output = "DONE";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			System.out.println(availability + collection);
			PreparedStatement ps = conn.prepareStatement("UPDATE products SET img = ?, name = ?, price = ?, availability = ?, collection = ? WHERE name = ?");
			ps.setString(1, img.replace("+", "/")); 
			ps.setString(2, name.replace("+", " ")); 
			ps.setDouble(3, Double.valueOf(price));
			ps.setInt(4, Integer.parseInt(availability)); 
			ps.setString(5, collection);
			ps.setString(6, name.replace("+", " ")); 
            ps.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}

    @GET
	@Path("/deleteProduct/{name}")
	@Produces("text/plain")
	public String deleteProduct(@PathParam("name") String name) 
	{
		Connection conn = null;
		String query_output = "DONE";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			
			PreparedStatement ps = conn.prepareStatement("DELETE FROM products WHERE name = ?"); 
			ps.setString(1, name);  
            ps.executeUpdate();
            
            PreparedStatement ps1 = conn.prepareStatement("DELETE FROM cart WHERE name = ?"); 
			ps1.setString(1, name);  
            ps1.executeUpdate();
            
            PreparedStatement ps2 = conn.prepareStatement("DELETE FROM favorites WHERE name = ?"); 
			ps2.setString(1, name);  
            ps2.executeUpdate();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return query_output;
	}
}