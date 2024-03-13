<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Welcome</title>
</head>

<body>
<%-- Ki?m tra xem bi?n "username" có giá tr? hay không --%>
<c:if test="${not empty username}">
    <table>
        <tr>
            <td>${username}</td>
        </tr>
        <tr>
        </tr>
        <tr>
        </tr>
        <tr>
            <td><a href="logout">Log out</a>
            </td>
        </tr>
    </table>
</c:if>

<%-- N?u bi?n "username" là null, hi?n th? thông báo --%>
<c:if test="${empty username}">
    <p>You are not authorized to access this page. Please log in.</p>
</c:if>
</body>

</html>