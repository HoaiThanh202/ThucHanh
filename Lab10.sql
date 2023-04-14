--a.Thêm dữ liệu cho bảng Nhanvien:

INSERT INTO dbo.Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV05', N'Nguyen Van Thanh', N'Nam', N'Ha Noi', '0987654321', 'nva@example.com', N'Kế toán')


--Thực hiện full backup:

BACKUP DATABASE QLBanHang TO DISK = 'C:\bk\QLBH.bak' WITH INIT
 --b. Thêm dữ liệu cho bảng NhanVien:

INSERT INTO dbo.Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV06', N'Nguyen Van Tan', N'Nam', N'Ho Chi Minh', '0987654452', 'ndv@example.com', N'Thủ kho')

--Thực hiện different backup:

BACKUP DATABASE QLBanHang TO DISK = 'C:\bk\QLBH_Diff.bak' WITH DIFFERENTIAL
--c. Thêm dữ liệu cho bảng Nhanvien:

INSERT INTO dbo.Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV07', N'Nguyen Kieu Trinh', N'Nu', N'Lao Cai', '0987654007', 'KieuTrinh@example.com', N'Thủ kho')

--Thực hiện log backup lần 1:

BACKUP LOG QLBanHang TO DISK = 'C:\bk\QLBH.trn' WITH INIT
--d. Thêm dữ liệu cho bảng Nhanvien:

INSERT INTO dbo.Nhanvien (manv, tennv, gioitinh, diachi, sodt, email, phong)
VALUES ('NV08', N'Trinh Thanh Cong', N'Nam', N'Long An', '0987654213', 'kds@example.com', N'Kế Toán')

--Thực hiện log backup lần 2:

BACKUP LOG QLBanHang TO DISK = 'C:\bk\QLBH.trn' WITH INIT
--câu 2a--
DROP DATABASE QLBanHang

--Câu 2b--
RESTORE DATABASE QLBanHang FROM DISK = 'C:\bk\QLBanHang.bak' WITH STANDBY = 'C:\bk\QLBanhang_undo.bak'
