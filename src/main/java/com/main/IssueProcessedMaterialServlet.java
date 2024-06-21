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

public class IssueProcessedMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public IssueProcessedMaterialServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String issuerID = request.getParameter("issuer_id");
        String processedMaterialName = request.getParameter("processed_material");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String issuerName = request.getParameter("issuer_name");
        String date = request.getParameter("date");
        String time = request.getParameter("time");

        Connection con = DBConnection.connect();

        try {
            // Check if the processed material is available and has sufficient quantity
            String checkQuery = "SELECT quantity FROM pro_materials WHERE name = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkQuery);
            checkStmt.setString(1, processedMaterialName);
            ResultSet checkRs = checkStmt.executeQuery();

            if (checkRs.next()) {
                int availableQuantity = checkRs.getInt("quantity");

                if (availableQuantity >= quantity) {
                    // Sufficient quantity available, proceed with issuing

                    // Update the processed material quantity after issuing
                    String updateQuery = "UPDATE pro_materials SET quantity = ? WHERE name = ?";
                    PreparedStatement updateStmt = con.prepareStatement(updateQuery);
                    updateStmt.setInt(1, availableQuantity - quantity);
                    updateStmt.setString(2, processedMaterialName);
                    int rowsAffected = updateStmt.executeUpdate();

                    if (rowsAffected > 0) {
                        // Insert the issue record into the database
                        String insertQuery = "INSERT INTO issued_processed_materials (issuer_id, processed_material, quantity, issuer_name, date, time) VALUES (?, ?, ?, ?, ?, ?)";
                        PreparedStatement insertStmt = con.prepareStatement(insertQuery);
                        insertStmt.setString(1, issuerID);
                        insertStmt.setString(2, processedMaterialName);
                        insertStmt.setInt(3, quantity);
                        insertStmt.setString(4, issuerName);
                        insertStmt.setString(5, date);
                        insertStmt.setString(6, time);
                        insertStmt.executeUpdate();

                        request.setAttribute("message", "Processed material issued successfully.");
                    } else {
                        request.setAttribute("message", "Failed to issue processed material.");
                    }
                } else {
                    // Insufficient quantity available
                    request.setAttribute("message", "Insufficient quantity available for the selected processed material.");
                }
            } else {
                // Processed material not found in the database
                request.setAttribute("message", "Processed material not found in the database.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("issue_process_material.jsp").forward(request, response);
    }
}
