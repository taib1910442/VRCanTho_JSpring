<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: trant
  Date: 8/29/2023
  Time: 2:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:forEach items="${wishlist}" var="wishlist">
<tr>
    <td>${wishlist.locationID}</td>
    <td>${wishlist.name}</td>
    <td>${wishlist.latitude}</td>
    <td>${wishlist.longitude}</td>
</tr>
</c:forEach>
</body>
</html>
