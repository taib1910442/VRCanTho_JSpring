<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
  Created by IntelliJ IDEA.
  User: trant
  Date: 10/16/2023
  Time: 11:55 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Collections" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sự kiện</title>
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>
    <link rel="stylesheet" href="<c:url value="/css/event.css" />"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body, html {
            margin: 0;
            padding: 0 8px;
            background-color: #aa1e3f;
        }
    </style>
    <style>
        #backButton {
            background: none;
            border: 1px;
            color: navy; /* Màu văn bản là đen */
            cursor: pointer;
            font-size: 16px; /* Kích thước chữ */
            text-decoration: underline; /* Gạch chân cho văn bản */
            display: flex;
            position: fixed;
            top: 30px; /* Cố định nút ở phía dưới màn hình cách mép dưới 20px */
            left: 20px;
            align-items: center;
        }

        #backButton::before {
            content: '\2190'; /* Mã Unicode cho mũi tên quay về (←) */
            margin-right: 5px; /* Khoảng cách giữa mũi tên và văn bản */
        }
    </style>
    <!-- Thêm vào phần CSS của trang -->
    <style>
        @keyframes fadeDown {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeUp {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(-50px);
            }
        }

        #addEventForm {
            display: none;
        }
        #eventDetailContent img {
            max-width: 100%; /* Hình ảnh sẽ không vượt quá chiều rộng của phần tử chứa nó */
            height: auto; /* Giữ tỷ lệ khung hình khi thay đổi kích thước */
        }
    </style>

</head>
<body>
<c:if test="${not empty events}">
    <c:set var="firstEvent" value="${events[0]}"/>
    <div id="test" style="color: white;"></div>
</c:if>

<div class="container" id="test2" style="display: none;">
    <h1 class="text-center my-4">Sự kiện và lễ hội Cần Thơ</h1>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">
                ${successMessage}
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
                ${errorMessage}
        </div>
    </c:if>

    <button id="backButton" style="display: none;" onclick="goBack()">Trở về</button>
<c:if test="${role == 'ROLE_ADMIN'}">
    <button type="button" class="btn btn-success" id="showAddEventFormBtn" style="margin-bottom: 50px">Thêm sự kiện</button>

    <form id="addEventForm" action="/webVR_war/events/add" method="post" style="display: none; background-color: whitesmoke;">
        <div class="form-group">
            <label for="evName">Tên sự kiện:</label>
            <input type="text" class="form-control" id="evName" name="evName" required>
        </div>

        <div class="form-group">
            <label for="evDes">Mô tả:</label>
            <textarea class="form-control" id="evDes" name="evDes" required></textarea>
        </div>

        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="isAnnual" name="isAnnual">
            <label class="form-check-label" for="isAnnual">Hằng năm</label>
        </div>

        <div class="form-check">
            <input type="checkbox" class="form-check-input" id="isLunar" name="isLunar">
            <label class="form-check-label" for="isLunar">Âm lịch</label>
        </div>

        <div class="form-group">
            <label for="evLocation">Nơi diễn ra:</label>
            <input type="text" class="form-control" id="evLocation" name="evLocation" required>
        </div>

        <div class="form-group">
            <label for="evDay">Ngày diễn ra:</label>
            <input type="number" class="form-control" id="evDay" name="evDay" required>
        </div>

        <div class="form-group">
            <label for="evMonth">Tháng diễn ra:</label>
            <input type="number" class="form-control" id="evMonth" name="evMonth" required>
        </div>

        <button type="submit" class="btn btn-primary" style="margin-bottom: 50px">Thêm sự kiện</button>
    </form>
</c:if>
    <div class="row">
        <div class="col-md-8" id="events">
            <c:forEach items="${events}" var="event">
                <div class="card" style="margin-bottom: 10px">
                    <c:if test="${role == 'ROLE_ADMIN'}">
                    <button class="btn btn-outline-danger" onclick="deleteEvent(${event.eventID})">
                        Xóa
                    </button>
                    </c:if>
                    <div class="card-body" onclick="showEventDetails(${event.eventID})">
                        <h4 class="card-title">${event.evName}</h4>

                        <p class="card-text">${event.evLocation}</p>
                        <p class="card-text">${event.evDes}</p>
                        <c:if test="${event.isLunar}">
                        <p class="card-text"><small class="text-muted" id="content${event.eventID}"></small></p>
                        </c:if>
                        <c:if test="${not event.isLunar}">
                            <p class="card-text"><small class="text-muted">Ngày diễn ra: ${event.evDay}/${event.evMonth}</small></p>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="col-md-8" id="eventDetail" style="display: none;">
