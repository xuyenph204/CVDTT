package BTL.models;

import java.sql.Timestamp;

public class GioHangItem {
    private int id;               // id của chi tiết giỏ hàng
    private int idGioHang;        // khóa ngoại tới bảng gio_hang
    private int idSanPham;        // khóa ngoại tới bảng san_pham
    private int soLuong;          // số lượng sản phẩm
    private Timestamp ngayTao;  // ngày thêm vào giỏ hàng

    private SanPham sanPham;     // đối tượng sản phẩm liên kết
    private NguoiDung nguoiDung; // nếu cần dùng thông tin người dùng

    // Constructor rỗng
    public GioHangItem() {}

    // Constructor đầy đủ
    public GioHangItem(int id, int idGioHang, int idSanPham, int soLuong, Timestamp ngayTao) {
        this.id = id;
        this.idGioHang = idGioHang;
        this.idSanPham = idSanPham;
        this.soLuong = soLuong;
        this.ngayTao = ngayTao;
    }

    // Getters & Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdGioHang() {
        return idGioHang;
    }

    public void setIdGioHang(int idGioHang) {
        this.idGioHang = idGioHang;
    }

    public int getIdSanPham() {
        return idSanPham;
    }

    public void setIdSanPham(int idSanPham) {
        this.idSanPham = idSanPham;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public Timestamp getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(Timestamp ngayTao) {
        this.ngayTao = ngayTao;
    }

    public SanPham getSanPham() {
        return sanPham;
    }

    public void setSanPham(SanPham sanPham) {
        this.sanPham = sanPham;
    }

    public NguoiDung getNguoiDung() {
        return nguoiDung;
    }

    public void setNguoiDung(NguoiDung nguoiDung) {
        this.nguoiDung = nguoiDung;
    }
}