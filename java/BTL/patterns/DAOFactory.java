package BTL.patterns;

import BTL.daos.SanPhamDAO;

public class DAOFactory {
    public static SanPhamDAO createSanPhamDAO() {
        return new SanPhamDAO();
    }
}
