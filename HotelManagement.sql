CREATE DATABASE HotelManagement;
GO

USE HotelManagement;
GO

-- Bảng KhachHang
CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY IDENTITY(1,1),
    TenKhachHang NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    CMND NVARCHAR(20) UNIQUE,
    SoDienThoai NVARCHAR(15),
    Email NVARCHAR(100),
    DiaChi NVARCHAR(200),
    NgayTao DATETIME DEFAULT GETDATE(),
    LaKhachVIP BIT DEFAULT 0,
    MucUuDai DECIMAL(5, 2) DEFAULT 0.00
);

-- Bảng NhanVien
CREATE TABLE NhanVien (
    MaNhanVien INT PRIMARY KEY IDENTITY(1,1),
    TenNhanVien NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    GioiTinh NVARCHAR(10) CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác')),
    Email NVARCHAR(100) UNIQUE,
    SoDienThoai NVARCHAR(15),
    ChucVu NVARCHAR(50),
    NgayVaoLam DATE DEFAULT GETDATE(),
    NgayTao DATETIME DEFAULT GETDATE()
);

-- Bảng NguoiDung
CREATE TABLE NguoiDung (
    MaNguoiDung INT PRIMARY KEY IDENTITY(1,1),
    Email NVARCHAR(100) NOT NULL UNIQUE,
    MatKhau NVARCHAR(100) NOT NULL,
    VaiTro NVARCHAR(20) NOT NULL CHECK (VaiTro IN (N'Nhân viên', N'Khách hàng')),
    TrangThai NVARCHAR(20) DEFAULT N'Chưa kích hoạt' CHECK (TrangThai IN (N'Chưa kích hoạt', N'Đã kích hoạt')),
    MaNhanVien INT NULL,
    MaKhachHang INT NULL,
    NgayTao DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    CONSTRAINT CHK_OneRoleOnly CHECK (
        (MaNhanVien IS NOT NULL AND MaKhachHang IS NULL AND VaiTro = N'Nhân viên') OR
        (MaKhachHang IS NOT NULL AND MaNhanVien IS NULL AND VaiTro = N'Khách hàng')
    )
);

-- Bảng LoaiPhong
CREATE TABLE LoaiPhong (
    MaLoaiPhong INT PRIMARY KEY IDENTITY(1,1),
    TenLoaiPhong NVARCHAR(50) NOT NULL,
    GiaPhong DECIMAL(18, 2) NOT NULL CHECK (GiaPhong >= 0),
    MoTa NVARCHAR(255)
);

-- Bảng Phong
CREATE TABLE Phong (
    MaPhong INT PRIMARY KEY IDENTITY(1,1),
    MaLoaiPhong INT NOT NULL,
    TinhTrang NVARCHAR(20) DEFAULT N'Trống' CHECK (TinhTrang IN (N'Trống', N'Đang thuê', N'Bảo trì')),
    SoDienThoaiHoTro NVARCHAR(15),
    FOREIGN KEY (MaLoaiPhong) REFERENCES LoaiPhong(MaLoaiPhong)
);

-- Bảng DichVu
CREATE TABLE DichVu (
    MaDichVu INT PRIMARY KEY IDENTITY(1,1),
    TenDichVu NVARCHAR(100) NOT NULL,
    DonVi NVARCHAR(20),
    GiaDichVu DECIMAL(18, 2) NOT NULL CHECK (GiaDichVu >= 0),
    MoTa NVARCHAR(255)
);

-- Bảng PhieuThue
CREATE TABLE PhieuThue (
    MaPhieuThue INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT NOT NULL,
    MaNhanVien INT NOT NULL,
    NgayLap DATETIME DEFAULT GETDATE(),
    TrangThai NVARCHAR(20) DEFAULT N'Đã đặt' CHECK (TrangThai IN (N'Đã đặt', N'Hoàn thành', N'Đã hủy')),
    NguonDatPhong NVARCHAR(20) DEFAULT N'Trực tiếp' CHECK (NguonDatPhong IN (N'Trực tiếp', N'Trực tuyến')),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang),
    FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- Bảng ChiTietPhieuThue
CREATE TABLE ChiTietPhieuThue (
    MaChiTietPhieuThue INT PRIMARY KEY IDENTITY(1,1),
    MaPhieuThue INT NOT NULL,
    MaPhong INT NOT NULL,
    SoLuongKhach INT DEFAULT 1 CHECK (SoLuongKhach > 0),
    NgayThue DATETIME NOT NULL,
    NgayTra DATETIME NOT NULL,
    CONSTRAINT CHK_Dates CHECK (NgayThue < NgayTra),
    FOREIGN KEY (MaPhieuThue) REFERENCES PhieuThue(MaPhieuThue),
    FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
);