<c:if test="${role == 'ROLE_ADMIN'}">
            <button id="editButton">Chỉnh sửa</button>
</c:if>
            <form method="post" id="updateEventForm">
                <label for="newContent"></label>
                <div class="post" id="eventDetailContent" style="background-color: white; padding: 15px; border-radius: 10px;">
                    <!-- Nội dung chi tiết sự kiện sẽ được cập nhật thông qua JavaScript -->
                </div>
                <textarea style="display:none;" type="hidden" class="about-text" id="newContent" name="newContent" contenteditable="true"></textarea>
                <!-- Thêm một trường ẩn để gửi nội dung chỉnh sửa lên server -->
                <button type="submit" id="saveButton" style="display:none;">Lưu lại</button>
            </form>
        </div>
        <div class="col-md-4" id="upcoming-events">
            <h3 class="my-4">Có thể bạn quan tâm:</h3>
            <c:forEach var="event2" items="${randomEvents}">
                <div class="card" style="margin-bottom: 10px">
                    <c:if test="${role == 'ROLE_ADMIN'}">
                    <button class="btn btn-outline-danger" onclick="deleteEvent(${event2.eventID})">
                        Xóa
                    </button>
                    </c:if>
                    <div class="card-body"  onclick="showEventDetails(${event2.eventID})">
                        <h4 class="card-title">${event2.evName}</h4>

                        <p class="card-text">${event2.evDes}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="<c:url value="/js/LunarSolarConverter.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/event.js" />"></script>
<script type="text/javascript">
    <c:forEach items="${events}" var="events" varStatus="loopStatus">
    <c:if test="${events.isLunar}">
    var content${events.eventID} = "";
    var converter = new LunarSolarConverter();
    var currentDate = new Date(); // Ngày hiện tại
    var foundResult = false;
    <c:if test="${loopStatus.first}">
    var currentDate2 = new Date();
    var currentYear = currentDate2.getFullYear();
    var lunar1 = new Lunar();
    lunar1.lunarYear = currentYear;
    lunar1.lunarMonth = ${events.evMonth};
    lunar1.lunarDay = ${events.evDay};

    var solar1 = converter.LunarToSolar(lunar1);

    var resultDate = new Date(solar1.solarYear, solar1.solarMonth - 1, solar1.solarDay);
    var timeDiff = resultDate - currentDate2;
    var daysDiff = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)); // 1000 milliseconds x 60 seconds x 60 minutes x 24 hours
    document.getElementById('test').innerHTML = '<img width="20" height="20" src="https://img.icons8.com/3d-fluency/94/confetti.png" alt="confetti"/> Còn ' + daysDiff + ' ngày nữa!';
    </c:if>
    for (var i = -1; i <= 20; i++) {
        var lunar = new Lunar();
        lunar.lunarYear = 2022 + i; // Năm trước, năm hiện tại và năm sau
        lunar.lunarMonth = ${events.evMonth};
        lunar.lunarDay = ${events.evDay};

        var solar = converter.LunarToSolar(lunar);

        // Tạo chuỗi kết quả theo định dạng mong muốn
        var result = "Ngày diễn ra: " + solar.solarDay + "/" + solar.solarMonth + "/" + solar.solarYear;

        // Kiểm tra nếu ngày dương lớn hơn ngày hiện tại thì mới hiển thị kết quả
        var solarDate = new Date(solar.solarYear, solar.solarMonth - 1, solar.solarDay); // Trừ đi 1 ở solarMonth vì JavaScript đếm tháng từ 0-11
        if (solarDate > currentDate && !foundResult) {
            content${events.eventID} += result;
            foundResult = true;
        }
    }

    document.getElementById('content${events.eventID}').innerHTML = content${events.eventID};
    </c:if>
    </c:forEach>
</script>
<script>
    // Hàm để kiểm tra URL có chứa #expand hay không và có giá trị id không
    function checkExpandHash() {
        var hash = window.location.hash;
        var queryParams = new URLSearchParams(window.location.search);
        if (hash === '#expand' || queryParams.has('id')) {
            document.getElementById("test").style.display = "none";
            document.getElementById("test2").style.display = "block";
        } else {
            document.getElementById("test").style.display = "block";
            document.getElementById("test2").style.display = "none";
        }
    }

    // Kiểm tra khi trang được nạp
    window.addEventListener('load', checkExpandHash);

    // Kiểm tra khi URL thay đổi
    window.addEventListener('hashchange', checkExpandHash);
