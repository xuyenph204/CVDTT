package BTL.daos;

import BTL.models.GioHangItem;
import BTL.models.SanPham;
import BTL.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GioHangDAO {
    private final Connection conn = DBConnection.getInstance().getConnection();

    /**
     * Lấy hoặc tạo giỏ hàng đang mua cho người dùng
     */
    private int layHoacTaoGioHang(int idNguoiDung) throws SQLException {
        String sql = "SELECT id FROM gio_hang WHERE id_nguoi_dung = ? AND trang_thai = 'dang_mua'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idNguoiDung);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return rs.getInt("id");
            }
        }

        // Nếu chưa có thì tạo mới
        String insert = "INSERT INTO gio_hang (id_nguoi_dung, trang_thai) VALUES (?, 'dang_mua')";
        try (PreparedStatement stmt = conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, idNguoiDung);
            stmt.executeUpdate();

            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }

        throw new SQLException("Không thể tạo giỏ hàng mới cho người dùng ID = " + idNguoiDung);
    }

    /**
     * Thêm sản phẩm vào giỏ hàng (nếu đã có thì cập nhật số lượng)
     */
    public void themSanPhamVaoGio(int idNguoiDung, GioHangItem item) {
        try {
            int idGioHang = layHoacTaoGioHang(idNguoiDung);

            String check = "SELECT so_luong FROM gio_hang_chi_tiet WHERE id_gio_hang = ? AND id_san_pham = ?";
            try (PreparedStatement stmt = conn.prepareStatement(check)) {
                stmt.setInt(1, idGioHang);
                stmt.setInt(2, item.getIdSanPham());
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Đã có → cập nhật số lượng
                        int soLuongHienTai = rs.getInt("so_luong");
                        String update = "UPDATE gio_hang_chi_tiet SET so_luong = ?, ngay_them = GETDATE() WHERE id_gio_hang = ? AND id_san_pham = ?";
                        try (PreparedStatement updateStmt = conn.prepareStatement(update)) {
                            updateStmt.setInt(1, soLuongHienTai + item.getSoLuong());
                            updateStmt.setInt(2, idGioHang);
                            updateStmt.setInt(3, item.getIdSanPham());
                            updateStmt.executeUpdate();
                        }
                    } else {
                        // Chưa có → thêm mới
                        String insert = "INSERT INTO gio_hang_chi_tiet (id_gio_hang, id_san_pham, so_luong, ngay_them) VALUES (?, ?, ?, GETDATE())";
                        try (PreparedStatement insertStmt = conn.prepareStatement(insert)) {
                            insertStmt.setInt(1, idGioHang);
                            insertStmt.setInt(2, item.getIdSanPham());
                            insertStmt.setInt(3, item.getSoLuong());
                            insertStmt.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Cập nhật số lượng sản phẩm trong giỏ hàng
     */
    public void capNhatSoLuong(int idNguoiDung, int idSanPham, int soLuongMoi) {
        try {
            int idGioHang = layHoacTaoGioHang(idNguoiDung);
            String sql = "UPDATE gio_hang_chi_tiet SET so_luong = ?, ngay_them = GETDATE() WHERE id_gio_hang = ? AND id_san_pham = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, soLuongMoi);
                stmt.setInt(2, idGioHang);
                stmt.setInt(3, idSanPham);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Xóa một sản phẩm khỏi giỏ hàng
     */
    public void xoaSanPhamKhoiGio(int idNguoiDung, int idSanPham) {
        try {
            int idGioHang = layHoacTaoGioHang(idNguoiDung);
            String sql = "DELETE FROM gio_hang_chi_tiet WHERE id_gio_hang = ? AND id_san_pham = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, idGioHang);
                stmt.setInt(2, idSanPham);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Lấy danh sách sản phẩm chi tiết trong giỏ hàng
     */
    public List<GioHangItem> layDanhSachSanPhamTrongGio(int idNguoiDung) {
        List<GioHangItem> danhSach = new ArrayList<>();
        try {
            int idGioHang = layHoacTaoGioHang(idNguoiDung);

            String sql = """
                SELECT ghct.id, ghct.id_san_pham, ghct.so_luong, ghct.ngay_them,
                       sp.id AS sp_id, sp.ten_san_pham, sp.mo_ta, sp.gia,
                       sp.so_luong AS ton_kho, sp.anh_url, sp.id_loai,
                       sp.ngay_tao, sp.ngay_cap_nhat
                FROM gio_hang_chi_tiet ghct
                JOIN san_pham sp ON ghct.id_san_pham = sp.id
                WHERE ghct.id_gio_hang = ?
            """;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, idGioHang);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        GioHangItem item = new GioHangItem();
                        item.setId(rs.getInt("id"));
                        item.setIdGioHang(idGioHang);
                        item.setIdSanPham(rs.getInt("id_san_pham"));
                        item.setSoLuong(rs.getInt("so_luong"));
                        item.setNgayTao(rs.getTimestamp("ngay_them"));

                        // Gắn thông tin sản phẩm vào item
                        SanPham sp = new SanPham();
                        sp.setId(rs.getInt("sp_id"));
                        sp.setTenSanPham(rs.getString("ten_san_pham"));
                        sp.setMoTa(rs.getString("mo_ta"));
                        sp.setGia(rs.getDouble("gia"));
                        sp.setSoLuong(rs.getInt("ton_kho"));
                        sp.setAnhUrl(rs.getString("anh_url"));
                        sp.setIdLoai(rs.getInt("id_loai"));
                        sp.setNgayTao(rs.getTimestamp("ngay_tao"));
                        sp.setNgayCapNhat(rs.getTimestamp("ngay_cap_nhat"));

                        item.setSanPham(sp);

                        danhSach.add(item);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return danhSach;
    }
}
