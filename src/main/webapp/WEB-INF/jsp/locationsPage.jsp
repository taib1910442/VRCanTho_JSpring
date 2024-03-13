<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Locations List</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
    }

    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        padding-top: 100px;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0, 0, 0);
        background-color: rgba(0, 0, 0, .4);
    }

    .modal-content {
        background-color: #fefefe;
        margin: auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
    }

    .close {
        color: #aaaaaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: #000;
        text-decoration: none;
        cursor: pointer;
    }

</style>
<body>
<table border="1">
    <tr>
        <th>Location ID</th>
        <th>Name</th>
        <th>Address</th>
        <th>Images</th>
        <!-- ... Thêm các cột khác -->
    </tr>
    <c:forEach items="${locations}" var="location">
        <tr>
            <td>${location.locationID}</td>
            <td>${location.name}</td>
            <td>${location.address}</td>
            <td>
                <c:if test="${not empty location.image}">
                        <img src="https://360imagez.s3.ap-southeast-2.amazonaws.com/${location.image}" alt="Image"
                             width="100" height="100">
                </c:if>
                <c:if test="${empty location.image}">
                    <button type="button" class="add-image-button" data-toggle="modal" data-target="#modal" data-location-id="${location.locationID}">
                        Add Image
                    </button>
                    <div class="modal" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalLabel">Upload Image for Location <span id="modalLocationID"></span></h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form action="uploadImage" method="post" enctype="multipart/form-data">
                                        <input type="hidden" id="locationIDInput" name="locationID">
                                        <label for="imageFile">Select an image:</label>
                                        <input type="file" id="imageFile" name="imageFile" required>
                                        <button type="submit" class="btn btn-primary">Upload Image</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </td>
            <td><a href="http://localhost:8000/360vr.html?locationID=${location.locationID}" target="_blank">Xem VR</a></td>
        </tr>
    </c:forEach>
</table>

<script>
    $(document).ready(function () {
        var modal = $('.modal');
        var btn = $('.add-image-button');
        var span = $('.close');

        btn.click(function () {
            modal.show();
        });

        span.click(function () {
            modal.hide();
        });

        $(window).on('click', function (e) {
            if ($(e.target).is('.modal')) {
                modal.hide();
            }
        });
        $('.add-image-button').click(function () {
            var locationID = $(this).data('location-id');
            $('#modalLocationID').text(locationID);
            $('#locationIDInput').val(locationID);
        });
    });

</script>
</body>
</html>
