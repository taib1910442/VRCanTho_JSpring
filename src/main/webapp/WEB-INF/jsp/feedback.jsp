<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: trant
  Date: 10/18/2023
  Time: 2:33 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<c:url value="/css/styles.css" />"/>
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
            max-height: 100vh;
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
</head>
<body>
<div id="modal_${locationID}" style="z-index: 9999; overflow: hidden;"
     class="fixed inset-0 flex items-center justify-center">
    <div class="bg-white rounded-lg modal-dialog"
         style="width: 100%;">
        <div class="aspect-w-16 aspect-h-9">
            <div class="w-fullbg-white rounded-lg border p-1 md:p-3 modal-body">
                <h3 class="font-semibold p-1">Bình luận</h3>
                <div class="flex flex-col gap-5 m-3">
                    <c:if test="${empty username}">
                        <span>Bạn cần <a style="color: #2a64a6;" href="../login" target="_blank">đăng nhập</a> để bình luận.</span>
                    </c:if>
                    <c:if test="${not empty username}">

                        <form action="../api/comments/add" method="post" id="commentForm_${locationID}"
                              class="comment-form">
                            <div class="w-full px-3 mt-6">
        <textarea
                class="content bg-gray-100 rounded border border-gray-400 leading-normal resize-none w-full h-20 py-2 px-3 font-medium placeholder-gray-400 focus:outline-none focus:bg-white"
                name="content" id="content" placeholder="Nội dung..." required></textarea>
                            </div>
                            <input type="hidden" name="username" id="username" value="${username}">
                            <input type="hidden" name="replyTo" id="replyTo" value="">
                            <span id="reply" style="color: #888;opacity: 0.7; margin-left: 10px; display: none"></span>
                            <p id="cancelreply" class="text-right text-red-500" style="display: none"
                               onclick="cancelReply()">Hủy</p>
                            <input type="hidden" name="locationID" id="locationID" value="${locationID}"><br>

                            <div class="w-full flex justify-end px-3">
                                <input type="submit" id="submitBtn"
                                       class="px-2.5 py-1.5 rounded-md text-white text-sm bg-indigo-500 text-lg"
                                       value='Gửi'>
                            </div>

                        </form>
                    </c:if>
                    <!-- Comment Container -->
                    <c:forEach items="${filteredComments}" var="comment">
                        <div>
                            <div class="flex w-full justify-between border rounded-md mb-2">
                                <div class="p-3">
                                    <div class="flex gap-3 items-center">
                                        <img src="https://360imagez.s3.ap-southeast-2.amazonaws.com/AdobeStock_549983970_Preview.png"
                                             class="object-cover w-10 h-10 rounded-full border-2 border-emerald-400  shadow-emerald-400">
                                        <h3 class="font-bold">
                                                ${comment.username}
                                        </h3>
                                        <div class="flex justify-between">
                                            <!-- Kiểm tra xem user hiện tại có quyền xóa bình luận hay không -->
                                            <c:if test="${comment.username eq username}">
                                                <button onclick="confirmDeleteComment(${comment.commentID})"
                                                        class="text-red-500 mr-1">Xóa
                                                </button>
                                            </c:if>
                                            <c:if test="${comment.username ne username}">
                                                <!-- Nút tố cáo -->
                                                <button onclick="showReportModal(${comment.commentID})"
                                                        class="text-blue-500">Tố cáo
                                                </button>
                                            </c:if>
                                        </div>
                                        <span style="color: #888;opacity: 0.7; margin-left: 10px">#${comment.commentID}</span>
                                    </div>
                                    <p class="text-gray-600 mt-2">
                                            ${comment.content}
                                    </p>
                                    <button class="text-right text-blue-500"
                                            onclick="replyToComment(${comment.commentID})">Trả lời
                                    </button>
                                </div>
                            </div>
                            <c:forEach items="${comments}" var="replycomment">
                                <c:if test="${comment.commentID == replycomment.replyTo}">
                                    <!-- Reply Container -->
                                    <div class="text-gray-300 font-bold pl-14">|</div>
                                    <div class="flex justify-between border ml-5  rounded-md">
                                        <div class="p-3">
                                            <div class="flex gap-3 items-center">
                                                <img src="https://360imagez.s3.ap-southeast-2.amazonaws.com/AdobeStock_549983970_Preview.png"
                                                     class="object-cover w-10 h-10 rounded-full border-2 border-emerald-400  shadow-emerald-400">
                                                <h3 class="font-bold">
                                                        ${replycomment.username}
                                                </h3>
                                                <div class="flex justify-between">
                                                    <!-- Kiểm tra xem user hiện tại có quyền xóa bình luận hay không -->
                                                    <c:if test="${replycomment.username eq username}">
                                                        <button onclick="confirmDeleteComment(${replycomment.commentID})"
                                                                class="text-red-500 mr-1">Xóa
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${replycomment.username ne username}">
                                                        <!-- Nút tố cáo -->
                                                        <button onclick="showReportModal(${replycomment.commentID})"
                                                                class="text-blue-500">Tố cáo
                                                        </button>
                                                    </c:if>
                                                </div>
                                                <span style="color: #888;opacity: 0.7; margin-left: 10px">#${replycomment.commentID}</span>
                                            </div>
                                            <p class="text-gray-600 mt-2">
                                                    ${replycomment.content}
                                            </p>
                                        </div>
                                    </div>
                                    <!-- END Reply Container -->
                                </c:if>
                            </c:forEach>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- Modal Tố cáo -->
