<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Location</title>
</head>
<script src="https://sdk.amazonaws.com/js/aws-sdk-2.357.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<body>
<h2>Add Location</h2>
<form method="post" action="saveLocation" enctype="multipart/form-data">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required><br>
    <label for="description">Description:</label>
    <textarea id="description" name="description" required></textarea><br>
    <label for="address">Address:</label>
    <input type="text" id="address" name="address" required><br>
    <label for="latitude">Latitude:</label>
    <input type="text" id="latitude" name="latitude" required><br>
    <label for="longitude">Longitude:</label>
    <input type="text" id="longitude" name="longitude" required><br>
    <label for="category">Category:</label>
    <input type="text" id="category" name="category" required><br>

    <input type="submit" onclick="s3upload()" value="Add Location">
</form>
</body>
</html>
