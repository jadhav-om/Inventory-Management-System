package com.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.main.DBConnection;
import com.main.Usergetset;

public class ResetPassword extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ResetPassword() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("forusername");
        String newPassword = request.getParameter("newpassword");

        Usergetset.setusername(username);
        Usergetset.setPass(newPassword);

        Connection con = DBConnection.connect();
        PrintWriter out = response.getWriter();

        try {
            PreparedStatement pstmt = con.prepareStatement("UPDATE adminlogin SET password=? WHERE username=?");
            pstmt.setString(1, newPassword);
            pstmt.setString(2, username);

            int rowsUpdated = pstmt.executeUpdate();

            if (rowsUpdated > 0) {
                out.println("<html><body>");
                out.println("<h1>Password Reset Successful</h1>");
                out.println("<p>Your password has been reset successfully.</p>");
                out.println("<p>Please login with your new password.</p>");
                out.println("</body></html>");
            } else {
                out.println("<html><body>");
                out.println("<h1>Error: Username Not Found</h1>");
                out.println("<p>The provided username was not found in the database.</p>");
                out.println("<p>Please make sure the username is correct.</p>");
                out.println("</body></html>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
