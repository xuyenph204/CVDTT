<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="BTL.models.SanPham" %>
<%
    SanPham sp = (SanPham) request.getAttribute("sp");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title><%= sp.getTenSanPham() %> - Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #fff0f5;
            font-family: 'Quicksand', sans-serif;
        }
        .product-image {
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        .product-title {
            color: #d81b60;
            font-weight: 600;
        }
        .product-price {
            color: #c2185b;
            font-size: 1.6rem;
            font-weight: bold;
        }
        .product-detail {
            background-color: #fce4ec;
            border-radius: 8px;
            padding: 1rem;
        }
        .btn-back {
            background-color: #f8bbd0;
            color: white;
            border: none;
        }
        .btn-back:hover {
            background-color: #f06292;
        }
        .dropdown-toggle::after {
            display: none;
        }
    </style>
</head>
<body>
<%@ include file="/layouts/header.jsp" %>

<div class="container mt-5">
    <div class="row align-items-center">
        <div class="col-md-6 mb-4">
            <img src="<%= request.getContextPath() %>/images/<%= sp.getAnhUrl() %>" class="img-fluid product-image" alt="<%= sp.getTenSanPham() %>">
        </div>
        <div class="col-md-6">
            <h2 class="product-title"><%= sp.getTenSanPham() %></h2>
            <p class="product-price">₫<%= String.format("%,.0f", sp.getGia()) %></p>
            <p><strong>Số lượng còn:</strong> <%= sp.getSoLuong() %></p>
            <p><strong>Mô tả chi tiết:</strong></p>
            <div class="product-detail mb-4">
                <%= sp.getMoTa() %>
            </div>

            <p><strong>Bình luận:</strong></p>
            <div class="mt-3 mb-4">
                <c:forEach var="bl" items="${danhSachBinhLuan}">
					<div class="border rounded p-3 mb-2 bg-white shadow-sm position-relative" id="bl-${bl.id}">
					    <div class="d-flex justify-content-between align-items-start">
					        <div>
					            <p class="mb-1 fw-bold text-primary">
					                ${bl.nguoiDung.hoTen} <span class="text-muted small">(${bl.ngayTao})</span>
					            </p>
					        </div>
					
					        <c:if test="${sessionScope.nguoiDung != null && sessionScope.nguoiDung.id == bl.nguoiDung.id}">
					            <div class="dropdown">
					                <button class="btn btn-sm btn-light border dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">...</button>
					                <ul class="dropdown-menu">
					                    <li>
					                        <a class="dropdown-item sua-binh-luan" href="#" data-id="${bl.id}">Sửa</a>
					                    </li>
					                </ul>
					            </div>
					        </c:if>
					    </div>
					
					    <!-- Nội dung bình luận -->
					    <p class="mb-0 noi-dung">${bl.noiDung}</p>
					
					    <!-- Form sửa -->
					    <form class="form-sua mt-2" action="${pageContext.request.contextPath}/binh-luan" method="post" style="display:none;">
					        <input type="hidden" name="idSanPham" value="${sp.id}" />
					        <input type="hidden" name="idBinhLuan" value="${bl.id}" />
					        <div class="input-group">
					            <input type="text" name="noiDung" class="form-control" value="${bl.noiDung}" required />
					            <button type="submit" class="btn btn-outline-success">Lưu</button>
					            <button type="button" class="btn btn-outline-secondary btn-huy" data-id="${bl.id}">Hủy</button>
					        </div>
					    </form>
					</div>

                </c:forEach>

                <c:if test="${empty danhSachBinhLuan}">
                    <p class="text-muted">Chưa có bình luận nào.</p>
                </c:if>
            </div>

            <!-- FORM THÊM BÌNH LUẬN -->
			<form action="${pageContext.request.contextPath}/binh-luan" method="post">
			    <input type="hidden" name="idSanPham" value="<%= sp.getId() %>" />
			    <div class="mb-3">
			        <textarea name="noiDung" class="form-control" rows="2" placeholder="Nhập bình luận..." required></textarea>
			    </div>
			    <button type="submit" class="btn btn-outline-danger">Gửi bình luận</button>
			</form>
			
			
			            <a href="<%= request.getContextPath() %>/trang-chu" class="btn btn-back mt-4">← Quay lại trang chủ</a>
			        </div>
			    </div>
			</div>

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll(".sua-binh-luan").forEach(function(link) {
        link.addEventListener("click", function(e) {
            e.preventDefault();
            const id = this.dataset.id;
            const container = document.getElementById("bl-" + id);
            const text = container.querySelector(".noi-dung");
            const form = container.querySelector(".form-sua");

            // Hiện form, ẩn nội dung
            text.style.display = "none";
            form.style.display = "block";
        });
    });

    document.querySelectorAll(".btn-huy").forEach(function(btn) {
        btn.addEventListener("click", function() {
            const id = this.dataset.id;
            const container = document.getElementById("bl-" + id);
            const text = container.querySelector(".noi-dung");
            const form = container.querySelector(".form-sua");

            form.style.display = "none";
            text.style.display = "block";
        });
    });
</script>

</body>
</html>
