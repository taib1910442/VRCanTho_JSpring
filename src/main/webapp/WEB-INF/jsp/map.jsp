<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bản đồ</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine/dist/leaflet-routing-machine.css">
    <link rel="stylesheet" href="<c:url value="/css/styles.css" />"/>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    <style>
        #container {
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            margin-top: 100px;
        }

        #map {
            width: 70%; /* Chiều rộng của bản đồ */
            height: 580px;
        }

        #controls {
            flex: 1;
            padding: 10px;
        }

        #places,
        #nearbyRestaurants,
        #searchInput {
            margin-bottom: 10px;
        }

        .search-results {
            list-style: none;
            padding: 0;
        }

        .search-results li {
            cursor: pointer;
            padding: 8px;
            background-color: #f9f9f9;
            border-bottom: 1px solid #ccc;
        }
        #controls {
            position: relative;
        }

    </style>
    <style>
        .autocomplete {
            position: relative;
            display: inline-block;
        }

        .search-results {
            position: absolute;
            border-bottom: none;
            border-top: none;
            z-index: 99;
            /*position the autocomplete items to be the same width as the container:*/
            top: 100%;
            left: 0;
            right: 0;
        }

        .search-results div {
            padding: 10px;
            cursor: pointer;
            background-color: #fff;
            border: 1px solid #ccc;
            border-bottom: 1px solid #d4d4d4;
        }

        /*when hovering an item:*/
        .search-results div:hover {
            background-color: #e9e9e9;
        }
        #directionsInfo {
            margin-top: 10px;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
.e29_289{
    width:150px!important;
    height:20px!important;
    top: 15px!important;
}
    </style>

</head>

<body>



<div class=e76_2>
    <div class="e76_3" style="display: block;"></div>
    <a class="e29_289" href="home.jsp"><img src="images/logo.png" alt="logo" class="h-25"></a>
    <div id="container" class="space-x-4 p-4">

        <div class="grid grid-cols-12 gap-y-4 w-full">
            <div class="p-4 col-span-12">
                <h1 class="mb-1 font-bold text-3xl">Bản đồ</h1>
            </div>
            <div class="p-4 col-span-8">
                <div id="map" class="h-96" style="width: 100%!important;"></div>
            </div>
            <div class="p-4 col-span-4">
                <div id="controls" class="flex-1 p-4">
                    <div class="autocomplete" style="width: 100%;">
                        <input id="searchInput" type="text" class="block w-full bg-white border border-gray-300 rounded-md p-2 mb-4" placeholder="Tìm kiếm địa điểm du lịch">
                        <ul id="searchResults" class="search-results"></ul>
                    </div>
                    <select id="places" class="block w-full bg-white border border-gray-300 rounded-md p-2 mb-4">
                        <option value="none">Trống</option>
                        <option value="food">Địa điểm ăn uống đặc sản</option>
                        <option value="travel">Địa điểm du lịch</option>
                    </select>
                    <div id="nearbyRestaurants" style="display: none;">
                        <h2 class="text-xl font-semibold mb-2">Quán ăn/nhà hàng đặc sản gần đó:</h2>
                        <ul id="restaurantList" class="list-disc pl-6 space-y-2"></ul>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>


<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>

<!-- Sau khi đã thêm thư viện Leaflet, thêm thư viện Leaflet Routing Machine -->
<script src="https://unpkg.com/leaflet-routing-machine@3.2.12/dist/leaflet-routing-machine.js"></script>

<!-- Tiếp theo, bạn có thể thêm mã JavaScript của bạn -->

