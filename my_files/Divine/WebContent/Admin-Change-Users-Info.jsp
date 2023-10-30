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
        <title>DIVINE | Users</title>
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

            .users {
                text-align: center;
                font-family: 'Noto Serif Display', serif;
                font-weight: 300;
            }
        </style>
    </head>
    <body>
    
    	<%
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

		if(request.getParameter("update-user-details-btn") != null) {
			
			String first_name = request.getParameter("first_name");
			String surname = request.getParameter("surname");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/updateUser/"+first_name+"/"+surname+"/"+email+"/"+password);
			ClientResponse myresponse = webResource.accept("text/plain").get(ClientResponse.class);
			
			if (myresponse.getStatus() != 200) {
				throw new RuntimeException("Failed: HTTP error code : " + myresponse.getStatus());
			}
		
			String output = myresponse.getEntity(String.class);
		}
		
		if(request.getParameter("delete-user-details-btn") != null) {
		
			String email = request.getParameter("email");
			
			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:8080/Divine/rest/DivineServices/deleteUser/"+email);
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
                        <a class="nav-link active" href="Admin-Change-Users-Info.jsp">USERS</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Admin-Change-Products-Info.jsp">PRODUCTS</a>
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

        <div class="users container">
            <table class="table">
                <tr>
                    <th>first name</th>
                    <th>surname</th>
                    <th>email</th>
                    <th>password</th>
                </tr>

                <% 
                final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
	            final String DB_URL = "jdbc:mysql://localhost/divine?autoReconnect=true&useSSL=false&allowPublicKeyRetrieval=true";
 	           
	            final String USER = "admin";
	            final String PASS = "peggymysql2022";
	            
                Connection conn = null;
                String first_name = "";
                String surname = "";
                String email = "";
                String password = "";
        		try {
        			Class.forName("com.mysql.cj.jdbc.Driver");
        			conn = DriverManager.getConnection(DB_URL, USER, PASS);
        			
        			ResultSet rs;
        			PreparedStatement ps = conn.prepareStatement("SELECT * FROM users");
                    rs = ps.executeQuery();%>
                    
                    <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:150px; outline: none;" type="button" data-toggle="modal" data-target="#add-user-Modal"><i class="fa fa-user"> Add new user</i></button>
                    
                    <%int i = 0;
                    while(rs.next()) 
                    { 
                    	i++;
                    	first_name = rs.getString("first_name");
		            	surname = rs.getString("surname");
		            	email = rs.getString("email");
		            	password = rs.getString("password");
		            	
		            	if (!email.contentEquals("guest@gmail.com") && !email.contentEquals("admin@gmail.com")) { %>
                    		
                        	<tr>
                                <td><% out.print(first_name); %></td>
                                <td><% out.print(surname); %></td>
                                <td><% out.print(email); %></td>
                                <td><% out.print(password); %></td>

                                <td> <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#edit-user-Modal-<%out.print(i);%>"><i class="fa fa-edit"></i></button></td>
                                <td> <button style="background-color: #dfe0df;color: #674335; border-right-color: #4b8178;border-bottom-color: #4b8178;font-size: 16px; width:30px; outline: none;" type="button" data-toggle="modal" data-target="#delete-user-Modal-<%out.print(i);%>"><i class="fa fa-trash"></i></button></td>
                            </tr><br>
                        <% } %>
                        <div class="modal" id="edit-user-Modal-<%out.print(i);%>">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title">UPDATE USER</h3>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <section class="Update-Form" text-align="center">
                                        <form method='POST'> 
                                            <label class='first_name-label' for='first_name'>FIRST NAME</label><br/>
                                            <input type='text' id='first_name' name='first_name' value='<%out.print(first_name);%>' aria-label='first name' pattern='\S+.*'><br/>
                                            
                                            <label class='surname-label' for='surname'>SURNAME</label><br/>
                                            <input type='text' id='surname' name='surname' value='<%out.print(surname);%>' aria-label='surname' pattern='\S+.*'><br/>

                                            <label class='email-label-2' for='email'>EMAIL</label><br/>
                                            <input type='text' id='email' name='email' value='<%out.print(email);%>' aria-label='email' readonly pattern='\S+.*'><br/>

                                            <label class='password-label-2' for='password'>PASSWORD</label><br/>
                                            <input type='text' id='password' name='password' value='<%out.print(password);%>' aria-label='password' readonly pattern='[A-Za-zΑ-Ωα-ω]{0, 20}'><br/>
                                            
                                            <input type='submit' id='update-user-details-btn' aria-label='update user details button' name='update-user-details-btn' value='UPDATE'/>
                                        </form>
                                    </section>
                                </div>
                            </div>
                        </div>

                        <div class="modal" id="delete-user-Modal-<%out.print(i);%>" class="delete-user">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title">DELETE USER</h3>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <section class="Delete-Form" text-align="center">
                                        <form method='POST'> 
                                            <label class='delete-label' style="color: black;" for='email'>Are you sure you want to delete user with email:</label><br/>
                                            <input type='text' id='email' style="border: none; width: 180px;" name='email' value='<%out.print(email);%>' readonly aria-label='user email'>?<br/>
                                            
                                            <input type='submit' id='delete-user-details-btn' style="margin: 15px;" aria-label='delete user details button' name='delete-user-details-btn' value='YES'/>
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
            
            <div class="modal" id="add-user-Modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3 class="modal-title">ADD USER</h3>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <section class="Sign-Up-Form" text-align="center">
                            <form method="POST" oninput='confirm_password.setCustomValidity(confirm_password.value != password.value ? "passwords do not match" : "")'>
                                <label class="first_name-label" for="first_name">FIRST NAME</label><br/>
                                <input type="text" id="first_name" name="first_name" aria-label="first name" required title="please enter first name" required minlength="1" pattern="\S+.*"><br/>
                                
                                <label class="surname-label" for="surname">SURNAME</label><br/>
                                <input type="text" id="surname" name="surname" aria-label="surname" required title="please enter surname" required minlength="1" pattern="\S+.*"><br/>

                                <label class="email-label-2" for="email">EMAIL</label><br/>
                                <input type="email" id="email" name="email" required title="please enter ur email"><br/>
                                
                                <label class="password-label-2" for="password">PASSWORD</label><br/>
                                <input type="password" id="password" name="password" required pattern="[A-Za-zΑ-Ωα-ω]{0, 20}" required title="please enter password"><br/>
                                
                                <label class="confirm_password-label" for="confirm_password">CONFIRM PASSWORD</label><br/>
                                <input type="password" id="confirm_password" name="confirm_password" required pattern="[A-Za-zΑ-Ωα-ω]{0, 20}" required title="please re-enter password"><br/>

                                <input type="submit" id="sign-up-btn" aria-label="sign up button" name="sign-up-btn" value="ADD NEW USER"/>
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