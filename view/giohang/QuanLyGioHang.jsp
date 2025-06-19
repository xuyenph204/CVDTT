<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý giỏ hàng</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background-color: #fff0f5;
        }

        h2 {
            color: #c2185b;
            font-weight: 600;
        }

        .table thead {
            background-color: #f8bbd0;
        }

        .table-hover tbody tr:hover {
            background-color: #fce4ec;
            transition: background-color 0.3s ease;
        }

        .btn-view {
            background-color: #f06292;
            color: white;
        }

        .btn-view:hover {
            background-color: #ec407a;
        }

        .container-xl {
            max-width: 1200px;
        }
    </style>
</head>
<body>

<div class="container-xl mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Danh sách giỏ hàng</h2>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="text-center">
                <tr>
                    <th>ID</th>
                    <th>ID Người dùng</th>
                    <th>Trạng thái</th>
                    <th>Ngày tạo</th>
                    <th>Ngày cập nhật</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="gh" items="${danhSachGioHang}">
                    <tr>
                        <td class="text-center">${gh.id}</td>
                        <td class="text-center">${gh.idNguoiDung}</td>
                        <td class="text-center">${gh.trangThai}</td>
                        <td class="text-center"><fmt:formatDate value="${gh.ngayTao}" pattern="dd/MM/yyyy HH:mm" /></td>
                        <td class="text-center"><fmt:formatDate value="${gh.ngayCapNhat}" pattern="dd/MM/yyyy HH:mm" /></td>
                        <td class="text-center">
                            <a href="${pageContext.request.contextPath}/gio-hang/chi-tiet?id=${gh.id}" class="btn btn-sm btn-view">Chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- JS Bootstrap -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
