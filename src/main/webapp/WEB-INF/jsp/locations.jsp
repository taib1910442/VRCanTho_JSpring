<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Danh sách địa điểm du lịch</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="<c:url value="/css/styles.css" />"/>
<link rel="stylesheet" href="<c:url value="/css/locationsList.css" />"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.8.1/flowbite.min.css" rel="stylesheet"/>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
    /* Tạo khoảng cách giữa các thẻ <tr> */
    tr {
        margin-bottom: 20px; /* Điều chỉnh khoảng cách theo mong muốn */
    }

    /* Tạo khung cho các thẻ <tr> */
    tr {
        border: 1px solid black; /* Tạo khung đen cho thẻ <tr> */
    }

    /* Tạo khung chỉ cho phần nội dung của thẻ <tr> */
    td {
        border: 1px solid black; /* Tạo khung đen cho ô <td> */
        padding: 5px; /* Tạo khoảng cách giữa nội dung và khung */
    }

    .modal-dialog {
        overflow-y: initial !important
    }

    .modal-body {
        height: 500px;
        overflow-y: auto;
    }

    /* CSS cho ngôi sao */
    .rate {
        float: left;
        height: 46px;
        padding: 0 10px;
    }

    .rate:not(:checked) > input {
        position: absolute;
        top: -9999px;
    }

    .rate:not(:checked) > label {
        float: right;
        width: 1em;
        overflow: hidden;
        white-space: nowrap;
        cursor: pointer;
        font-size: 30px;
        color: #ccc;
    }

    .rate:not(:checked) > label:before {
        content: '★ ';
    }

    .rate > input:checked ~ label {
        color: #ffc700;
    }

    .rate:not(:checked) > label:hover,
    .rate:not(:checked) > label:hover ~ label {
        color: #deb217;
    }

    .rate > input:checked + label:hover,
    .rate > input:checked + label:hover ~ label,
    .rate > input:checked ~ label:hover,
    .rate > input:checked ~ label:hover ~ label,
    .rate > label:hover ~ input:checked ~ label {
        color: #c59b08;
    }
    .fixedTextarea {
        resize: none; /* Tắt chức năng kéo */
        width: 100%; /* Đặt chiều rộng ban đầu */
        height: 30%; /* Đặt chiều cao ban đầu */
    }
</style>
<body>
<c:if test="${not empty resultMessage}">
    ${resultMessage}
