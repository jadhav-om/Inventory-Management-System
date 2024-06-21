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

public class UpdateRawMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UpdateRawMaterialServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rawMaterialName = request.getParameter("raw_material");
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));

        Connection con = DBConnection.connect();

        try {
            // Get the current quantity of the raw material
            String getCurrentQuantityQuery = "SELECT quantity FROM raw_materials WHERE name = ?";
            PreparedStatement getCurrentQuantityStmt = con.prepareStatement(getCurrentQuantityQuery);
            getCurrentQuantityStmt.setString(1, rawMaterialName);
            ResultSet currentQuantityRs = getCurrentQuantityStmt.executeQuery();

            int currentQuantity = 0;

            if (currentQuantityRs.next()) {
                currentQuantity = currentQuantityRs.getInt("quantity");
            }

            // Calculate the updated quantity
            int updatedQuantity = currentQuantity + newQuantity;

            // Update the raw material quantity
            String updateQuery = "UPDATE raw_materials SET quantity = ? WHERE name = ?";
            PreparedStatement updateStmt = con.prepareStatement(updateQuery);
            updateStmt.setInt(1, updatedQuantity);
            updateStmt.setString(2, rawMaterialName);
            int rowsAffected = updateStmt.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("message", "Quantity updated successfully.");
            } else {
                request.setAttribute("message", "Failed to update quantity.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        request.getRequestDispatcher("update_raw_material.jsp").forward(request, response);
    }
}
