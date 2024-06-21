package com.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateProcessedMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateProcessedMaterialServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String processedMaterialName = request.getParameter("processed_material");
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        Connection con = DBConnection.connect();

        try {
            // Check if the processed material exists in the database
            String checkQuery = "SELECT quantity FROM pro_materials WHERE name = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, processedMaterialName);
            ResultSet checkRs = checkStmt.executeQuery();

            if (checkRs.next()) {
                int currentQuantity = checkRs.getInt("quantity");

                // Calculate the updated quantity by adding the new quantity to the current quantity
                int updatedQuantity = currentQuantity + newQuantity;

                System.out.println("Current Quantity: " + currentQuantity);
                System.out.println("New Quantity: " + newQuantity);
                System.out.println("Updated Quantity: " + updatedQuantity);

                // Update the processed material quantity
                String updateQuery = "UPDATE pro_materials SET quantity = ? WHERE name = ?";
                PreparedStatement updateStmt = con.prepareStatement(updateQuery);
                updateStmt.setInt(1, updatedQuantity);
                updateStmt.setString(2, processedMaterialName);
                int rowsAffected = updateStmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("message", "Processed material quantity updated successfully.");
                } else {
                    request.setAttribute("message", "Failed to update processed material quantity.");
                }
            } else {
                request.setAttribute("message", "Processed material not found in the database.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher("update_process_material.jsp").forward(request, response);
    }
}