</c:if>
<c:if test="${not empty role and (role == 'ROLE_ADMIN' or role == 'ROLE_MANAGER')}">
    <table border="1">
        <tr>
            <th>Location ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>Images</th>
            <!-- ... Thêm các cột khác -->
        </tr>
        <c:forEach items="${locationsList}" var="location">
            <tr>
                <td>${locationsList.locationID}</td>
                <td>${locationsList.name}</td>
                <td>${locationsList.address}</td>
                <td>
                    <c:if test="${not empty location.image}">
                        <img src="https://360imagez.s3.ap-southeast-2.amazonaws.com/${location.image}" alt="Image"
                             width="100" height="100">
                    </c:if>
                    <c:if test="${empty location.image}">
                        <%--<button type="button" class="add-image-button" data-toggle="modal" data-target="#modal"
                                data-location-id="${location.locationID}">
                            Add Image
                        </button>
                        <div class="modal" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel"
                             aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalLabel">Upload Image for Location <span
                                                id="modalLocationID"></span></h5>
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
                        </div>--%>
                    </c:if>
                </td>
                <td><a href="http://localhost:8000/360vr.html?locationID=${location.locationID}" target="_blank">Xem
                    VR</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<c:if test="${empty role or (role == 'ROLE_USER')}">
    <div class=e76_2>
        <div class="e76_3"></div>
        <a class="e29_289" href="home.jsp">VRCanTho</a><span class="e76_1785">Khám phá</span>
        <div class="e76_38">
            <div class="e76_39">
                loại hình du lịch
                <c:forEach items="${sessionScope.ratings}" var="rating">
                    <p>Đánh giá: ${rating.ratingValue}</p>
                   <%-- <p>Bình luận: ${rating.comment}</p>--%>
                </c:forEach>
            </div>
        </div>
        <span class="e76_888">Tài khoản</span>

        <div class="e93_200">
            <form id="searchForm" action="search" method="GET">
                <label for="default-search" class="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-white">Tìm kiếm</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none">
                        <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true"
                             xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="m19 19-4-4m0-7A7 7 0 1 1 1 8a7 7 0 0 1 14 0Z"></path>
                        </svg>
                    </div>
                    <input type="text" id="default-search" name="keyword"
                           class="block w-full p-4 pl-10 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                           placeholder="Nhập tên địa điểm cần tìm..." onkeydown="if (event.keyCode == 13) this.form.submit();">
                    <button type="button" id="clearInput" class="absolute inset-y-0 right-0 flex items-center pr-3 cursor-pointer">
                        <svg class="w-4 h-4 text-gray-500 dark:text-gray-400" aria-hidden="true"
                             xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                  d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
            </form>

        </div>
        <div class="e93_1799" id="list1">

            <c:forEach items="${empty location ? locationsList : location}" var="locationsList">
                <div class="relative flex flex-col md:flex-row md:space-x-5 space-y-3 md:space-y-0 rounded-xl shadow-lg p-3 border border-white bg-white"
                     style="margin-bottom: 10px;">
                    <div class="md:w-1/3 bg-white grid place-items-center">
                        <img src="https://360imagez.s3.ap-southeast-2.amazonaws.com/${locationsList.imageThumb}"
                             alt="tailwind logo" class="rounded-xl image-zoom">
                    </div>
                    <div class="w-full md:w-2/3 bg-white flex flex-col space-y-2 p-3">
                        <div class="flex justify-between item-center">
                            <p class="text-gray-500 font-medium hidden md:block">${locationsList.category}</p>
                            <div class="flex items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-yellow-500"
                                     viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                </svg>
                                <c:import var="ratingValue"
                                          url="http://localhost:8080/webVR_war/rate/location?locationID=${locationsList.locationID}"/>
                                <c:set var="roundedRating" value="${ratingValue}"/>
                                <c:choose>
                                    <c:when test="${not empty roundedRating}">
                                        <script>
                                            var ratingValue = ${ratingValue};
                                            var roundedRating = ratingValue.toFixed(1);
                                            document.write(roundedRating);
                                        </script>
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                                <p class="text-gray-600 font-bold text-sm ml-1">
                                    Điểm
                                    <span class="text-gray-500 font-normal">
                                            <c:choose>
                                                <c:when test="${not empty locationsList.locationID}">
                                                    (<c:import var="totalRatingCount"
                                                               url="https://loudly-primary-piglet.ngrok-free.app/webVR_war/rate/locationTotalRate?locationID=${locationsList.locationID}"/>
                                                    ${totalRatingCount} lượt đánh giá )
                                                </c:when>
                                                <c:otherwise>
                                                    ( 0 lượt đánh giá )
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                </p>
                            </div>
                            <div class="">
                                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-pink-500"
                                     viewBox="0 0 20 20" fill="none">
                                    <path stroke="currentColor" stroke-width="2"
                                          d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z"></path>
                                </svg>
                                    <%--<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-pink-500"
                                         viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd"
                                              d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z"
                                              clip-rule="evenodd"></path>
                                    </svg>--%>
                            </div>
                        </div>
                        <h3 class="font-black text-gray-800 md:text-3xl text-xl">${locationsList.name}</h3>
                        <p class="md:text-lg text-gray-500 text-base">${locationsList.description}</p>
                        <div class="flex justify-between item-center">
                            <div class="flex items-center">
                                <a class="text-xl font-black text-gray-800"
                                   href="https://taib1910442.github.io/360vr?locationID=${locationsList.locationID}"
                                   target="_blank">
                                    <div class="flex items-center">
                                        <span style="margin-right: 10px">Xem VR</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25"></path></svg>
                                    </div>
                                </a>
                            </div>
                            <div class="flex items-center">
                                <a class="text-xl font-blue"
                                   href="http://localhost:8080/webVR_war/location/${locationsList.locationID}"
                                   target="_blank">
                                    <div class="flex items-center">
                                        <span class="text-xl font-black text-gray-800" style="margin-right: 10px">Xem bản đồ</span>
                                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5"><path stroke-linecap="round" stroke-linejoin="round" d="M13.5 6H5.25A2.25 2.25 0 003 8.25v10.5A2.25 2.25 0 005.25 21h10.5A2.25 2.25 0 0018 18.75V10.5m-10.5 6L21 3m0 0h-5.25M21 3v5.25"></path></svg>
                                    </div>
                                </a>
                            </div>
                            <div class="flex items-center">
                                <script>
                                    document.addEventListener('DOMContentLoaded', function () {

                                        const abrirModal_${locationsList.locationID} = document.getElementById('abrirModal_${locationsList.locationID}');
                                        const modal_${locationsList.locationID} = document.getElementById('modal_${locationsList.locationID}');

                                        abrirModal_${locationsList.locationID}.addEventListener('click', () => {
                                            modal_${locationsList.locationID}.classList.remove('hidden');
                                        });

                                        modal_${locationsList.locationID}.addEventListener('click', (event) => {
                                            if (event.target === modal_${locationsList.locationID}) {
                                                modal_${locationsList.locationID}.classList.add('hidden');
                                            }
                                        });

                                    });
                                </script>
                                <button id="abrirModal_${locationsList.locationID}"
                                        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                    Bình luận
                                </button>
                                <div id="modal_${locationsList.locationID}" style="z-index: 9999; overflow: hidden;"
                                     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                                    <div class="bg-white p-4 rounded-lg modal-dialog"
                                         style="width: 80%; overflow-y: scroll;">
                                        <div class="aspect-w-16 aspect-h-9">
                                            <div class="w-fullbg-white rounded-lg border p-1 md:p-3 m-10 modal-body">
                                                <h3 class="font-semibold p-1">Bình luận</h3>
                                                <div class="flex flex-col gap-5 m-3">
                                                    <form action="api/comments/add" method="post" id="commentForm_${locationsList.locationID}" class="comment-form" enctype="multipart/form-data">
                                                        <div class="w-full px-3 mt-6">
        <textarea class="content bg-gray-100 rounded border border-gray-400 leading-normal resize-none w-full h-20 py-2 px-3 font-medium placeholder-gray-400 focus:outline-none focus:bg-white"
                  name="content" id="content_${locationsList.locationID}" placeholder="Nội dung..." required></textarea>
                                                        </div>
                                                        <input type="hidden" name="username" id="username" value="${username}">
                                                        <input type="hidden" name="locationID" id="locationID_${locationsList.locationID}" value="${locationsList.locationID}"><br>

                                                        <div class="w-full flex justify-end px-3">
                                                            <button id="target_${locationsList.locationID}" class="px-2.5 py-1.5 rounded-md text-white text-sm bg-red-500 text-lg mr-2">Xóa</button>
                                                            <input type="submit" class="px-2.5 py-1.5 rounded-md text-white text-sm bg-indigo-500 text-lg" value='Gửi'>
                                                        </div>

                                                    </form>
                                                    <script>
                                                        $(document).ready(function () {
                                                            $( "#target_${locationsList.locationID}" ).click(function() {
                                                                $('#content_${locationsList.locationID}').val('');
                                                            });
                                                        });
                                                    </script>
                                                    <!-- Comment Container -->
                                                    <c:forEach items="${comment}" var="comment">
                                                        <c:choose>
                                                        <c:when test="${comment.locationID == locationsList.locationID}">
                                                    <div>
                                                        <div class="flex w-full justify-between border rounded-md mb-2">

                                                            <div class="p-3">
                                                                <div class="flex gap-3 items-center">
                                                                    <img src="https://360imagez.s3.ap-southeast-2.amazonaws.com/AdobeStock_549983970_Preview.png"
                                                                         class="object-cover w-10 h-10 rounded-full border-2 border-emerald-400  shadow-emerald-400">
                                                                    <h3 class="font-bold">
                                                                        User 1
                                                                    </h3>
                                                                </div>
                                                                <p class="text-gray-600 mt-2">
                                                                    this is sample commnent
                                                                </p>
                                                                <button class="text-right text-blue-500">Reply
                                                                </button>
                                                            </div>
                                                        </div>

                                                        <!-- Reply Container  -->
                                                        <%--<div class="text-gray-300 font-bold pl-14">|</div>
                                                        <div class="flex justify-between border ml-5  rounded-md">
                                                            <div class="p-3">
                                                                <div class="flex gap-3 items-center">
                                                                    <img src="https://avatars.githubusercontent.com/u/22263436?v=4"
                                                                         class="object-cover w-10 h-10 rounded-full border-2 border-emerald-400  shadow-emerald-400">
                                                                    <h3 class="font-bold">
                                                                        User 2
                                                                    </h3>
                                                                </div>
                                                                <p class="text-gray-600 mt-2">
                                                                    this is sample commnent
                                                                </p>
                                                            </div>

                                                        </div>--%>
                                                        <!-- END Reply Container  -->
                                                        <!-- Reply Container  -->
                                                       <%--<div class="text-gray-300 font-bold pl-14">|</div>
                                                        <div class="flex justify-between border ml-5  rounded-md">
                                                            <div class="p-3">
                                                                <div class="flex gap-3 items-center">
                                                                    <img src="https://360imagez.s3.ap-southeast-2.amazonaws.com/AdobeStock_549983970_Preview.png"
                                                                         class="object-cover w-10 h-10 rounded-full border-2 border-emerald-400  shadow-emerald-400">
                                                                    <h3 class="font-bold">
                                                                        User 3
                                                                    </h3>
                                                                </div>
                                                                <p class="text-gray-600 mt-2">
                                                                    this is sample commnent
                                                                </p>
                                                            </div>

                                                        </div>--%>
                                                        <!-- END Reply Container  -->

                                                    </div>
                                                    <!-- END Comment Container  -->
                                                        </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="flex items-center">
                                <script>
                                    document.addEventListener('DOMContentLoaded', function () {

                                        const rateModalbutton_${locationsList.locationID} = document.getElementById('rateModalbutton_${locationsList.locationID}');
                                        const ratemodal_${locationsList.locationID} = document.getElementById('ratemodal_${locationsList.locationID}');

                                        rateModalbutton_${locationsList.locationID}.addEventListener('click', () => {
                                            ratemodal_${locationsList.locationID}.classList.remove('hidden');
                                        });

                                        ratemodal_${locationsList.locationID}.addEventListener('click', (event) => {
                                            if (event.target === ratemodal_${locationsList.locationID}) {
                                                ratemodal_${locationsList.locationID}.classList.add('hidden');
                                            }
                                        });
                                    });
                                </script>
                                <button id="rateModalbutton_${locationsList.locationID}"
                                        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
                                    Đánh giá
                                </button>
                                <div id="ratemodal_${locationsList.locationID}"
                                     style="z-index: 9999; overflow: hidden;"
                                     class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden">
                                    <div class="bg-white p-4 rounded-lg">
                                        <div class="aspect-w-16 aspect-h-9">
                                            <div class="w-fullbg-white rounded-lg border p-1 md:p-3 m-10">
                                                <c:set var="hasMatch" value="false" />
                                                <c:forEach items="${sessionScope.ratings}" var="rating">
                                                    <c:choose>
                                                        <c:when test="${rating.locationID == locationsList.locationID}">
                                                            <c:set var="hasMatch" value="true" />
                                                            <h3 class="font-semibold p-1">Đánh giá</h3>
                                                            <form action="rate/rating" method="post" id="rate_${locationsList.locationID}">
                                                                <input type="hidden" id="successMessage_${locationsList.locationID}" value="${successMessage}" />
                                                                <input type="hidden" name="locationID" value="${locationsList.locationID}">
                                                                <div class="rate">
                                                                    <input type="radio" id="star5_${locationsList.locationID}" name="rate" value="5" ${rating.ratingValue == 5 ? 'checked' : ''}/>
                                                                    <label for="star5_${locationsList.locationID}" title="5 stars">5 stars</label>

                                                                    <input type="radio" id="star4_${locationsList.locationID}" name="rate" value="4" ${rating.ratingValue == 4 ? 'checked' : ''}/>
                                                                    <label for="star4_${locationsList.locationID}" title="4 stars">4 stars</label>

                                                                    <input type="radio" id="star3_${locationsList.locationID}" name="rate" value="3" ${rating.ratingValue == 3 ? 'checked' : ''}/>
                                                                    <label for="star3_${locationsList.locationID}" title="3 stars">3 stars</label>

                                                                    <input type="radio" id="star2_${locationsList.locationID}" name="rate" value="2" ${rating.ratingValue == 2 ? 'checked' : ''}/>
                                                                    <label for="star2_${locationsList.locationID}" title="2 stars">2 stars</label>

                                                                    <input type="radio" id="star1_${locationsList.locationID}" name="rate" value="1" ${rating.ratingValue == 1 ? 'checked' : ''}/>
                                                                    <label for="star1_${locationsList.locationID}" title="1 star">1 star</label>

                                                                </div>
                                                                <br>
                                                                <div>
                                                                    <label for="comment_${locationsList.locationID}"></label>
                                                                    <textarea id="comment_${locationsList.locationID}" name="comment" rows="6" class="fixedTextarea" cols="50" placeholder="Nhận xét của bạn">${rating.comment}</textarea>
                                                                </div>
                                                                <br>
                                                                <input type="submit" value="Sửa Đánh Giá">
                                                            </form>
                                                        </c:when>
                                                    </c:choose>
                                                </c:forEach>
                                                <c:if test="${not hasMatch and not empty username}">
                                                    <h3 class="font-semibold p-1">Đánh giá</h3>
                                                    <form action="rate/rating" method="post" id="rate_${locationsList.locationID}">
                                                        <input type="hidden" id="successMessage_${locationsList.locationID}" value="${successMessage}" />
                                                        <input type="hidden" name="locationID" value="${locationsList.locationID}">
                                                        <div class="rate">
                                                            <input type="radio" id="star5_${locationsList.locationID}" name="rate" value="5"/>
                                                            <label for="star5_${locationsList.locationID}" title="5 stars">5 stars</label>

                                                            <input type="radio" id="star4_${locationsList.locationID}" name="rate" value="4"/>
                                                            <label for="star4_${locationsList.locationID}" title="4 stars">4 stars</label>

                                                            <input type="radio" id="star3_${locationsList.locationID}" name="rate" value="3"/>
                                                            <label for="star3_${locationsList.locationID}" title="3 stars">3 stars</label>

                                                            <input type="radio" id="star2_${locationsList.locationID}" name="rate" value="2"/>
                                                            <label for="star2_${locationsList.locationID}" title="2 stars">2 stars</label>

                                                            <input type="radio" id="star1_${locationsList.locationID}" name="rate" value="1"/>
                                                            <label for="star1_${locationsList.locationID}" title="1 star">1 star</label>
                                                        </div>
                                                        <br>
                                                        <div>
                                                            <label for="comment_${locationsList.locationID}"></label>
                                                            <textarea id="comment_${locationsList.locationID}" name="comment" rows="6" class="fixedTextarea" cols="50" placeholder="Nhận xét của bạn"></textarea>
                                                        </div>
                                                        <br>
                                                        <input type="submit" value="Gửi Đánh Giá">
                                                    </form>
                                                </c:if>
                                                <c:if test="${empty username}">
                                                    <span>Bạn cần <a href="login">đăng nhập</a> để đánh giá.</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</c:if>
