package com.main;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.main.DBConnection;

public class AddRawMaterialServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddRawMaterialServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = DBConnection.connect();
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String unit = request.getParameter("unit");
            double cost = Double.parseDouble(request.getParameter("costperunit"));

            PreparedStatement pstmt = con.prepareStatement(
                    "INSERT INTO raw_materials (id, name, quantity, unit, costperunit) VALUES (?, ?, ?, ?, ?)");
            pstmt.setString(1, id);
            pstmt.setString(2, name);
            pstmt.setInt(3, quantity);
            pstmt.setString(4, unit);
            pstmt.setDouble(5, cost);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                request.setAttribute("message", "Raw material added successfully.");
            } else {
                request.setAttribute("message", "Failed to add raw material.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("add_raw_material.html").forward(request, response);
    }
}
