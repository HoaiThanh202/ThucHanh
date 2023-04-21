--1a--
CREATE PROCEDURE sp_ThemKhoa
    @makhoa nvarchar(10),
    @tenkhoa nvarchar(50),
    @dienthoai nvarchar(20)
AS
BEGIN
    IF EXISTS (SELECT * FROM KHOA WHERE tenkhoa = @tenkhoa)
    BEGIN
        PRINT 'Tên khoa đã tồn tại'
    END
    ELSE
    BEGIN
        INSERT INTO KHOA(makhoa, tenkhoa, dienthoai)
        VALUES (@makhoa, @tenkhoa, @dienthoai)
        PRINT 'Thêm khoa thành công'
    END
END

--1b--
CREATE PROCEDURE sp_ThemLop 
    @malop nvarchar(10),
    @tenlop nvarchar(50),
    @khoa nvarchar(10),
    @hedt nvarchar(10),
    @namnhaphoc nvarchar(10),
    @makhoa nvarchar(10)
AS
BEGIN
    IF EXISTS (SELECT * FROM Lop WHERE tenlop = @tenlop)
    BEGIN
        PRINT 'Tên lớp đã tồn tại'
    END
    ELSE IF NOT EXISTS (SELECT * FROM KHOA WHERE makhoa = @makhoa)
    BEGIN
        PRINT 'Mã khoa không tồn tại'
    END
    ELSE
    BEGIN
        INSERT INTO Lop(malop, tenlop, khoa, hedt, namnhaphoc, makhoa)
        VALUES (@malop, @tenlop, @khoa, @hedt, @namnhaphoc, @makhoa)
        PRINT 'Thêm lớp thành công'
    END
END

--1c--
CREATE PROCEDURE sp_ThemKhoa2
    @makhoa nvarchar(10),
    @tenkhoa nvarchar(50),
    @dienthoai nvarchar(20)
AS
BEGIN
    IF EXISTS (SELECT * FROM KHOA WHERE tenkhoa = @tenkhoa)
    BEGIN
        SELECT 0
    END
    ELSE
    BEGIN
        INSERT INTO KHOA(makhoa, tenkhoa, dienthoai)
        VALUES (@makhoa, @tenkhoa, @dienthoai)
        SELECT 1
    END
END

--1d--
CREATE PROCEDURE sp_ThemLop2 
    @malop nvarchar(10),
    @tenlop nvarchar(50),
    @khoa nvarchar(10),
    @hedt nvarchar(10),
    @namnhaphoc nvarchar(10),
    @makhoa nvarchar(10)
AS
BEGIN
    IF EXISTS (SELECT * FROM Lop WHERE tenlop = @tenlop)
    BEGIN
        SELECT 0
    END
    ELSE IF NOT EXISTS (SELECT * FROM KHOA WHERE makhoa = @makhoa)
    BEGIN
        SELECT 1
    END
    ELSE
    BEGIN
        INSERT INTO Lop(malop, tenlop, khoa, hedt, namnhaphoc, makhoa)
        VALUES (@malop, @tenlop, @khoa, @hedt, @namnhaphoc, @makhoa)
        SELECT 2
    END
END

--2a--
CREATE PROCEDURE SP_Them_Nhan_Vien
    @MaNV nvarchar(10),
    @MaCV nvarchar(10),
    @TenNV nvarchar(50),
    @Ngaysinh date,
    @LuongCanBan float,
    @NgayCong int,
    @PhuCap float
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM tblChucVu WHERE MaCV = @MaCV)
    BEGIN
        PRINT 'Mã chức vụ không tồn tại'
    END
    ELSE
    BEGIN
        INSERT INTO tblNhanVien (MaNV, MaCV, TenNV, Ngaysinh, LuongCanBan, NgayCong, PhuCap)
        VALUES (@MaNV, @MaCV, @TenNV, @Ngaysinh, @LuongCanBan, @NgayCong, @PhuCap)
        PRINT 'Thêm nhân viên thành công'
    END
END

--2b--
CREATE PROCEDURE SP_CapNhat_Nhan_Vien
    @MaNV nvarchar(10),
    @MaCV nvarchar(10),
    @TenNV nvarchar(50),
    @Ngaysinh date,
    @LuongCanBan float,
    @NgayCong int,
    @PhuCap float
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM tblNhanVien WHERE MaNV = @MaNV)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại'
    END
    ELSE IF NOT EXISTS (SELECT * FROM tblChucVu WHERE MaCV = @MaCV)
    BEGIN
        PRINT 'Mã chức vụ không tồn tại'
    END
    ELSE
    BEGIN
        UPDATE tblNhanVien
        SET MaCV = @MaCV, TenNV = @TenNV, Ngaysinh = @Ngaysinh, LuongCanBan = @LuongCanBan, NgayCong = @NgayCong, PhuCap = @PhuCap
        WHERE MaNV = @MaNV
        PRINT 'Cập nhật thông tin nhân viên thành công'
    END
END

--2c--
CREATE PROCEDURE SP_LuongLN
AS
BEGIN
    SELECT MaNV, TenNV, LuongCanBan, NgayCong, PhuCap, LuongCanBan*NgayCong+PhuCap AS Luong
    FROM tblNhanVien