-- Bảng ChiTietDichVu
CREATE TABLE ChiTietDichVu (
    MaChiTietDichVu INT PRIMARY KEY IDENTITY(1,1),
    MaPhieuThue INT NOT NULL,
    MaDichVu INT NOT NULL,
    SoLuong INT DEFAULT 1 CHECK (SoLuong > 0),
    NgaySuDung DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (MaPhieuThue) REFERENCES PhieuThue(MaPhieuThue),
    FOREIGN KEY (MaDichVu) REFERENCES DichVu(MaDichVu)
);

-- Bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon INT PRIMARY KEY IDENTITY(1,1),
    MaPhieuThue INT NOT NULL,
    TienPhong DECIMAL(18, 2) NOT NULL CHECK (TienPhong >= 0),
    TienDichVu DECIMAL(18, 2) NOT NULL CHECK (TienDichVu >= 0),
    TongTien DECIMAL(18, 2) NOT NULL CHECK (TongTien >= 0),
    NgayXuatHoaDon DATETIME DEFAULT GETDATE(),
    PhuongThucThanhToan NVARCHAR(50) DEFAULT N'Tiền mặt' CHECK (PhuongThucThanhToan IN (N'Tiền mặt', N'Chuyển khoản', N'Thẻ tín dụng')),
    TrangThaiThanhToan NVARCHAR(20) DEFAULT N'Chưa thanh toán' CHECK (TrangThaiThanhToan IN (N'Chưa thanh toán', N'Đã thanh toán')),
    FOREIGN KEY (MaPhieuThue) REFERENCES PhieuThue(MaPhieuThue)
);

-- Bảng BaoTriPhong
CREATE TABLE BaoTriPhong (
    MaBaoTri INT PRIMARY KEY IDENTITY(1,1),
    MaPhong INT NOT NULL,
    LyDo NVARCHAR(255),
    NgayBatDau DATETIME NOT NULL,
    NgayKetThuc DATETIME,
    TrangThai NVARCHAR(20) DEFAULT N'Đang bảo trì' CHECK (TrangThai IN (N'Đang bảo trì', N'Hoàn thành')),
    CONSTRAINT CHK_BaoTri_Dates CHECK (NgayBatDau < NgayKetThuc),
    FOREIGN KEY (MaPhong) REFERENCES Phong(MaPhong)
);

-- Bảng LichSuVIP
CREATE TABLE LichSuVIP (
    MaVIP INT PRIMARY KEY IDENTITY(1,1),
    MaKhachHang INT NOT NULL,
    NgayDangKy DATETIME DEFAULT GETDATE(),
    MucUuDai DECIMAL(5, 2) NOT NULL CHECK (MucUuDai >= 0),
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);

-- Bảng LichSuDoiPhong (Thêm mới)
CREATE TABLE LichSuDoiPhong (
    MaDoiPhong INT PRIMARY KEY IDENTITY(1,1),
    MaChiTietPhieuThue INT NOT NULL,
    PhongCu INT NOT NULL,
    PhongMoi INT NOT NULL,
    ThoiGianDoiPhong DATETIME DEFAULT GETDATE(),
    LyDo NVARCHAR(255),
    FOREIGN KEY (MaChiTietPhieuThue) REFERENCES ChiTietPhieuThue(MaChiTietPhieuThue),
    FOREIGN KEY (PhongCu) REFERENCES Phong(MaPhong),
    FOREIGN KEY (PhongMoi) REFERENCES Phong(MaPhong)
);

-- Tạo chỉ mục để tối ưu truy vấn
CREATE INDEX IDX_KhachHang_SoDienThoai ON KhachHang(SoDienThoai);
CREATE INDEX IDX_NhanVien_Email ON NhanVien(Email);
CREATE INDEX IDX_NguoiDung_Email ON NguoiDung(Email);
CREATE INDEX IDX_ChiTietPhieuThue_NgayThue ON ChiTietPhieuThue(NgayThue);
CREATE INDEX IDX_ChiTietDichVu_NgaySuDung ON ChiTietDichVu(NgaySuDung);
CREATE INDEX IDX_HoaDon_NgayXuatHoaDon ON HoaDon(NgayXuatHoaDon);
CREATE INDEX IDX_LichSuDoiPhong_ThoiGianDoiPhong ON LichSuDoiPhong(ThoiGianDoiPhong);

