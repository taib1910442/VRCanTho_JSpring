<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Trang quản lý</title>
    <!-- Include Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

    <!-- Include custom styles -->
    <style>
        .comment-item {
            border: 1px solid #ccc;
            margin-bottom: 10px;
            padding: 10px;
        }

        .report-reason {
            color: #aa1e3f;
            font-size: 12px;
            font-style: italic;
        }

        .comment-content {
            font-weight: bold;
        }

        .comment-id {
            color: gray;
            font-size: 12px;
        }

    </style>
</head>

<body class="bg-gray-100">
<div class="container mx-auto p-4">
    <!-- Tabs -->
    <div class="mb-4">
        <ul class="flex">

            <li class="mr-1">
                <button class="tab bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-t-lg focus:outline-none">
                    Quản lý
                    người dùng
                </button>
            </li>
            <li class="mr-1">
                <button class="tab bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-t-lg focus:outline-none">
                    Quản lý địa
                    điểm du lịch
                </button>
            </li>
            <li class="mr-1">
                <button class="tab bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-t-lg focus:outline-none">
                    Quản lý nhà
                    hàng
                </button>
            </li>
            <li class="mr-1">
                <button class="tab bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-t-lg focus:outline-none">
                    Quản lý món
                    ăn
                </button>
            </li>
            <li class="mr-1">
                <button id="homeButton"
                        class="tab bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-t-lg focus:outline-none">
                    Trang chủ
                </button>
            </li>
        </ul>
    </div>

    <!-- Content -->
    <div class="bg-white p-4 rounded-lg shadow">
        <!-- Quản lý người dùng -->
        <div class="tab-content">
            <!-- Table for user management -->
            <table class="tab-pane w-full">
                <!-- Table headers -->
                <thead>
                <tr>
                    <th class="px-4 py-2">Tên</th>
                    <th class="px-4 py-2">Email</th>
                    <th class="px-4 py-2">Bình luận</th>
                    <th class="px-4 py-2">Tùy chọn</th>
                </tr>
                </thead>
                <!-- Table body -->
                <tbody>
                <!-- Populate table rows with data dynamically -->
                <!-- Sample data row -->
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td class="border px-4 py-2 ${user.role eq 'BANNED' ? 'text-red-500' : ''}">${user.username}</td>
                        <td class="border px-4 py-2">${user.email}</td>
                        <td class="border px-4 py-2">
                            <div class="flex justify-center items-center">
                                <button id="open-comment-modal"
                                        class="open-comment-modal bg-blue-500 hover:bg-blue-600 text-white py-1 px-2 rounded focus:outline-none"
                                        onclick="openComments('${user.username}')">Xem bình
                                    luận
                                </button>
                            </div>
                        </td>
                        <td class="border px-4 py-2">
                            <div class="flex justify-center items-center">
                                <c:if test="${user.role ne 'ROLE_ADMIN'}">
                                    <c:if test="${user.role ne 'BANNED'}">
                                        <button class="bg-red-500 hover:bg-red-600 text-white py-1 px-2 mr-4 rounded focus:outline-none"
                                                onclick="ban('${user.username}')">Cấm
                                        </button>
                                    </c:if>
                                <button
                                        class="bg-yellow-500 hover:bg-yellow-600 text-white py-1 px-2 rounded focus:outline-none" onclick="removeUserByName('${user.username}')">
                                    Xóa
                                </button></c:if>
                            </div>

                        </td>
                    </tr>
                </c:forEach>
                <!-- More rows -->
                </tbody>
            </table>

            <!-- Quản lý địa điểm du lịch -->
            <table class="hidden tab-pane w-full">
                <!-- Table headers -->
                <thead>
                <tr>
                    <td colspan="5">
                        <button class="bg-green-500 hover:bg-green-600 text-white py-1 px-2 rounded focus:outline-none"
                                onclick="openAddLocationModal()">Thêm địa điểm du lịch
                        </button>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">ID</th>
                    <th class="px-4 py-2">Tên</th>
                    <th class="px-4 py-2">Vĩ tuyến</th>
                    <th class="px-4 py-2">Kinh tuyến</th>
                    <th class="px-4 py-2">Tùy chọn</th>
                </tr>
                </thead>
                <!-- Table body -->
                <tbody>
                <!-- Populate table rows with data dynamically -->
                <!-- Sample data row -->
                <c:forEach items="${locations}" var="location">
                    <tr>
                        <td class="border px-4 py-2">${location.locationID}</td>
                        <td class="border px-4 py-2">${location.name}</td>
                        <td class="border px-4 py-2">${location.latitude}</td>
                        <td class="border px-4 py-2">${location.longitude}</td>
                        <td class="border px-4 py-2">
                            <div class="flex justify-center items-center">
                                <button onclick="confirmDeleteLocation(${location.locationID})"
                                        class="bg-yellow-500 hover:bg-yellow-600 text-white py-1 px-2 rounded focus:outline-none">
                                    Xóa
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <!-- More rows -->
                </tbody>
            </table>

            <!-- Quản lý nhà hàng -->
            <table class="hidden tab-pane w-full">
                <!-- Table headers -->
                <thead>
                <tr>
                    <td colspan="6">
                        <button class="bg-green-500 hover:bg-green-600 text-white py-1 px-2 rounded focus:outline-none"
                                onclick="openAddRestaurantModal()">Thêm nhà hàng
                        </button>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">ID</th>
                    <th class="px-4 py-2">Tên</th>
                    <th class="px-4 py-2">Vĩ tuyến</th>
                    <th class="px-4 py-2">Kinh tuyến</th>
                    <th class="px-4 py-2">Địa chỉ cụ thể</th>
                    <th class="px-4 py-2">Tùy chọn</th>
                </tr>

                </thead>
                <!-- Table body -->
                <tbody>

                <!-- Populate table rows with data dynamically -->
                <!-- Sample data row -->
                <c:forEach items="${res}" var="restaurant">
                    <tr>
                        <td class="border px-4 py-2">${restaurant.restaurantID}</td>
                        <td class="border px-4 py-2">${restaurant.restaurantName}</td>
                        <td class="border px-4 py-2">${restaurant.lat}</td>
                        <td class="border px-4 py-2">${restaurant.lng}</td>
                        <td class="border px-4 py-2">${restaurant.restaurantLocate}</td>

                        <td class="border px-4 py-2">
                            <div class="flex justify-center items-center">
                                <button
                                        class="bg-yellow-500 hover:bg-yellow-600 text-white py-1 px-2 rounded focus:outline-none" onclick="confirmDeleteRestaurant(${restaurant.restaurantID})">
                                    Xóa
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <!-- More rows -->
                </tbody>
            </table>

            <!-- Quản lý món ăn -->
            <table class="hidden tab-pane w-full">
                <!-- Table headers -->
                <thead>
                <tr>
                    <td colspan="5">
                        <button class="bg-green-500 hover:bg-green-600 text-white py-1 px-2 rounded focus:outline-none"
                                onclick="openAddFoodModal()">Thêm món ăn
                        </button>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">ID</th>
                    <th class="px-4 py-2">Tên</th>
                    <th class="px-4 py-2">Giá dự kiến</th>
                    <th class="px-4 py-2">Tùy chọn</th>
                </tr>
                </thead>
                <!-- Table body -->
                <tbody>
                <!-- Populate table rows with data dynamically -->
                <!-- Sample data row -->
                <c:forEach items="${foods}" var="food">
                    <tr>
                        <td class="border px-4 py-2">${food.foodID}</td>
                        <td class="border px-4 py-2">${food.foodName}</td>
                        <td class="border px-4 py-2">${food.price}</td>
                        <td class="border px-4 py-2">
                            <div class="flex justify-center items-center">
                                <button onclick="confirmDeleteFood(${food.foodID})"
                                        class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none">
                                    Xóa
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <!-- More rows -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modals for adding data -->
    <!-- Add Restaurant Modal -->
    <div id="addRestaurantModal"
         class="hidden fixed top-0 left-0 w-full h-full bg-gray-900 bg-opacity-50 flex justify-center items-center">
        <div class="bg-white p-6 rounded shadow-lg">
            <!-- Form for adding restaurant -->
            <form id="addRestaurantForm" onsubmit="saveRestaurant(event)">
                <div class="mb-4">
                    <label for="restaurantName" class="block text-gray-700 font-bold mb-2">Tên nhà hàng:</label>
                    <input type="text" id="restaurantName" name="restaurantName"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập tên nhà hàng">
                </div>
                <div class="mb-4">
                    <label for="restaurantLatitude" class="block text-gray-700 font-bold mb-2">Kinh độ:</label>
                    <input type="text" id="restaurantLatitude" name="restaurantLatitude"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập vĩ độ">
                </div>
                <div class="mb-4">
                    <label for="restaurantLongitude" class="block text-gray-700 font-bold mb-2">Vĩ độ:</label>
                    <input type="text" id="restaurantLongitude" name="restaurantLongitude"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập kinh độ">
                </div>
                <div class="mb-4">
                    <label for="restaurantLocate" class="block text-gray-700 font-bold mb-2">Địa chỉ:</label>
                    <input type="text" id="restaurantLocate" name="restaurantLocate"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập địa chỉ cụ thể">
                </div>
                <!-- Submit button -->
                <div class="flex justify-end">
                    <button class="bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded focus:outline-none"
                            >Lưu
                    </button>
                    <button class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none ml-2"
                            onclick="closeModal('addRestaurantModal')">Hủy
                    </button>
                </div>
                <div id="successMessageRestaurant" class="hidden bg-green-500 text-white py-2 px-4 rounded mt-1">
                    Thêm thành công
                </div>
            </form>
        </div>
    </div>

    <!-- Add Food Modal -->
    <div id="addFoodModal"
         class="hidden fixed top-0 left-0 w-full h-full bg-gray-900 bg-opacity-50 flex justify-center items-center">
        <div class="bg-white p-6 rounded shadow-lg">
            <!-- Form for adding food -->
            <form id="addFoodForm" onsubmit="saveFood(event)">
                <div class="mb-4">
                    <label for="foodName" class="block text-gray-700 font-bold mb-2">Tên món ăn:</label>
                    <input type="text" id="foodName" name="foodName"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập tên món ăn">
                </div>
                <div class="mb-4" id="restaurants">
                    <div class="restaurant-select mb-2">
                        <label for="foodRestaurant" class="block text-gray-700 font-bold mb-2">Chọn nhà hàng/quán ăn có
                            phục vụ:</label>
                        <select id="foodRestaurant" name="foodRestaurant"
                                class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500">
                            <option value="" selected disabled>Chọn nhà hàng</option>
                            <c:forEach items="${res}" var="restaurantOption">
                                <option value="${restaurantOption.restaurantName}">${restaurantOption.restaurantName}</option>
                            </c:forEach>
                        </select>
                        <button type="button"
                                class="add-select-button bg-green-500 hover:bg-green-600 text-white py-1 px-2 rounded focus:outline-none ml-2"
                                onclick="addSelect()">+
                        </button>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="foodPrice" class="block text-gray-700 font-bold mb-2">Giá dự kiến:</label>
                    <input type="text" id="foodPrice" name="foodPrice"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập giá dự kiến">
                </div>
                <div class="mb-4">
                    <label for="foodImgLink" class="block text-gray-700 font-bold mb-2">Url hình ảnh:</label>
                    <input type="text" id="foodImgLink" name="foodImgLink"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập Url cho ảnh minh họa">
                </div>
                <!-- Submit button -->
                <div class="flex justify-end">
                    <button class="bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded focus:outline-none"
                    >Lưu
                    </button>
                    <button class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none ml-2"
                            onclick="closeModal('addFoodModal')">Hủy
                    </button>
                </div>
                <div id="successMessage" class="hidden bg-green-500 text-white py-2 px-4 rounded mt-1">
                    Thêm thành công
                </div>
            </form>
        </div>
    </div>

    <!-- Add Location Modal -->
    <div id="addLocationModal"
         class="hidden fixed top-0 left-0 w-full h-full bg-gray-900 bg-opacity-50 flex justify-center items-center">
        <div class="bg-white p-6 rounded shadow-lg">
            <!-- Form for adding location -->
            <form id="addLocationForm" onsubmit="saveLocation(event)">
                <div class="mb-4">
                    <label for="locationName" class="block text-gray-700 font-bold mb-2">Tên địa điểm:</label>
                    <input type="text" id="locationName" name="locationName"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập tên địa điểm">
                </div>
                <div class="mb-4">
                    <label for="locationLatitude" class="block text-gray-700 font-bold mb-2">Vĩ độ:</label>
                    <input type="text" id="locationLatitude" name="locationLatitude"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập vĩ độ">
                </div>
                <div class="mb-4">
                    <label for="locationLongitude" class="block text-gray-700 font-bold mb-2">Kinh độ:</label>
                    <input type="text" id="locationLongitude" name="locationLongitude"
                           class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500"
                           placeholder="Nhập kinh độ">
                </div>
                <!-- Submit button -->
                <div class="flex justify-end">
                    <button class="bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded focus:outline-none"
                           >Lưu
                    </button>
                    <button class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none ml-2"
                            onclick="closeModal('addLocationModal')">Hủy
                    </button>
                </div>
                <div id="successMessageLocation" class="hidden bg-green-500 text-white py-2 px-4 rounded mt-1">
                    Thêm thành công
                </div>
            </form>
        </div>
    </div>

    <!-- Modal 'Xem bình luận' -->
    <div id="commentModal" class="fixed z-10 inset-0 overflow-y-auto hidden">
        <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
            <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
            <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <!-- Modal header -->
                <div class="bg-gray-200 px-4 py-3">
                    <h3 class="text-lg font-semibold">Xem bình luận</h3>
                </div>
                <!-- Modal body -->
                <div class="bg-white px-4 py-3">
                    <!-- Tabs -->
                    <div class="flex justify-around">
                        <button id="allCommentsTab" class="px-4 py-2 bg-gray-300 rounded-t-md CommentsTab">Tất cả bình
                            luận
                        </button>
                        <button id="reportedCommentsTab" class="px-4 py-2 bg-gray-300 rounded-t-md CommentsTab">Bình
                            luận bị tố cáo
                        </button>
                    </div>
                    <!-- Tab content -->
                    <div id="allCommentsContent" class="p-4 ContentTab">
                    </div>
                    <div id="reportedCommentsContent" class="hidden p-4 ContentTab">
                    </div>
                </div>
                <!-- Modal footer -->
                <div class="bg-gray-200 px-4 py-3">
                    <button id="closeModal"
                            class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded focus:outline-none">Đóng
                    </button>
                </div>
            </div>
        </div>
    </div>


    <div id="deleteConfirmationModal"
         class="fixed inset-0 z-50 flex items-center justify-center overflow-auto bg-black bg-opacity-50 hidden">
        <div class="bg-white p-8 rounded shadow-lg">
            <!-- Modal Header -->
            <div class="flex justify-between items-center mb-4">
                <h4 class="text-lg font-semibold">Xác nhận xóa</h4>
                <button onclick="closeDeleteConfirmationModal()"
                        class="text-gray-500 hover:text-gray-700 focus:outline-none">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn xóa không?</p>
                <div class="flex justify-end mt-4">
                    <button onclick="deleteFood()"
                            class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none mr-2">Xóa
                    </button>
                    <button onclick="closeDeleteConfirmationModal()"
                            class="bg-gray-300 hover:bg-gray-400 text-gray-700 py-2 px-4 rounded focus:outline-none">Hủy
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div id="banConfirmationModal"
         class="fixed inset-0 z-50 flex items-center justify-center overflow-auto bg-black bg-opacity-50 hidden">
        <div class="bg-white p-8 rounded shadow-lg">
            <!-- Modal Header -->
            <div class="flex justify-between items-center mb-4">
                <h4 class="text-lg font-semibold">Xác nhận cấm người dùng</h4>
                <button onclick="closeBanConfirmationModal()"
                        class="text-gray-500 hover:text-gray-700 focus:outline-none">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn cấm nguời dùng này không?</p>
                <p style="color: #aa1e3f; font-size: 11px; font-style: italic;">Người dùng bị cấm sẽ không thể đăng nhập
                    hoặc đăng ký với tên này nữa!! Đồng thời cũng sẽ xóa hết các dữ liệu liên quan.</p>
                <div class="flex justify-end mt-4">
                    <button onclick="banUser()"
                            class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none mr-2">Cấm
                    </button>
                    <button onclick="closeBanConfirmationModal()"
                            class="bg-gray-300 hover:bg-gray-400 text-gray-700 py-2 px-4 rounded focus:outline-none">Hủy
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div id="removeUserConfirmationModal"
         class="fixed inset-0 z-50 flex items-center justify-center overflow-auto bg-black bg-opacity-50 hidden">
        <div class="bg-white p-8 rounded shadow-lg">
            <!-- Modal Header -->
            <div class="flex justify-between items-center mb-4">
                <h4 class="text-lg font-semibold">Xác nhận xóa người dùng</h4>
                <button onclick="closeRemoveConfirmationModal()"
                        class="text-gray-500 hover:text-gray-700 focus:outline-none">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn xóa nguời dùng này không?</p>
                <div class="flex justify-end mt-4">
                    <button onclick="removeUser()"
                            class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none mr-2">Xóa
                    </button>
                    <button onclick="closeRemoveConfirmationModal()"
                            class="bg-gray-300 hover:bg-gray-400 text-gray-700 py-2 px-4 rounded focus:outline-none">Hủy
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div id="deleteRestaurantConfirmationModal"
         class="fixed inset-0 z-50 flex items-center justify-center overflow-auto bg-black bg-opacity-50 hidden">
        <div class="bg-white p-8 rounded shadow-lg">
            <!-- Modal Header -->
            <div class="flex justify-between items-center mb-4">
                <h4 class="text-lg font-semibold">Xác nhận xóa nhà hàng</h4>
                <button onclick="closeDeleteRestaurantConfirmationModal()"
                        class="text-gray-500 hover:text-gray-700 focus:outline-none">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn sẽ xóa nhà hàng và các liên kết có liên quan, có chắc muốn xóa nhà hàng này không?</p>
                <div class="flex justify-end mt-4">
                    <button onclick="deleteRestaurant()"
                            class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none mr-2">Xóa
                    </button>
                    <button onclick="closeDeleteRestaurantConfirmationModal()"
                            class="bg-gray-300 hover:bg-gray-400 text-gray-700 py-2 px-4 rounded focus:outline-none">Hủy
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div id="deleteLocationConfirmationModal"
         class="fixed inset-0 z-50 flex items-center justify-center overflow-auto bg-black bg-opacity-50 hidden">
        <div class="bg-white p-8 rounded shadow-lg">
            <!-- Modal Header -->
            <div class="flex justify-between items-center mb-4">
                <h4 class="text-lg font-semibold">Xác nhận xóa</h4>
                <button onclick="closeDeleteLocationConfirmationModal()"
                        class="text-gray-500 hover:text-gray-700 focus:outline-none">
                    <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                         xmlns="http://www.w3.org/2000/svg">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                              d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc muốn xóa địa điểm không?</p>
                <p style="color: #aa1e3f; font-size: 11px; font-style: italic;">Địa điểm bị xóa sẽ có thể ảnh hưởng một số chức năng ở Tour ảo.</p>
                <div class="flex justify-end mt-4">
                    <button onclick="deleteLocation()"
                            class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none mr-2">Xóa
                    </button>
                    <button onclick="closeDeleteLocationConfirmationModal()"
                            class="bg-gray-300 hover:bg-gray-400 text-gray-700 py-2 px-4 rounded focus:outline-none">Hủy
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- JavaScript for modals and functionality -->
    <script>
        // Functions to open and close modals
        function openAddRestaurantModal() {
            document.getElementById('addRestaurantModal').classList.remove('hidden');
        }

        function openAddFoodModal() {
            document.getElementById('addFoodModal').classList.remove('hidden');
        }

        function openAddLocationModal() {
            document.getElementById('addLocationModal').classList.remove('hidden');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.add('hidden');
        }
        function saveRestaurant(event) {
            event.preventDefault(); // Ngăn chặn việc load lại trang sau khi nhấn nút lưu

            var formData = new FormData(document.getElementById('addRestaurantForm'));
            fetch('/webVR_war/saveRestaurant', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        // Hiển thị thông báo thành công
                        var successMessage = document.getElementById('successMessageRestaurant');
                        successMessage.classList.remove('hidden');

                        // Ẩn thông báo sau 2.5 giây
                        setTimeout(function () {
                            successMessage.classList.add('hidden');
                        }, 2500);
                        setTimeout(() => {
                            window.location.reload();
                        }, 3000);
                        // Xóa dữ liệu trong form (nếu cần)
                        document.getElementById('restaurantName').value = '';
                        document.getElementById('restaurantLatitude').value = '';
                        document.getElementById('restaurantLongitude').value = '';
                        document.getElementById('restaurantLocate').value = '';
                    } else {
                        // Xử lý khi có lỗi từ server
                        console.error('Lỗi khi thêm dữ liệu nhà hàng:', response.statusText);
                    }
                })
                .catch(error => {
                    // Xử lý khi có lỗi không xác định
                    console.error('Lỗi khi gửi yêu cầu:', error);
                });
        }
        let currentLocationID;

        function confirmDeleteLocation(locationID) {
            currentLocationID = locationID;
            document.getElementById('deleteLocationConfirmationModal').classList.remove('hidden');
        }

        function closeDeleteLocationConfirmationModal() {
            document.getElementById('deleteLocationConfirmationModal').classList.add('hidden');
        }

        function deleteLocation() {
            fetch(`/webVR_war/deleteLocation/` + currentLocationID, {
                method: 'DELETE',
            })
                .then(response => {
                    if (response.ok) {
                        // Xóa thành công, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBody = document.querySelector('#deleteLocationConfirmationModal .modal-body');
                        modalBody.innerHTML = '<h3 style="color: #00ff80"> Xóa thành công! </h3>';

                        setTimeout(() => {
                            closeDeleteLocationConfirmationModal();
                        }, 2000);
                        setTimeout(() => {
                            window.location.reload();
                        }, 2500);
                        console.log('Đã xóa nhà hàng thành công với ID:', currentFoodID);
                        // Thực hiện các thao tác khác sau khi xóa thành công nếu cần
                    } else {
                        // Xóa thất bại, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBody = document.querySelector('#deleteLocationConfirmationModal .modal-body');
                        modalBody.innerHTML = '<h3 style="color: #c80000"> Xóa thất bại! </h3>';

                        setTimeout(() => {
                            closeDeleteLocationConfirmationModal();
                        }, 2000);

                        console.error('Lỗi khi xóa địa điểm:', response.statusText);
                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gửi yêu cầu xóa:', error);
                });
        }
        let currentRestaurantID;

        function confirmDeleteRestaurant(resID) {
            currentRestaurantID = resID;
            document.getElementById('deleteRestaurantConfirmationModal').classList.remove('hidden');
        }

        function closeDeleteRestaurantConfirmationModal() {
            document.getElementById('deleteRestaurantConfirmationModal').classList.add('hidden');
        }

        function deleteRestaurant() {
            fetch(`/webVR_war/deleteRestaurant/` + currentRestaurantID, {
                method: 'DELETE',
            })
                .then(response => {
                    if (response.ok) {
                        // Xóa thành công, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBody = document.querySelector('#deleteRestaurantConfirmationModal .modal-body');
                        modalBody.innerHTML = '<h3 style="color: #00ff80"> Xóa thành công! </h3>';

                        setTimeout(() => {
                            closeDeleteRestaurantConfirmationModal();
                        }, 2000);
                        setTimeout(() => {
                            window.location.reload();
                        }, 2500);
                        console.log('Đã xóa nhà hàng thành công với ID:', currentFoodID);
                        // Thực hiện các thao tác khác sau khi xóa thành công nếu cần
                    } else {
                        // Xóa thất bại, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBody = document.querySelector('#deleteRestaurantConfirmationModal .modal-body');
                        modalBody.innerHTML = '<h3 style="color: #c80000"> Xóa thất bại! </h3>';

                        setTimeout(() => {
                            closeDeleteRestaurantConfirmationModal();
                        }, 2000);

                        console.error('Lỗi khi xóa nhà hàng:', response.statusText);
                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gửi yêu cầu xóa:', error);
                });
        }
        function saveLocation(event) {
            event.preventDefault(); // Ngăn chặn việc load lại trang sau khi nhấn nút lưu

            var formData = new FormData(document.getElementById('addLocationForm'));
            fetch('/webVR_war/saveLocation', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        // Hiển thị thông báo thành công
                        var successMessage = document.getElementById('successMessageLocation');
                        successMessage.classList.remove('hidden');

                        // Ẩn thông báo sau 2.5 giây
                        setTimeout(function () {
                            successMessage.classList.add('hidden');
                        }, 2500);
                        setTimeout(() => {
                            window.location.reload();
                        }, 3000);
                        // Xóa dữ liệu trong form (nếu cần)
                        document.getElementById('locationName').value = '';
                        document.getElementById('locationLatitude').value = '';
                        document.getElementById('locationLongitude').value = '';
                    } else {
                        // Xử lý khi có lỗi từ server
                        console.error('Lỗi khi thêm dữ liệu địa điểm:', response.statusText);
                    }
                })
                .catch(error => {
                    // Xử lý khi có lỗi không xác định
                    console.error('Lỗi khi gửi yêu cầu:', error);
                });
        }

        function addSelect() {
            const restaurantsDiv = document.getElementById('restaurants');
            const selectCount = restaurantsDiv.getElementsByClassName('restaurant-select').length;

            if (selectCount < 5) { // Giới hạn số lượng ô select tối đa là 5
                const newSelectDiv = document.createElement('div');
                newSelectDiv.classList.add('restaurant-select', 'mb-2');

                const selectHTML = `
                                <select name="foodRestaurant" class="w-full border border-gray-300 rounded-md py-2 px-3 focus:outline-none focus:border-blue-500">
                                    <option value="" selected disabled>Chọn nhà hàng</option>
                                    <!-- Populate with restaurant options -->
                                    <c:forEach items="${res}" var="restaurantOption">
                                        <option value="${restaurantOption.restaurantName}">${restaurantOption.restaurantName}</option>
                                    </c:forEach>
                                    <!-- Add more options -->
                                </select>
                                <button type="button" class="add-select-button bg-green-500 hover:bg-green-600 text-white py-1 px-2 rounded focus:outline-none ml-2" onclick="addSelect()">+</button>
                                <button type="button" class="remove-select-button bg-red-500 hover:bg-red-600 text-white py-1 px-2 rounded focus:outline-none ml-2" onclick="removeSelect(this)">-</button>`;

                newSelectDiv.innerHTML = selectHTML;
                restaurantsDiv.appendChild(newSelectDiv);
            }
        }

        function removeSelect(button) {
            const selectDiv = button.parentElement;
            const restaurantsDiv = document.getElementById('restaurants');
            restaurantsDiv.removeChild(selectDiv);
        }

        // Functions to save data (dummy functions for demonstration)
        function saveFood(event) {
            const selects = document.getElementsByName('foodRestaurant');
            let selectedValues = [];

            for (let i = 0; i < selects.length; i++) {
                const value = selects[i].value;
                if (value) {
                    selectedValues.push(value);
                }
            }

            const concatenatedValues = selectedValues.join(', ');
            console.log('Giá trị từ các ô select: ', concatenatedValues);
            event.preventDefault(); // Ngăn chặn việc load lại trang sau khi nhấn nút lưu

            var formData = new FormData(document.getElementById('addFoodForm'));

            fetch('/webVR_war/saveFood', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.ok) {
                        // Hiển thị thông báo thành công
                        var successMessage = document.getElementById('successMessage');
                        successMessage.classList.remove('hidden');

                        // Ẩn thông báo sau 2.5 giây
                        setTimeout(function () {
                            successMessage.classList.add('hidden');
                        }, 2500);
                        setTimeout(() => {
                            window.location.reload();
                        }, 3000);
                        // Xóa dữ liệu trong form (nếu cần)
                        document.getElementById('foodName').value = '';
                        document.getElementById('foodRestaurant').value = '';
                        document.getElementById('foodPrice').value = '';
                        document.getElementById('foodImgLink').value = '';
                    } else {
                        // Xử lý khi có lỗi từ server
                        console.error('Lỗi khi thêm dữ liệu:', response.statusText);
                    }
                })
                .catch(error => {
                    // Xử lý khi có lỗi không xác định
                    console.error('Lỗi khi gửi yêu cầu:', error);
                });
        }

        let currentFoodID;

        function confirmDeleteFood(foodID) {
            currentFoodID = foodID;
            document.getElementById('deleteConfirmationModal').classList.remove('hidden');
        }

        function closeDeleteConfirmationModal() {
            document.getElementById('deleteConfirmationModal').classList.add('hidden');
        }

        function deleteFood() {
            fetch(`/webVR_war/deleteFood/` + currentFoodID, {
                method: 'DELETE',
            })
                .then(response => {
                    if (response.ok) {
                        // Xóa thành công, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBody = document.querySelector('#deleteConfirmationModal .modal-body');
                        modalBody.innerHTML = '<h3 style="color: #00ff80"> Xóa thành công! </h3>';

                        setTimeout(() => {
                            closeDeleteConfirmationModal();
                        }, 2000);
                        setTimeout(() => {
                            window.location.reload();
                        }, 2500);
                        console.log('Đã xóa food thành công với ID:', currentFoodID);
                        // Thực hiện các thao tác khác sau khi xóa thành công nếu cần
                    } else {
                        // Xóa thất bại, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBody = document.querySelector('#deleteConfirmationModal .modal-body');
                        modalBody.innerHTML = '<h3 style="color: #c80000"> Xóa thất bại! </h3>';

                        setTimeout(() => {
                            closeDeleteConfirmationModal();
                        }, 2000);

                        console.error('Lỗi khi xóa food:', response.statusText);
                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gửi yêu cầu xóa:', error);
                });
        }

        // Lấy thẻ button theo ID
        const homeButton = document.getElementById('homeButton');

        // Thêm sự kiện click cho nút Trang chủ
        homeButton.addEventListener('click', function () {
            // Chuyển hướng đến địa chỉ href khi nút được nhấn
            window.location.href = 'http://localhost:8080/webVR_war/';
        });

        let Username;

        function removeUserByName(username) {
            Username = username;
            document.getElementById('removeUserConfirmationModal').classList.remove('hidden');
        }

        function closeRemoveConfirmationModal() {
            document.getElementById('removeUserConfirmationModal').classList.add('hidden');
        }

        function removeUser() {
            fetch(`/webVR_war/remove/` + Username, {
                method: 'DELETE',
            })
                .then(response => {
                    if (response.ok) {
                        // Xóa thành công, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalRemoveBody = document.querySelector('#removeUserConfirmationModal .modal-body');
                        modalRemoveBody.innerHTML = '<h3 style="color: #00ff80"> Xóa người dùng thành công! </h3>';

                        setTimeout(() => {
                            closeRemoveConfirmationModal();
                        }, 2000);
                        setTimeout(() => {
                            window.location.reload();
                        }, 2500);

                        // Thực hiện các thao tác khác sau khi xóa thành công nếu cần
                    } else {
                        // Xóa thất bại, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalRemoveBody = document.querySelector('#removeUserConfirmationModal .modal-body');
                        modalRemoveBody.innerHTML = '<h3 style="color: #c80000"> Xóa người dùng thất bại! </h3>';

                        setTimeout(() => {
                            closeRemoveConfirmationModal();
                        }, 2000);

                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gửi yêu cầu xóa:', error);
                });
        }
        function ban(username) {
            Username = username;
            document.getElementById('banConfirmationModal').classList.remove('hidden');
        }

        function closeBanConfirmationModal() {
            document.getElementById('banConfirmationModal').classList.add('hidden');
        }

        function banUser() {
            fetch(`/webVR_war/ban/` + Username, {
                method: 'POST',
            })
                .then(response => {
                    if (response.ok) {
                        // Xóa thành công, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBanBody = document.querySelector('#banConfirmationModal .modal-body');
                        modalBanBody.innerHTML = '<h3 style="color: #00ff80"> Cấm người dùng thành công! </h3>';

                        setTimeout(() => {
                            closeBanConfirmationModal();
                        }, 2000);
                        setTimeout(() => {
                            window.location.reload();
                        }, 2500);

                        // Thực hiện các thao tác khác sau khi xóa thành công nếu cần
                    } else {
                        // Xóa thất bại, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                        const modalBanBody = document.querySelector('#banConfirmationModal .modal-body');
                        modalBanBody.innerHTML = '<h3 style="color: #c80000"> Cấm người dùng thất bại! </h3>';

                        setTimeout(() => {
                            closeBanConfirmationModal();
                        }, 2000);

                    }
                })
                .catch(error => {
                    console.error('Lỗi khi gửi yêu cầu cấm:', error);
                });
        }
        function openComments(username) {
            Username = username;
            getAllComment();
            getAllReportedComment();
            document.getElementById('commentModal').classList.remove('hidden');
        }

        // Đóng modal khi click vào nút Đóng
        document.getElementById('closeModal').addEventListener('click', function () {
            document.getElementById('commentModal').classList.add('hidden');
        });
        const commenttabContent = document.querySelectorAll('.ContentTab');
        const commenttabButtons = document.querySelectorAll('.CommentsTab');
        commenttabButtons.forEach((button, index) => {
            button.addEventListener('click', () => {
                // Hide all tab content elements
                commenttabContent.forEach(tab => tab.classList.add('hidden'));

                // Show the corresponding tab content based on index
                commenttabContent[index].classList.remove('hidden');


            });
        });

        function getAllComment() {
            fetch(`/webVR_war/comments/` + Username, {
                method: 'GET',
            })
                .then(response => {
                    if (response.ok) {
                        return response.json(); // Chuyển đổi dữ liệu API sang JSON
                    } else {
                        throw new Error('Lỗi kết nối!');
                    }
                })
                .then(data => {
                    const allCommentBody = document.querySelector('#allCommentsContent');
                    allCommentBody.innerHTML = ''; // Xóa nội dung cũ trước khi thêm dữ liệu mới

                    // Xử lý mỗi bình luận từ dữ liệu trả về
                    data.forEach(comment => {
                        const commentElement = document.createElement('div');
                        commentElement.classList.add('comment-item'); // Thêm lớp CSS cho mỗi phần tử bình luận
                        commentElement.innerHTML = `
                <div class="comment-content">` + comment.content + `</div>
                <div class="comment-id">ID:` + comment.commentID + `</div>
            `;
                        allCommentBody.appendChild(commentElement); // Thêm mỗi bình luận vào nội dung của tab 'Tất cả bình luận'
                    });

                    console.log('Danh sách comment của:', Username);
                    // Thực hiện các thao tác khác sau khi lấy dữ liệu thành công nếu cần
                })
                .catch(error => {
                    console.error('Lỗi:', error.message);
                });
        }

        function getAllReportedComment() {
            fetch(`/webVR_war/reported-comments/` + Username, {
                method: 'GET',
            })
                .then(response => {
                    if (response.ok) {
                        return response.json(); // Chuyển đổi dữ liệu API sang JSON
                    } else {
                        throw new Error('Lỗi kết nối!');
                    }
                })
                .then(data => {
                    const allCommentBody = document.querySelector('#reportedCommentsContent');
                    allCommentBody.innerHTML = ''; // Xóa nội dung cũ trước khi thêm dữ liệu mới

                    // Xử lý mỗi bình luận từ dữ liệu trả về
                    data.forEach(comment => {
                        const commentElement = document.createElement('div');
                        commentElement.classList.add('comment-item'); // Thêm lớp CSS cho mỗi phần tử bình luận
                        commentElement.innerHTML = `
                <div class="report-reason">` + comment.reason + `</div>
                <div class="comment-content">` + comment.content + `</div>
                <div class="comment-id">ID:` + comment.commentID + `</div>
            `;
                        allCommentBody.appendChild(commentElement); // Thêm mỗi bình luận vào nội dung của tab 'Tất cả bình luận'
                    });

                    console.log('Danh sách comment của:', Username);
                    // Thực hiện các thao tác khác sau khi lấy dữ liệu thành công nếu cần
                })
                .catch(error => {
                    console.error('Lỗi:', error.message);
                });
        }
    </script>
</div>
<!-- JavaScript for tab functionality -->
<script>
    const tabButtons = document.querySelectorAll('.tab');
    const tabContent = document.querySelectorAll('.tab-content .tab-pane');

    // Function to show the corresponding tab based on the URL hash
    function showTabFromHash() {
        const hash = window.location.hash;
        if (hash === '#users') {
            showTab(0); // Index of the Users tab
        } else if (hash === '#locations') {
            showTab(1); // Index of the Locations tab
        } else if (hash === '#restaurant') {
            showTab(2); // Index of the Restaurants tab
        } else if (hash === '#food') {
            showTab(3); // Index of the Foods tab
        }
    }

    // Function to show the specified tab
    function showTab(index) {
        // Hide all tab content elements
        tabContent.forEach(tab => tab.classList.add('hidden'));

        // Show the specified tab content
        tabContent[index].classList.remove('hidden');
    }

    // Add click event listeners to tab buttons
    tabButtons.forEach((button, index) => {
        button.addEventListener('click', () => {
            // Hide all tab content elements
            tabContent.forEach(tab => tab.classList.add('hidden'));

            // Show the corresponding tab content based on index
            tabContent[index].classList.remove('hidden');

            // Update URL hash based on the selected tab
            const tabHashes = ['#users', '#locations', '#restaurant', '#food'];
            window.location.hash = tabHashes[index];
        });
    });

    // Show the tab based on the URL hash when the page loads
    window.addEventListener('DOMContentLoaded', () => {
        showTabFromHash();
    });


</script>
</body>

</html>