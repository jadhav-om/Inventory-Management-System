<%@ page import="java.sql.*" %>
<%@ page import="com.main.DBConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Dashboard - SB Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
   
   
    <style>
        /* Styling for the body (webpage background) */
        body {
            background-color: #e6f7ff; /* Light blue color */
        }

        /* Rest of your styles */
        /* ... */
    </style>
   
   
<style>
        /* Styling for the footer */
        .footer {
            background-color: #f8f9fa; /* Update to the color of your choice, #007bff is a blue color */
            color: #fff; /* White text color */
            padding: 15px 0;
        }

        .footer .container {
            text-align: center;
        }

        .footer .container .text-muted {
            font-size: 14px;
        }
    </style>




<button class="delete-button">Delete</button>
   
   
 <style>
    .table-container {
        border: 1px solid #ddd;
        padding: 10px;
        border-radius: 5px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .table {
        width: 100%;
        border-collapse: collapse;
    }

    .table thead th {
        background-color: #f8f9fa;
        color: #333;
        font-weight: bold;
        padding: 12px;
        border-bottom: 2px solid #ddd;
        text-align: left;
    }

    .table tbody td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
    }

    .table tbody tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .table tbody tr:hover {
        background-color: #f5f5f5;
    }
</style>
   
</head>
<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!-- Navbar Brand with Logo -->
        <a class="navbar-brand ps-3" href="dashboard.html" style="font-size: 30px;">
           <i class="fas fa-cube fa-spin" style="color: #007bff;"></i>
           <b class="animate__animated animate__heartBeat">INVENTIX</b>
       </a>
        
        <!-- Sidebar Toggle -->
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
        
        <!-- Navbar Search -->
        <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
            <div class="input-group">
                <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
            </div>
        </form>
        
        <!-- Navbar -->
        <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            <i class="fas fa-user fa-fw"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
            <!-- <li><a class="dropdown-item" href="#!">Settings</a></li>
            <li><a class="dropdown-item" href="#!">Activity Log</a></li>
            <li><hr class="dropdown-divider" /></li> -->
            <li>
                <a class="dropdown-item" href="index.html">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </li>
</ul>

    </nav>
    
    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading" style="font-size: 18px; color: white;">
                            <b>Menu Navigation</b>
                        </div>
                        <a class="nav-link" href="dashboard.html">
                            <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                            Dashboard
                        </a>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                            <div class="sb-nav-link-icon"><i class="fas fa-tools"></i></div>
                            Raw Material
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="add_raw_material.html">
                                    <div class="sb-nav-link-icon"><i class="fas fa-plus"></i></div>
                                    <span class="animate__animated animate__pulse">Add</span>
                                </a>
                                <a class="nav-link" href="view_raw_material.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-eye"></i></div>
                                    <span class="animate__animated animate__pulse">View</span>
                                </a>
                                 <a class="nav-link" href="update_raw_material.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-sync-alt"></i></div>
                                     Update
                              </a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseProcessLayouts" aria-expanded="false" aria-controls="collapseProcessLayouts">
                            <div class="sb-nav-link-icon"><i class="fas fa-cogs"></i></div>
                             Processed Material
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseProcessLayouts" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="add_process_material.html">
                                    <div class="sb-nav-link-icon"><i class="fas fa-plus-circle"></i></div>
                                    Add
                                </a>
                                <a class="nav-link" href="view_process_material.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-eye"></i></div>
                                    View
                                </a>
                                 <a class="nav-link" href="update_process_material.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-sync-alt"></i></div>
                                     Update
                              </a>
                            </nav>
                        </div>
                        <a class="nav-link" href="issue_raw_material.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-shipping-fast"></i></div>
                            Issue Raw Material
                        </a>
                        <a class="nav-link" href="issue_process_material.jsp">
                            <div class="sb-nav-link-icon"><i class="fas fa-industry"></i></div>
                            Issue Process Material
                        </a>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseViewLogs" aria-expanded="false" aria-controls="collapseViewLogs">
                            <div class="sb-nav-link-icon"><i class="fas fa-book"></i></div>
                            View Logs
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseViewLogs" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="view_logs_raw.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-database"></i></div>
                                    Raw
                                </a>
                                <a class="nav-link" href="view_logs_processed.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-cogs"></i></div>
                                    Processed
                                </a>
                            </nav>
                        </div>
                        <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseUnavailableItems" aria-expanded="false" aria-controls="collapseUnavailableItems">
                            <div class="sb-nav-link-icon"><i class="fas fa-exclamation-circle"></i></div>
                            Unavailable Items
                            <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                        </a>
                        <div class="collapse" id="collapseUnavailableItems" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link" href="raw_unavailable_items.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-database"></i></div>
                                    Raw
                                </a>
                                <a class="nav-link" href="process_unavailable_items.jsp">
                                    <div class="sb-nav-link-icon"><i class="fas fa-cogs"></i></div>
                                    Processed
                                </a>
                            </nav>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Inventory Manager
                    </div>
                </div>
            </nav>
        </div>
   
   
   
   <div id="layoutSidenav_content">
    <main>
        <div class="container-fluid px-4">
            <h1 class="mt-4 text-center">View Processed Material</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item">Dashboard</li>
                <li class="breadcrumb-item active">View Processed Material</li>
            </ol>
            <div class="card mb-4">
                <div class="card-body">
                    <div class="table-container">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Quantity</th>
                                    <th>Unit</th>
                                    <th>Cost per Unit</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                try {
                                    // Import the required classes and packages for database connection and querying
                                    // Connect to the database
                                    Connection con = DBConnection.connect();
                                    // Execute the SQL query to fetch processed materials data
                                    Statement stmt = con.createStatement();
                                    ResultSet rs = stmt.executeQuery("SELECT * FROM pro_materials");
                                    // Iterate over the result set and populate the table rows dynamically
                                    while (rs.next()) {
                                        String id = rs.getString("id");
                                        String name = rs.getString("name");
                                        int quantity = rs.getInt("quantity");
                                        String unit = rs.getString("unit");
                                        double cost = rs.getDouble("costperunit");
                                %>
                                <tr>
                                    <td><%= id %></td>
                                    <td><%= name %></td>
                                    <td><%= quantity %></td>
                                    <td><%= unit %></td>
                                    <td><%= cost %></td>
                                    <td>
                                        <a href="delete_process_material.jsp?id=<%= id %>" class="btn btn-primary btn-sm">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                                <% 
                                    }
                                    // Close the database connection and result set
                                    rs.close();
                                    stmt.close();
                                    con.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
     <footer class="footer mt-auto py-3">
    <div class="container text-center">
        <span class="text-muted">
            &copy; 2023 Inventix. All rights reserved. | Designed <i class="fas fa-gem" style="color: #ff4d4d;"></i> by Om Jadhav
        </span>
    </div>
</footer>
    
</div>
   
   
        
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="assets/demo/chart-area-demo.js"></script>
    <script src="assets/demo/chart-bar-demo.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>
</body>
</html>