<div id="reportModal" class="hidden fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-50"
     style="z-index: 9999;">
    <div class="bg-white p-4 rounded-lg">
        <h3 class="font-semibold">Tố cáo bình luận</h3>
        <div class="modal-body">
            <select id="reasonSelect" class="mt-2 w-full border rounded">
                <option value="Spam">Spam</option>
                <option value="Nội dung không phù hợp">Nội dung không phù hợp</option>
                <option value="Phân biệt vùng miền/chủng tộc">Phân biệt vùng miền/chủng tộc</option>
                <option value="Ngôn ngữ đả kích">Ngôn ngữ đả kích</option>
            </select>
            <button onclick="submitReport()" class="mt-4 bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded">
                Gửi
            </button>
            <button onclick="cancelReport()" class="mt-4 bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded">Hủy
            </button>
        </div>
    </div>
</div>
<!-- Modal Xóa -->
<div id="deleteConfirmationModal"
     class="fixed inset-0 z-50 flex items-center justify-center overflow-auto bg-black bg-opacity-50 hidden"
     style="z-index: 9999">
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
                <button onclick="deleteComment()"
                        class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded focus:outline-none mr-2">Xóa
                </button>
                <button onclick="closeDeleteConfirmationModal()"
                        class="bg-gray-300 hover:bg-gray-400 text-gray-700 py-2 px-4 rounded focus:outline-none">Hủy
                </button>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById("submitBtn").addEventListener("click", function (event) {
        event.preventDefault(); // Ngăn chặn gửi biểu mẫu theo cách thông thường

        // Lấy dữ liệu từ các trường biểu mẫu
        const username = document.getElementById("username").value;
        const locationID = document.getElementById("locationID").value;
        const content = document.getElementById("content").value;
        const reply = document.getElementById("replyTo").value;
        // Tạo đối tượng JSON từ dữ liệu
        const commentData = {
            username: username,
            replyTo: reply,
            locationID: locationID,
            content: content
            // Thêm các trường dữ liệu khác nếu cần
        };

        // Gửi dữ liệu dưới dạng JSON
        fetch("../api/comments/add", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(commentData)
        })
            .then(response => response.json())
            .then(data => {
                window.location.reload();
            })
            .catch(error => {
                // Xử lý lỗi (nếu có)
            });
    });
