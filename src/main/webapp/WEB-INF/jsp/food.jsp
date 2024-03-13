<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: trant
  Date: 10/19/2023
  Time: 12:30 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <title>aa</title>
    <link rel="stylesheet" href="<c:url value="/css/5.css" />"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
        ul li {
            display: list-item;
        }
        body {
            overflow-x: hidden; /* Ẩn thanh cuộn ngang */
            background-color: #ffc99c;
        }
    </style>
</head>
<body>
<c:forEach items="${foods}" var="food" varStatus="loopStatus">

    <c:if test="${loopStatus.index % 4 == 0}">
        <div class="row"> <!-- Start a new row -->
            <c:forEach var="i" begin="${loopStatus.index}" end="${loopStatus.index + 3}">
                <c:set var="food" value="${foods[i]}"/>
                <div class="col-sm-3">
                    <div class="card">
                        <div class="card-inner">
                            <div class="card-front">
                                <img width="100%" height="100%" src="${food.link}">
                            </div>
                            <div class="card-back">
                                <ul>
                                    <span style="font-size: 14px!important;"> ${food.foodName}</span>
                                    <c:forEach items="${restaurants}" var="restaurant">
                                        <c:if test="${restaurant.foodID eq food.foodID}">
                                            <li style="font-size: 10px;">${restaurant.restaurantName}
                                                - ${restaurant.restaurantLocate}</li>
                                        </c:if>
                                    </c:forEach>
                                    <b>Giá: </b><span> ${food.price}</span>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!-- Close the current row -->
    </c:if>

</c:forEach>
</body>
</html>