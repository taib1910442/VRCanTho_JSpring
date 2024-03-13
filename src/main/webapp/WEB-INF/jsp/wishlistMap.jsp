<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: trant
  Date: 8/29/2023
  Time: 12:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tuyến đường qua các điểm đến</title>
    <style>

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height: 100%;
        }
    </style>
    <style>
        #sidebar {
            width: 500px;
            height: auto;
            z-index: 9999;
            background-color: #f0f0f0;
            position: fixed;
            top: 60px;
            border-radius: 25px;
            transition: right 0.5s ease;
        }

        #content {
            margin-right: 20px;
            padding: 20px;
            z-index: 9999;
            transition: margin-right 0.5s ease;
        }

        #toggleButton {
            position: fixed;
            right: 20px;
            top: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="contact.jsp"/>
<div id="sidebar" style="right: 0px;">
    <button id="toggleButton">X</button>
    <div id="content">
        <div>
            <button id="routeButton">Tìm đường đi</button>
            <div id="routeInfo"></div>
        </div>
        <h2>Những địa điểm bạn quan tâm:</h2><br>
        <c:forEach items="${wishlistLocations}" var="wishlist" varStatus="loop">
            <span>${loop.index + 1}. ${wishlist.name}</span><br>
        </c:forEach>
        <c:forEach items="${ratings}" var="rating">
            ${rating.locationID}
        </c:forEach>
        <a href="logout">Đăng xuất</a>
    </div>

</div>


<div id="map"></div>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCxPzv8uOgzggSaHuo7kJQF3P3iagvVUH4&callback=initMap" async defer></script>
<script>
    // Xử lý sự kiện tạo bản đồ
    function initMap() {
        const map = new google.maps.Map(document.getElementById('map'), {
            center: { lat: 10.8231, lng: 106.6297 },
            zoom: 18,
            zoomControl: true,
            zoomControlOptions: {
                position: google.maps.ControlPosition.LEFT_BOTTOM,
            },
            scaleControl: true,
            streetViewControl: false,
            fullscreenControl: true,
            fullscreenControlOptions: {
                position: google.maps.ControlPosition.LEFT_CENTER,
            }
        });

        const directionsService = new google.maps.DirectionsService();
        const directionsRenderer = new google.maps.DirectionsRenderer({ map: map });
        const routeButton = document.getElementById('routeButton');
        const routeInfoDiv = document.getElementById('routeInfo');
        // Gọi API để lấy dữ liệu điểm đến
        // Xử lý sự kiện khi nút "Tìm đường đi" được nhấn
        routeButton.addEventListener('click', () => {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(position => {
                    const currentLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

                    // Gọi API để lấy dữ liệu điểm đến
                    fetch("https://loudly-primary-piglet.ngrok-free.app/webVR_war/api/getWishlistLocations")
                        .then(response => response.json())
                        .then(data => {
                            // Dữ liệu từ API
                            const waypoints = data.map(location => ({
                                location: new google.maps.LatLng(location.latitude, location.longitude),
                                stopover: true
                            }));

                            const request = {
                                origin: currentLocation, // Vị trí bản thân
                                destination: waypoints[waypoints.length - 1].location,
                                waypoints: waypoints.slice(0, waypoints.length - 1),
                                travelMode: google.maps.TravelMode.DRIVING
                            };

                            directionsService.route(request, function(result, status) {
                                if (status === google.maps.DirectionsStatus.OK) {
                                    directionsRenderer.setDirections(result);
                                    const route = result.routes[0];
                                    const totalDistance = route.legs.reduce((acc, leg) => acc + leg.distance.value, 0);
                                    const totalTime = route.legs.reduce((acc, leg) => acc + leg.duration.value, 0);

                                    const distanceInKm = (totalDistance / 1000).toFixed(2);
                                    const timeInMinutes = Math.round(totalTime / 60);

                                    routeInfoDiv.innerHTML = `Khoảng cách: ${distanceInKm} km<br>Thời gian dự kiến: ${timeInMinutes} phút`;
                                }
                            });
                        });
                });
            } else {
                routeInfoDiv.innerHTML = "Trình duyệt không hỗ trợ định vị.";
            }
        });

    }
</script>

<script>
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    const toggleButton = document.getElementById('toggleButton');

    let sidebarVisible = true;

    toggleButton.addEventListener('click', () => {
        if (sidebarVisible) {
            sidebar.style.right = '-500px';
            content.style.marginRight = '20px';
            toggleButton.textContent = '${username}';
        } else {
            sidebar.style.right = '0';
            content.style.marginRight = '20px';
            toggleButton.textContent = 'X';
        }
        sidebarVisible = !sidebarVisible;
    });
</script>
</body>
</html>