END

--3a--
CREATE PROCEDURE SP_NhapHangSXX
    @MaHangSX nvarchar(10),
    @TenHang nvarchar(50),
    @DiaChi nvarchar(100),
    @SoDT nvarchar(20),
    @Email nvarchar(50)
AS
BEGIN
    IF EXISTS (SELECT * FROM HangSX WHERE TenHang = @TenHang)
    BEGIN
        PRINT 'Tên hãng sản xuất đã tồn tại'
    END
    ELSE
    BEGIN
        INSERT INTO HangSX(MaHangSX, TenHang, DiaChi, SoDT, Email)
        VALUES(@MaHangSX, @TenHang, @DiaChi, @SoDT, @Email)
        PRINT 'Nhập thông tin hãng sản xuất thành công'
    END
END

--3b--
CREATE PROCEDURE SP_NhapSanPham
    @MaSP nvarchar(10),
    @TenHangSX nvarchar(50),
    @TenSP nvarchar(50),
    @SoLuong int,
    @MauSac nvarchar(20),
    @GiaBan float,
    @DonViTinh nvarchar(10),
    @MoTa nvarchar(100)
AS
BEGIN
    IF EXISTS (SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        UPDATE SanPham
        SET TenHangSX = @TenHangSX, TenSP = @TenSP, SoLuong = @SoLuong, MauSac = @MauSac, GiaBan = @GiaBan, DonViTinh = @DonViTinh, MoTa = @MoTa
        WHERE MaSP = @MaSP
        PRINT 'Cập nhật thông tin sản phẩm thành công'
    END
    ELSE
    BEGIN
        INSERT INTO SanPham(MaSP, TenHangSX, TenSP, SoLuong, MauSac, GiaBan, DonViTinh, MoTa)
        VALUES(@MaSP, @TenHangSX, @TenSP, @SoLuong, @MauSac, @GiaBan, @DonViTinh, @MoTa)
        PRINT 'Nhập thông tin sản phẩm thành công'
    END
END

--3c--
CREATE PROCEDURE SP_XoaHangSX
    @TenHang nvarchar(50)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM HangSX WHERE TenHang = @TenHang)
    BEGIN
        PRINT 'Tên hãng sản xuất không tồn tại'
    END
    ELSE
    BEGIN
        BEGIN TRANSACTION
        DELETE FROM Nhap WHERE MaSP IN (SELECT MaSP FROM SanPham WHERE TenHangSX = @TenHang)
        DELETE FROM Xuat WHERE MaSP IN (SELECT MaSP FROM SanPham WHERE TenHangSX = @TenHang)
        DELETE FROM SanPham WHERE TenHangSX = @TenHang
        DELETE FROM HangSX WHERE TenHang = @TenHang
        COMMIT TRANSACTION
        PRINT 'Xóa thông tin hãng sản xuất thành công'
    END
END

--3d--
CREATE PROCEDURE SP_NhapNhanVien
    @MaNV nvarchar(10),
    @TenNV nvarchar(50),
    @GioiTinh nvarchar(5),
    @DiaChi nvarchar(100),
    @SoDT nvarchar(20),
    @Email nvarchar(50),
    @Phong nvarchar(50),
    @Flag bit
AS
BEGIN
    IF @Flag = 0
    BEGIN
        UPDATE NhanVien
        SET TenNV = @TenNV, GioiTinh = @GioiTinh, DiaChi = @DiaChi, SoDT = @SoDT, Email = @Email, Phong = @Phong
        WHERE MaNV = @MaNV
        PRINT 'Cập nhật thông tin nhân viên thành công'
    END
    ELSE
    BEGIN
        INSERT INTO NhanVien(MaNV, TenNV, GioiTinh, DiaChi, SoDT, Email, Phong)
        VALUES(@MaNV, @TenNV, @GioiTinh, @DiaChi, @SoDT, @Email, @Phong)
        PRINT 'Nhập thông tin nhân viên thành công'
    END
END

--3e--
CREATE PROCEDURE SP_NhapNhap
    @SoHDN nvarchar(10),
    @MaSP nvarchar(10),
    @MaNV nvarchar(10),
    @NgayNhap date,
    @SoLuongN int,
    @DonGiaN float
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        PRINT 'Mã sản phẩm không tồn tại'
    END
    ELSE IF NOT EXISTS (SELECT * FROM NhanVien WHERE MaNV = @MaNV)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại'
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT * FROM Nhap WHERE SoHDN = @SoHDN)
        BEGIN
            UPDATE Nhap
            SET MaSP = @MaSP, MaNV = @MaNV, NgayNhap = @NgayNhap, SoLuongN = @SoLuongN, DonGiaN = @DonGiaN
            WHERE SoHDN = @SoHDN
            PRINT 'Cập nhật thông tin phiếu nhập thành công'
        END
        ELSE
        BEGIN
            INSERT INTO Nhap(SoHDN, MaSP, MaNV, NgayNhap, SoLuongN, DonGiaN)
            VALUES(@SoHDN, @MaSP, @MaNV, @NgayNhap, @SoLuongN, @DonGiaN)
            PRINT 'Nhập thông tin phiếu nhập thành công'
        END
    END