-- Trigger để tự động cập nhật TinhTrang trong bảng Phong
GO
CREATE TRIGGER UpdateRoomStatus
ON ChiTietPhieuThue
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Phong
    SET TinhTrang = 
        CASE 
            WHEN EXISTS (
                SELECT 1 
                FROM BaoTriPhong bt 
                WHERE bt.MaPhong = Phong.MaPhong 
                AND bt.TrangThai = N'Đang bảo trì'
            ) THEN N'Bảo trì'
            ELSE 
                CASE 
                    WHEN EXISTS (
                        SELECT 1 
                        FROM ChiTietPhieuThue cpt 
                        WHERE cpt.MaPhong = Phong.MaPhong 
                        AND GETDATE() BETWEEN cpt.NgayThue AND cpt.NgayTra
                    ) THEN N'Đang thuê'
                    ELSE N'Trống'
                END
        END
    FROM Phong
    WHERE Phong.MaPhong IN (
        SELECT MaPhong FROM inserted
        UNION
        SELECT MaPhong FROM deleted
    );
END;
GO

-- Trigger cập nhật trạng thái phòng khi bảo trì
GO
CREATE TRIGGER UpdateRoomStatusOnMaintenance
ON BaoTriPhong
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Phong
    SET TinhTrang = 
        CASE 
            WHEN EXISTS (
                SELECT 1 
                FROM BaoTriPhong bt 
                WHERE bt.MaPhong = Phong.MaPhong 
                AND bt.TrangThai = N'Đang bảo trì'
            ) THEN N'Bảo trì'
            ELSE 
                CASE 
                    WHEN EXISTS (
                        SELECT 1 
                        FROM ChiTietPhieuThue cpt 
                        WHERE cpt.MaPhong = Phong.MaPhong 
                        AND GETDATE() BETWEEN cpt.NgayThue AND cpt.NgayTra
                    ) THEN N'Đang thuê'
                    ELSE N'Trống'
                END
        END
    FROM Phong
    WHERE Phong.MaPhong IN (SELECT MaPhong FROM inserted);
END;
GO

-- 1. Thêm dữ liệu vào bảng KhachHang
INSERT INTO KhachHang (TenKhachHang, NgaySinh, GioiTinh, CMND, SoDienThoai, Email, DiaChi, NgayTao, LaKhachVIP, MucUuDai)
VALUES 
    (N'Nguyễn Văn Hùng', '1990-05-15', N'Nam', '123456789', '0905123456', 'hungnv@gmail.com', N'123 Đường Láng, Đống Đa, Hà Nội', '2025-04-01', 1, 10.00),
    (N'Trần Thị Mai', '1985-08-20', N'Nữ', '987654321', '0918765432', 'mai.tran@yahoo.com', N'45 Nguyễn Huệ, TP Huế', '2025-04-02', 0, 0.00),
    (N'Phạm Quốc Anh', '1995-03-10', N'Nam', '456789123', '0935123789', 'anhpq@gmail.com', N'78 Lê Lợi, TP Đà Nẵng', '2025-04-03', 0, 0.00);

-- 2. Thêm dữ liệu vào bảng NhanVien
INSERT INTO NhanVien (TenNhanVien, NgaySinh, GioiTinh, Email, SoDienThoai, ChucVu, NgayVaoLam, NgayTao)
VALUES 
    (N'Lê Thị Hồng', '1992-07-12', N'Nữ', 'hong.le@hotel.com', '0987654321', N'Lễ tân', '2024-01-15', '2024-01-15'),
    (N'Ngô Văn Tâm', '1988-11-05', N'Nam', 'tam.ngo@hotel.com', '0971234567', N'Quản lý', '2023-06-01', '2023-06-01'),
    (N'Hoàng Minh Tuấn', '1990-09-25', N'Nam', 'tuan.hm@hotel.com', '0967891234', N'Lễ tân', '2024-03-01', '2024-03-01');

-- 3. Thêm dữ liệu vào bảng NguoiDung
INSERT INTO NguoiDung (Email, MatKhau, VaiTro, TrangThai, MaNhanVien, MaKhachHang, NgayTao)
VALUES 
    (N'hong.le@hotel.com', N'password123', N'Nhân viên', N'Đã kích hoạt', 1, NULL, '2024-01-15'),
    (N'tam.ngo@hotel.com', N'admin123', N'Nhân viên', N'Đã kích hoạt', 2, NULL, '2023-06-01'),
    (N'tuan.hm@hotel.com', N'password456', N'Nhân viên', N'Đã kích hoạt', 3, NULL, '2024-03-01'),
    (N'hungnv@gmail.com', N'customer123', N'Khách hàng', N'Đã kích hoạt', NULL, 1, '2025-04-01'),
    (N'anhpq@gmail.com', N'customer789', N'Khách hàng', N'Đã kích hoạt', NULL, 3, '2025-04-03');

