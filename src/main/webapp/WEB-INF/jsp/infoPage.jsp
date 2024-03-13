<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!-- Coding By CodingNepal - codingnepalweb.com -->
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Popup Modal Box</title>
    <!-- CSS -->
    <link rel="stylesheet" href="<c:url value="/css/box.css" />"/>
    <!-- Fontawesome CDN Link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.8.1/flowbite.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <style>
        body{}
        /* About Me
        ---------------------*/
        @media (max-width: 991px) {
            .about-text {
                margin-top: 5px;
            }
        }
        .about-text h3 {
            font-size: 45px;
            font-weight: 700;
            margin: 0 0 10px;
        }
        @media (max-width: 767px) {
            .about-text h3 {
                font-size: 35px;
            }
        }
        .about-text h4 {
            font-weight: 600;
            margin-bottom: 15px;
        }
        @media (max-width: 767px) {
            .about-text h4 {
                font-size: 18px;
            }
        }
        .about-text p {
            font-size: 18px;
        }
        .about-text p mark {
            font-weight: 600;
            color: #3a3973;
        }
        .about-text .btn-bar {
            padding-top: 8px;
        }
        .about-text .btn-bar a {
            min-width: 150px;
            text-align: center;
            margin-right: 10px;
        }

        .about-list {
            padding-top: 10px;
        }
        .about-list .media {
            padding: 5px 0;
        }
        .about-list label {
            color: #3a3973;
            font-weight: 600;
            width: 88px;
            margin: 0;
            position: relative;
        }
        .about-list label:after {
            content: "";
            position: absolute;
            top: 0;
            bottom: 0;
            right: 11px;
            width: 1px;
            height: 12px;
            background: #3a3973;
            -moz-transform: rotate(15deg);
            -o-transform: rotate(15deg);
            -ms-transform: rotate(15deg);
            -webkit-transform: rotate(15deg);
            transform: rotate(15deg);
            margin: auto;
            opacity: 0.5;
        }
        .about-list p {
            margin: 0;
            font-size: 15px;
        }

        .about-img {
            box-shadow: 0 5px 14px 0 rgba(0, 0, 0, 0.06);
            padding: 10px;
            background: #ffffff;
        }
        @media (max-width: 991px) {
            .about-img {
                margin-top: 30px;
            }
        }

        .counter-section {
            padding: 40px 20px;
        }
        .counter-section .count-data {
            margin-top: 10px;
            margin-bottom: 10px;
        }
        .counter-section .count {
            font-weight: 700;
            color: #ffffff;
            margin: 0 0 10px;
        }
        .counter-section p {
            font-weight: 500;
            margin: 0;
            color: #fe4f6c;
        }
        .theme-color {
            color: #fe4f6c;
        }

        .section {
            position: relative;
        }
        .gray-bg {
            background-color: #ebf4fa;
        }
        .px-btn.theme {
            background: #fe4f6c;
            color: #ffffff;
            border: 2px solid #fe4f6c;
        }
        .px-btn {
            padding: 0 20px;
            line-height: 42px;
            border: 2px solid transparent;
            position: relative;
            display: inline-block;
            background: none;
            border: none;
            -moz-transition: ease all 0.35s;
            -o-transition: ease all 0.35s;
            -webkit-transition: ease all 0.35s;
            transition: ease all 0.35s;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
        }

        .px-btn.theme-t {
            background: transparent;
            border: 2px solid #fe4f6c;
            color: #fe4f6c;
        }

    </style>
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.2/classic/ckeditor.js"></script>


</head>
<body>
<section class="section about-section gray-bg" id="about">
    <div class="container">
        <div class="row align-items-center justify-content-around flex-row-reverse">


            <div class="col-lg-5">
                <c:if test="${role == 'ROLE_ADMIN'}">
                <button id="editButton">Chỉnh sửa</button>
                </c:if>
                <!-- Thêm biểu mẫu để chỉnh sửa nội dung -->
                <form action="../info/${info.infoId}/update" method="post">
                    <label for="newDescription"></label>
                    <div class="about-text" id="editableContent">${info.description}</div>
                    <textarea style="display:none;" type="hidden" class="about-text" id="newDescription" name="newDescription" contenteditable="true"></textarea>
                    <!-- Thêm một trường ẩn để gửi nội dung chỉnh sửa lên server -->
                    <button type="submit" id="saveButton" style="display:none;">Lưu lại</button>
                </form>

            </div>
        </div>
    </div>
</section>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Lấy tham chiếu đến vùng văn bản có thể chỉnh sửa
        const editableContent = document.getElementById("editableContent");

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
            document.getElementById("newDescription").value = editor.getData();
        });
    });

</script>
</body>
</html>