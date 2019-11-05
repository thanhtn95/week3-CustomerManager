<%@ page import="model.Customer" %><%--
  Created by IntelliJ IDEA.
  User: z-one
  Date: 11/5/19
  Time: 1:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<%
    Customer selectedCustomer = (Customer) request.getAttribute("selectedCustomer");
%>
<form method="post" action="${pageContext.request.contextPath}/customers">
    <fieldset>
        <legend><h2>Add Customer Info</h2></legend>
        <p>ID:&nbsp;<input type="number" name="id" readonly="true" value="<%=selectedCustomer.getId()%>"></p>
        <p>Name:&nbsp; <input type="text" name="name" value="<%=selectedCustomer.getFullName()%>"></p>
        <p>Address:&nbsp;<input type="text" name="address" value="<%=selectedCustomer.getAddress()%>"></p>
        <p>Email:&nbsp;<input type="text" name="email" value="<%=selectedCustomer.getEmail()%>"></p>
        <p>Phone Number:&nbsp;<input type="text" name="phone" value="<%=selectedCustomer.getPhone()%>"></p>
    </fieldset>
    <p><input type="submit" name="action" value="Edit"></p>
    <p><a href="${pageContext.request.contextPath}/customers?action=view">
        <button type="button">Back</button>
    </a></p>
</form>
</body>
</html>