</script>
<script>
    function addHyperlinksToContent() {
        var contentElement = document.getElementById('eventDetailContent');
        var content = contentElement.innerHTML;

        // Định nghĩa đối tượng ánh xạ cho các cụm từ và hyperlink tương ứng
        var wordToLinkMap = {
            "ben ninh kieu": "http://localhost:61075/R3Jhenhw/index.html#benninhkieu",
            "dinh binh thuy": "http://localhost:61075/R3Jhenhw/index.html#dinhbinhthuy",
            "luu huu phuoc": "http://localhost:61075/R3Jhenhw/index.html#cvluuhuuphuoc",
            "du lich my khanh": "http://localhost:61075/R3Jhenhw/index.html#mykhanh",
            "nha co binh thuy": "http://localhost:61075/R3Jhenhw/index.html#nhacodbt",
            "thien vien truc lam": "http://localhost:61075/R3Jhenhw/index.html#tvtruclam",
            "chua ong": "http://localhost:61075/R3Jhenhw/index.html#chuaong",
            "bao gia trang vien": "http://localhost:61075/R3Jhenhw/index.html#baogiatrangvien",
            "ong de": "http://localhost:61075/R3Jhenhw/index.html#ongde"
        };

        // Lặp qua từng cụm từ trong đối tượng ánh xạ và thêm hyperlink vào nội dung
        Object.keys(wordToLinkMap).forEach(function(word) {
            var regex = new RegExp('\\b' + word.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&') + '\\b', 'gi');
            content = content.replace(regex, '<a href="' + wordToLinkMap[word] + '">' + word + '</a>');
        });

        // Cập nhật nội dung của phần tử
        contentElement.innerHTML = content;
    }
    function showEventDetails(eventID) {
        addHyperlinksToContent();
        document.getElementById('updateEventForm').action = `/webVR_war/events/`+ eventID +`/update`;
        // Ẩn danh sách sự kiện
        document.getElementById("events").style.display = "none";
        document.getElementById("backButton").style.display = "block";
        // Hiển thị chi tiết sự kiện
        document.getElementById("eventDetail").style.display = "block";

        // Gọi AJAX để lấy chi tiết sự kiện từ server
        fetch('/webVR_war/events/details?id=' + eventID)
            .then(response => response.json())
            .then(data => {
                // Cập nhật nội dung chi tiết sự kiện
                updateEventDetailContent(data);
            })
            .catch(error => console.error('Error:', error));
    }

    function updateEventDetailContent(data) {
        // Lấy phần tử để hiển thị chi tiết sự kiện
        var eventDetailContentElement = document.getElementById("eventDetailContent");

        // Tạo HTML mới dựa trên dữ liệu từ server
        // Cập nhật nội dung chi tiết sự kiện
        eventDetailContentElement.innerHTML = data.evContent;
    }
    function goBack() {
        // Ẩn nút trở về và hiển thị forEach
        document.getElementById("backButton").style.display = "none";
        document.getElementById("eventDetail").style.display = "none";
        document.getElementById("events").style.display = "block";

        // Xóa eventID và thay đổi URL
        history.pushState({}, null, '/webVR_war/events#expand');
    }
</script>
<!-- Thêm vào cuối trang hoặc trên phần cuối của thẻ <body> -->
<!-- Thêm vào cuối trang hoặc trên phần cuối của thẻ <body> -->
<script>
    var addEventForm = document.getElementById('addEventForm');
    var showAddEventFormBtn = document.getElementById('showAddEventFormBtn');
    var isFormVisible = false;

    showAddEventFormBtn.addEventListener('click', function () {
        if (!isFormVisible) {
            // Hiển thị form với hiệu ứng fade-down
            addEventForm.style.display = 'block';
            addEventForm.style.animation = 'fadeDown 0.5s ease-in-out';

            // Đặt cờ để biết form đang được hiển thị
            isFormVisible = true;
        } else {
            // Ẩn form với hiệu ứng fade-up
            addEventForm.style.animation = 'fadeUp 0.5s ease-in-out';
            setTimeout(function () {
                addEventForm.style.display = 'none';
                // Đặt cờ để biết form đã bị ẩn
                isFormVisible = false;
            }, 500); // Thời gian giống với thời gian của hiệu ứng
        }
    });
</script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy tham chiếu đến vùng văn bản có thể chỉnh sửa
        const editableContent = document.getElementById("eventDetailContent");

        // Lấy tham chiếu đến nút "Chỉnh sửa" và "Lưu lại"
        const editButton = document.getElementById("editButton");
        const saveButton = document.getElementById("saveButton");

        let editor;
        // Khi người dùng nhấp vào nút "Chỉnh sửa"
        editButton.addEventListener("click", function () {
            // Hiển thị nút "Lưu lại" và ẩn nút "Chỉnh sửa"
            editButton.style.display = "none";
            saveButton.style.display = "inline-block";

            if (!editor) {
                // Khởi tạo CKEditor cho vùng văn bản
                ClassicEditor
                    .create(editableContent)
                    .then(newEditor => {
                        editor = newEditor;
                    })
                    .catch(error => {
                        console.error(error);
                    });
            }

            // Bật CKEditor để chỉnh sửa
            editor.isReadOnly = false;
        });

        // Khi người dùng nhấp vào nút "Lưu lại"
        saveButton.addEventListener("click", function () {
            // Ẩn nút "Lưu lại" và hiển thị nút "Chỉnh sửa"
            editButton.style.display = "inline-block";
            saveButton.style.display = "none";

            // Gán nội dung đã chỉnh sửa vào vùng văn bản
            document.getElementById("newContent").value = editor.getData();
        });
    });

