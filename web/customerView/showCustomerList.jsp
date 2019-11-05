<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Customer" %><%--
  Created by IntelliJ IDEA.
  User: z-one
  Date: 11/5/19
  Time: 10:51 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% ArrayList<Customer> customerList = (ArrayList<Customer>) request.getAttribute("customerList");%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="myStyle.css">
</head>
<body>
<fieldset>
    <table>
        <tr>
            <td>ID</td>
            <td>Name</td>
            <td>Address</td>
            <td>email</td>
            <td>Phone Number</td>
        </tr>
        <%for (int i = 0; i < customerList.size(); i++) {%>
        <tr class="notfirstTr">
            <td><%=customerList.get(i).getId()%>
            </td>
            <td><%=customerList.get(i).getFullName()%>
            </td>
            <td><%=customerList.get(i).getAddress()%>
            </td>
            <td><%=customerList.get(i).getEmail()%>
            </td>
            <td><%=customerList.get(i).getPhone()%>
            </td>
            <td><a href="${pageContext.request.contextPath}/customers?action=delete&id=<%=customerList.get(i).getId()%>"
                   onclick="return confirm('Are You Sure?')">Delete</a></td>
            <td>
                <a href="${pageContext.request.contextPath}/customers?action=getEditForm&id=<%=customerList.get(i).getId()%>">Edit</a>
            </td>
        </tr>
        <%}%>
    </table>
    <p></p>
    <p><a href="customerView/AddCustomerForm.jsp">
        <button type="button">Add New Customer</button>
    </a></p>
</fieldset>
</body>
</html>
