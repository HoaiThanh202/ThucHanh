--Tạo view lab 2_2
create view v_lab2_2 as 
SELECT masp, tensp, tenhang, soluong, mausac, giaban, donvitinh, mota
FROM Sanpham sp
inner join Hangsx hsx
on sp.mahangsx = hsx.mahangsx
--Tạo view lab 2_3
create view v_lab2_3 as 
SELECT sp.*, hsx.tenhang, hsx.sodt, hsx.email, hsx.diachi
FROM sanpham sp
inner join Hangsx hsx
on sp.mahangsx = hsx.mahangsx
WHERE hsx.tenhang = 'Samsung'
--Tạo view lab 2_4
create view v_lab2_4 as 
SELECT *
FROM nhanvien
WHERE gioitinh = 'Nữ' AND phong = 'Kế toán'
--Tạo view lab 2_5
create view v_lab2_5 as 
SELECT sohdn, nh.masp, tensp, tenhang, soluongN, dongiaN, tiennhap=soluongN*dongiaN, mausac, donvitinh, ngaynhap, tennv, phong
from Nhap nh
inner join Sanpham sp on nh.masp = sp.masp
inner join Hangsx hsx on sp.mahangsx = hsx.mahangsx
inner join Nhanvien nv on nh.manv = nv.manv

--Tạo view lab 2_6
create view v_lab2_6 as 
SELECT Xuat.sohdx, Sanpham.masp, Sanpham.tensp, Hangsx.tenhang, Xuat.soluongX, Sanpham.giaban, 
       Xuat.soluongX*Sanpham.giaban AS tienxuat, Sanpham.mausac, Sanpham.donvitinh, Xuat.ngayxuat, 
       Nhanvien.tennv, Nhanvien.phong
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhanvien ON Xuat.manv = Nhanvien.manv
WHERE MONTH(Xuat.ngayxuat) = 10 AND YEAR(Xuat.ngayxuat) = 2018
--Tạo view lab 2_7
create view v_lab2_7 as 
SELECT sohdn, Sanpham.masp, tensp, soluongN, dongiaN, ngaynhap, tennv, phong
FROM Nhap 
JOIN Sanpham ON Nhap.masp = Sanpham.masp 
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2017;
--Tạo view lab 2_8
create view v_lab2_8 as 
SELECT TOP 10 Xuat.sohdx, Sanpham.tensp, Xuat.soluongX
FROM Xuat 
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE YEAR(Xuat.ngayxuat) = '2023' 
--Tạo view lab 2_9
create view v_lab2_9 as 
SELECT TOP 10 tenSP, giaBan
FROM SanPham
--Tạo view lab 2_10
create view v_lab2_10 as 
SELECT Sanpham.*, Hangsx.sodt, Hangsx.tenhang, Hangsx.email, Hangsx.diachi
FROM Sanpham
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND Sanpham.giaban >= 100000 AND Sanpham.giaban <= 500000
--Tạo view lab 2_11
create view v_lab2_11 as 
SELECT SUM(soluongN * dongiaN) AS tongtien
FROM Nhap
JOIN Sanpham ON Nhap.masp = Sanpham.masp
JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
WHERE Hangsx.tenhang = 'Samsung' AND YEAR(ngaynhap) = 2018
--Tạo view lab 2_12
create view v_lab2_12 as 
SELECT SUM(Xuat.soluongX * Sanpham.giaban) AS Tongtien
FROM Xuat
INNER JOIN Sanpham ON Xuat.masp = Sanpham.masp
WHERE Xuat.ngayxuat = '2018-09-02'
--Tạo view lab 2_13
create view v_lab2_13 as 
SELECT TOP 1 sohdn, ngaynhap, dongiaN
FROM Nhap
--Tạo view lab 2_14
create view v_lab2_14 as 
SELECT TOP 10 Sanpham.tensp, SUM(Nhap.soluongN) AS TongSoLuongN 
FROM Sanpham 
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp 
WHERE YEAR(Nhap.ngaynhap) = 2019 
GROUP BY Sanpham.tensp 
ORDER BY TongSoLuongN DESC
--Tạo view lab 2_15
create view v_lab2_15 as 
SELECT Sanpham.masp, Sanpham.tensp
FROM Sanpham
INNER JOIN Hangsx ON Sanpham.mahangsx = Hangsx.mahangsx
INNER JOIN Nhap ON Sanpham.masp = Nhap.masp
INNER JOIN Nhanvien ON Nhap.manv = Nhanvien.manv
WHERE Hangsx.tenhang = 'Samsung' AND Nhanvien.manv = 'NV01';
--Tạo view lab 2_16
create view v_lab2_16 as 
SELECT sohdn, masp, soluongN, ngaynhap
FROM Nhap
WHERE masp = 'SP02' AND manv = 'NV02'
--Tạo view lab 2_17
create view v_lab2_17 as 
SELECT Nhanvien.manv, Nhanvien.tennv
FROM Nhanvien
JOIN Xuat ON Nhanvien.manv = Xuat.manv
WHERE Xuat.masp = 'SP02' AND Xuat.ngayxuat = '2020-03-02'