</script>
<script>



    // Lấy phân đoạn từ URL
    document.addEventListener('DOMContentLoaded', function() {
    var hash2 = window.location.hash;
    var htmlElement = document.querySelector('html');
    var bodyElement = document.querySelector('body');
    var mainElement = document.getElementById('test2');
    // Kiểm tra nếu phân đoạn là "#exa" thì thay đổi màu nền thành trắng
    if (hash2 !== '') {
            bodyElement.style.backgroundColor = 'transparent';
            htmlElement.style.backgroundColor = 'transparent';
            mainElement.style.backgroundColor = 'transparent';

    } else {
        bodyElement.style.backgroundColor = '#aa1e3f';
        htmlElement.style.backgroundColor = '#aa1e3f';
    }


    });
</script>
<script type="text/javascript">
    function deleteEvent(eventId) {
        if (confirm("Bạn có chắc chắn muốn xóa sự kiện này không?")) {
            fetch(`/webVR_war/events/` + eventId + `/delete`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                    // Các headers khác nếu cần thiết
                }
            })
                .then(data => {
                    // Xử lý dữ liệu hoặc thông báo thành công nếu cần
                    console.log(data);

                    // Tải lại trang hoặc cập nhật giao diện nếu cần
                    location.reload(); // hoặc thực hiện cập nhật UI khác
                })
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        var eventLocations = document.querySelectorAll('.card-text');
        eventLocations.forEach(function(location) {
            var locationText = location.textContent.trim();
            switch (locationText) {
                case 'Bến Ninh Kiều':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#benninhkieu">Bến Ninh Kiều</a>';
                    break;
                case 'Thiền viện Trúc Lâm Phương Nam':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#tvtruclam">Thiền viện Trúc Lâm Phương Nam</a>';
                    break;
                case 'Đình Bình Thủy':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#dinhbinhthuy">Đình Bình Thủy</a>';
                    break;
                case 'Nhà cổ Bình Thủy':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#nhacodbt">Nhà cổ Bình Thủy</a>';
                    break;
                case 'Công viên Lưu Hữu Phước':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#cvluuhuuphuoc">Công viên Lưu Hữu Phước</a>';
                    break;
                case 'Du lịch sinh thái Bảo Gia Trang Viên':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#baogiatrangvien">Du lịch sinh thái Bảo Gia Trang Viên</a>';
                    break;
                case 'Làng du lịch Mỹ Khánh':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#mykhanh">Làng du lịch Mỹ Khánh</a>';
                    break;
                case 'Làng du lịch Ông Đề':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#ongde">Làng du lịch Ông Đề</a>';
                    break;
                case 'Chùa Ông':
                    location.innerHTML = '<a href="http://localhost:8088/R3Jhenhw/index.html#chuaong">Chùa Ông</a>';
                    break;
                default:
                    break;
            }
        });

        var links = document.querySelectorAll('.card-text a');
        links.forEach(function(link) {
            link.addEventListener('click', function(event) {
                event.preventDefault(); // Ngăn chặn hành động mặc định của link
                var url = this.getAttribute('href'); // Lấy URL từ href của link
                window.open(url, '_top'); // Mở URL mới trong cửa sổ trình duyệt hiện tại
            });
        });

    });

</script>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</html>

