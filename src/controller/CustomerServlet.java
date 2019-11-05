package controller;

import model.Customer;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;

@WebServlet(urlPatterns = "/customers")
public class CustomerServlet extends javax.servlet.http.HttpServlet {
    private Connection getConnection() {
        Connection conn = null;
        try {
            conn = DBConnection.initializeDatabase();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String aciton = request.getParameter("action");
        Connection conn = getConnection();
        String name, address, email, phone;
        switch (aciton) {
            case "Add":
                name = request.getParameter("name");
                address = request.getParameter("address");
                email = request.getParameter("email");
                phone = request.getParameter("phone");
                try {
                    PreparedStatement ps = conn.prepareStatement("insert into tbl_customers(full_name,address,email,phone) values(?,?,?,?)");
                    ps.setString(1, name);
                    ps.setString(2, address);
                    ps.setString(3, email);
                    ps.setString(4, phone);
                    ps.executeUpdate();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect("customers?action=view");
                break;

            case "Edit":
                int id = Integer.parseInt(request.getParameter("id"));
                name = request.getParameter("name");
                address = request.getParameter("address");
                email = request.getParameter("email");
                phone = request.getParameter("phone");
                try {
                    PreparedStatement ps = conn.prepareStatement("Update tbl_customers set full_name=?,address=?,email=?,phone=? where customer_number=?");
                    ps.setString(1, name);
                    ps.setString(2, address);
                    ps.setString(3, email);
                    ps.setString(4, phone);
                    ps.setInt(5, id);
                    ps.executeUpdate();
                    ps.close();
                    conn.close();

                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect("customers?action=view");
                break;
        }
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String action = request.getParameter("action");
        Connection conn = getConnection();
        switch (action) {
            case "view":
                ArrayList<Customer> customerList = new ArrayList<>();
                try {
                    PreparedStatement ps = conn.prepareStatement("select * from tbl_customers");
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        Customer customer = new Customer();
                        customer.setId(rs.getInt(1));
                        customer.setFullName(rs.getString(2));
                        customer.setAddress(rs.getString(3));
                        customer.setEmail(rs.getString(4));
                        customer.setPhone(rs.getString(5));
                        customerList.add(customer);
                    }
                    rs.close();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                request.setAttribute("customerList", customerList);
                request.getRequestDispatcher("customerView/showCustomerList.jsp").forward(request, response);
                break;

            case "delete":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    PreparedStatement ps = conn.prepareStatement("delete from tbl_customers where customer_number=?");
                    ps.setInt(1, id);
                    ps.executeUpdate();
                    ps.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect("customers?action=view");
                break;

            case "getEditForm":
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    PreparedStatement ps = conn.prepareStatement("select * from tbl_customers where customer_number=?");
                    ps.setInt(1, id);
                    ResultSet rs = ps.executeQuery();
                    Customer newCustomer = new Customer();
                    while (rs.next()) {
                        newCustomer.setId(rs.getInt(1));
                        newCustomer.setFullName(rs.getString(2));
                        newCustomer.setAddress(rs.getString(3));
                        newCustomer.setEmail(rs.getString(4));
                        newCustomer.setPhone(rs.getString(5));
                    }
                    request.setAttribute("selectedCustomer", newCustomer);
                    request.getRequestDispatcher("customerView/EditCustomerForm.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                break;
        }
    }
}
