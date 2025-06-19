package BTL.patterns;

import BTL.daos.GioHangDAO;
import BTL.models.GioHangItem;

import java.util.List;

public class QuanLyGioHangFacade {
    private GioHangDAO gioHangDAO = new GioHangDAO();

    // Thêm sản phẩm
    public void themSanPham(int idNguoiDung, GioHangItem item) {
        gioHangDAO.themSanPhamVaoGio(idNguoiDung, item);
    }

    // Sửa số lượng
    public void suaSoLuong(int idNguoiDung, int idSanPham, int soLuongMoi) {
        gioHangDAO.capNhatSoLuong(idNguoiDung, idSanPham, soLuongMoi);
    }

    // Xóa sản phẩm
    public void xoaSanPham(int idNguoiDung, int idSanPham) {
        gioHangDAO.xoaSanPhamKhoiGio(idNguoiDung, idSanPham);
    }

    // Lấy danh sách sản phẩm trong giỏ
    public List<GioHangItem> layDanhSach(int idNguoiDung) {
        return gioHangDAO.layDanhSachSanPhamTrongGio(idNguoiDung);
    }
}