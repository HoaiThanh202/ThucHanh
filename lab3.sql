--câu 1
SELECT Hangsx.mahangsx, Hangsx.tenhang, COUNT(Sanpham.masp) AS SoLoaiSanPham
FROM Hangsx
LEFT JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
GROUP BY Hangsx.mahangsx, Hangsx.tenhang;
--Câu 2
SELECT Sanpham.masp, Sanpham.tensp, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Sanpham.masp, Sanpham.tensp;
--Câu 3
SELECT Sanpham.masp, Sanpham.tensp, SUM(Xuat.soluongX) AS TongSoLuongXuat
FROM Sanpham
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Xuat.ngayxuat) = 2018 AND Sanpham.mahangsx = 'SAMSUNG' 
GROUP BY Sanpham.masp, Sanpham.tensp
HAVING SUM(Xuat.soluongX) > 10000;
--Câu 4
SELECT Nhanvien.phong, COUNT(*) AS SoLuongNhanVienNam
FROM Nhanvien
WHERE Nhanvien.gioitinh = N'Nam'
GROUP BY Nhanvien.phong;
--Câu 5
SELECT Hangsx.tenhang, SUM(Nhap.soluongN) AS TongSoLuongNhap
FROM Hangsx
INNER JOIN Sanpham ON Hangsx.mahangsx = Sanpham.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
WHERE YEAR(Nhap.ngaynhap) = 2018
GROUP BY Hangsx.tenhang
--Câu 6
SELECT Nhanvien.tennv, SUM(Xuat.soluongX * Sanpham.giaban) AS TongTienXuat
FROM Nhanvien
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = 2018
GROUP BY Nhanvien.tennv
--Câu 7
SELECT Nhanvien.tennv, SUM(Nhap.soluongN * Nhap.dongiaN) AS TongTienNhap
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
WHERE YEAR(Nhap.ngaynhap) = 2018 AND MONTH(Nhap.ngaynhap) = 8
GROUP BY Nhanvien.tennv
HAVING SUM(Nhap.soluongN * Nhap.dongiaN) > 100000
--Câu 8
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
LEFT JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE Xuat.masp IS NULL
--Câu 9
SELECT Sanpham.masp, Sanpham.tensp, Sanpham.soluong, Sanpham.mausac, Sanpham.giaban, Sanpham.donvitinh, Sanpham.mota
FROM Sanpham
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Xuat ON Sanpham.masp = Xuat.masp
WHERE YEAR(Nhap.ngaynhap) = 2018 AND YEAR(Xuat.ngayxuat) = 2018

--Câu 10
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
INNER JOIN Nhap ON Nhanvien.manv = Nhap.manv
INNER JOIN Xuat ON Nhanvien.manv = Xuat.manv

--Câu 11
SELECT *
FROM Nhanvien
LEFT JOIN Nhap ON Nhanvien.manv = Nhap.manv
LEFT JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Nhap.manv IS NULL AND Xuat.manv IS NULL;