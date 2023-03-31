go
use QLBanhang
go


--cau 1--
go
CREATE FUNCTION Lab5_1 (@masp VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @hangsx VARCHAR(50)
    SELECT @hangsx = h.tenhang
    FROM Sanpham s
    JOIN Hangsx h ON s.mahangsx = h.mahangsx
    WHERE s.masp = @masp

    RETURN @hangsx
END
go
go
SELECT dbo.Lab5_1('SP01')
go

--Cau 2--
go
CREATE FUNCTION Lab5_2(@x INT, @y INT)
RETURNS MONEY
AS
BEGIN
    DECLARE @TongGiaTriNhap MONEY
    SELECT @TongGiaTriNhap = SUM(dongiaN * soluongN)
    FROM Nhap
    WHERE YEAR(ngaynhap) BETWEEN @x AND @y
    RETURN @TongGiaTriNhap
END
go
go
SELECT dbo.Lab5_2(2016,2019)
go


--Cau 3--
go 
CREATE FUNCTION Lab5_3(@tenSanPham nvarchar(50), @nam int)
RETURNS int
AS
BEGIN
    DECLARE @soLuongNhap int, @soLuongXuat int, @soLuongThayDoi int;
    SELECT @soLuongNhap = SUM(soluongN) FROM Nhap n JOIN Sanpham sp ON n.masp = sp.masp WHERE sp.tensp = @tenSanPham AND YEAR(n.ngaynhap) = @nam;
    SELECT @soLuongXuat = SUM(soluongX) FROM Xuat x JOIN Sanpham sp ON x.masp = sp.masp WHERE sp.tensp = @tenSanPham AND YEAR(x.ngayxuat) = @nam;
    SET @soLuongThayDoi = @soLuongNhap - @soLuongXuat;
    RETURN @soLuongThayDoi;
END
go
go
SELECT dbo.Lab5_3('Galaxy Note 11',2020)
go

--Cau 4--
go
CREATE FUNCTION dbo.Lab5_4(
    @ngay_bat_dau DATE,
    @ngay_ket_thuc DATE
)
RETURNS MONEY
AS
BEGIN
    DECLARE @tong_gia_tri_nhap MONEY;
    SELECT @tong_gia_tri_nhap = SUM(nhap.soluongN * sanpham.giaban)
    FROM Nhap AS nhap
    INNER JOIN Sanpham AS sanpham ON nhap.masp = sanpham.masp
    WHERE nhap.ngaynhap >= @ngay_bat_dau AND nhap.ngaynhap <= @ngay_ket_thuc;
    RETURN @tong_gia_tri_nhap;
END;
go
go
SELECT dbo.Lab5_4('2018-01-01', '2020-12-31') AS TongGiaTriNhap;
go

--Cau 5--
go
CREATE FUNCTION Lab5_5(@tenHang NVARCHAR(20), @nam INT)
RETURNS MONEY
AS
BEGIN
  DECLARE @tongGiaTriXuat MONEY;
  SELECT @tongGiaTriXuat = SUM(S.giaban * X.soluongX)
  FROM Xuat X
  JOIN Sanpham S ON X.masp = S.masp
  JOIN Hangsx H ON S.mahangsx = H.mahangsx
  WHERE H.tenhang = @tenHang AND YEAR(X.ngayxuat) = @nam;
  RETURN @tongGiaTriXuat;
END;
go
go
SELECT dbo.Lab5_5(N'Samsung', 2020) AS 'TongGiaTriXuat';
go

--Cau 6--
go
CREATE FUNCTION Lab5_6 (@tenPhong NVARCHAR(30))
RETURNS TABLE
AS
RETURN
    SELECT phong, COUNT(manv) AS soLuongNhanVien
    FROM Nhanvien
    WHERE phong = @tenPhong
    GROUP BY phong;
go
go
SELECT * FROM Lab5_6(N'Vật tư')
go

--Cau 7--
go
CREATE FUNCTION Lab5_7(@ten_sp NVARCHAR(20), @ngay_xuat DATE)
RETURNS INT
AS
BEGIN
  DECLARE @so_luong_xuat INT
  SELECT @so_luong_xuat = SUM(soluongX)
  FROM Xuat x JOIN Sanpham sp ON x.masp = sp.masp
  WHERE sp.tensp = @ten_sp AND x.ngayxuat = @ngay_xuat
  RETURN @so_luong_xuat
END
go
go
SELECT dbo.Lab5_7('Samsung', '12-12-2020')
go

--cau 8--
go
CREATE FUNCTION Lab5_8 (@InvoiceNumber NCHAR(10))
RETURNS NVARCHAR(20)
AS
BEGIN
  DECLARE @EmployeePhone NVARCHAR(20)
  SELECT @EmployeePhone = Nhanvien.sodt
  FROM Nhanvien
  INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.sohdx = @InvoiceNumber
  RETURN @EmployeePhone
END
go
go
SELECT dbo.Lab5_8('X01')
go

--cau9--
go
CREATE FUNCTION Lab5_9(@tenSP NVARCHAR(20), @nam INT)
RETURNS INT
AS
BEGIN
  DECLARE @tongNhapXuat INT;
  SET @tongNhapXuat = (
  SELECT COALESCE(SUM(nhap.soluongN), 0) + COALESCE(SUM(xuat.soluongX), 0) AS tongSoLuong
    FROM Sanpham sp
    LEFT JOIN Nhap nhap ON sp.masp = nhap.masp
    LEFT JOIN Xuat xuat ON sp.masp = xuat.masp
    WHERE sp.tensp = @tenSP AND YEAR(nhap.ngaynhap) = @nam AND YEAR(xuat.ngayxuat) = @nam
  );
  RETURN @tongNhapXuat;
END;
go
go
SELECT dbo.Lab5_9('Galaxy V21', 2020) AS TongNhapXuat;
go

--cau10--
go
CREATE FUNCTION Lab5_10(@tenhang NVARCHAR(20))
RETURNS INT
AS
BEGIN
    DECLARE @soluong INT;

    SELECT @soluong = SUM(soluong)
    FROM Sanpham sp JOIN Hangsx hs ON sp.mahangsx = hs.mahangsx
    WHERE hs.tenhang = @tenhang;

    RETURN @soluong;
END;
go
go
SELECT dbo.Lab5_10('Samsung') AS 'Tổng số lượng sản phẩm của hãng'
go