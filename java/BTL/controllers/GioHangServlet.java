package BTL.controllers;

import BTL.daos.GioHangDAO;
import BTL.daos.SanPhamDAO;
import BTL.models.GioHangItem;
import BTL.models.SanPham;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/gio-hang/*")
public class GioHangServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private final GioHangDAO gioHangDAO = new GioHangDAO();
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer idNguoiDung = (Integer) session.getAttribute("idNguoiDung");

        if (idNguoiDung == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
            return;
        }

        String action = request.getPathInfo();
        if (action == null || action.equals("/") || action.equals("/hien-thi")) {
            hienThiGioHang(request, response, idNguoiDung);
            return;
        }

        switch (action) {
            case "/xoa":
                try {
                    int idSanPham = Integer.parseInt(request.getParameter("id"));
                    gioHangDAO.xoaSanPhamKhoiGio(idNguoiDung, idSanPham);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
                response.sendRedirect(request.getContextPath() + "/gio-hang/hien-thi");
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Integer idNguoiDung = (Integer) session.getAttribute("idNguoiDung");

        if (idNguoiDung == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap.jsp");
            return;
        }

        String action = request.getPathInfo();
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/gio-hang/hien-thi");
            return;
        }

        try {
            int idSanPham = Integer.parseInt(request.getParameter("id"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));

            if (soLuong <= 0) {
                response.sendRedirect(request.getContextPath() + "/gio-hang/hien-thi");
                return;
            }

            switch (action) {
                case "/them":
                    GioHangItem item = new GioHangItem();
                    item.setIdSanPham(idSanPham);
                    item.setSoLuong(soLuong);
                    gioHangDAO.themSanPhamVaoGio(idNguoiDung, item);
                    break;

                case "/capnhat":
                    gioHangDAO.capNhatSoLuong(idNguoiDung, idSanPham, soLuong);
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/gio-hang/hien-thi");
    }

    private void hienThiGioHang(HttpServletRequest request, HttpServletResponse response, int idNguoiDung)
            throws ServletException, IOException {

        List<GioHangItem> ds = gioHangDAO.layDanhSachSanPhamTrongGio(idNguoiDung);

        // Dữ liệu sản phẩm đã được lấy trong DAO rồi, nếu chưa có thì dùng đoạn dưới
        for (GioHangItem item : ds) {
            if (item.getSanPham() == null) {
                SanPham sp = sanPhamDAO.timTheoId(item.getIdSanPham());
                item.setSanPham(sp);
            }
        }

        request.setAttribute("cartItems", ds);
        request.getRequestDispatcher("/views/giohang/gioHang.jsp").forward(request, response);
    }
}