</script>
<script>
    function replyToComment(commentID) {
        // Tìm đối tượng input hidden và thay đổi giá trị
        var replyToInput = document.getElementById("replyTo");
        replyToInput.value = commentID;

        // Hiển thị thẻ span "Trả lời"
        var replySpan = document.getElementById("reply");
        document.getElementById("reply").innerHTML = "Trả lời #" + commentID;
        replySpan.style.display = "inline";
        var cancel = document.getElementById("cancelreply");
        cancel.style.display = "inline";
    }

    function cancelReply() {
        var cancelreplyToInput = document.getElementById("replyTo");
        cancelreplyToInput.value = "";

        var cancelreplySpan = document.getElementById("reply");
        cancelreplySpan.style.display = "none";
        var cancelreply = document.getElementById("cancelreply");
        cancelreply.style.display = "none";
    }

    let currentCommentID;

    function confirmDeleteComment(CommentID) {
        currentCommentID = CommentID;
        document.getElementById('deleteConfirmationModal').classList.remove('hidden');
    }

    function closeDeleteConfirmationModal() {
        document.getElementById('deleteConfirmationModal').classList.add('hidden');
    }

    function deleteComment() {
        fetch(`/webVR_war/deleteComment/` + currentCommentID, {
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
                    console.log('Đã xóa comment thành công với ID:', currentCommentID);
                    // Thực hiện các thao tác khác sau khi xóa thành công nếu cần
                } else {
                    // Xóa thất bại, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                    const modalBody = document.querySelector('#deleteConfirmationModal .modal-body');
                    modalBody.innerHTML = '<h3 style="color: #c80000"> Xóa thất bại! </h3>';

                    setTimeout(() => {
                        closeDeleteConfirmationModal();
                    }, 2000);

                    console.error('Lỗi khi xóa comment:', response.statusText);
                }
            })
            .catch(error => {
                console.error('Lỗi khi gửi yêu cầu xóa:', error);
            });
    }

    // Function hiển thị modal tố cáo
    function showReportModal(commentID) {
        currentCommentID = commentID;
        document.getElementById('reportModal').classList.remove('hidden');
    }

    // Function gửi tố cáo
    function closeSubmitReport() {
        document.getElementById('reportModal').classList.add('hidden');
    }

    function submitReport() {
        const reason = document.getElementById('reasonSelect').value;
        fetch(`/webVR_war/reportedComment?commentID=` + currentCommentID + `&reason=` + reason, {
            method: 'POST',
        })
            .then(response => {
                if (response.ok) {
                    // Xóa thành công, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                    const modalBody = document.querySelector('#reportModal .modal-body');
                    modalBody.innerHTML = '<h3 style="color: #00ff80"> Tố cáo thành công! </h3>';

                    setTimeout(() => {
                        closeSubmitReport();
                    }, 2000);
                    setTimeout(() => {
                        window.location.reload();
                    }, 2500);
                    console.log('Đã tố cáo comment thành công với ID:', currentCommentID);
                    // Thực hiện các thao tác khác sau khi xóa thành công nếu cần
                } else {
                    // Xóa thất bại, thay đổi nội dung modal và sau đó ẩn modal sau 2 giây
                    const modalBody = document.querySelector('#reportModal .modal-body');
                    modalBody.innerHTML = '<h3 style="color: #c80000"> Tố cáo thất bại! </h3>';

                    setTimeout(() => {
                        closeSubmitReport();
                    }, 2000);

                    console.error('Lỗi khi tố cáo comment:', response.statusText);
                }
            })
            .catch(error => {
                console.error('Lỗi khi gửi yêu cầu tố cáo:', error);
            });
    }

    function cancelReport() {
        document.getElementById('reportModal').classList.add('hidden');
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.8.1/flowbite.min.js"></script>
</body>
</html>
