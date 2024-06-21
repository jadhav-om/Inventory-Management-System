<%@ page import="java.sql.*" %>
<%@ page import="com.main.DBConnection" %>

<%
    try {
        // Retrieve the ID parameter from the request
        String id = request.getParameter("id");

        // Connect to the database
        Connection con = DBConnection.connect();

        // Prepare the SQL query to delete the raw material
        String deleteSql = "DELETE FROM pro_materials WHERE id = ?";
        PreparedStatement deleteStmt = con.prepareStatement(deleteSql);
        deleteStmt.setString(1, id);

        // Execute the delete query
        int rowsDeleted = deleteStmt.executeUpdate();

        if (rowsDeleted > 0) {
            // Prepare the SQL query to update the IDs
            String updateSql = "UPDATE pro_materials SET id = id - 1 WHERE id > ?";
            PreparedStatement updateStmt = con.prepareStatement(updateSql);
            updateStmt.setString(1, id);
            
            // Execute the update query
            int rowsUpdated = updateStmt.executeUpdate();

            // Close the prepared statements
            updateStmt.close();
            deleteStmt.close();

            // Retrieve the updated records ordered by ID
            String selectSql = "SELECT * FROM pro_materials ORDER BY id";
            Statement selectStmt = con.createStatement();
            ResultSet rs = selectStmt.executeQuery(selectSql);

            // Display the updated records in serial order
            while (rs.next()) {
                String updatedId = rs.getString("id");
                // Retrieve and display other columns as needed
                // ...

                // Display the updated record
                out.println("<tr>");
                out.println("<td>" + updatedId + "</td>");
                // Display other columns
                // ...
                out.println("</tr>");
            }

            // Close the result set and statement
            rs.close();
            selectStmt.close();
        }

        // Close the database connection
        con.close();

        // Redirect back to the "view_raw_material.jsp" page after deletion and updating IDs
        response.sendRedirect("view_process_material.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
        // Handle any potential exceptions or error messages
    }
%>
