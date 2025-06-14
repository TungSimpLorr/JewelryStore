
USE jewelry_store_db;

-- bang nguoi dung
CREATE TABLE IF NOT EXISTS nguoi_dung (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    mat_khau VARCHAR(255) NOT NULL
);

-- bang admin
CREATE TABLE IF NOT EXISTS quan_tri_vien (
    id_quan_tri_vien INT PRIMARY KEY AUTO_INCREMENT,
    ten_quan_tri_vien VARCHAR(50) UNIQUE,
    mat_khau_ma_hoa VARCHAR(255),
    quyen ENUM('superadmin', 'staff')
);

-- bang danh muc bai viet
CREATE TABLE IF NOT EXISTS danh_muc_bai_viet (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ten_danh_muc VARCHAR(100) NOT NULL
);

-- bang thuong hieu 
CREATE TABLE IF NOT EXISTS thuong_hieu (
    id_thuong_hieu INT PRIMARY KEY AUTO_INCREMENT,
    ten_thuong_hieu VARCHAR(100) NOT NULL
);

-- bang loai san pham 
CREATE TABLE IF NOT EXISTS loai_san_pham (
    id_loai_san_pham INT PRIMARY KEY AUTO_INCREMENT,
    ten_loai VARCHAR(100) NOT NULL
);

-- bang san pham
CREATE TABLE IF NOT EXISTS san_pham (
    id_san_pham INT PRIMARY KEY AUTO_INCREMENT,
    ma_san_pham VARCHAR(100) NOT NULL,
    ten_san_pham VARCHAR(255) NOT NULL,
    gia_san_pham DECIMAL(10,2) NOT NULL,
    mo_ta TEXT,
    id_thuong_hieu INT,
    id_loai_san_pham INT,
    khoi_luong DECIMAL(10,2),
    trang_thai_chung BOOLEAN DEFAULT 1,
    url_anh_dai_dien VARCHAR(255),
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_thuong_hieu) REFERENCES thuong_hieu(id_thuong_hieu) ON DELETE CASCADE,
    FOREIGN KEY (id_loai_san_pham) REFERENCES loai_san_pham(id_loai_san_pham) ON DELETE CASCADE
);

-- bang blog 
CREATE TABLE IF NOT EXISTS bai_viet (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tieu_de VARCHAR(255) NOT NULL,
    noi_dung TEXT NOT NULL,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ma_nguoi_dung INT NOT NULL,
    ma_danh_muc INT NOT NULL,
    trang_thai ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(id) ON DELETE CASCADE,
    FOREIGN KEY (ma_danh_muc) REFERENCES danh_muc_bai_viet(id) ON DELETE RESTRICT
);

-- bang gio hang
CREATE TABLE IF NOT EXISTS gio_hang (
    id_gio_hang INT PRIMARY KEY AUTO_INCREMENT,
    ma_nguoi_dung INT,
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    trang_thai_gio_hang ENUM('active', 'ordered', 'abandoned') DEFAULT 'active',
    FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(id) ON DELETE CASCADE
);

-- bang chi tiet gio hang 
CREATE TABLE IF NOT EXISTS chi_tiet_gio_hang (
    id_muc_gio_hang INT PRIMARY KEY AUTO_INCREMENT,
    ma_gio_hang INT,
    ma_san_pham INT,
    so_luong INT,
    gia DECIMAL(10,2),
    tong_phu DECIMAL(10,2),
    FOREIGN KEY (ma_gio_hang) REFERENCES gio_hang(id_gio_hang) ON DELETE CASCADE,
    FOREIGN KEY (ma_san_pham) REFERENCES san_pham(id_san_pham) ON DELETE RESTRICT
);

-- bang anh san pham
CREATE TABLE IF NOT EXISTS anh_san_pham (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ma_san_pham INT,
    duong_dan VARCHAR(255),
    FOREIGN KEY (ma_san_pham) REFERENCES san_pham(id_san_pham) ON DELETE CASCADE
);

-- bang don hang 
CREATE TABLE IF NOT EXISTS don_hang (
    id_don_hang INT PRIMARY KEY AUTO_INCREMENT,
    ma_nguoi_dung INT NOT NULL,
    tong_tien DECIMAL(10,2) NOT NULL,
    dia_chi_giao_hang VARCHAR(255) NOT NULL,
    trang_thai ENUM('cho_xu_ly', 'dang_giao', 'da_giao', 'da_huy') DEFAULT 'cho_xu_ly',
    ngay_dat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_nguoi_dung) REFERENCES nguoi_dung(id) ON DELETE CASCADE
);

-- bang chi tiet don hang 
CREATE TABLE IF NOT EXISTS chi_tiet_don_hang (
    id_chi_tiet INT PRIMARY KEY AUTO_INCREMENT,
    ma_don_hang INT NOT NULL,
    ma_san_pham INT NOT NULL,
    so_luong INT NOT NULL,
    gia DECIMAL(10,2) NOT NULL,
    tong_phu DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (ma_don_hang) REFERENCES don_hang(id_don_hang) ON DELETE CASCADE,
    FOREIGN KEY (ma_san_pham) REFERENCES san_pham(id_san_pham) ON DELETE RESTRICT
);