<jsp:include page="contact.jsp"/>
<script>
    // Lấy tham chiếu đến trường nhập và nút "X"
    const searchInput = document.getElementById("default-search");
    const clearButton = document.getElementById("clearInput");

    // Xử lý sự kiện khi người dùng nhấn Enter trong trường nhập
    searchInput.addEventListener("keydown", function (event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            this.form.submit();
        }
    });

    // Xử lý sự kiện khi người dùng nhấn vào nút "X"
    clearButton.addEventListener("click", function () {
        searchInput.value = ""; // Xóa nội dung trong trường nhập
        searchInput.focus(); // Đặt trỏ chuột lại vào trường nhập

        // Kiểm tra URL hiện tại của trang
        const currentURL = window.location.href;
        if (currentURL.includes("/search?keyword=")) {
            // Nếu URL có dạng '/search?keyword=...', chuyển về '/search'
            window.location.href = "search";
        }
    });
    $(document).ready(function () {
        $('.comment-form').each(function () {
            $(this).submit(function (e) {
                e.preventDefault(); // Ngăn chặn sự kiện mặc định của form
                const formData = $(this).serializeArray();
                const jsonData = {};

                // Chuyển đổi dữ liệu form thành JSON
                $.each(formData, function (index, field) {
                    jsonData[field.name] = field.value;
                });

                $.ajax({
                    url: this.action,
                    type: 'POST',
                    data: JSON.stringify(jsonData), // Chuyển đổi thành chuỗi JSON
                    contentType: 'application/json', // Đặt Content-Type là application/json
                    success: function (data) {
                        if (data.success) {
                            $(".modal-dialog").load(" .modal-dialog");
                            $( ".target" ).click(function() {
                                $('.content').val('');
                            });
                        }
                    },
                    error: function (error) {
                        console.error('Có lỗi xảy ra:', error);
                    }
                });
            });
        });
    });

</script>

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
    function reloadPage() {
        // Tải lại trang hiện tại
        window.location.reload();
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.8.1/flowbite.min.js"></script>
</body>
</html>
