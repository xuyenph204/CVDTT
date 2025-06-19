package BTL.controllers;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import BTL.models.BinhLuan;
import BTL.models.NguoiDung;
import BTL.patterns.BinhLuanServiceFactory;
import BTL.services.IBinhLuanService; 

@WebServlet("/binh-luan")
public class BinhLuanServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IBinhLuanService binhLuanService = BinhLuanServiceFactory.createService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");

        String noiDung = request.getParameter("noiDung");
        int idSanPham = Integer.parseInt(request.getParameter("idSanPham"));
        String idBinhLuanStr = request.getParameter("idBinhLuan"); // sửa nếu có

        HttpSession session = request.getSession();
        NguoiDung nd = (NguoiDung) session.getAttribute("nguoiDung");

        if (nd != null && noiDung != null && !noiDung.trim().isEmpty()) {
            BinhLuan bl = new BinhLuan();
            bl.setIdSanPham(idSanPham);
            bl.setIdNguoiDung(nd.getId());
            bl.setNoiDung(noiDung);
            bl.setNgayCapNhat(new Timestamp(System.currentTimeMillis()));

            if (idBinhLuanStr != null && !idBinhLuanStr.isEmpty()) {
                bl.setId(Integer.parseInt(idBinhLuanStr));
                binhLuanService.suaBinhLuan(bl);
            } else {
                bl.setNgayTao(bl.getNgayCapNhat());
                binhLuanService.themBinhLuan(bl);
            }
        }

        response.sendRedirect(request.getContextPath() + "/san-pham/chi-tiet?id=" + idSanPham);
    }
}

