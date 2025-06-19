<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${gh.id == 0 ? "Thêm giỏ hàng mới" : "Cập nhật giỏ hàng"}</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background-color: #fff0f5;
        }

        .card-header {
            background-color: #f06292 !important;
            color: white;
            font-weight: bold;
        }

        .form-group label {
            font-weight: 600;
        }
    </style>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header">
            <h4 class="mb-0">${gh.id == 0 ? "Thêm giỏ hàng mới" : "Cập nhật giỏ hàng"}</h4>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/gio-hang" method="post">
                <input type="hidden" name="id" value="${gh.id}" />

                <div class="form-group">
                    <label for="idNguoiDung">Người dùng</label>
                    <select name="idNguoiDung" id="idNguoiDung" class="form-control" required>
                        <option value="">-- Chọn người dùng --</option>
                        <c:forEach var="nd" items="${danhSachNguoiDung}">
                            <option value="${nd.id}" <c:if test="${nd.id == gh.idNguoiDung}">selected</c:if>>
                                ${nd.hoTen} (${nd.tenDangNhap})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="trangThai">Trạng thái</label>
                    <select name="trangThai" id="trangThai" class="form-control" required>
                        <option value="">-- Chọn trạng thái --</option>
                        <option value="Đang xử lý" <c:if test="${gh.trangThai == 'Đang xử lý'}">selected</c:if>>Đang xử lý</option>
                        <option value="Đã thanh toán" <c:if test="${gh.trangThai == 'Đã thanh toán'}">selected</c:if>>Đã thanh toán</option>
                        <option value="Đã huỷ" <c:if test="${gh.trangThai == 'Đã huỷ'}">selected</c:if>>Đã huỷ</option>
                    </select>
                </div>

                <div class="form-group d-flex justify-content-between mt-4">
                    <button type="submit"
                            style="background-color: #ec407a; color: white; border: none; padding: 8px 20px; border-radius: 4px;">
                        ${gh.id == 0 ? "Thêm giỏ hàng" : "Cập nhật"}
                    </button>

                    <a href="${pageContext.request.contextPath}/gio-hang/quan-ly"
                       style="background-color: #ba68c8; color: white; border: none; padding: 8px 20px; border-radius: 4px; text-decoration: none;">
                        Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
