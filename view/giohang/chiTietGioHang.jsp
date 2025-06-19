<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết giỏ hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #fff0f5;
            font-family: 'Quicksand', sans-serif;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .table th {
            background-color: #f8bbd0;
            font-weight: 600;
        }

        .table-hover tbody tr:hover {
            background-color: #fce4ec;
        }

        .btn-back {
            background-color: #f8bbd0;
            color: white;
            border: none;
        }

        .btn-back:hover {
            background-color: #f06292;
        }
    </style>
</head>
<body>
<%@ include file="/layouts/index.jsp" %>

<div class="container mt-5">
    <div class="card p-4">
        <h4 class="mb-3 text-danger">Chi tiết giỏ hàng #${gioHang.id}</h4>

        <div class="mb-3">
            <p><strong>Người dùng:</strong> ${gioHang.nguoiDung.hoTen} (${gioHang.nguoiDung.tenDangNhap})</p>
            <p><strong>Trạng thái:</strong> ${gioHang.trangThai}</p>
            <p><strong>Ngày tạo:</strong> <fmt:formatDate value="${gioHang.ngayTao}" pattern="dd/MM/yyyy HH:mm"/></p>
            <p><strong>Ngày cập nhật:</strong> <fmt:formatDate value="${gioHang.ngayCapNhat}" pattern="dd/MM/yyyy HH:mm"/></p>
        </div>

        <h5 class="text-primary mb-3">Sản phẩm trong giỏ</h5>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead>
                    <tr class="text-center">
                        <th>Ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Ngày thêm</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${gioHangChiTietList}">
                        <tr>
                            <td class="text-center">
                                <img src="${pageContext.request.contextPath}/images/${item.sanPham.anhUrl}"
                                     width="60" height="60"
                                     style="object-fit: cover; border-radius: 5px;" />
                            </td>
                            <td>${item.sanPham.tenSanPham}</td>
                            <td class="text-end">
                                <fmt:formatNumber value="${item.sanPham.gia}" type="currency" currencySymbol="₫"/>
                            </td>
                            <td class="text-center">${item.soLuong}</td>
                            <td class="text-end">
                                <fmt:formatNumber value="${item.soLuong * item.sanPham.gia}" type="currency" currencySymbol="₫"/>
                            </td>
                            <td class="text-center">
                                <fmt:formatDate value="${item.ngayThem}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty gioHangChiTietList}">
                        <tr>
                            <td colspan="6" class="text-center text-muted">Không có sản phẩm nào trong giỏ hàng.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <a href="${pageContext.request.contextPath}/gio-hang/quan-ly" class="btn btn-back mt-4">← Quay lại danh sách</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