<script>
    var map = L.map('map').setView([10.032308466836616, 105.78816910381381], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        crossOrigin: true
    }).addTo(map);

    var travelMarkers = [
        <c:forEach items="${locations}" var="location">
        { name: '${location.name}', lat: ${location.latitude}, lng: ${location.longitude} },
        </c:forEach>
    ];

    var restaurantMarkers = [
        <c:forEach items="${restaurants}" var="restaurant">
        { name: '${restaurant.restaurantName}', lat: ${restaurant.lat}, lng: ${restaurant.lng} },
        </c:forEach>
    ];

    var travelLayer = L.layerGroup();
    var restaurantLayer = L.layerGroup();
    var restaurantMarkerLayer = L.layerGroup(); // Layer cho các marker của nhà hàng khi xem trên bản đồ
    var currentRestaurantMarker = null; // Marker hiện tại đang được xem
    var currentTravelMarker = null; // Marker địa điểm du lịch hiện tại

    for (var i = 0; i < travelMarkers.length; i++) {
        var marker = L.marker([travelMarkers[i].lat, travelMarkers[i].lng]).bindPopup(travelMarkers[i].name);
        marker.on('click', function (e) {
            showNearbyRestaurants(e.latlng);
        });
        travelLayer.addLayer(marker);
    }

    for (var i = 0; i < restaurantMarkers.length; i++) {
        var marker = L.marker([restaurantMarkers[i].lat, restaurantMarkers[i].lng]).bindPopup(restaurantMarkers[i].name);
        restaurantLayer.addLayer(marker);
    }

    var baseMaps = {
        "OpenStreetMap": L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
        })
    };

    var overlayMaps = {
        "Tất cả địa điểm": L.layerGroup([travelLayer, restaurantLayer, restaurantMarkerLayer]),
        "Địa điểm du lịch": travelLayer
    };

    L.control.layers(baseMaps, overlayMaps).addTo(map);

    document.getElementById('places').addEventListener('change', function () {
        var selectedValue = this.value;
        if (selectedValue === 'travel') {
            map.removeLayer(restaurantLayer);
            map.addLayer(travelLayer);
            document.getElementById('nearbyRestaurants').style.display = 'none';
            restaurantMarkerLayer.clearLayers();
            currentRestaurantMarker = null;
            map.removeLayer(restaurantMarkerLayer);
            if (currentTravelMarker) {
                map.removeLayer(currentTravelMarker);
            }
        } else if (selectedValue === 'food') {
            map.removeLayer(travelLayer);
            map.addLayer(restaurantLayer);
            document.getElementById('nearbyRestaurants').style.display = 'block';
            restaurantMarkerLayer.clearLayers();
            currentRestaurantMarker = null;
            map.removeLayer(currentTravelMarker);
        } else {
            map.removeLayer(travelLayer);
            map.removeLayer(restaurantLayer);
            document.getElementById('nearbyRestaurants').style.display = 'none';
            restaurantMarkerLayer.clearLayers();
            currentRestaurantMarker = null;
            if (currentTravelMarker) {
                map.removeLayer(currentTravelMarker);
            }
        }
    });

    function showNearbyRestaurants(latlng) {
        var nearbyRestaurants = findNearbyRestaurants(latlng, restaurantMarkers, 5);
        var restaurantList = document.getElementById('restaurantList');
        restaurantList.innerHTML = '';

        if (nearbyRestaurants.length > 0) {
            document.getElementById('nearbyRestaurants').style.display = 'block';
            nearbyRestaurants.forEach(function (restaurant) {
                var li = document.createElement('li');
                li.textContent = restaurant.name + ' - Khoảng cách: ' + latlng.distanceTo([restaurant.lat, restaurant.lng]).toFixed(2) + ' mét  ';

                var viewOnMapButton = document.createElement('button');
                viewOnMapButton.textContent = 'Xem trên bản đồ';
                viewOnMapButton.className = 'bg-blue-500 text-white py-2 px-4 rounded';
                viewOnMapButton.addEventListener('click', function () {
                    showRestaurantOnMap(restaurant);
                });

                li.appendChild(viewOnMapButton);
                restaurantList.appendChild(li);
            });
        }
    }

    function showRestaurantOnMap(restaurant) {
        if (currentRestaurantMarker) {
            restaurantMarkerLayer.removeLayer(currentRestaurantMarker);
        }
        var marker = L.marker([restaurant.lat, restaurant.lng]).addTo(restaurantMarkerLayer);
        currentRestaurantMarker = marker;
        marker.bindPopup(restaurant.name);
        map.addLayer(restaurantMarkerLayer);
        map.setView([restaurant.lat, restaurant.lng], 17);
    }

    function findNearbyRestaurants(latlng, markers, num) {
        var nearbyRestaurants = markers.slice();
        nearbyRestaurants.sort(function (a, b) {
            var distanceA = latlng.distanceTo([a.lat, a.lng]);
            var distanceB = latlng.distanceTo([b.lat, b.lng]);
            return distanceA - distanceB;
        });
        return nearbyRestaurants.slice(0, num);
    }

    // Tìm kiếm địa điểm du lịch
    var searchInput = document.getElementById('searchInput');
    var searchResults = document.getElementById('searchResults');

    searchInput.addEventListener('input', function () {
        var searchValue = this.value.toLowerCase();
        var results = [];

        if (searchValue) {
            results = travelMarkers.filter(function (marker) {
                return marker.name.toLowerCase().includes(searchValue);
            });
        }

        displaySearchResults(results);
    });

    function displaySearchResults(results) {
        searchResults.innerHTML = '';

        results.forEach(function (result) {
            var li = document.createElement('div');
            li.textContent = result.name;
            li.className = 'cursor-pointer';
            li.addEventListener('click', function () {
                map.setView([result.lat, result.lng], 17);
                searchInput.value = '';
                searchResults.innerHTML = '';
                showTravelMarker(result);
            });
            searchResults.appendChild(li);
        });
    }

    function showTravelMarker(travelMarker) {
        if (currentTravelMarker) {
            map.removeLayer(currentTravelMarker);
        }
        var marker = L.marker([travelMarker.lat, travelMarker.lng]).addTo(map);
        marker.bindPopup(travelMarker.name);
        marker.on('click', function (e) {
            showNearbyRestaurants(e.latlng);
        });
        currentTravelMarker = marker;
    }
    var routingControl = null;

    function addDirectionsButtonToPopup(marker, destination) {
        // Tạo popup cho marker
        var popup = L.popup()
            .setContent(marker.getPopup().getContent());

        marker.bindPopup(popup);

        // Thêm sự kiện "click" vào marker
        marker.on('click', function () {
            // Tạo nút "Tìm đường"
            var directionsButton = L.DomUtil.create('button', 'directions-button');
            directionsButton.innerHTML = 'Tìm đường';
            directionsButton.style.backgroundColor = '#0078d4'; // Màu nền xanh dương
            directionsButton.style.color = '#fff'; // Màu chữ trắng
            directionsButton.style.padding = '8px 16px'; // Kích thước nút
            directionsButton.style.border = 'none'; // Loại bỏ đường viền
            directionsButton.style.borderRadius = '5px'; // Bo tròn góc nút
            directionsButton.style.cursor = 'pointer'; // Biến con trỏ thành "pointer" khi di chuột vào nút
            // Gán sự kiện click cho nút "Tìm đường"
            directionsButton.addEventListener('click', function () {
                if (routingControl) {
                    map.removeControl(routingControl);
                    routingControl = null;
                }
                // Lấy vị trí hiện tại của người dùng (yêu cầu quyền vị trí)
                if ("geolocation" in navigator) {
                    navigator.geolocation.getCurrentPosition(function (position) {
                        var userLocation = [position.coords.latitude, position.coords.longitude];

                        // Sử dụng Leaflet Routing Machine để vẽ tuyến đường
                        routingControl = L.Routing.control({
                            waypoints: [
                                L.latLng(userLocation),
                                L.latLng(destination.lat, destination.lng)
                            ],
                        }).addTo(map);
                    });
                } else {
                    alert('Trình duyệt không hỗ trợ lấy vị trí của bạn.');
                }
            });

            // Thêm nút "Tìm đường" vào popup
            popup._contentNode.appendChild(directionsButton);
        });
    }



    // Thêm nút "Tìm đường đi" cho các marker
    for (var i = 0; i < travelMarkers.length; i++) {
        var marker = L.marker([travelMarkers[i].lat, travelMarkers[i].lng]).bindPopup(travelMarkers[i].name);
        addDirectionsButtonToPopup(marker, { lat: travelMarkers[i].lat, lng: travelMarkers[i].lng });
        travelLayer.addLayer(marker);
    }

    for (var i = 0; i < restaurantMarkers.length; i++) {
        var marker = L.marker([restaurantMarkers[i].lat, restaurantMarkers[i].lng]).bindPopup(restaurantMarkers[i].name);
        addDirectionsButtonToPopup(marker, { lat: restaurantMarkers[i].lat, lng: restaurantMarkers[i].lng });
        restaurantLayer.addLayer(marker);
    }


</script>

</body>
</html>

