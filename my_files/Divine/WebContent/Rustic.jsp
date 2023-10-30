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
        <title>DIVINE | Rustic Collection</title>
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
            h1 {
                text-align: center;
                padding-left: 0;
                padding-bottom: 20px;
            }
            .candle-names, .candle-price {
                color: black;
            }

            .img:hover {
                box-shadow: 3px 2px rgba(75, 129, 120, 0.9);
                transition: 0.3s;
            }

            .product-information {
                display: flex;
                padding: 10px;
            }

            .info {
                font-family: 'Noto Serif Display', serif;
                font-weight: 300;
                font-size: 125%;
                padding-left: 10px;
                text-align: left;
            }

            .modal-img {
                width: 337px;
                height: 337px;
            }

            .modal-lg {
                width: 700px;
            }

            .item-btns {
                font-family: 'Noto Serif Display', serif;
                font-weight: 100;
                padding-left: 14px;
                padding-top: 12px;
            }

            input {
                font-weight: 100;
                color: black;
                outline: none;
            }
            
            label {
                color: black;
                display: inline;
            }

            select {
                border: none;
                background-color: white;
                font-family: 'Noto Serif Display', serif;
                font-weight: 100;
                width: 130px;
            }

            option {
                font-family: 'Noto Serif Display', serif;
                font-weight: 100;
            }

            .email-label-1 {
                padding-top: 20px;
                color: #674335;
            }

            .first_name-label, .surname-label, .email-label-2, .password-label-1, .password-label-2, .confirm_password-label {
                padding-top: 10px;
                color: #674335;
            }
        </style>
    </head>
    <body>
    	<%
    		String user_email = (String)session.getAttribute("user_email"); 
	    	if (user_email == null) {
				session.setAttribute("user_email", "guest@gmail.com");
			}
	    	
			if(request.getParameter("sign-in-btn") != null) {
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/signInUser/"+email+"/"+password);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				String output = myresponse.getEntity(String.class);
				if (output.equals("res")) { // if user exists
					session.setAttribute("user_email", email);
				} else {
					session.setAttribute("user_email", "guest@gmail.com");
				}
			}
	
			if(request.getParameter("sign-up-btn") != null) {
				String first_name = request.getParameter("first_name");
				String surname = request.getParameter("surname");
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/addUser/"+first_name+"/"+surname+"/"+email+"/"+password);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				session.setAttribute("user_email", email);
				String output = myresponse.getEntity(String.class);
				if (output.contentEquals("cannotsignup")) { %>
					<span class="print_message"><% out.println("A user with that email already exists."); %></span>
				<% }
			}
			
			if(request.getParameter("favorites-btn") != null) {
				user_email = (String)session.getAttribute("user_email"); 
				String name = request.getParameter("name");
				name = URLEncoder.encode(name, "UTF-8");
				String price = request.getParameter("price");
				
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/addToFavorites/"+user_email+"/"+name+"/"+price);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				String output = myresponse.getEntity(String.class);
				if (output.contentEquals("item already there")) { %>
					<span class="print_message"><% out.println("Item already there."); %></span>
				<% }
			}
			
			if(request.getParameter("cart-btn") != null) {
				user_email = (String)session.getAttribute("user_email"); 
				String name = request.getParameter("name");
				name = URLEncoder.encode(name, "UTF-8");
				String price = request.getParameter("price");
				String quantity = request.getParameter("quantity");
				String colour = request.getParameter("colour");
				
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/addToCart/"+user_email+"/"+name+"/"+price+"/"+quantity+"/"+colour);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				String output = myresponse.getEntity(String.class);
				if (output.contentEquals("item already there")) { %>
					<span class="print_message"><% out.println("Item already there."); %></span>
				<% }
			}
			
			if(request.getParameter("delete-product-from-cart-btn") != null) {
				String name = request.getParameter("name");
				name = URLEncoder.encode(name, "UTF-8");
				
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/deleteFromCart/"+user_email+"/"+name);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				String output = myresponse.getEntity(String.class);
				if (output.contentEquals("DONE")) { %>
					<span class="print_message"><% out.println("Item successfully deleted from cart."); %></span>
				<% }
			}
			
			if(request.getParameter("checkout-btn") != null) {
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/checkout/"+user_email);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				String output = myresponse.getEntity(String.class);
				if (output.contentEquals("DONE")) { %>
					<span class="print_message"><% out.println("Checkout Completed - Your cart is empty now."); %></span>
				<% }
			}
			
			if(request.getParameter("delete-product-from-favs-btn") != null) {
				String name = request.getParameter("name");
				name = URLEncoder.encode(name, "UTF-8");
				
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/deleteFromFavorites/"+user_email+"/"+name);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				String output = myresponse.getEntity(String.class);
				if (output.contentEquals("DONE")) { %>
					<span class="print_message"><% out.println("Item successfully deleted from favorites."); %></span>
				<% }
			}
			
			if(request.getParameter("empty-favs-btn") != null) {
				Client client = Client.create();
				WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/emptyFavorites/"+user_email);
				ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
				
				if (myresponse.getStatus() != 200) {
					throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
				}
			
				String output = myresponse.getEntity(String.class);
				if (output.contentEquals("DONE")) { %>
					<span class="print_message"><% out.println("Your favorites is empty now."); %></span>
				<% }
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
                        <a class="nav-link" href="Home.jsp">HOME</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="Inspiration.jsp" type="button" class="dropdown-toggle" data-toggle="dropdown">
                            OUR COLLECTIONS
                        </a>
                        <div class="dropdown-menu">
                            <a class="dropdown-item" href="Rustic.jsp">RUSTIC</a>
                            <a class="dropdown-item" href="Silhouette.jsp">SILHOUETTE</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Inspiration.jsp">INSPIRATION</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Gallery.jsp">GALLERY</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Account.jsp">ACCOUNT</a>
                    </li>
                </ul>
            </div>
        </nav>
        <div class="extras" align="right">
            <!--favorites, cart button, user button-->
            <% user_email = (String)session.getAttribute("user_email"); 
            if (!user_email.contentEquals("guest@gmail.com")) { %>
	            <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#favorites-Modal"><i class="fa fa-heart"></i></button>
	            <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#cart-Modal"><i class="fa fa-shopping-cart"></i></button>
                <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#sign-out-Modal"><i class="fa fa-sign-out"></i></button>
            <% } else { %>
                <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#cart-Modal"><i class="fa fa-shopping-cart"></i></button>
                <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#sign-in-Modal"><i class="fa fa-user"></i></button>
            <% } %>

			<!--CART MODAL-->
            <div class="modal" id="cart-Modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">YOUR CART</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <section class="Cart-Form" text-align="center">
                            <form method="POST">
								<%
				                    final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
				    	            final String DB_URL = "jdbc:mysql://localhost/divine?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
				    	           
				    	            final String USER = "admin";
				    	            final String PASS = "peggymysql2022";
				    	            
				                    Connection conn = null;
				                    String img = "";
				                    String name = "";
				                    Double price = 0.0;
				                    int quantity = 0;
				                    String colour = "";
				            		try {
				            			Class.forName("com.mysql.cj.jdbc.Driver");
				            			conn = DriverManager.getConnection(DB_URL, USER, PASS);
				            			
				            			ResultSet rs;
				            			PreparedStatement ps = conn.prepareStatement("SELECT * FROM cart WHERE email = ?");
				            			ps.setString(1, user_email);
				                        rs = ps.executeQuery();
				                        
				                        int i = 0;
				                        while(rs.next()) 
				                        { 
				                        	i++;
				                        	img = rs.getString("img");
							            	name = rs.getString("name");
							            	price = rs.getDouble("price");
							            	quantity = rs.getInt("quantity");
							            	colour = rs.getString("colour");%>
				                        
	                                        <div class="item">
	                                            <img style="border: none; align: left;" class="img" id="img" name="img" src="<%out.print(img);%>" width="168.5" height="168.5" alt="candle image">
	                                        
	                                            <div class="products-info">
	                                                <label class="name-label" for="name">Name: </label>
	                                                <input style="white-space: pre-wrap; outline: none; border: none; font-family: 'Noto Serif Display', serif; font-weight: 100; width: 220px;" type="text" id="name" name="name" readonly value="<%out.print(name);%>"><br/>
	                                            
	                                                <label class="price-label" for="price">Price: </label>
	                                                <input style="outline: none; border: none; font-family: 'Noto Serif Display', serif; font-weight: 100; width: 30px;" type="text" id="price" name="price" readonly value="<%out.print(price.intValue());%>"><span style="font-family: 'Noto Serif Display', serif; font-weight: 100;">&euro;</span><br/>
	                                            
	                                                <label class="quantity-label" for="quantity">Quantity: </label>
	                                                <input style="outline: none; border: none; font-family: 'Noto Serif Display', serif; font-weight: 100; width: 30px;" type="text" id="quantity" name="quantity" readonly value="<%out.print(quantity);%>"><br/>
	                                            
	                                                <label class="colour-label" for="colour">Colour: </label>
	                                                <input style="outline: none; border: none; font-family: 'Noto Serif Display', serif; font-weight: 100; width: 150px;" type="text" id="colour" name="colour" readonly value="<%out.print(colour);%>"><br/>
	                                            </div>
	                                            <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="submit" class="delete-product-from-cart-btn" id="delete-product-from-cart-btn" name="delete-product-from-cart-btn"><i class="fa fa-trash"></i></button>
	                                        </div>
                                     	<% } 
				            		} catch (SQLException | ClassNotFoundException e) {
					            		e.printStackTrace();
					            	}
					            %>
                                <br><br>
                                <div class="justify-content-center mx-auto">
                                    <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-family: 'Noto Serif Display', serif;font-weight: 300;font-size: 16px; width:120px; outline: none;" type="submit" id="checkout-btn" style="text-align: center; margin: 15px;margin-top: 0px;" aria-label="checkout button" class="checkout-btn" name="checkout-btn">CHECKOUT</button>
                                </div>
                            </form>
                        </section>
                    </div>
                </div>
            </div>
            
            <!--FAVORITES MODAL-->
            <div class="modal" id="favorites-Modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">YOUR FAVORITES</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <section class="Cart-Form" text-align="center">
                            <form method="POST">
								<%
				                    conn = null;
				                    img = "";
				                    name = "";
				                    price = 0.0;
				            		try {
				            			Class.forName("com.mysql.cj.jdbc.Driver");
				            			conn = DriverManager.getConnection(DB_URL, USER, PASS);
				            			
				            			ResultSet rs;
				            			PreparedStatement ps = conn.prepareStatement("SELECT * FROM favorites WHERE email = ?");
				            			ps.setString(1, user_email);
				                        rs = ps.executeQuery();
				                        
				                        int i = 0;
				                        while(rs.next()) 
				                        { 
				                        	i++;
				                        	img = rs.getString("img");
							            	name = rs.getString("name");
							            	price = rs.getDouble("price");%>
				                        
	                                        <div class="item">
	                                            <img style="border: none; align: left;" class="img" id="img" name="img" src="<%out.print(img);%>" width="168.5" height="168.5" alt="candle image">
	                                        
	                                            <div class="products-info">
	                                                <label class="name-label" for="name">Name: </label>
	                                                <input style="white-space: pre-wrap; outline: none; border: none; font-family: 'Noto Serif Display', serif; font-weight: 100; width: 220px;" type="text" id="name" name="name" readonly value="<%out.print(name);%>"><br/>
	                                            
	                                                <label class="price-label" for="price">Price: </label>
	                                                <input style="outline: none; border: none; font-family: 'Noto Serif Display', serif; font-weight: 100; width: 30px;" type="text" id="price" name="price" readonly value="<%out.print(price.intValue());%>"><span style="font-family: 'Noto Serif Display', serif; font-weight: 100;">&euro;</span><br/>
	                                            
	                                            </div>
	                                            <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="submit" class="delete-product-from-favs-btn" id="delete-product-from-favs-btn" name="delete-product-from-favs-btn"><i class="fa fa-trash"></i></button>
	                                        </div>
                                     	<% } 
				            		} catch (SQLException | ClassNotFoundException e) {
					            		e.printStackTrace();
					            	}
					            %>
                                <br><br>
                                <div class="justify-content-center mx-auto">
                                    <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-family: 'Noto Serif Display', serif;font-weight: 300;font-size: 16px; width:120px; outline: none;" type="submit" id="empty-favs-btn" style="text-align: center; margin: 15px;margin-top: 0px;" aria-label="empty favorites button" class="empty-favs-btn" name="empty-favs-btn">EMPTY</button>
                                </div>
                            </form>
                        </section>
                    </div>
                </div>
            </div>
            
            <!--SIGN IN MODAL-->
            <div class="modal" id="sign-in-Modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">HELLO YOU</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <section class="Sign-In-Form" text-align="center">
                            <form method="POST">
                                <label class="email-label-1" style="color:#674335;" for="email">EMAIL</label><br/>
                                <input type="email" id="email" name="email" required title="please enter your email"><br/>
                                
                                <label class="password-label-1" for="password">PASSWORD</label><br/>
                                <input type="password" id="password" name="password" required pattern="[A-Za-zΑ-Ωα-ω]{0, 20}" required title="please enter your password"></input><br/>

                                <input type="submit" id="sign-in-btn" aria-label="sign in button" class="sign-in-btn" name="sign-in-btn" value="SIGN IN"/>
                            </form>
                            <h6 class="new-here">NEW HERE? <a class="sign-up-button" class="btn btn-primary" data-toggle="modal" data-target="#sign-up-Modal" href="">SIGN UP</a></h6>
                        </section>
                    </div>
                </div>
            </div>

            <!--SIGN UP MODAL-->
            <div class="modal" id="sign-up-Modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">WELCOME</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <section class="Sign-Up-Form" text-align="center">
                            <form method="POST" oninput='confirm_password.setCustomValidity(confirm_password.value != password.value ? "passwords do not match" : "")'>
                                <label class="first_name-label" for="first_name">FIRST NAME</label><br/>
                                <input type="text" id="first_name" name="first_name" aria-label="first name" required title="please enter your first name" required minlength="1" pattern="\S+.*"><br/>
                                
                                <label class="surname-label" for="surname">SURNAME</label><br/>
                                <input type="text" id="surname" name="surname" aria-label="surname" required title="please enter your surname" required minlength="1" pattern="\S+.*"><br/>

                                <label class="email-label-2" for="email">EMAIL</label><br/>
                                <input type="email" id="email" name="email" required title="please enter your email"><br/>
                                
                                <label class="password-label-2" for="password">PASSWORD</label><br/>
                                <input type="password" id="password" name="password" required pattern="[A-Za-zΑ-Ωα-ω]{0, 20}" required title="please enter your password"><br/>
                                
                                <label class="confirm_password-label" for="confirm_password">CONFIRM PASSWORD</label><br/>
                                <input type="password" id="confirm_password" name="confirm_password" required pattern="[A-Za-zΑ-Ωα-ω]{0, 20}" required title="please re-enter your password"><br/>

                                <input type="submit" id="sign-up-btn" aria-label="sign up button" class="sign-up-btn" name="sign-up-btn" value="SIGN UP"/>
                            </form>
                        </section>
                    </div>
                </div>
            </div>

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
        	user_email = (String)session.getAttribute("user_email"); 
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
        
        <div align="center">
            <h1>RUSTIC</h1>
                <div class="container myCont3">
	                <div class="row">
	                    <% 
		                    conn = null;
		                    img = "";
		                    name = "";
		                    price = 0.0;
		                    int availability = 0;
		                    String collection = "";
		            		try {
		            			Class.forName("com.mysql.cj.jdbc.Driver");
		            			conn = DriverManager.getConnection(DB_URL, USER, PASS);
		            			
		            			ResultSet rs;
		            			PreparedStatement ps = conn.prepareStatement("SELECT * FROM products WHERE collection = 'RUSTIC'");
		                        rs = ps.executeQuery();
		                        
		                        int i = 0;
		                        
		                        while(rs.next()) 
		                        { 
		                        	i++;
		                        	img = rs.getString("img");
					            	name = rs.getString("name");
					            	price = rs.getDouble("price");
					            	availability = rs.getInt("availability");
					            	collection = rs.getString("collection");%> 
		                        	<div class="col-md-3">
	                            		<button style="background-color: white; border: none; outline: none;" type="button" data-toggle="modal" data-target="#rustic-Modal-<%out.print(i);%>"><img class="img-fluid w-100 img" src="<%out.print(img);%>" size="50%" alt="candle image"></button>
		                                <div class="candle-names">
		                                    <%out.print(name);%>
		                                </div>
		                                <div class="candle-price">
		                                    <%out.print(price.intValue());%>&euro;
		                                </div>
			                            <!--ITEM MODAL-->
			                            <div class="modal" id="rustic-Modal-<%out.print(i);%>">
			                                <div class="modal-dialog modal-lg">
			                                    <div class="modal-content">
			                                        <div class="modal-header">
			                                            <h3 class="modal-title"><%out.print(name);%></h3>
			                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
			                                        </div>
			                                        <section class="product-information" text-align="center">
			                                            <img class="modal-img" src="<%out.print(img);%>" width="337" height="337" alt="candle image">
			                                            <div class="info">
			                                                <form method="POST">
			                                                    <label class="name-label" for="name" style="white-space: pre-wrap;">Name: </label>
			                                                    <input style="white-space: pre-wrap; border: none; width: 150px;" type="text" id="name" name="name" value="<%out.print(name);%>" readonly><br>
			
			                                                    <label class="price-label" for="price">Price: </label>
			                                                    <input type="text" id="price" style="width: 30px; border: none;" name="price" value="<%out.print(price.intValue());%>" readonly><span style="font-weight: 100;">&euro;</span><br> 
			
			                                                    <label class="availability-label" for="availability">Availability: </label>
			                                                    <input type="text" id="availability" style="width: 30px; border: none;" name="availability" value="<%out.print(availability);%>" readonly> <span style="font-weight: 100;"> items left</span><br>
			                                                    
			                                                    <label class="quantity-label" for="quantity">Quantity:</label>
			                                                    <input type="number" id="quantity" name="quantity" style="width: 50px; font-weight: 100; border: none" value="1" min="1" max="<%out.print(availability);%>"><br>
			                                                    
			                                                    <label class="colour-label" for="colour">Colour:</label>
			                                                    <select id="colour" name="colour">
			                                                        <option value="white">WHITE</option>
			                                                        <option value="beige">BEIGE</option>
			                                                        <option value="brown">BROWN</option>
			                                                        <option value="burgundy">BURGUNDY</option>
			                                                        <option value="sage">SAGE</option>
			                                                        <option value="carnation">CARNATION</option>
			                                                        <option value="lilac">LILAC</option>
			                                                        <option value="aegean">AEGEAN</option>
			                                                    </select><br><br><br><br><br>
			
			                                                    <div class="item-btns">
			                                                        <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:160px; outline: none;" type="submit" id="favorites-btn" name="favorites-btn"><i class="fa fa-heart"></i> Add to Favorites</button>
			                                                        <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:150px; outline: none;" type="submit" id="cart-btn" name="cart-btn"><i class="fa fa-shopping-cart"></i> Add to Cart</button>
			                                                    </div>
			                                                </form>
			                                            </div>
			                                        </section>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
		                        <% } 
		            		} catch (SQLException | ClassNotFoundException e) {
			            		e.printStackTrace();
			            	}%>
	                </div>
                </div>
            </div><br><br>
        <footer>
            &copy DIVINE, 2022
        </footer>
    </body>
</html>