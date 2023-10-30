<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.sun.jersey.api.client.Client"%>
<%@ page import="com.sun.jersey.api.client.ClientResponse"%>
<%@ page import="com.sun.jersey.api.client.WebResource"%> 
<%@ page import="java.net.URLEncoder"%>

<!DOCTYPE html>
<html>
    <head>
    	<meta charset="ISO-8859-1">
        <title>DIVINE | Products</title>
        <link rel="shortcut icon" href="images/icon.png"/>
        
        <!--Basic Settings-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        
        <!--External CSS Bootstrap-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/css/bootstrap.min.css">
        
        <!--External JQuery-->
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>

        <!--External JS Bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
        
        <!--Noto Serif Display fonts-->
        <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+Display:wght@100&display=swap" rel="stylesheet"> 
        <link href="https://fonts.googleapis.com/css2?family=Noto+Serif+Display:wght@300&display=swap" rel="stylesheet"> 
        
        <!--Icon Library-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!--External CSS-->
        <link rel="stylesheet" href="style.css?v=1">

        <style>
            .navbar {
                padding: 0;
            }
            .nav-item .dropdown-menu{ display: none; }
            .nav-item:hover .dropdown-menu{ display: block; }
            .nav-item .dropdown-menu{ margin-top:0; }
            .slogan {
                font-family: "Calibri Light", sans-serif;
                font-size: 90%;
            }

            .num {
                padding: 30px;
            }

            .products {
                text-align: center;
                font-family: 'Noto Serif Display', serif;
                font-weight: 300;
            }

            input {
                outline: none;
            }
        </style>
    </head>
    <body>
    
	<%
	    if(request.getParameter("add-product-btn") != null) {
    		
    		String img = request.getParameter("img");
    		img = img.replace("/", "+");
			String name = request.getParameter("name");
			name = URLEncoder.encode(name, "UTF-8");
			String price = request.getParameter("price");
			String availability = request.getParameter("availability");
			String collection = request.getParameter("collection");
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/addProduct/"+img+"/"+name+"/"+price+"/"+availability+"/"+collection);
			ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			
			if (myresponse.getStatus() != 200) {
				throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
			}
		
			String output = myresponse.getEntity(String.class);
			if (output.contentEquals("product already exists")) { %>
				<span class="print_message"><% out.println("A product with that name already exists."); %></span>
			<% }
		}

		if(request.getParameter("update-product-details-btn") != null) {
			
			String img = request.getParameter("img");
			img = img.replace("/", "+");
			String name = request.getParameter("name");
			name = URLEncoder.encode(name, "UTF-8");
			String price = request.getParameter("price");
			String availability = request.getParameter("availability");
			String collection = request.getParameter("collection");
			
			System.out.println(img + name + price + availability + collection);
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/updateProduct/"+img+"/"+name+"/"+price+"/"+availability+"/"+collection);
			ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			
			if (myresponse.getStatus() != 200) {
				throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
			}
		
			String output = myresponse.getEntity(String.class);
		}
		
		if(request.getParameter("delete-product-details-btn") != null) {
		
			String name = request.getParameter("name");
			name = URLEncoder.encode(name, "UTF-8");
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/deleteProduct/"+name);
			ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			
			if (myresponse.getStatus() != 200) {
				throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
			}
		
			String output = myresponse.getEntity(String.class);
		}
	%>
        <header class="text-center">
            <a href="Home.jsp"><img src="images/logo.png" width="166.3px" height="83.67px" align="center"></a><br>
            <font size=small color="white">DIVINE</font>
            <font class="slogan" color=#ad873a>..divine scents for divine people</font>
            <br><br>
        </header>

        <nav class="mx-auto">
            <div class="container">
                <ul class="nav justify-content-center">
                    <li class="nav-item">
                        <a class="nav-link" href="Admin-Change-Users-Info.jsp">USERS</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="Admin-Change-Products-Info.jsp">PRODUCTS</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Account.jsp">ACCOUNT</a>
                    </li>
                </ul>
            </div>
        </nav>
        
        <div class="extras" align="right">
            <!--sign out button-->
            <button style="background-color: #dfe0df;color: #674335;
            border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#sign-out-Modal"><i class="fa fa-sign-out"></i></button>
        
            <!--SIGN OUT MODAL-->
            <div class="modal" id="sign-out-Modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">LEAVING?</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <section class="Sign-Out-Form" text-align="center">
                            <form method="POST">   
                                <input type="submit" id="sign-out-btn1" aria-label="sign out button" name="sign-out-btn1" value="YES"/>
                                <input type="submit" id="sign-out-btn2" aria-label="sign out button" name="sign-out-btn2" value="STAY"/>
                            </form>
                        </section>
                    </div>
                </div>
            </div>
        </div>
        
        <%
        	String user_email = (String)session.getAttribute("user_email"); 
			if(request.getParameter("sign-out-btn1") != null) { // if the button "YES" was pressed -- then the user wants to sign out
				session.setAttribute("user_email", "guest@gmail.com");
				session.invalidate();
			}
		%>
		 
        <% user_email = (String)session.getAttribute("user_email"); 
        if (!user_email.equals("guest@gmail.com")) { // check if there is someone signed in %>
               <span id='user_status'>a user is signed in: <% out.println(user_email); %></span>
        <% } else { // if there's no user logged in, find the 'dummy' one %>
               <span id='user_status'>there's a guest here</span>
        <% } %>

        <div class="products container">
            <table class="table">
                <tr>
                    <th>img</th>
                    <th>name</th>
                    <th>price</th>
                    <th>availability</th>
                    <th>collection</th>
                </tr>

				<% 
                final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	            final String DB_URL = "jdbc:mysql://localhost/divine?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
 	           
	            final String USER = "admin";
	            final String PASS = "peggymysql2022";
	            
                Connection conn = null;
                String img = "";
                String name = "";
                Double price = 0.0;
                int availability = 0;
                String collection = "";
        		try {
        			Class.forName("com.mysql.cj.jdbc.Driver");
        			conn = DriverManager.getConnection(DB_URL, USER, PASS);
        			
        			ResultSet rs;
        			PreparedStatement ps = conn.prepareStatement("SELECT * FROM products");
                    rs = ps.executeQuery();%>
                    
                    <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:150px; outline: none;" type="button" data-toggle="modal" data-target="#add-product-Modal">Add new product</i></button>
                    
                    <%int i = 0;
                    while(rs.next()) 
                    { 
                    	i++;
                    	img = rs.getString("img");
                    	name = rs.getString("name");
                    	price = rs.getDouble("price");
                    	availability = rs.getInt("availability");
                    	collection = rs.getString("collection");%>
		            	
		            		
                    	<tr>
                            <td><% out.print(img); %></td>
                            <td><% out.print(name); %></td>
                            <td><% out.print(price); %></td>
                            <td><% out.print(availability); %></td>
                            <td><% out.print(collection); %></td>

                            <td> <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#edit-product-Modal-<%out.print(i);%>"><i class="fa fa-edit"></i></button></td>
                            <td> <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#delete-product-Modal-<%out.print(i);%>"><i class="fa fa-trash"></i></button></td>
                        </tr><br>
                        <div class="modal" id="edit-product-Modal-<%out.print(i);%>">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title">UPDATE PRODUCT</h3>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <section class="Update-Form" text-align="center">
                                        <form method='POST'> 
                                            <label class='img-label' for='img'>IMAGE</label><br/>
                                            <input type='text' id='img' name='img' value='<%out.print(img);%>' aria-label='image' pattern='\S+.*'><br/>
                                            
                                            <label class='name-label' for='name'>NAME</label><br/>
                                            <input type='text' id='name' name='name' value='<%out.print(name);%>' aria-label='name' readonly pattern='\S+.*'><br/>

                                            <label class='price-label' for='price'>PRICE</label><br/>
                                            <input type='text' id='price' name='price' value='<%out.print(price);%>' aria-label='price' pattern='\S+.*'><br/>

                                            <label class='availability-label' for='availability'>AVAILABILITY</label><br/>
                                            <input type='text' id='availability' name='availability' value='<%out.print(availability);%>' aria-label='availability' pattern='[A-Za-zΑ-Ωα-ω]{0, 20}'><br/>
                                            
                                            <label class='collection-label' for='collection'>COLLECTION</label><br/>
                                            <select id="collection" name="collection" required title="please select collection">
			                                    <option value="RUSTIC">RUSTIC</option>
			                                    <option value="SILHOUETTE">SILHOUETTE</option>
			                                </select><br/>
                                            
                                            <input type='submit' id='update-product-details-btn' aria-label='update product details button' name='update-product-details-btn' value='UPDATE'/>
                                        </form>
                                    </section>
                                </div>
                            </div>
                        </div>

                        <div class="modal" id="delete-product-Modal-<%out.print(i);%>" class="delete-product">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title">DELETE PRODUCT</h3>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <section class="Delete-Form" text-align="center">
                                        <form method='POST'> 
                                            <label class='delete-label' style="color: black;" for='name'>Are you sure you want to delete product with name:</label><br/>
                                            <input type='text' id='name' style="border: none; width: 180px;" name='name' value='<%out.print(name);%>' readonly aria-label='product name'>?<br/>
                                            
                                            <input type='submit' id='delete-product-details-btn' style="margin: 15px;" aria-label='delete product details button' name='delete-product-details-btn' value='YES'/>
                                        </form>
                                    </section>
                                </div>
                            </div>
                        </div>
                    <% } %>
            </table>
        		<% } catch (SQLException | ClassNotFoundException e) {
            		e.printStackTrace();
            	}
            %>            
            
            <div class="modal" id="add-product-Modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">ADD PRODUCT</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <section class="Sign-Up-Form" text-align="center">
                            <form method="POST">
                                <label class="img-label" for="img">IMAGE</label><br/>
                                <input type="text" id="img" name="img" aria-label="image" required title="please enter image path" required minlength="1" pattern="\S+.*"><br/>
                                
                                <label class="name-label" for="name">NAME</label><br/>
                                <input type="text" id="name" name="name" aria-label="name" required title="please enter name" required minlength="1" pattern="\S+.*"><br/>

                                <label class="price-label" for="price">PRICE</label><br/>
                                <input type="text" id="price" name="price" required pattern="{0, 20}" required title="please enter price"><br/>
                                
                                <label class="availability-label" for="availability">AVAILABILITY</label><br/>
                                <input type="text" id="password" name="availability" required pattern="{0, 20}" required title="please enter availability"><br/>
                                
                                <label class="collection-label" for="collection">COLLECTION</label><br/>
                                <select id="collection" name="collection" required title="please select collection">
                                    <option value="RUSTIC">RUSTIC</option>
                                    <option value="SILHOUETTE">SILHOUETTE</option>
                                </select><br/>
                                <input type="submit" id="add-product-btn" aria-label="add product button" name="add-product-btn" value="ADD NEW PRODUCT"/>
                            </form>
                        </section>
                    </div>
                </div>
            </div>
        </div>
        <footer>
            &copy DIVINE, 2022
        </footer>
    </body>
</html>