-- 4. Thêm dữ liệu vào bảng LoaiPhong
INSERT INTO LoaiPhong (TenLoaiPhong, GiaPhong, MoTa)
VALUES 
    (N'Cao cấp', 1500000, N'Phòng rộng 40m2, có ban công và view biển'),
    (N'Trung cấp', 800000, N'Phòng 30m2, đầy đủ tiện nghi, không có ban công'),
    (N'Bình dân', 500000, N'Phòng 20m2, tiện nghi cơ bản');

-- 5. Thêm dữ liệu vào bảng Phong
INSERT INTO Phong (MaLoaiPhong, TinhTrang, SoDienThoaiHoTro)
VALUES 
    (1, N'Trống', '19001234'),
    (1, N'Trống', '19001234'),
    (2, N'Trống', '19001234'),
    (3, N'Trống', '19001234');

-- 6. Thêm dữ liệu vào bảng DichVu
INSERT INTO DichVu (TenDichVu, DonVi, GiaDichVu, MoTa)
VALUES 
    (N'Ăn sáng buffet', N'Lần', 200000, N'Buffet sáng đa dạng món Á-Âu'),
    (N'Giặt là', N'Kg', 50000, N'Giặt và ủi quần áo theo kg'),
    (N'Thuê xe máy', N'Giờ', 30000, N'Thuê xe máy để khám phá khu vực');

-- 7. Thêm dữ liệu vào bảng PhieuThue
INSERT INTO PhieuThue (MaKhachHang, MaNhanVien, NgayLap, TrangThai, NguonDatPhong)
VALUES 
    (1, 1, '2025-04-25 10:00:00', N'Đã đặt', N'Trực tiếp'),
    (2, 3, '2025-04-26 14:00:00', N'Đã đặt', N'Trực tiếp'),
    (3, 1, '2025-04-27 09:00:00', N'Đã hủy', N'Trực tiếp'),
    (3, 1, '2025-04-27 15:00:00', N'Đã đặt', N'Trực tuyến');

-- 8. Thêm dữ liệu vào bảng ChiTietPhieuThue
INSERT INTO ChiTietPhieuThue (MaPhieuThue, MaPhong, SoLuongKhach, NgayThue, NgayTra)
VALUES 
    (1, 1, 2, '2025-04-25 14:00:00', '2025-04-28 12:00:00'),
    (1, 2, 1, '2025-04-25 14:00:00', '2025-04-28 12:00:00'),
    (2, 3, 3, '2025-04-26 15:00:00', '2025-04-29 11:00:00'),
    (4, 2, 2, '2025-05-01 14:00:00', '2025-05-03 12:00:00');

-- 9. Thêm dữ liệu vào bảng ChiTietDichVu
INSERT INTO ChiTietDichVu (MaPhieuThue, MaDichVu, SoLuong, NgaySuDung)
VALUES 
    (1, 1, 2, '2025-04-26 07:00:00'),
    (1, 2, 3, '2025-04-27 09:00:00'),
    (2, 3, 4, '2025-04-26 10:00:00'),
    (4, 1, 2, '2025-05-02 07:00:00');

-- 10. Thêm dữ liệu vào bảng HoaDon
INSERT INTO HoaDon (MaPhieuThue, TienPhong, TienDichVu, TongTien, NgayXuatHoaDon, PhuongThucThanhToan, TrangThaiThanhToan)
VALUES 
    (1, 9000000, 550000, 9550000, '2025-04-28 12:30:00', N'Thẻ tín dụng', N'Đã thanh toán'),
    (2, 2400000, 120000, 2520000, '2025-04-29 11:30:00', N'Chuyển khoản', N'Chưa thanh toán');

-- 11. Thêm dữ liệu vào bảng BaoTriPhong
INSERT INTO BaoTriPhong (MaPhong, LyDo, NgayBatDau, NgayKetThuc, TrangThai)
VALUES 
    (4, N'Hư máy lạnh', '2025-04-28 09:00:00', '2025-04-29 17:00:00', N'Hoàn thành'),
    (3, N'Vệ sinh định kỳ', '2025-04-30 08:00:00', '2025-04-30 12:00:00', N'Hoàn thành');

-- 12. Thêm dữ liệu vào bảng LichSuVIP
INSERT INTO LichSuVIP (MaKhachHang, NgayDangKy, MucUuDai)
VALUES 
    (1, '2025-04-27', 10.00);

-- 13. Thêm dữ liệu vào bảng LichSuDoiPhong
INSERT INTO LichSuDoiPhong (MaChiTietPhieuThue, PhongCu, PhongMoi, ThoiGianDoiPhong, LyDo)
VALUES 
    (1, 1, 4, '2025-04-26 15:00:00', N'Phòng không có view'),
    (3, 3, 1, '2025-04-27 10:00:00', N'Khách yêu cầu phòng cao cấp hơn');
GO