END

--3f--
CREATE PROCEDURE SP_Nhap_Xuat
    @SoHDX nvarchar(10),
    @MaSP nvarchar(10),
    @MaNV nvarchar(10),
    @NgayXuat date,
    @SoLuongX int
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSP=@MaSP)
    BEGIN
        PRINT 'Mã sản phẩm không tồn tại'
    END
    ELSE IF NOT EXISTS (SELECT * FROM NhanVien WHERE MaNV=@MaNV)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại'
    END
    ELSE
    BEGIN
        DECLARE @SoLuongTon int
        SELECT @SoLuongTon = SoLuongTon FROM SanPham WHERE MaSP = @MaSP
        IF(@SoLuongTon < @SoLuongX)
        BEGIN
            PRINT 'Số lượng xuất vượt quá số lượng tồn kho'
        END
        ELSE
        BEGIN
            IF EXISTS (SELECT * FROM Xuat WHERE SoHDX=@SoHDX)
            BEGIN
                UPDATE Xuat
                SET MaSP=@MaSP, MaNV=@MaNV, NgayXuat=@NgayXuat, SoLuongX=@SoLuongX
                WHERE SoHDX=@SoHDX
            END
            ELSE
            BEGIN
                INSERT INTO Xuat(SoHDX, MaSP, MaNV, NgayXuat, SoLuongX)
                VALUES (@SoHDX, @MaSP, @MaNV, @NgayXuat, @SoLuongX)
            END

            UPDATE SanPham
            SET SoLuongTon = SoLuongTon - @SoLuongX
            WHERE MaSP = @MaSP
        END
    END
END

--3g--
CREATE PROCEDURE SP_Xoa_NhanVien
    @MaNV nvarchar(10)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM NhanVien WHERE MaNV = @MaNV)
    BEGIN
        PRINT 'Mã nhân viên không tồn tại'
    END
    ELSE
    BEGIN
        DELETE FROM Nhap WHERE MaNV = @MaNV
        DELETE FROM Xuat WHERE MaNV = @MaNV
        DELETE FROM NhanVien WHERE MaNV = @MaNV
        PRINT 'Đã xóa nhân viên thành công'
    END
END

--3h--
CREATE PROCEDURE SP_Xoa_SanPham
    @MaSP nvarchar(10)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        PRINT 'Mã sản phẩm không tồn tại'
    END
    ELSE
    BEGIN
        DELETE FROM Nhap WHERE MaSP = @MaSP
        DELETE FROM Xuat WHERE MaSP = @MaSP
        DELETE FROM SanPham WHERE MaSP = @MaSP
        PRINT 'Đã xóa sản phẩm thành công'
    END
END

--4a--
CREATE TRIGGER TR_Nhap_Insert
ON Nhap
AFTER INSERT
AS
BEGIN
    DECLARE @MaSP nvarchar(10)
    DECLARE @SoLuongN int
    DECLARE @DonGiaN decimal(18,2)

    SELECT @MaSP = i.MaSP, @SoLuongN = i.SoLuongN, @DonGiaN = i.DonGiaN
    FROM inserted i

    IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        RAISERROR ('Mã sản phẩm không tồn tại', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    IF (@SoLuongN <= 0 OR @DonGiaN <= 0)
    BEGIN
        RAISERROR ('Số lượng và đơn giá phải lớn hơn 0', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    UPDATE SanPham
    SET SoLuongTon = SoLuongTon + @SoLuongN
    WHERE MaSP = @MaSP
END

--4b--
CREATE TRIGGER TR_Xuat_Insert
ON Xuat
AFTER INSERT
AS
BEGIN
    DECLARE @MaSP nvarchar(10)
    DECLARE @SoLuongX int

    SELECT @MaSP = i.MaSP, @SoLuongX = i.SoLuongX
    FROM inserted i

    IF NOT EXISTS (SELECT * FROM SanPham WHERE MaSP = @MaSP)
    BEGIN
        RAISERROR ('Mã sản phẩm không tồn tại', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    DECLARE @SoLuongTon int
    SELECT @SoLuongTon = SoLuongTon FROM SanPham WHERE MaSP = @MaSP

    IF (@SoLuongX <= 0 OR @SoLuongX > @SoLuongTon)
    BEGIN
        RAISERROR ('Số lượng xuất không hợp lệ', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    UPDATE SanPham
    SET SoLuongTon = @SoLuongTon - @SoLuongX
    WHERE MaSP = @MaSP
END

--4c--
CREATE TRIGGER TR_Xuat_Delete
ON Xuat
AFTER DELETE
AS
BEGIN
    DECLARE @MaSP nvarchar(10)
    DECLARE @SoLuongX int

    SELECT @MaSP = d.MaSP, @SoLuongX = d.SoLuongX
    FROM deleted d

    UPDATE SanPham
    SET SoLuongTon = SoLuongTon + @SoLuongX
    WHERE MaSP = @MaSP
END