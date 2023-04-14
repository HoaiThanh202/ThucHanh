go
use QLBanHang
go

go
--cau1--
CREATE TRIGGER trg_Nhap_CheckConstraints
ON Nhap
AFTER INSERT
AS
BEGIN
    DECLARE @masp NVARCHAR(10)
    DECLARE @manv NVARCHAR(10)
    DECLARE @soluongN INT
    DECLARE @dongiaN FLOAT

    SELECT @masp = masp, @manv = manv, @soluongN = soluongN, @dongiaN = dongiaN
    FROM inserted
    
    -- Kiểm tra masp có trong bảng Sanpham chưa
    IF NOT EXISTS (SELECT * FROM Sanpham WHERE masp = @masp)
    BEGIN
        RAISERROR('Lỗi: masp không tồn tại trong bảng Sanpham', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Kiểm tra manv có trong bảng Nhanvien chưa
    IF NOT EXISTS (SELECT * FROM Nhanvien WHERE manv = @manv)
    BEGIN
        RAISERROR('Lỗi: manv không tồn tại trong bảng Nhanvien', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Kiểm tra ràng buộc dữ liệu
    IF @soluongN <= 0 OR @dongiaN <= 0
    BEGIN
        RAISERROR('Lỗi: soluongN và dongiaN phải lớn hơn 0', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Cập nhật số lượng sản phẩm trong bảng Sanpham
    UPDATE Sanpham
    SET soluong = soluong + @soluongN
    WHERE masp = @masp
END

go

go
--cau 2--
CREATE TRIGGER checkXuat
ON Xuat
AFTER INSERT
AS
BEGIN
    -- Kiểm tra ràng buộc toàn vẹn
    IF NOT EXISTS (SELECT masp FROM Sanpham WHERE masp = (SELECT masp FROM inserted))
    BEGIN
        RAISERROR('Mã sản phẩm không tồn tại trong bảng Sanpham', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    IF NOT EXISTS (SELECT manv FROM Nhanvien WHERE manv = (SELECT manv FROM inserted))
    BEGIN
        RAISERROR('Mã nhân viên không tồn tại trong bảng Nhanvien', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Kiểm tra ràng buộc dữ liệu
    DECLARE @soluongX INT
    SELECT @soluongX = soluongX FROM inserted
    
    DECLARE @soluong INT
    SELECT @soluong = soluong FROM Sanpham WHERE masp = (SELECT masp FROM inserted)
    
    IF (@soluongX > @soluong)
    BEGIN
        RAISERROR('Số lượng xuất vượt quá số lượng trong kho', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END
    
    -- Cập nhật số lượng trong bảng Sanpham
    UPDATE Sanpham
    SET soluong = soluong - @soluongX
    WHERE masp = (SELECT masp FROM inserted)
END
go

go
--cau 3--
CREATE TRIGGER updateSoluongXoaPhieuXuat
ON Xuat
AFTER DELETE
AS
BEGIN
    -- Cập nhật số lượng hàng trong bảng Sanpham tương ứng với sản phẩm đã xuất
    UPDATE Sanpham
    SET Soluong = Sanpham.Soluong + deleted.soluongX
    FROM Sanpham
    JOIN deleted ON Sanpham.Masp = deleted.Masp
END
go

go
--cau 4--
CREATE TRIGGER update_xuat_soluong_trigger
ON xuat
AFTER UPDATE
AS
BEGIN
    -- Kiểm tra xem có ít nhất 2 bản ghi bị update hay không
    IF (SELECT COUNT(*) FROM inserted) < 2
    BEGIN
DECLARE @old_soluong INT, @new_soluong INT, @masp NVARCHAR(10)

        SELECT @masp = i.masp, @old_soluong = d.soluongX, @new_soluong = i.soluongX
        FROM deleted d INNER JOIN inserted i ON d.sohdx = i.sohdx AND d.masp = i.masp

        -- Kiểm tra số lượng xuất mới có nhỏ hơn số lượng tồn kho hay không
        IF (@new_soluong <= (SELECT soluong FROM sanpham WHERE masp = @masp))
        BEGIN
            UPDATE xuat SET soluongX = @new_soluong WHERE sohdx IN (SELECT sohdx FROM inserted)
            UPDATE sanpham SET soluong = soluong + @old_soluong - @new_soluong WHERE masp = @masp
        END
    END
END

go

go
go
--cau 5--
CREATE TRIGGER tr_updateNhap
ON Nhap
AFTER UPDATE
AS
BEGIN
    -- Kiểm tra số bản ghi thay đổi
    IF (SELECT COUNT(*) FROM inserted) > 1
    BEGIN
        RAISERROR('Chỉ được phép cập nhật 1 bản ghi tại một thời điểm', 16, 1)
        ROLLBACK
    END
    
    -- Kiểm tra số lượng nhập
    DECLARE @masp INT
    DECLARE @soluongN INT
    DECLARE @soluong INT
    
    SELECT @masp = i.masp, @soluongN = i.soluongN, @soluong = s.soluong
    FROM inserted i
    INNER JOIN Sanpham s ON i.masp = s.masp
    
    IF (@soluongN > @soluong)
    BEGIN
        RAISERROR('Số lượng nhập không được vượt quá số lượng hiện có trong kho', 16, 1)
        ROLLBACK
    END
    
    -- Cập nhật số lượng trong bảng Sanpham
    UPDATE Sanpham
    SET soluong = soluong + (@soluongN - (SELECT soluongN FROM deleted WHERE masp = @masp))
    WHERE masp = @masp
END

go

go
--câu 6--
go
CREATE TRIGGER update_soluong_sp 
ON Nhap
AFTER DELETE
AS

BEGIN
    
    UPDATE Sanpham
    SET Soluong = Sanpham.Soluong - deleted.soluongN
    FROM Sanpham
    JOIN deleted ON Sanpham.Masp = deleted.Masp
END
go