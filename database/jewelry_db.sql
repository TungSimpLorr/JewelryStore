
use jewelry_db ;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";



-- bang loai san pham 
create table `loai_san_pham` (
  `id_loai_san_pham` int(11) not null auto_increment,
  `ten_loai` varchar(100) not null,
  primary key (`id_loai_san_pham`)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;




-- bang thuong hieu 
create table `thuong_hieu` (
  `id_thuong_hieu` int(11) not null auto_increment,
  `ten_thuong_hieu` varchar(255) not null,
  primary key (`id_thuong_hieu`)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;


-- bang san pham
create table  `san_pham` (
  `id_san_pham` int(11) not null auto_increment,
  `ma_san_pham` varchar(100) not null unique,
  `ten_san_pham` varchar(255) not null,
  `gia_san_pham` decimal(15,2) not null,
  `mo_ta` text default null,
  `id_thuong_hieu` int(11) default null,
  `id_loai_san_pham` int(11) default null,
  `khoi_luong` decimal(10,2) default null,
  `kich_thuoc` decimal(10,2) default null,
  `chat_lieu` varchar(25) not null , 
  `trang_thai_chung` tinyint(1) default 1,
  `url_anh_dai_dien` varchar(255) default null,
  `ngay_tao` timestamp not null default current_timestamp(),
  `ngay_cap_nhat` timestamp not null default current_timestamp() on update current_timestamp(),
  primary key (`id_san_pham`),
  foreign key (`id_thuong_hieu`) references `thuong_hieu`(`id_thuong_hieu`) on delete set null on update cascade,
  foreign key (`id_loai_san_pham`) references `loai_san_pham`(`id_loai_san_pham`) on delete set null on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang nguoi dung
create table `nguoi_dung` (
  `id_nguoi_dung` int(11) not null auto_increment,
  `ten_dang_nhap` varchar(50) not null unique,
  `mat_khau` varchar(255) not null,
  `email` varchar(255) not null unique,
  `ho_ten` varchar(255),
  `dia_chi` varchar(255),
  `so_dien_thoai` varchar(20),
  `ngay_tao` timestamp default current_timestamp(),
  primary key (`id_nguoi_dung`)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang admin
create table `quan_tri_vien` (
  `id_quan_tri` int(11) not null auto_increment,
  `ten_dang_nhap` varchar(50) not null unique,
  `mat_khau` varchar(255) not null,
  `email` varchar(255) not null unique,
  `ho_ten` varchar(255),
  `quyen_han` varchar(50) default 'admin',
  primary key (`id_quan_tri`)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang gio hang 
create table  `gio_hang` (
  `id_gio_hang` int(11) not null auto_increment,
  `id_nguoi_dung` int(11) not null unique,
  `ngay_tao` timestamp default current_timestamp(),
  `ngay_cap_nhat` timestamp default current_timestamp() on update current_timestamp(),
  primary key (`id_gio_hang`),
  foreign key (`id_nguoi_dung`) references `nguoi_dung`(`id_nguoi_dung`) on delete cascade on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- chi tiet gio hang 
create table  `chi_tiet_gio_hang` (
  `id_chi_tiet_gio_hang` int(11) not null auto_increment,
  `id_gio_hang` int(11) not null,
  `id_san_pham` int(11) not null,
  `so_luong` int(11) not null default 1,
  `gia_tai_thoi_diem` decimal(15,2) not null,
  primary key (`id_chi_tiet_gio_hang`),
  unique key `unique_gio_hang_sp` (`id_gio_hang`, `id_san_pham`),
  foreign key (`id_gio_hang`) references `gio_hang`(`id_gio_hang`) on delete cascade on update cascade,
  foreign key (`id_san_pham`) references `san_pham`(`id_san_pham`) on delete cascade on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang don hang 
create table `don_hang` (
  `id_don_hang` int(11) not null auto_increment,
  `id_nguoi_dung` int(11) not null,
  `ngay_dat_hang` timestamp default current_timestamp(),
  `tong_tien` decimal(15,2) not null,
  `trang_thai_don_hang` varchar(50) default 'Pending',
  `dia_chi_giao_hang` varchar(255),
  `phuong_thuc_thanh_toan` varchar(50),
  `ngay_cap_nhat` timestamp default current_timestamp() on update current_timestamp(),
  primary key (`id_don_hang`),
  foreign key (`id_nguoi_dung`) references `nguoi_dung`(`id_nguoi_dung`) on delete restrict on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- chi tiet don hang
create table  `chi_tiet_don_hang` (
  `id_chi_tiet_don_hang` int(11) not null auto_increment,
  `id_don_hang` int(11) not null,
  `id_san_pham` int(11) not null,
  `so_luong` int(11) not null,
  `gia_tai_thoi_diem` decimal(15,2) not null,
  primary key (`id_chi_tiet_don_hang`),
  unique key `unique_don_hang_sp` (`id_don_hang`, `id_san_pham`),
  foreign key (`id_don_hang`) references `don_hang`(`id_don_hang`) on delete cascade on update cascade,
  foreign key (`id_san_pham`) references `san_pham`(`id_san_pham`) on delete restrict on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang anh san pham
create table `anh_san_pham` (
  `id_anh` int(11) not null auto_increment,
  `id_san_pham` int(11) not null,
  `url_anh` varchar(1000) not null,
  primary key (`id_anh`),
  foreign key (`id_san_pham`) references `san_pham`(`id_san_pham`) on delete cascade on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang danh muc blogs
create table  `danh_muc_bai_viet` (
  `id_danh_muc` int(11) not null auto_increment,
  `ten_danh_muc` varchar(100) not null,
  `mo_ta` text,
  primary key (`id_danh_muc`)
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang blogs 
create table `bai_viet` (
  `id_bai_viet` int(11) not null auto_increment,
  `tieu_de` varchar(255) not null,
  `noi_dung` text not null,
  `ngay_dang` timestamp default current_timestamp(),
  `ngay_cap_nhat` timestamp default current_timestamp() on update current_timestamp(),
  `id_danh_muc` int(11) not null,
  `id_nguoi_tao` int(11) not null,
  `trang_thai` enum('draft', 'published', 'archived') default 'draft',
  primary key (`id_bai_viet`),
  foreign key (`id_danh_muc`) references `danh_muc_bai_viet`(`id_danh_muc`) on delete restrict on update cascade,
  foreign key (`id_nguoi_tao`) references `quan_tri_vien`(`id_quan_tri`) on delete restrict on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

--bang chi tiet bai viet
create table `chi_tiet_bai_viet` (
  `id_chi_tiet_bai_viet` int(11) not null auto_increment,
  `id_bai_viet` int(11) not null,
  `noi_dung` text not null,
  `hinh_anh` varchar(1000) default null,
  `created_at` timestamp default current_timestamp(),
  primary key (`id_chi_tiet_bai_viet`),
  foreign key (`id_bai_viet`) references `bai_viet`(`id_bai_viet`) on delete cascade on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- chen vao bang loai san pham
insert into `loai_san_pham` (`id_loai_san_pham`, `ten_loai`) values
(1, 'Vòng cổ'),
(2, 'Nhẫn'),
(3, 'Vòng tay'),
(4, 'Đồng hồ'),
(5, 'Khuyên tai');

-- chen vao bang thuong hieu
insert into `thuong_hieu` (`id_thuong_hieu`, `ten_thuong_hieu`) values
(1, 'Aura Gems'), 
(2, 'Lily'), 
(3, 'Caraluna'), 
(4, 'PNJ'), 
(5, 'Glamira'), 
(6, 'The Princess'), 
(7, 'Rubble'), 
(8, 'ESTELLE'), 
(9, 'Piaget'), 
(10, 'Tiffany & Co'), 
(11, 'Jemmia'), 
(12, 'Pandora'), 
(13, 'Viễn Chí Bảo'),
(14, 'Tierra'), 
(15, 'Doji'),
(16, 'Huy Thanh JewelryStore'),
(17, 'Swarovski'),
(18, 'Curnon'),
(19, 'Kat Swarovski');

-- chen vao bang san pham 
INSERT INTO `san_pham` (`id_san_pham`, `ma_san_pham`, `ten_san_pham`, `gia_san_pham`, `mo_ta`, `id_thuong_hieu`, `id_loai_san_pham`, `khoi_luong`, `kich_thuoc`, `chat_lieu`, `trang_thai_chung`, `url_anh_dai_dien`, `ngay_tao`, `ngay_cap_nhat`) VALUES
(1, 'KTJS001', 'HOA TAI VÀNG NỮ', 10000000.00, 'Hoàn thiện vẻ ngoài của bạn với đôi khuyên tai vòng đầy cá tính này. Thiết kế độc đáo với các chi tiết hình nón được sắp xếp tinh xảo, tạo nên vẻ đẹp vừa mạnh mẽ vừa thanh lịch. Chế tác từ chất liệu cao cấp với bề mặt sáng bóng, đôi khuyên tai này sẽ là điểm nhấn ấn tượng, thể hiện phong cách độc đáo và đẳng cấp của bạn trong mọi sự kiện.', 3, 5, 25.00, 25.00, 'bac', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwe49cdfc3/images/large/ae97fbd4ed3a5a9ca24af70605fdee3c.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(2, 'KTJS002', 'HOA TAI PANTHÈRE DE CARTIER, KIM CƯƠNG', 11500000.00, 'Con báo, loài động vật biểu tượng của Cartier, xuất hiện lần đầu tiên trong các bộ sưu tập của Maison vào năm 1914. Louis Cartier là người đầu tiên thuần hóa loài động vật huyền thoại này, và đồng nghiệp của ông là Jeanne Toussaint đã biến nó thành một huyền thoại. Con báo có thể hung dữ, vui tươi hoặc đáng yêu, thể hiện tất cả các khía cạnh của tính cách phóng khoáng của nó từ bộ sưu tập này sang bộ sưu tập khác.', 3, 5, 25.00, 25.00, 'vang', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw3ce1a991/images/large/9899a6a249d35be8aa05e7398ae73ff2.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(3, 'KTJS003', 'HOA TAI CLASSIC DIAMOND STUD', 90000000.00, 'Đôi bông tai này được thiết kế theo hình nơ, đính đầy kim cương. Mỗi chiếc nơ có vẻ ngoài bồng bềnh với các dải ruy băng vắt chéo nhau, được nạm kim cương tròn và kim cương baguette, tạo nên sự lấp lánh và sang trọng. Chúng có màu bạc hoặc trắng.', 10, 5, 25.00, 25.00, 'kim cuong', 1, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7c57b587/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGE1149_RGE1149_GE27379_Hero_1.jpg?sw=2000&sh=2000', '2025-06-18', '2025-06-18'),
(4, 'KTJS004', 'HOA TAI GRAIN DE CAFÉ', 110000000.00, 'Nguồn cảm hứng thực sự, hình dạng đầy đặn và tròn trịa của nó truyền cảm hứng cho Cartier tạo ra một bộ sưu tập độc đáo, giống như tầm nhìn của hãng về thiên nhiên: nổi loạn, tự do và tinh tế. Hoa tai Grain de Café, vàng vàng 18K (750/1000), vàng trắng 18K (750/1000), đính 70 viên kim cương cắt kiểu brilliant, tổng cộng 1,67 carat.', 3, 5, 25.00, 25.00, 'vang', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw160afab8/images/large/9f1c1ade45c75530883841698eff905b.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(5, 'KTJS005', 'HOA TAI THẢ VÀNG K10 ĐÍNH ĐÁ CZ', 2500000.00, 'Mang vẻ đẹp thuần khiết và lấp lánh, đôi khuyên tai này là điểm nhấn hoàn hảo cho mọi phong cách. Với thiết kế hai viên đá tròn được sắp xếp tinh xảo, một viên lớn hơn phía trên và một viên nhỏ hơn lấp lánh phía dưới, chúng tạo nên sự chuyển động nhẹ nhàng và quyến rũ. Ánh kim loại ấm áp kết hợp cùng vẻ đẹp rạng ngời của đá, tạo nên một món trang sức vừa cổ điển vừa hiện đại, lý tưởng cho cả những buổi tiệc sang trọng hay nét thanh lịch thường ngày.', 8, 5, 25.00, 25.00, 'kim cuong', 1, 'https://estelle.vn/wp-content/uploads/2025/04/trim_fce_item631fc6156ca52.jpg', '2025-06-18', '2025-06-18'),
(6, 'KTJS006', 'HOA TAI TIFFANY SOLITAIRE DIAMOND STUD', 37651705.00, 'Nâng tầm phong cách của bạn với đôi hoa tai kim cương Tiffany & Co. Solitaire tuyệt đẹp. Mỗi viên kim cương tròn sáng bóng được lựa chọn và kết hợp tỉ mỉ về kích thước, màu sắc, độ trong và sự hiện diện, đảm bảo một vẻ đẹp hài hòa và lấp lánh hoàn hảo. Được chế tác từ bạch kim cao cấp, đôi hoa tai này mang đến sự sang trọng vượt thời gian và độ bền bỉ đáng kinh ngạc. Với tổng trọng lượng carat 0.22, chúng là điểm nhấn tinh tế nhưng vẫn đủ nổi bật, tôn lên vẻ đẹp thanh lịch và rạng ngời của bạn. Thiết kế dành riêng cho tai xỏ khuyên, chúng là món trang sức hoàn hảo để bạn tỏa sáng trong mọi khoảnh khắc.', 2, 5, 25.00, 25.00, 'bac', 1, 'https://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-solitaire-diamond-stud-earrings-14041419_921472_ED_M.jpg?&op_usm=2.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal', '2025-06-18', '2025-06-18'),
(7, 'KTJS007', 'HOA TAI ĐINH TÁN CARTIER D''AMOUR, 2 VIÊN ĐÁ SAPPHIRE HỒNG', 50000000.00, 'Nâng tầm phong cách của bạn với đôi hoa tai kim cương Tiffany & Co. Solitaire tuyệt đẹp. Mỗi viên kim cương tròn sáng bóng được lựa chọn và kết hợp tỉ mỉ về kích thước, màu sắc, độ trong và sự hiện diện, đảm bảo một vẻ đẹp hài hòa và lấp lánh hoàn hảo. Được chế tác từ bạch kim cao cấp, đôi hoa tai này mang đến sự sang trọng vượt thời gian và độ bền bỉ đáng kinh ngạc. Với tổng trọng lượng carat 0.22, chúng là điểm nhấn tinh tế nhưng vẫn đủ nổi bật, tôn lên vẻ đẹp thanh lịch và rạng ngời của bạn. Thiết kế dành riêng cho tai xỏ khuyên, chúng là món trang sức hoàn hảo để bạn tỏa sáng trong mọi khoảnh khắc.', 3, 5, 25.00, 25.00, 'kim cuong', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw54988b05/images/large/9ede5fdaa4ed5828b2add5fb6c28e333.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(8, 'KTJS008', 'HOA TAI ĐINH TÁN CARTIER D''AMOUR, 2 VIÊN KIM CƯƠNG, MẪU TRUNG BÌNH', 78651000.00, 'Mang vẻ đẹp rạng ngời và thuần khiết, đôi khuyên tai nụ đính đá này là lựa chọn hoàn hảo cho những ai yêu thích sự thanh lịch và tinh tế. Viên đá trung tâm được cắt gọt tỉ mỉ, phản chiếu ánh sáng lấp lánh đầy mê hoặc, trong khi thiết kế viền bao quanh (bezel) mang lại vẻ ngoài chắc chắn và cảm giác đeo thoải mái. Đây là món trang sức cơ bản nhưng không kém phần nổi bật, làm quà tặng lý tưởng hoặc bổ sung hoàn hảo cho bộ sưu tập của bạn.', 3, 5, 25.00, 25.00, 'kim cuong', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw440d3181/images/large/983b93c35a2c55c7a75c1db5acbd1363.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(9, 'KTJS009', 'HOA TAI VÒNG ETINCELLE DE CARTIER, MẪU NHỎ, LÁT ĐÁ', 100792250.00, 'Bộ sưu tập tinh tế này toát lên vẻ thanh lịch và sự giản dị tinh tế. Những đường nét tinh tế của kim cương lát tạo nên vẻ rạng rỡ vượt thời gian - một phong cách tinh khiết, nữ tính.', 3, 5, 25.00, 25.00, 'kim cuong', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwa7f605b9/images/large/0027d0e4f9b45938b578e767e9d0d67e.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(10, 'KTJS010', 'HOA TAI VÒNG TRÒN ĐƠN LOVE, LÁT ĐÁ', 14789350.00, 'Là đứa con của New York những năm 1970, bộ sưu tập LOVE ngày nay vẫn là biểu tượng mang tính biểu tượng của tình yêu vượt qua mọi quy ước. Các họa tiết ốc vít, hình bầu dục lý tưởng và sự thanh lịch không thể phủ nhận đã tạo nên tác phẩm như một sự tôn vinh vượt thời gian cho tình yêu nồng cháy. Đính kim cương, vàng vàng hoặc vàng hồng: bạn sẽ đi xa đến đâu vì tình yêu?', 3, 5, 4.00, 25.00, 'bac', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwda382758/images/large/86d0e3f4eb0c57eda0c9ff83c9c71e61.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(11, 'DHJS001', 'ĐÒNG HỒ TANK MUSR DE CARTIER', 85870850.00, 'Louis Cartier đã tạo ra chiếc đồng hồ Tank vào năm 1917. Một huyền thoại đã ra đời. Nguyên mẫu đầu tiên được tặng cho Tướng Pershing vài năm trước khi chiếc đồng hồ được đưa ra thị trường vào năm 1919. Các vấu hòa quyện liền mạch vào các cạnh trần của brancard phẳng thẳng đứng, mang lại cho chiếc đồng hồ tính thẩm mỹ độc đáo. Những đường nét sạch sẽ, sắc nét đã chứng tỏ được sự ưa chuộng lớn với những khách hàng thanh lịch, phóng khoáng. Chiếc đồng hồ Tank hiện đã trở thành biểu tượng đã truyền cảm hứng cho vô số biến thể, nhưng vẫn giữ được bản sắc riêng biệt của nó.', 3, 4, 4.00, 25.00, 'bac', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw8da2181a/images/large/401b3628e15a551bbd56c247eb73da86.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(12, 'DHJS002', 'ĐỒNG HỒ SANTOS DE CARTIER', 195160050.00, 'Năm 1904, Louis Cartier đã đáp ứng mong muốn của phi công nổi tiếng người Brazil Alberto Santos Dumont: có thể xem giờ trong khi bay. Sự ra đời của một trong những chiếc đồng hồ đeo tay đầu tiên đã gắn kết tình bạn giữa hai người tiên phong này. Các góc bo tròn của mặt đồng hồ, đường cong liền mạch của sừng và các ốc vít lộ ra tạo nên một chiếc đồng hồ mang tính biểu tượng sẽ truyền cảm hứng cho vô số cách diễn giải lại.', 3, 4, 25.00, 25.00, 'bac', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw0da74ff1/images/large/a3b2fdde384359bfb31cd128f3a440d9.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(13, 'DHJS003', 'ĐỒNG HỒ BALLON BLEU DE CARTIER', 182150800.00, 'Nổi như một quả bóng bay và xanh như viên cabochon được đặt an toàn bên cạnh, chiếc đồng hồ Ballon Bleu của Cartier mang đến nét thanh lịch cho cả cổ tay nam và nữ. Các chữ số La Mã được dẫn đường trên đường đi của chúng bằng một cơ chế lên dây màu xanh lam đậm. Với các đường cong lồi của vỏ, mặt số guilloché, kim hình thanh kiếm và các mắt xích được đánh bóng hoặc hoàn thiện bằng satin của dây đeo... chiếc đồng hồ Ballon Bleu của Cartier lướt qua thế giới chế tác đồng hồ của Cartier.', 3, 4, 25.00, 25.00, 'bac', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw484ced06/images/large/32b4de94767a5960852bb6d28f170daa.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(14, 'DHJS004', 'ĐỒNG HỒ BAIGNOIRE', 212875225.00, 'Thiết kế năm 1912 của chiếc đồng hồ sau này được đặt tên là “Baignoire” đã chứng minh được tài năng của Cartier trong việc chế tác các hình dạng đồng hồ. Một hình elip thanh lịch được rèn độc đáo theo một đường thẳng, chiếc đồng hồ “Baignoire” chính là tinh hoa của phong cách Cartier: sự kết hợp vô song giữa sự tinh khiết và sự sang trọng vượt thời gian.', 3, 4, 25.00, 25.00, 'bac', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb44a27f9/images/large/7e1214e6b3025d3dacafd0d8cafcf4c4.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(15, 'DHJS005', 'ĐỒNG HỒ PANTHÈRE DE CARTIER', 120999975.00, 'Một chiếc đồng hồ cũng là một món đồ trang sức đẹp, Panthère de Cartier là một trong những thiết kế đặc biệt nhất của Cartier. Được tạo ra vào những năm 80 và hiện đại hơn bao giờ hết, đây là biểu tượng phong cách thực sự cho những người phụ nữ không bao giờ bị bỏ qua.', 3, 4, 25.00, 25.00, 'bac', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw4f917d96/images/large/81c2b64b82b251c791e413a1955b7a28.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(16, 'DHJS006', 'ĐỒNG HỒ ALTIPLANO ORIGIN', 55000000.00, 'Đồng hồ Altiplano Origin, 40 mm. Vỏ bằng vàng trắng 18K. Mặt số có vạch chỉ giờ bằng vàng rhodied. Mặt sau bằng tinh thể sapphire. Dây đeo có thể thay đổi. Manufacture 1205P1, bộ máy cơ tự lên dây siêu mỏng (dày 3 mm), có giây nhỏ và ngày.', 1, 4, 25.00, 25.00, 'bac', 1, 'https://img.piaget.com/new-product-banner-normal-2/520c35fb8e2cf8123aaddd05b548ab7041e9ee6f.jpg', '2025-06-18', '2025-06-18'),
(17, 'DHJS007', 'ĐỒNG HỒ LIMELIGHT GALA', 260000000.00, 'Đồng hồ Limelight Gala, 32 mm. Vỏ bằng vàng hồng 18K đính 63 viên kim cương cắt sáng (khoảng 1,66 carat). Mặt số bằng đá malachite tự nhiên. Vòng đeo tay lưới Milanese bằng vàng hồng 18K. Bộ máy cơ tự động 501P1 Manufacture.', 1, 4, 25.00, 25.00, 'bac', 1, 'https://img.piaget.com/new-product-banner-normal-2/77bb928e0d180c3bdf0c3155f1c499f0bd6f42bf.jpg', '2025-06-18', '2025-06-18'),
(18, 'DHJS008', 'ĐỒNG HỒ PIAGET POLO SKELETON', 360000000.00, 'Đồng hồ Piaget Polo skeleton, 42 mm. Vỏ thép. Đồng hồ được giao kèm dây đeo thứ hai. Mặt sau bằng pha lê sapphire. Bộ máy tự động 1200S1 màu xanh lam của nhà sản xuất.', 1, 4, 25.00, 25.00, 'bac', 1, 'https://img.piaget.com/new-product-banner-normal-2/9aaa97d8b318b022916b5363aad02e3f132d3454.jpg', '2025-06-18', '2025-06-18'),
(19, 'DHJS009', 'ĐỒNG HỒ PIAGET POLO FLYING TOURBILLON MOONPHASE', 100000000.00, 'Đồng hồ Piaget Polo Flying Tourbillon Moonphase, 44 mm. Vỏ bằng titan. Mặt đồng hồ hở màu xanh. Dây đeo cao su có thể thay thế. Đồng hồ được giao kèm dây đeo cá sấu màu xanh bổ sung. Khóa gập. Mặt sau bằng tinh thể sapphire nhỏ. Bộ máy cơ học lên dây cót bằng tay siêu mỏng tourbillon 642P của nhà sản xuất với chỉ báo pha mặt trăng, có chỉ báo mặt trăng thiên văn ở vị trí 6 giờ.', 1, 4, 25.00, 25.00, 'bac', 1, 'https://img.piaget.com/new-product-banner-normal-2/bec64579c51b8eaa904ae51ab91891fb606e6b3e.jpg', '2025-06-18', '2025-06-18'),
(20, 'DHJS010', 'ĐỒNG HỒ PIAGET POLO DATE', 420000000.00, 'Đồng hồ Piaget Polo Date, 36 mm. Vỏ thép. Mặt đồng hồ có 36 viên kim cương cắt sáng (khoảng 0,07 ct). Mặt sau bằng pha lê sapphire. Dây đeo có thể thay đổi. Bộ máy cơ tự động 500P1 của nhà sản xuất.', 1, 4, 25.00, 25.00, 'bac', 1, 'https://img.piaget.com/new-product-banner-normal-2/2c0519cbadfb6041136446c4ca61537a3058fa88.jpg', '2025-06-18', '2025-06-18'),
(21, 'VCJS001', 'VÒNG CỔ ALEXANDRA DIAMOND', 2000000.00, 'Với viên kim cương lấp lánh được cắt gọt tinh xảo, chiếc vòng cổ này là biểu tượng của vẻ đẹp cổ điển và sự sang trọng tuyệt đối. Alexandra Diamond không chỉ là một món trang sức, mà còn là tuyên ngôn về phong cách tinh tế, hoàn hảo cho những quý cô yêu thích sự lộng lẫy và đẳng cấp.', 4, 1, 25.00, 25.00, 'kim cuong', 1, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300', '2025-06-18', '2025-06-18'),
(22, 'VCJS002', 'VÒNG CỔ DARKQUEEN DIAMOND', 5000000.00, 'Khám phá sức mạnh của bóng tối và sự quyến rũ bất tận với DarkQueen Diamond. Viên kim cương huyền bí, ánh lên vẻ đẹp sâu thẳm đầy mê hoặc, tạo nên một tuyên ngôn thời trang táo bạo và độc đáo. Chiếc vòng cổ này dành cho những ai dám thể hiện cá tính mạnh mẽ, biến mỗi khoảnh khắc thành sàn diễn của riêng mình. DarkQueen Diamond – nơi vẻ đẹp quyền lực được thăng hoa.', 4, 1, 25.00, 25.00, 'kim cuong', 1, 'https://cdn.pnj.io/images/detailed/246/sp-gcddddw000898-day-co-kim-cuong-vang-trang-14k-pnj-1.png', '2025-06-18', '2025-06-18'),
(23, 'VCJS003', 'VÒNG CỔ LONELY ROCKSTAR', 1000000.00, 'Lonely Rockstar không chỉ là một chiếc vòng cổ, mà là bản tình ca của sự tự do và cá tính nổi loạn. Với thiết kế độc đáo, góc cạnh và đầy phóng khoáng, chiếc vòng cổ này là biểu tượng cho tinh thần không ngừng khám phá, vượt qua mọi giới hạn. Dù bạn là người tiên phong hay một tâm hồn nghệ sĩ, Lonely Rockstar sẽ là điểm nhấn hoàn hảo, khẳng định phong cách khác biệt và không thể trộn lẫn của bạn.', 4, 1, 25.00, 25.00, 'kim cuong', 1, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300', '2025-06-18', '2025-06-18'),
(24, 'VCJS004', 'VÒNG CỔ GOLD LADY', 2500000.00, 'Gold Lady là sự kết hợp hoàn hảo giữa vẻ đẹp cổ điển và nét hiện đại quyến rũ. Được chế tác tinh xảo từ vàng nguyên chất, chiếc vòng cổ này mang đến sự ấm áp, rạng rỡ và sang trọng vượt thời gian. Gold Lady không chỉ tôn lên vẻ đẹp tự nhiên của bạn mà còn là biểu tượng của sự thịnh vượng và may mắn, lý tưởng cho những quý cô yêu thích sự tinh tế và đẳng cấp.', 4, 1, 25.00, 25.00, 'kim cuong', 1, 'https://i.pinimg.com/736x/15/a0/0f/15a00f23ca4d6370ec29afa2b5e30e85.jpg', '2025-06-18', '2025-06-18'),
(25, 'VCJS005', 'VÒNG CỔ SWAROVSKI', 1000000.00, 'Dây chuyền mặt pha lê Swarovski trái tim đại dương là một thiết kế vô cùng sang trọng và hấp dẫn đến từ trang sức LiLi. Hãy tưởng tượng viên pha lê đính trên dây chuyền bạc này sáng lấp lánh trên khuôn cổ của bạn, sẽ thật tuyệt vời đúng không nào.', 5, 1, 25.00, 25.00, 'kim cuong', 1, 'https://lili.vn/wp-content/uploads/2020/12/day-chuyen-bac-mat-pha-le-swaroski-trai-tim-dai-duong-LILI_295787-1-1.jpg', '2025-06-18', '2025-06-18'),
(26, 'VCJS006', 'VÒNG CỔ DATE NIGHT', 1500000.00, 'Tựa như vì sao sáng nhất trên bầu trời đêm, vòng cổ "Date Night" mang đến vẻ đẹp lấp lánh đầy cuốn hút, khiến bạn tỏa sáng trong những khoảnh khắc đáng nhớ. Mặt dây chuyền được thiết kế hình ngôi sao tỏa sáng rực rỡ, đính hàng loạt viên đá nhỏ li ti tạo hiệu ứng bắt sáng tuyệt vời, như ánh nhìn đầu tiên trong một buổi hẹn hò mộng mơ.', 6, 1, 25.00, 25.00, 'kim cuong', 1, 'https://bizweb.dktcdn.net/100/461/213/products/vyn51-thumb-compressed.jpg?v=1687701501847', '2025-06-18', '2025-06-18'),
(27, 'VCJS007', 'VÒNG CỔ CZ CÁ TIÊN', 5200100.00, 'Chiếc vòng cổ "Cá Tiên" lấy cảm hứng từ nàng tiên cá huyền thoại, mang thiết kế mềm mại và bay bổng. Mặt dây hình tròn cách điệu như một khung cảnh dưới đáy đại dương, nổi bật với phần đuôi cá tiên ánh tím lấp lánh – biểu tượng của sự tự do và vẻ đẹp kỳ ảo. Tâm điểm là viên đá CZ mô phỏng ngọc trai ánh trăng, được bao bọc bởi những chi tiết đính đá CZ nhỏ lấp lánh, gợi cảm giác như những giọt nước biển tinh khiết. Đuôi cá được phủ men ánh tím nổi bật, tạo chiều sâu và sự độc đáo cho thiết kế.', 5, 1, 25.00, 25.00, 'kim cuong', 1, 'https://lili.vn/wp-content/uploads/2021/12/Day-chuyen-bac-nu-phong-cach-co-trang-CZ-LILI_831944_3.jpg', '2025-06-18', '2025-06-18'),
(28, 'VCJS008', 'VÒNG CỔ "BÁU VẬT ĐẠI DƯƠNG"', 29000000.00, 'chiếc vòng cổ ngọc trai được đeo trên cổ của một người phụ nữ. Chiếc vòng cổ có những viên ngọc trai nhỏ, tròn, màu trắng ngà, được xâu chuỗi đều đặn. Điểm nhấn của chiếc vòng cổ là một viên ngọc trai lớn hơn một chút ở trung tâm, được bao quanh bởi một thiết kế hình mặt trời bằng kim loại màu vàng, tạo nên sự nổi bật và tinh tế.', 7, 1, 25.00, 25.00, 'ngoc trai', 1, 'https://product.hstatic.net/200000351153/product/n9203_model_c73e0b95e554445ebf4153f4a0018987_c7a87db49771436db694edde9e6324bf_large.jpg', '2025-06-18', '2025-06-18'),
(29, 'VCJS009', 'VÒNG CỔ ES', 5000000.00, 'Đây là một chiếc vòng cổ/dây chuyền bạc tinh xảo và duyên dáng, nổi bật với mặt dây chuyền hình chùm sao lấp lánh.Mặt dây chuyền gồm ba ngôi sao, trong đó có hai ngôi sao trơn và một ngôi sao được gắn hai viên đá CZ (Cubic Zirconia) nhỏ, tạo điểm nhấn lấp lánh như những vì tinh tú. Chiếc vòng được làm từ bạc trắng, mang lại vẻ đẹp thanh lịch và hiện đại.Dây chuyền có độ dài vừa phải, phù hợp để đeo hàng ngày hoặc kết hợp với các trang phục khác nhau.', 8, 1, 25.00, 25.00, 'bac', 1, 'https://estelle.vn/wp-content/uploads/2023/12/5ca8fa2487be97cee631e7a5d2a008be.jpg', '2025-06-18', '2025-06-18'),
(30, 'VCJS010', 'VÒNG CỔ HOA HỒNG', 234000000.00, 'Chiếc vòng cổ sang trọng mềm mại này dành cho phụ nữ được tạo thành từ những nụ hoa và hoa hồng nở dọc theo một sợi dây chuyền vàng trắng, mỗi nụ hoa nhẹ nhàng đung đưa trên đó, tạo nên chuyển động liên tục. Những họa tiết này được tô điểm bằng những viên kim cương nhỏ, tỏa sáng như những giọt sương buổi sớm.', 1, 1, 25.00, 25.00, 'bac', 1, 'https://estelle.vn/wp-content/uploads/2023/12/5ca8fa2487be97cee631e7a5d2a008be.jpg', '2025-06-18', '2025-06-18'),
(31, 'RRJS001', 'NHẪN STARLIGHT', 200.00, 'Đây là một chiếc nhẫn bạc thanh mảnh với thiết kế tinh tế, nổi bật bởi cụm hoa đính đá trắng lấp lánh ở mặt nhẫn. Chi tiết điểm nhấn là một bông hoa nhỏ đính đá được treo lơ lửng, tạo cảm giác chuyển động nhẹ nhàng và nữ tính. Thiết kế phù hợp với phong cách nhẹ nhàng, thanh lịch, thích hợp để đeo hằng ngày hoặc làm quà tặng ý nghĩa.', 16, 2, 25.00, 25.00, 'bac', 1, 'https://cloud.huythanhjewelry.vn/storage/photos/shares/01upload/1750065578947/nlf439bac9251_1750068451.jpg', '2025-06-18', '2025-06-18'),
(32, 'RRJS002', 'NHẪN DISNEY', 100000000.00, 'Với kiểu dáng thời thượng cùng những viên đá đính xung quanh bề mặt chiếc nhẫn trên chất liệu bạc 925, Disney kết hợp với PNJ mang đến chiếc nhẫn trong BST Inside Out 2 với vẻ đẹp trẻ trung nhưng không kém phần phá cách, giúp các cô gái trông thật nổi bật', 4, 2, 25.00, 25.00, 'bac', 1, 'https://cdn.pnj.io/images/detailed/213/sp-snztxmw060011-nhan-bac-dinh-da-disney-pnj-inside-out-2-01.png', '2025-06-18', '2025-06-18'),
(33, 'RRJS003', 'NHẪN POSSESSION', 71000000.00, 'Đây là một chiếc nhẫn kim loại cao cấp, thiết kế tối giản và hiện đại. Bề mặt nhẫn được khắc vân sọc dọc tinh tế, tạo hiệu ứng ánh sáng độc đáo khi nghiêng dưới ánh sáng. Phía trong nhẫn có khắc tên thương hiệu PIAGET, cho thấy đây là sản phẩm thuộc dòng trang sức xa xỉ, phù hợp với cả nam và nữ yêu thích phong cách sang trọng nhưng không cầu kỳ', 9, 2, 25.00, 25.00, 'bac', 1, 'https://img.piaget.com/product-light-box-1/ebb2b2112fbca36d589eab9448d0badc4f20e8e4.jpg', '2025-06-18', '2025-06-18'),
(34, 'RRJS004', 'NHẪN PANDORA MOMENTS BẠC SAO BĂNG TINH XẢO', 2390000.00, 'Sản phẩm bắt mắt này có hai khối zirconia trong suốt được cắt hình ngôi sao, mỗi khối được đặt ở hai đầu của một dải mở được trang trí bằng họa tiết ngôi sao băng tinh tế. Lấy cảm hứng từ ý tưởng rằng thế giới sẽ tỏa sáng hơn khi chúng ta ở bên những người thân yêu, chiếc nhẫn này thật hoàn hảo để kết hợp với những chiếc nhẫn khác hoặc đeo một mình để thể hiện một lời tuyên bố thiêng liêng.', 12, 2, 25.00, 25.00, 'bac', 1, 'https://product.hstatic.net/200000103143/product/pngtrpnt_193582c01_rgb_26da96f6a16042dd8517b9726bdb6769_master.png', '2025-06-18', '2025-06-18'),
(35, 'RRJS005', 'NHẪN THỜI TRANG VÀNG 14K ĐÁ CZ', 3300000.00, 'Chiếc nhẫn làm bằng vàng 14K đính đá CZ tượng trưng cho sự lấp lánh, rạng rỡ và vẻ đẹp tinh khiết như ánh sao. Vàng 14K đảm bảo độ bền và tính thẩm mỹ cao, trong khi đá CZ mang đến sự lấp lánh tương tự kim cương, thể hiện ước mơ và hy vọng.', 16, 2, 25.00, 25.00, 'vang', 1, 'https://cdn.huythanhjewelry.vn/storage/photos/shares/01upload/1713754308/nlf4906-3_1715852218.png', '2025-06-18', '2025-06-18'),
(36, 'RRJS006', 'NHẪN HYPERBOLA', 70200000.00, 'Chiếc nhẫn Hyperbola xoắn này tích hợp nhiều kiểu dáng trong một thiết kế nhỏ gọn tuyệt đẹp. Hai dải mạ rhodium chồng lên nhau được trang trí bằng Swarovski Zirconia trong suốt ở các thiết lập rãnh và chấu. Một viên pha lê cắt hình bầu dục bổ sung được đặt ở giữa để tăng thêm tác động. Kết hợp với một chiếc vòng tay phù hợp để có vẻ ngoài thực sự nổi bật', 17, 2, 25.00, 25.00, 'bac', 1, 'https://asset.swarovski.com/images/$size_1450/t_swa103/b_rgb:ffffff,c_scale,dpr_2.0,f_auto,w_675/5691228_png/hyperbola-ring--mixed-cuts--white--rhodium-plated-swarovski-5691228.png', '2025-06-18', '2025-06-18'),
(37, 'RRJS007', 'NHẪN GLAMIRA ALHERTINE', 15000000.00, 'Chiếc nhẫn hở với hai viên đá tượng trưng cho sự kết nối và cân bằng. Hai viên đá có thể đại diện cho hai tâm hồn đồng điệu, tình yêu hoặc tình bạn gắn bó. Thiết kế mở cũng gợi ý sự cởi mở, đón nhận những điều mới mẻ. Đây là biểu tượng của sự hài hòa và những mối quan hệ ý nghĩa', 5, 2, 25.00, 25.00, 'bac', 1, 'https://cdn-media.glamira.com/media/product/newgeneration/view/2/sku/Alhertine/diamond/diamond-Brillant_AAA/alloycolour/white.jpg', '2025-06-18', '2025-06-18'),
(38, 'RRJS008', 'NHẪN BẠC 925 ĐÍNH ĐÁ CHỦ OVAL GẮN ĐÁ VIỀN LẤP LÁNH', 10000000.00, 'Nhẫn Bạc 925 Đính Đá Chủ Oval Gắn Đá Viền Lấp Lánh phù hợp cho nàng đeo hàng ngày bởi tính ứng dụng cao. Thiết kế cổ điển nhưng không kém phần hiện đại, chiếc nhẫn này sẽ là điểm nhấn hoàn hảo cho mọi phong cách', 3, 2, 25.00, 25.00, 'bac', 1, 'https://bizweb.dktcdn.net/100/461/213/products/vcr510-1735791883504.jpg?v=1735791899930', '2025-06-18', '2025-06-18'),
(39, 'RRJS009', 'NHẪN CẦU HÔN LOVING', 9440000.00, 'Nếu bạn đang tìm kiếm một mẫu nhẫn cầu hôn có vẻ đẹp cổ điển ngọt ngào, thì nhẫn đính hôn kim cương Cathedral đai trơn 6 chấu basic NCH1503 là lựa chọn hoàn hảo nhất. Mẫu nhẫn cầu hôn này có thiết kế đặc trưng của kiểu nhẫn Cathedral với một viên kim cương chủ được nâng đỡ bởi 6 chấu nhô lên từ đai nhẫn, thiết kế này giúp nhẫn dễ dàng bắt ánh sáng và thêm phần rực rỡ. Trao nàng chiếc nhẫn này là cách chàng trai bày tỏ mong ước được cùng người thương tay trong tay bước vào thánh đường của tình yêu', 14, 2, 25.00, 25.00, 'bac', 1, 'https://www.tierra.vn/wp-content/uploads/2024/07/NCH1503-R_04.webp', '2025-06-18', '2025-06-18'),
(40, 'RRJS010', 'NHẪN VÀNG TRẮNG 14K GẮN KIM CƯƠNG DOJI', 8870000.00, 'Chiếc nhẫn này là một ổ nhẫn chưa gắn đá, được làm từ vàng trắng 18K. Phần đai nhẫn được chạm khắc tinh xảo với họa tiết lá hoặc dây leo, tạo vẻ cổ điển và mềm mại. Chấu nhẫn được thiết kế hình cánh hoa hoặc giọt nước, sẵn sàng nâng niu viên đá chủ, thể hiện sự tinh xảo và đẳng cấp', 15, 2, 25.00, 25.00, 'vang', 1, 'https://product.hstatic.net/200000567741/product/afra000446d2kk1_1_d0aa14fff7d44111b5061eaa83ab97cd_1024x1024.jpg', '2025-06-18', '2025-06-18'),
(41, 'VTJS001', 'VÒNG TAY DÂY', 115000000.00, 'Tiffany Knot là biểu tượng của những mối quan hệ bền chặt của tình yêu. Lấy cảm hứng từ chiếc nơ lưu trữ được chế tác vào năm 1889, Knot là biểu tượng của những mối quan hệ bền chặt nhất và những kết nối có ý nghĩa trong cuộc sống. Chiếc vòng tay bằng dây này được chế tác từ vàng vàng 18k và được đánh bóng thủ công để có độ sáng bóng cao. Mỗi viên kim cương tròn sáng bóng—được lựa chọn đặc biệt để đáp ứng các tiêu chuẩn cao của Tiffany—được đính thủ công ở các góc chính xác để tối đa hóa độ sáng bóng. Đeo chiếc vòng tay bằng dây này một mình hoặc kết hợp với những kiểu dáng cổ điển để tạo nên sự kết hợp bất ngờ.', 2, 3, 25.00, 25.00, 'vang', 1, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-knotwire-bangle-69526020_1080400_ED_M.jpg?&op_usm=2.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal', '2025-06-18', '2025-06-18'),
(42, 'VTJS002', 'VÒNG TAY MICRO LINK', 97000000.00, 'Tiffany HardWear là biểu hiện của sức mạnh biến đổi của tình yêu. Lấy cảm hứng từ chiếc vòng tay tinh túy từ năm 1962 được tìm thấy trong kho lưu trữ của Nhà, HardWear thể hiện sự bền bỉ và tinh thần phóng khoáng. Các mắt xích đo lường mang tính biểu tượng của bộ sưu tập tạo nên chiếc vòng tay bóng bẩy này.', 2, 3, 25.00, 25.00, 'vang', 1, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-hardwearmicro-link-bracelet-60416931_993613_ED_M.jpg?&op_usm=1.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal', '2025-06-18', '2025-06-18'),
(43, 'VTJS003', 'VÒNG TAY TRÁI TIM HỞ', 15000000.00, 'Hình dạng đơn giản, gợi cảm của thiết kế Elsa Peretti Open Heart tôn vinh tinh thần tình yêu. Vượt thời gian và thanh lịch, chiếc vòng tay này tạo nên một tuyên bố nổi bật.', 2, 3, 25.00, 25.00, 'bac', 1, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/elsa-perettiopen-heart-bangle-23511304_1028022_ED.jpg?&op_usm=2.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal', '2025-06-18', '2025-06-18'),
(44, 'VTJS004', 'VÒNG TAY PANTHÈRE DE CARTIER', 61000000.00, 'Con báo, loài động vật biểu tượng của Cartier, xuất hiện lần đầu tiên trong các bộ sưu tập của Maison vào năm 1914. Louis Cartier là người đầu tiên thuần hóa loài động vật huyền thoại này, và đồng nghiệp của ông là Jeanne Toussaint đã biến nó thành một huyền thoại. Con báo có thể hung dữ, vui tươi hoặc đáng yêu, thể hiện tất cả các khía cạnh của tính cách phóng khoáng của nó từ bộ sưu tập này sang bộ sưu tập khác.', 3, 3, 25.00, 25.00, 'vang', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw0076f10a/images/large/53be636f03fb53469140fc02d3255c87.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(45, 'VTJS005', 'VÒNG TAY CLASH DE CARTIER', 57000000.00, 'Sự tương phản hai mặt. Trang sức vừa tôn vinh vừa chống lại các hình thức cổ điển, cân bằng giữa tinh thần nghiêm túc với nét quyến rũ nguyên bản.', 3, 3, 25.00, 25.00, 'vang', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwe9e73e3b/images/large/7ee7bc5e3f0453a9bd142b0b2770d204.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(46, 'VTJS006', 'VÒNG TAY TRINITY', 110000000.00, 'Được thiết kế bởi Louis Cartier vào năm 1924, chiếc nhẫn Trinity là thiết kế đặc trưng của Cartier Maison. Ba dải vàng hồng, vàng vàng và trắng đan xen tượng trưng cho tình yêu, lòng chung thủy và tình bạn. Chiếc nhẫn đã truyền cảm hứng cho toàn bộ bộ sưu tập Trinity, một minh chứng vượt thời gian cho những tình yêu đáng nhớ nhất trong cuộc sống.', 3, 3, 25.00, 25.00, 'vang', 1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw129e9662/images/large/b306cb3932c450349ee98e0e3bb7c02b.png?sw=750&sh=750&sm=fit&sfrm=png', '2025-06-18', '2025-06-18'),
(47, 'VTJS007', 'VÒNG TAY ALHAMBRA CỔ ĐIỂN, 5 HỌA TIẾT', 245000000.00, 'Vòng tay Alhambra cổ điển, 5 họa tiết, vàng vàng 18K chạm khắc guilloché, kim cương tròn; chất lượng kim cương từ DEF, IF đến VVS.', 11, 3, 25.00, 25.00, 'vang', 1, 'https://www.vancleefarpels.com/content/dam/rcq/vca/19/40/21/7/1940217.png', '2025-06-18', '2025-06-18'),
(48, 'VTJS008', 'VÒNG TAY BẮC TRUNG PERLÉE', 147000000.00, 'Vòng tay Perlée Signature, vàng 18K, mẫu trung bình', 11, 3, 25.00, 25.00, 'vang', 1, 'https://www.vancleefarpels.com/content/dam/rcq/vca/Tl/Hq/DE/21/Tc/m9/sy/EU/EJ/5H/aA/TlHqDE21Tcm9syEUEJ5HaA.png', '2025-06-18', '2025-06-18'),
(49, 'VTJS009', 'VÒNG TAY FRIVOLE, 7 BÔNG HOA', 150000000.00, 'Vòng tay Frivole, 7 bông hoa, vàng vàng 18K, kim cương tròn, mẫu trung bình; chất lượng kim cương từ DEF, IF đến VVS.', 11, 3, 25.00, 25.00, 'vang', 1, 'https://www.vancleefarpels.com/content/dam/rcq/vca/20/29/29/2/2029292.png', '2025-06-18', '2025-06-18'),
(50, 'VTJS010', 'VÒNG TAY ALHAMBRA CỔ ĐIỂN, 5 HỌA TIẾT', 261000000.00, 'Vòng tay Alhambra cổ điển, 5 họa tiết, vàng hồng 18K, xà cừ xám, kim cương tròn; chất lượng kim cương từ DEF, IF đến VVS.', 11, 3, 25.00, 25.00, 'vang', 1, 'https://www.vancleefarpels.com/content/dam/rcq/vca/17/08/14/6/1708146.png', '2025-06-18', '2025-06-18');

-- chen vao bang anh san pham

insert into anh_san_pham (id_san_pham, url_anh) values
(1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwe49cdfc3/images/large/ae97fbd4ed3a5a9ca24af70605fdee3c.png?sw=750&sh=750&sm=fit&sfrm=png'),
(1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw0d750727/images/large/fc3b1369e0bb5e3b95fa05a9a1bc59b6.png?sw=750&sh=750&sm=fit&sfrm=png'),
(1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwcbda0e4d/images/large/74a8b3099617508c86f93744232284c2.png?sw=750&sh=750&sm=fit&sfrm=png'),
(1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw545e67d0/images/large/cb66b06501485d7cb06fbcbd2e555715.png?sw=750&sh=750&sm=fit&sfrm=png'),
(1, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw047ebc0c/images/large/aaff03500b8f5453b62863632417d1b5.png?sw=750&sh=750&sm=fit&sfrm=png'),
(2, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw3ce1a991/images/large/9899a6a249d35be8aa05e7398ae73ff2.png?sw=750&sh=750&sm=fit&sfrm=png'),
(2, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb975fac8/images/large/8f695ff7dd805c2e87233ca951209644.png?sw=750&sh=750&sm=fit&sfrm=png'),
(2, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwa467f47f/images/large/81a2866210ef545ab44ef09ab0fff389.png?sw=750&sh=750&sm=fit&sfrm=png'),
(2, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw396aa7ee/images/large/bfcd74e8c7f0554794be89e181803e22.png?sw=750&sh=750&sm=fit&sfrm=png'),
(2, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwbdb5d37f/images/large/fd90c1e22ae251cdb0d699f80b8bffc5.png?sw=750&sh=750&sm=fit&sfrm=png'),
(3, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7c57b587/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGE1149_RGE1149_GE27379_Hero_1.jpg?sw=800&sh=800'),
(3, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw3fb9d30e/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGE1149_RGE1149_Model_2.jpg?sw=800&sh=800'),
(3, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw0c7ede26/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGE1149_RGE1149_GE27379_Side_5.jpg?sw=800&sh=800'),
(3, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dwf009e946/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGE1646_RGE1646_GE37671_Hero_1.jpg?sw=3000&sh=3000'),
(3, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dwaacafb1d/sfcc-graff-staging/R/G/E/1/6/RGE1646_RGE1646_GE37671_model_4.jpg?sw=800&sh=800'),
(4, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw160afab8/images/large/9f1c1ade45c75530883841698eff905b.png?sw=750&sh=750&sm=fit&sfrm=png'),
(4, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw0ef6097e/images/large/20968a0cf6e65c24836fa72266de487f.png?sw=750&sh=750&sm=fit&sfrm=png'),
(4, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwee1e8c98/images/large/3788e962af9f529ebbd1c2f0faa7581d.png?sw=750&sh=750&sm=fit&sfrm=png'),
(4, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw8449c83d/images/large/259a880fd91a5f8cb5f6d74317831746.png?sw=750&sh=750&sm=fit&sfrm=png'),
(4, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw1dd4d747/images/large/0a0f987a790e5374ab94ff9ab1313ad2.png?sw=750&sh=750&sm=fit&sfrm=png'),
(5, 'https://estelle.vn/wp-content/uploads/2025/04/trim_fce_item631fc6156ca52.jpg'),
(5, 'https://estelle.vn/wp-content/uploads/2025/04/0231-0239-0029_00_500x.webp'),
(5, 'https://estelle.vn/wp-content/uploads/2025/04/0231-0239-0029_00_3_720x-1.webp'),
(5, 'https://estelle.vn/wp-content/uploads/2025/04/0231-0239-0029_00_2_720x-1.webp'),
(5, 'https://estelle.vn/wp-content/uploads/2025/04/0231-0239-0029_00_1_720x-1.webp'),
(6, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-solitaire-diamond-stud-earrings-14041419_921472_ED_M.jpg?&op_usm=2.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(6, 'https://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-solitaire-diamond-stud-earrings-12888333_1029745_SV_1_M.jpg?&op_usm=2.0'),
(6, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-solitaire-diamond-stud-earrings-12888333_1031000_AV_1_M.jpg?&op_usm=2.0'),
(6, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-solitaire-diamond-stud-earrings-12888333_1031001_AV_2_M.jpg?&op_usm=2.0'),
(6, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-solitaire-diamond-stud-earrings-12888333_1062442_AV_3_M.jpg?&op_usm=2.0'),
(7, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw54988b05/images/large/9ede5fdaa4ed5828b2add5fb6c28e333.png?sw=750&sh=750&sm=fit&sfrm=png'),
(7, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwccc8b02e/images/large/ca5a01f9fff350eeb8aa3335179e8184.png?sw=750&sh=750&sm=fit&sfrm=png'),
(7, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwd34fc4a9/images/large/b2ec9ba62b9e5fb291a8c2d426adfcdc.png?sw=750&sh=750&sm=fit&sfrm=png'),
(7, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwea2ac1c5/images/large/b4fc56fd21a75aee99934ea5c7e12222.png?sw=750&sh=750&sm=fit&sfrm=png'),
(7, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwa2f95aae/images/large/07166ef6489e5eaa8252378d1db3b88c.png?sw=750&sh=750&sm=fit&sfrm=png'),
(8, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw440d3181/images/large/983b93c35a2c55c7a75c1db5acbd1363.png?sw=750&sh=750&sm=fit&sfrm=png'),
(8, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb3998418/images/large/a182e30f81395eb385c166fd78d89beb.png?sw=750&sh=750&sm=fit&sfrm=png'),
(8, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw691c6d20/images/large/180e2581cb2b513791ce47cc488dbf5a.png?sw=750&sh=750&sm=fit&sfrm=png'),
(8, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw54876564/images/large/d1d2ae2b98865a54bbd02ed3b32ffe1d.png?sw=750&sh=750&sm=fit&sfrm=png'),
(8, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb49ebfd5/images/large/1d1e91eb1a5c5d35aba3a37720c68d3e.png?sw=750&sh=750&sm=fit&sfrm=png'),
(9, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwa7f605b9/images/large/0027d0e4f9b45938b578e767e9d0d67e.png?sw=750&sh=750&sm=fit&sfrm=png'),
(9, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw1e3780bf/images/large/d46821b4bd1b50e78aa00d5f92848cf7.png?sw=750&sh=750&sm=fit&sfrm=png'),
(9, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw75c4725f/images/large/f8270e03b6d25341b97205c4f90ec85c.png?sw=750&sh=750&sm=fit&sfrm=png'),
(9, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwaccd8de4/images/large/d83990d4a4d1590db88b6725cca62b8e.png?sw=750&sh=750&sm=fit&sfrm=png'),
(9, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw560525a0/images/large/f2abba9574b35a6694fa5a8027aac721.png?sw=750&sh=750&sm=fit&sfrm=png'),
(10, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwda382758/images/large/86d0e3f4eb0c57eda0c9ff83c9c71e61.png?sw=750&sh=750&sm=fit&sfrm=png'),
(10, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw0973bfe2/images/large/8809a9eb2f1f5fac85f727936fa8ec32.png?sw=750&sh=750&sm=fit&sfrm=png'),
(10, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw8255dbd3/images/large/998d7e7868ee597da9b13f7ac74bc36f.png?sw=750&sh=750&sm=fit&sfrm=png'),
(10, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw8255dbd3/images/large/998d7e7868ee597da9b13f7ac74bc36f.png?sw=750&sh=750&sm=fit&sfrm=png'),
(10, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw20b577ab/images/large/08df4b77358752228c1e270600709dae.png?sw=750&sh=750&sm=fit&sfrm=png'),
(11, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw1f6b2894/images/large/54402c5a408b55a18a1ee4939266b244.png?sw=750&sh=750&sm=fit&sfrm=png'),
(11, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw991a9c07/images/large/e9e96081c3125bdfb6c67c08898dd880.png?sw=750&sh=750&sm=fit&sfrm=png'),
(11, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwadd72bd6/images/large/95fa73c1624b5a61b633e85462f54dd4.png?sw=750&sh=750&sm=fit&sfrm=png'),
(11, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb5f4cfef/images/large/80ad6cb8aab15aaba0f1a84dea0e12e2.png?sw=750&sh=750&sm=fit&sfrm=png'),
(11, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwd4d8e99b/images/large/8446782c81b65682921c2282c3398deb.png?sw=750&sh=750&sm=fit&sfrm=png'),
(12, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwe20e1a8b/images/large/0df5608d248d5d3a84c0dcf47fa1a53f.png?sw=750&sh=750&sm=fit&sfrm=png'),
(12, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwef783bba/images/large/fe4fe23b518f5710bff1b2d22bf77fd6.png?sw=750&sh=750&sm=fit&sfrm=png'),
(12, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwda1441af/images/large/8418e6fff94a53a0a9983015587ac201.png?sw=750&sh=750&sm=fit&sfrm=png'),
(12, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwaeeddfb5/images/large/31185f4ed22754e2abad8368bb847f89.png?sw=750&sh=750&sm=fit&sfrm=png'),
(12, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw92cf8113/images/large/a2ef0ec061ab5cf59a3646b02af6e5ab.png?sw=750&sh=750&sm=fit&sfrm=png'),
(13, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwabcc1b7b/images/large/32b4de94767a5960852bb6d28f170daa.png?sw=750&sh=750&sm=fit&sfrm=png'),
(13, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw0baae5db/images/large/e7c07d61af1156259e904d2ab1073439.png?sw=750&sh=750&sm=fit&sfrm=png'),
(13, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw3acd3f1e/images/large/ab5d870a2f0a57e8a86a63ea6492ca78.png?sw=750&sh=750&sm=fit&sfrm=png'),
(13, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw4b62cd0e/images/large/a77da9475cc359d096504d3c99199a51.png?sw=750&sh=750&sm=fit&sfrm=png'),
(13, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw8da758d2/images/large/20e3d6531f525d65a7bcb9939ed02c79.png?sw=750&sh=750&sm=fit&sfrm=png'),
(14, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw10d08ab0/images/large/7e1214e6b3025d3dacafd0d8cafcf4c4.png?sw=750&sh=750&sm=fit&sfrm=png'),
(14, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwbd77132d/images/large/24169868f854521684108e35e74a2a80.png?sw=750&sh=750&sm=fit&sfrm=png'),
(14, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwfec76a18/images/large/1ae74e6bbd165dcb81a244c8c4437f49.png?sw=750&sh=750&sm=fit&sfrm=png'),
(14, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwce40182e/images/large/6b372b3ae1585b39bdd7d2b30121dfa6.png?sw=750&sh=750&sm=fit&sfrm=png'),
(14, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw964ec653/images/large/2723257be30450feae6bcefab6832786.png?sw=750&sh=750&sm=fit&sfrm=png'),
(15, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw032a5929/images/large/6b31cc78e69254c89469bd4149d7133b.png?sw=750&sh=750&sm=fit&sfrm=png'),
(15, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwe5b2b786/images/large/079a4adf0a0b56b1a0e5b2b96a614efb.png?sw=750&sh=750&sm=fit&sfrm=png'),
(15, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb6ed8e35/images/large/fb2056aacad5531c92d748dd6083dd67.png?sw=750&sh=750&sm=fit&sfrm=png'),
(15, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb6ed8e35/images/large/fb2056aacad5531c92d748dd6083dd67.png?sw=750&sh=750&sm=fit&sfrm=png'),
(15, 'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwb4f95c3f/images/large/292972a9e55e5c6da26d0c8130bfa39f.png?sw=750&sh=750&sm=fit&sfrm=png'),
(16, 'https://img.piaget.com/new-product-banner-normal-2/520c35fb8e2cf8123aaddd05b548ab7041e9ee6f.jpg'),
(16, 'https://img.piaget.com/product-slideshow-4/1ebed23a459a69f9ac82a6b84a8300a3ac6594c5.jpg'),
(16, 'https://img.piaget.com/product-slideshow-4/0738909e8c1abc3ec5981351d06c956add19b083.jpg'),
(16, 'https://img.piaget.com/product-slideshow-4/6e4abdfce35b79873dcd3bd06dd11899a695d595.jpg'),
(16, 'https://img.piaget.com/product-characteristics-3/2d83216f73a17b9e2517c8b6f5b97b9873d1b9bd.jpg'),
(17, 'https://img.piaget.com/new-product-banner-normal-2/77bb928e0d180c3bdf0c3155f1c499f0bd6f42bf.jpg'),
(17, 'https://img.piaget.com/product-slideshow-4/e7a407372261258060eabe8f7825c3e8c4ab795b.jpg'),
(17, 'https://img.piaget.com/product-slideshow-4/b7964b6be25b104a1d835c676704f8a8398e3801.jpg'),
(17, 'https://img.piaget.com/product-slideshow-4/d033078207af34c4476b49bf6cac1f9c06c3a3d2.jpg'),
(17, 'https://img.piaget.com/product-characteristics-3/3b14ee604d1bde0b15fbdb359ff575d10cd734e4.jpg'),
(18, 'https://img.piaget.com/new-product-banner-normal-2/9aaa97d8b318b022916b5363aad02e3f132d3454.jpg'),
(18, 'https://img.piaget.com/product-slideshow-4/402e0d8a8576e9880cc3647861b0a8cab47330c7.jpg'),
(18, 'https://img.piaget.com/product-slideshow-4/b4f1289cc5adee2a67a0c5f51fc0dbd51ba57dbb.jpg'),
(18, 'https://img.piaget.com/product-slideshow-4/4553a26778eae409484a5f2a9ad99965bbc620b9.jpg'),
(18, 'https://img.piaget.com/product-slideshow-4/5619085b53939afe60b3bf8db533d29f378aaabe.jpg'),
(19, 'https://img.piaget.com/new-product-banner-normal-2/bec64579c51b8eaa904ae51ab91891fb606e6b3e.jpg'),
(19, 'https://img.piaget.com/product-slideshow-padding-2/86059a91f708897c66965293222c40b9b41bfdf9.jpg'),
(19, 'https://img.piaget.com/product-slideshow-padding-2/bea037c236846eb702e99d8743217a18c8f942c0.jpg'),
(19, 'https://img.piaget.com/product-slideshow-padding-2/c66a0de8b17b462c9099cba7477bfe61b7ce89eb.jpg'),
(19, 'https://img.piaget.com/product-slideshow-4/a48848141d614af9fb9453085528012e0d7f5989.jpg'),
(20, 'https://img.piaget.com/new-product-banner-normal-2/2c0519cbadfb6041136446c4ca61537a3058fa88.jpg'),
(20, 'https://img.piaget.com/product-slideshow-padding-2/1141ae6307719ec647dd4d08c80498c13f440ae9.jpg'),
(20, 'https://img.piaget.com/product-slideshow-padding-2/3f8d9d060c7627feeba21055ffb6ebb8415d808e.jpg'),
(20, 'https://img.piaget.com/product-slideshow-padding-2/81a97502cf8401fde36448223f33c58c1457f523.jpg'),
(20, 'https://img.piaget.com/product-slideshow-4/000571fdbd71f03c9b196e7c150e796ad8e37f9f.jpg'),
(21, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300'),
(21, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7f8dfdac/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGN677_RGN677_Hero_1.jpg?sw=800&sh=800'),
(21, 'https://i.pinimg.com/736x/5f/aa/88/5faa882886d6a17f3e90b372b973a774.jpg'),
(21, 'https://i.pinimg.com/736x/86/12/d7/8612d79d4d15e81d2459e1af3998f077.jpg'),
(21, 'https://www.christies.com/img/LotImages/2023/HGK/2023_HGK_22175_1921_000(diamond_necklace055032).jpg?maxwidth=1390&maxheight=1300'),
(22, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300'),
(22, 'https://cdn.pnj.io/images/detailed/246/sp-gcddddw000898-day-co-kim-cuong-vang-trang-14k-pnj-2.png'),
(22, 'https://cdn.pnj.io/images/detailed/246/sp-gcddddw000898-day-co-kim-cuong-vang-trang-14k-pnj-3.png'),
(22, 'https://cdn.pnj.io/images/detailed/246/on-gcddddw000898-day-co-kim-cuong-vang-trang-14k-pnj-3.jpg'),
(22, 'https://cdn.pnj.io/images/detailed/246/sp-gcddddw000898-day-co-kim-cuong-vang-trang-14k-pnj-1.png'),
(23, 'https://i.pinimg.com/736x/15/a0/0f/15a00f23ca4d6370ec29afa2b5e30e85.jpg'),
(23, 'https://i.pinimg.com/736x/15/a0/0f/15a00f23ca4d6370ec29afa2b5e30e85.jpg'),
(23, 'https://i.pinimg.com/736x/5f/aa/88/5faa882886d6a17f3e90b372b973a774.jpg'),
(23, 'https://i.pinimg.com/736x/86/12/d7/8612d79d4d15e81d2459e1af3998f077.jpg'),
(23, 'https://www.christies.com/img/LotImages/2023/HGK/2023_HGK_22175_1921_000(diamond_necklace055032).jpg?maxwidth=1390&maxheight=1300'),
(24, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300'),
(24, 'https://www.christies.com/img/LotImages/2023/HGK/2023_HGK_22175_1921_000(diamond_necklace055032).jpg?maxwidth=1390&maxheight=1300'),
(24, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7f8dfdac/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGN677_RGN677_Hero_1.jpg?sw=800&sh=800'),
(24, 'https://i.pinimg.com/736x/5f/aa/88/5faa882886d6a17f3e90b372b973a774.jpg'),
(24, 'https://i.pinimg.com/736x/86/12/d7/8612d79d4d15e81d2459e1af3998f077.jpg'),
(25, 'https://lili.vn/wp-content/uploads/2020/12/day-chuyen-bac-mat-pha-le-swaroski-trai-tim-dai-duong-LILI_295787-1-1.jpg'),
(25, 'https://lili.vn/wp-content/uploads/2022/08/Mat-day-chuyen-bac-nu-dinh-da-CZ-trai-tim-Grainne-LILI_262454_1-768x768.jpg'),
(25, 'https://lili.vn/wp-content/uploads/2020/12/Day-chuyen-bac-nu-dinh-pha-le-Swarovski-trai-tim-dai-duong-LILI_295787_21.jpg'),
(25, 'https://lili.vn/wp-content/uploads/2020/12/day-chuyen-bac-mat-pha-le-swaroski-trai-tim-dai-duong-LILI_295787-6-400x400.jpg'),
(25, 'https://lili.vn/wp-content/uploads/2020/12/day-chuyen-bac-mat-pha-le-swaroski-trai-tim-dai-duong-LILI_295787-8.jpg'),
(26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/461/213/products/vyn51-vye38-vyr05-compressed.jpg?v=1687701501847'),
(26, 'https://bizweb.dktcdn.net/100/461/213/products/vyn51-thumb-compressed.jpg?v=1687701501847'),
(26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/461/213/products/vyn51-2-compressed.jpg?v=1716801473667'),
(26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/461/213/products/vyn51.png?v=1716801473667'),
(26, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/461/213/products/vyn51-thong-so-compressed.jpg?v=1687701501847'),
(27, 'https://lili.vn/wp-content/uploads/2021/12/Day-chuyen-bac-nu-phong-cach-co-trang-CZ-LILI_831944_3.jpg'),
(27, 'https://lili.vn/wp-content/uploads/2021/12/Day-chuyen-bac-nu-phong-cach-co-trang-CZ-LILI_831944_1-400x400.jpg'),
(27, 'https://lili.vn/wp-content/uploads/2021/12/Day-chuyen-bac-nu-phong-cach-co-trang-CZ-LILI_831944_2.jpg'),
(27, 'https://lili.vn/wp-content/uploads/2021/12/Day-chuyen-bac-nu-phong-cach-co-trang-CZ-LILI_831944_4.jpg'),
(27, 'https://lili.vn/wp-content/uploads/2021/12/Day-chuyen-bac-nu-phong-cach-co-trang-CZ-LILI_831944_5.jpg'),
(28, 'https://product.hstatic.net/200000351153/product/n9203_model_c73e0b95e554445ebf4153f4a0018987_c7a87db49771436db694edde9e6324bf_large.jpg'),
(28, 'https://product.hstatic.net/200000351153/product/n9203_model_c73e0b95e554445ebf4153f4a0018987_c7a87db49771436db694edde9e6324bf_master.jpg'),
(28, 'https://product.hstatic.net/200000351153/product/n9203_concept2_6972664631d043d8bf114e77d3a273a0_6127215b03814b018b27feb3467ac8e0_master.jpg'),
(28, 'https://product.hstatic.net/200000351153/product/n9203_concept_9c831ba2c15c42608f17a0e9967328c6_10584cbaddaf4822aed361822dd719ee_master.jpg'),
(28, 'https://product.hstatic.net/200000351153/product/n9203_lua_d6215746876d416e9bad49067078f70d_5a7e105374d0498a88328fd3645dc771_master.jpg'),
(29, 'https://estelle.vn/wp-content/uploads/2023/12/5ca8fa2487be97cee631e7a5d2a008be.jpg'),
(29, 'https://estelle.vn/wp-content/uploads/2023/12/5ca8fa2487be97cee631e7a5d2a008be.jpg.webp'),
(29, 'https://estelle.vn/wp-content/uploads/2023/12/ab66115a8a79bff9f535fcef14b4be58.jpg.webp'),
(29, 'https://estelle.vn/wp-content/uploads/2023/12/a5885766735e13538634b7a54a20cbca.jpg.webp'),
(29, 'https://estelle.vn/wp-content/uploads/2023/12/5ca8fa2487be97cee631e7a5d2a008be.jpg'),
(30, 'https://img.piaget.com/product-characteristics-2xl-3/5c7e9d9298e59096b85113c91d588a359fb77cc0.jpg'),
(30, 'https://img.piaget.com/product-light-box-1/78a710d2cd82492ca556073784e907c604456dae.jpg'),
(30, 'https://img.piaget.com/product-light-box-1/d7779a1b4534c7a7cf9db6579154b85754550e0c.jpg'),
(30, 'https://img.piaget.com/product-light-box-1/3e2ba4e01c439d0d2e27ce22afffd69f90d98ed9.jpg'),
(30, 'https://img.piaget.com/product-characteristics-2xl-3/5c7e9d9298e59096b85113c91d588a359fb77cc0.jpg'),
(31, 'https://cloud.huythanhjewelry.vn/storage/photos/shares/01upload/1750065578947/nlf439bac9251_1750068451.jpg'),
(31, 'https://cloud.huythanhjewelry.vn/storage/photos/shares/01upload/1750065578947/nlf439bac9252_1750068451.jpg'),
(31, 'https://cloud.huythanhjewelry.vn/storage/photos/shares/01upload/1750065578947/nlf439bac9253_1750068451.jpg'),
(31, 'https://cloud.huythanhjewelry.vn/storage/photos/shares/01upload/1750065435/nlf413bac9251_1750070249.jpg'),
(31, 'https://cloud.huythanhjewelry.vn/storage/photos/shares/01upload/1750065435/nlf413bac9253_1750070249.jpg'),
(32, 'https://cdn.pnj.io/images/detailed/213/sp-snztxmw060011-nhan-bac-dinh-da-disney-pnj-inside-out-2-01.png'),
(32, 'https://cdn.pnj.io/images/detailed/213/on-snztxmw060011-nhan-bac-dinh-da-disney-pnj-inside-out-2-3.jpg'),
(32, 'https://cdn.pnj.io/images/detailed/213/on-snztxmw060011-nhan-bac-dinh-da-disney-pnj-inside-out-2-2.jpg'),
(32, 'https://cdn.pnj.io/images/detailed/213/sp-snztxmw060011-nhan-bac-dinh-da-disney-pnj-inside-out-2-2.png'),
(32, 'https://cdn.pnj.io/images/detailed/213/sp-snztxmw060011-nhan-bac-dinh-da-disney-pnj-inside-out-2-3.png'),
(33, 'https://img.piaget.com/product-light-box-1/ebb2b2112fbca36d589eab9448d0badc4f20e8e4.jpg'),
(33, 'https://img.piaget.com/product-light-box-1/3a0bda90d2fc137008dd88bfe60eb10512f51fd1.jpg'),
(33, 'https://img.piaget.com/product-light-box-1/c3d6c7eefc7fb50995b42b0f201d52c978bbc94c.jpg'),
(33, 'https://img.piaget.com/product-light-box-1/db22b92a7c2f5761604859840700ec1fa375492e.jpg'),
(33, 'https://img.piaget.com/product-light-box-1/9153a2e69d8718820022156b05f20d8e2616e82d.jpg'),
(34, 'https://us.pandora.net/dw/image/v2/AAVX_PRD/on/demandware.static/-/Sites-pandora-master-catalog/default/dwe9cadf06/productimages/singlepackshot/NAMPS0768_RGB.jpg?sw=1500&sh=1500&sm=fit&sfrm=png&bgcolor=F5F5F5'),
(34, 'https://us.pandora.net/dw/image/v2/AAVX_PRD/on/demandware.static/-/Sites-pandora-master-catalog/default/dw0e636a5f/productimages/singlepackshot/593854C00_RGB.jpg?sw=1500&sh=1500&sm=fit&sfrm=png&bgcolor=F5F5F5'),
(34, 'https://us.pandora.net/dw/image/v2/AAVX_PRD/on/demandware.static/-/Sites-pandora-master-catalog/default/dw6bc950ee/productimages/main_rect_base/193510C01_RGB.jpg?sw=450&sh=450&sm=fit&sfrm=png&bgcolor=F5F5F5'),
(34, 'https://us.pandora.net/dw/image/v2/AAVX_PRD/on/demandware.static/-/Sites-pandora-master-catalog/default/dwb448381f/productimages/main_rect_base/PSG2473.jpg?sw=1200&sh=1200&sm=fit&sfrm=png&bgcolor=F5F5F5'),
(34, 'https://us.pandora.net/dw/image/v2/AAVX_PRD/on/demandware.static/-/Sites-pandora-master-catalog/default/dw5d2b9e44/productimages/main_rect_base/PSG487.jpg?sw=1200&sh=1200&sm=fit&sfrm=png&bgcolor=F5F5F5'),
(35, 'https://cdn.huythanhjewelry.vn/storage/photos/shares/01upload/1713754308/nlf4906-3_1715852218.png'),
(35, 'https://cdn.huythanhjewelry.vn/storage/photos/shares/01upload/1713754308/nlf4907-3_1715852219.png'),
(35, 'https://cdn.huythanhjewelry.vn/storage/photos/shares/01upload/1713754308/nlf490-vt-2_1728976826.jpg'),
(35, 'https://cdn.huythanhjewelry.vn/storage/photos/shares/01upload/1713754308/nlf4906_1715852219.png'),
(35, 'https://cdn.huythanhjewelry.vn/storage/photos/shares/01upload/1713754308/nlf4907_1715852219.png'),
(36, 'https://asset.swarovski.com/images/$size_1450/t_swa103/b_rgb:ffffff,c_scale,dpr_2.0,f_auto,w_675/5691228_png/hyperbola-ring--mixed-cuts--white--rhodium-plated-swarovski-5691228.png'),
(36, 'https://asset.swarovski.com/images/$size_1450/t_swa103/b_rgb:ffffff,c_scale,dpr_2.0,f_auto,w_675/5691228_png_var1/hyperbola-ring--mixed-cuts--white--rhodium-plated-swarovski-5691228.png'),
(36, 'https://asset.swarovski.com/images/$size_1450/t_swa103/b_rgb:ffffff,c_scale,dpr_2.0,f_auto,w_675/5691228_png_var2/hyperbola-ring--mixed-cuts--white--rhodium-plated-swarovski-5691228.png'),
(36, 'https://asset.swarovski.com/images/$size_1450/t_swa103/b_rgb:ffffff,c_scale,dpr_2.0,f_auto,w_675/5691228_png_var3/hyperbola-ring--mixed-cuts--white--rhodium-plated-swarovski-5691228.png'),
(36, 'https://asset.swarovski.com/images/$size_1450/t_swa002/c_scale,dpr_2.0,f_auto,w_675/5691228_ms1/hyperbola-ring--mixed-cuts--white--rhodium-plated-swarovski-5691228.jpg'),
(37, 'https://cdn-media.glamira.com/media/product/newgeneration/view/1/sku/Alhertine/diamond/diamond-Brillant_AAA/alloycolour/white.jpg'),
(37, 'https://cdn-media.glamira.com/media/product/newgeneration/view/2/sku/Alhertine/diamond/diamond-Brillant_AAA/alloycolour/white.jpg'),
(37, 'https://cdn-media.glamira.com/media/product/newgeneration/view/3/sku/Alhertine/diamond/diamond-Brillant_AAA/alloycolour/white.jpg'),
(37, 'https://cdn-media.glamira.com/media/product/newgeneration/view/4/sku/Alhertine/diamond/diamond-Brillant_AAA/alloycolour/white.jpg'),
(37, 'https://cdn-media.glamira.com/media/product/newgeneration/view/5/sku/Alhertine/diamond/diamond-Brillant_AAA/alloycolour/white.jpg?width=220&height=220'),
(38, 'https://bizweb.dktcdn.net/100/461/213/products/vcr510-1735791883504.jpg?v=1735791899930'),
(38, 'https://bizweb.dktcdn.net/100/461/213/products/vcr510-1736234030647.jpg?v=1736234036770'),
(38, 'https://bizweb.dktcdn.net/100/461/213/products/vcr510-1735208085496.jpg?v=1739153723667'),
(38, 'https://bizweb.dktcdn.net/100/461/213/products/vcr28-1735791391511.jpg?v=1735791789920'),
(38, 'https://bizweb.dktcdn.net/100/461/213/products/vcr28-1735207725582.jpg?v=1736234156710'),
(39, 'https://www.tierra.vn/wp-content/uploads/2024/07/NCH1503-R_04.webp'),
(39, 'https://www.tierra.vn/wp-content/uploads/2024/07/NCH1503-R_01.webp'),
(39, 'https://www.tierra.vn/wp-content/uploads/2024/07/NCH1503-R_05.webp'),
(39, 'https://www.tierra.vn/wp-content/uploads/2024/07/NCH1503-R_03.webp'),
(39, 'https://www.tierra.vn/wp-content/uploads/2025/05/NCH1502_4-T.webp'),
(40, 'https://product.hstatic.net/200000567741/product/afra000446d2kk1_1_d0aa14fff7d44111b5061eaa83ab97cd_1024x1024.jpg'),
(40, 'https://product.hstatic.net/200000567741/product/afra002614d2kk1_1_731efd02d8274ed3b656bd8bc34b7ba1_1024x1024.jpg'),
(40, 'https://product.hstatic.net/200000567741/product/afra000367d2kk1_1_f246c5d43399400d93a4258ddef90072_1024x1024.jpg'),
(40, 'https://product.hstatic.net/200000567741/product/afra002612d2kk1_1_2fbd7fea09ad47199ac4a728aa906ae3_1024x1024.jpg'),
(40, 'https://product.hstatic.net/200000567741/product/afra002610d2kk1_1_fdc5bb103e5e42b19bc05d9b6ee8181a_1024x1024.jpg'),
(41, 'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-knotwire-bangle-69526020_1080400_ED_M.jpg?&op_usm=2.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(41,'https://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-knotwire-bangle-69526020_1080402_SV_1_M.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(41,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-knotwire-bangle-69526020_1080403_SV_2_M.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(41,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-knotwire-bangle-69526020_1080397_AV_1_M.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(41,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-knotwire-bangle-69526020_1080399_AV_4_M.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(42,'https://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-hardwearmicro-link-bracelet-60416931_993613_ED_M.jpg?&op_usm=1.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(42,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-hardwearmicro-link-bracelet-60416931_1011581_SV_1_M.jpg?&op_usm=1.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(42,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-hardwearmicro-link-bracelet-60416931_1011580_AV_1_M.jpg?&op_usm=1.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(42,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-hardwearmicro-link-bracelet-60416931_1011582_AV_3_M.jpg?&op_usm=1.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(42,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-hardwearmicro-link-bracelet-60416931_993612_AV_2_M.jpg?&op_usm=1.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(43,'https://media.tiffany.com/is/image/Tiffany/EcomItemL2/elsa-perettiopen-heart-bangle-23511304_1028022_ED.jpg?&op_usm=2.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(43,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/elsa-perettiopen-heart-bangle-23511304_1028023_SV_1.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(43,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/elsa-perettiopen-heart-bangle-23511304_1028019_AV_1.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(43,'http://media.tiffany.com/is/image/Tiffany/EcomItemL2/elsa-perettiopen-heart-bangle-23511304_1028020_AV_2.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(43,'https://media.tiffany.com/i//media.tiffany.com/is/image/Tiffany/EcomItemL2/elsa-perettiopen-heart-bangle-23511304_1028021_AV_3.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal/image/Tiffany/EcomItemL2/elsa-perettiopen-heart-bangle-23511304_1028020_AV_2.jpg?&op_usm=2.0,1.0,6.0&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal'),
(44,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw0076f10a/images/large/53be636f03fb53469140fc02d3255c87.png?sw=750&sh=750&sm=fit&sfrm=png'),
(44,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw987f0b7d/images/large/14665e5754d259edbfd968d4c67a86c7.png?sw=750&sh=750&sm=fit&sfrm=png'),
(44,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw96d01e7d/images/large/8d05a8c5f1db57e0990b65339d52ed1b.png?sw=750&sh=750&sm=fit&sfrm=png'),
(44,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwec4bd773/images/large/a9220e1338605961b472fabe8e7422c0.png?sw=750&sh=750&sm=fit&sfrm=png'),
(44,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw9fd30ddf/images/large/b71627993e08525cbf73565e35a107d5.png?sw=750&sh=750&sm=fit&sfrm=png'),
(45,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwe9e73e3b/images/large/7ee7bc5e3f0453a9bd142b0b2770d204.png?sw=750&sh=750&sm=fit&sfrm=png'),
(45,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw83347bdb/images/large/43b514e49f845916bebe3ab982a77525.png?sw=750&sh=750&sm=fit&sfrm=png'),
(45,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw552aa120/images/large/6e00f3014f3c5305b8e6b2c36890f3f9.png?sw=750&sh=750&sm=fit&sfrm=png'),
(45,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwbf95b89a/images/large/d81feea57cd159b5908868e83377558f.png?sw=750&sh=750&sm=fit&sfrm=png'),
(45,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwd6616e7e/images/large/2ea844ffbe985a80b0481a5a93c3f48d.png?sw=750&sh=750&sm=fit&sfrm=png'),
(46,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw129e9662/images/large/b306cb3932c450349ee98e0e3bb7c02b.png?sw=750&sh=750&sm=fit&sfrm=png'),
(46,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw77887aa5/images/large/c9eaec9e44fe5d09bf80a8cd89d11273.png?sw=750&sh=750&sm=fit&sfrm=png'),
(46,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwca430f7f/images/large/4514e0a085b853689c24b516f290a0a7.png?sw=750&sh=750&sm=fit&sfrm=png'),
(46,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dw5a6237ff/images/large/a6410b2c951f5a92b6f04e88142963bc.png?sw=750&sh=750&sm=fit&sfrm=png'),
(46,'https://www.cartier.com/dw/image/v2/BGTJ_PRD/on/demandware.static/-/Sites-cartier-master/default/dwc3f70306/images/large/ae59676a957b50998c04316bba61a860.png?sw=750&sh=750&sm=fit&sfrm=png'),
(47,'https://www.vancleefarpels.com/content/dam/rcq/vca/19/40/21/7/1940217.png'),
(47,'https://www.vancleefarpels.com/content/dam/rcq/vca/20/53/82/6/2053826.jpeg'),
(47,'https://www.vancleefarpels.com/content/dam/rcq/vca/21/21/45/5/2121455.jpeg'),
(47,'https://www.vancleefarpels.com/content/dam/rcq/vca/19/40/21/5/1940215.png'),
(47,'https://www.vancleefarpels.com/content/dam/rcq/vca/19/40/21/6/1940216.png'),
(48,'https://www.vancleefarpels.com/content/dam/rcq/vca/Tl/Hq/DE/21/Tc/m9/sy/EU/EJ/5H/aA/TlHqDE21Tcm9syEUEJ5HaA.png'),
(48,'https://www.vancleefarpels.com/content/dam/rcq/vca/Tl/Hq/DE/21/Tc/m9/sy/EU/EJ/5H/aA/TlHqDE21Tcm9syEUEJ5HaA.png'),
(48,'https://www.vancleefarpels.com/content/dam/rcq/vca/24/03/99/2/2403992.jpeg'),
(48,'https://www.vancleefarpels.com/content/dam/rcq/vca/pm/TQ/Td/uX/Tt/qL/P2/Jr/kh/Fi/7w/pmTQTduXTtqLP2JrkhFi7w.jpeg'),
(48,'https://www.vancleefarpels.com/content/dam/rcq/vca/Gf/g_/-G/PB/Rb/C8/84/d1/zR/Ve/1Q/Gfg_-GPBRbC884d1zRVe1Q.png'),
(49,'https://www.vancleefarpels.com/content/dam/rcq/vca/20/29/29/2/2029292.png'),
(49,'https://www.vancleefarpels.com/content/dam/rcq/vca/20/29/29/1/2029291.png'),
(49,'https://www.vancleefarpels.com/content/dam/rcq/vca/21/21/52/5/2121525.jpeg'),
(49,'https://www.vancleefarpels.com/content/dam/rcq/vca/20/33/36/6/2033366.jpeg'),
(49,'https://www.vancleefarpels.com/content/dam/rcq/vca/20/29/29/4/2029294.png'),
(50,'https://www.vancleefarpels.com/content/dam/rcq/vca/17/08/14/6/1708146.png'),
(50,'https://www.vancleefarpels.com/content/dam/rcq/vca/F1/9s/OE/xL/mk/2f/kM/Pw/-V/AN/SQ/F19sOExLmk2fkMPw-VANSQ.jpeg'),
(50,'https://www.vancleefarpels.com/content/dam/rcq/vca/18/16/50/3/1816503.png'),
(50,'https://www.vancleefarpels.com/content/dam/rcq/vca/17/08/14/5/1708145.png'),
(50, 'https://www.vancleefarpels.com/content/dam/rcq/vca/17/08/14/6/1708146.png');

--chèn data vào bảng danh mục bài viết 
INSERT INTO danh_muc_bai_viet (id_danh_muc, ten_danh_muc) VALUES
(1, 'Câu chuyện JewelryStore '),
(2, 'Xu hướng-Phong cách '),
(3, 'Kiến thức ');

--chèn data vào bảng bài viết
INSERT INTO bai_viet (id_bai_viet, tieu_de, noi_dung, ngay_dang, ngay_cap_nhat, id_danh_muc, id_nguoi_tao, trang_thai) VALUES
(1, 'Câu chuyện thương hiệu', 'Từ năm 2000 đến nay...', '2025-05-31 17:00:00', '2025-06-20 03:05:20', 1, 1, 'draft'),
(2, 'Xu hướng 2025', 'Thiết kế phát triển hiện đại...', '2025-06-01 17:00:00', '2025-06-20 03:05:20', 2, 2, 'draft'),
(3, 'Bảo quản đá quý', 'Trang sức mang lại nhiều...', '2025-06-02 17:00:00', '2025-06-20 03:05:20', 3, 3, 'draft'),
(4, 'Tối giản quay lại ', 'Xu hướng tối giản được ưa chuộng...', '2025-06-03 17:00:00', '2025-06-20 03:05:20', 2, 2, 'draft'),
(5, 'Người sáng lập nói gì?', 'Chia sẻ từ người thành thương hiệu...', '2025-08-04 17:00:00', '2025-06-20 03:05:20', 1, 1, 'draft'),
(6, 'Mix dây chuyền', 'Phối hợp cùng sản phẩm cá tính...', '2025-06-05 17:00:00', '2025-06-20 03:05:20', 2, 2, 'draft'),
(7, 'Phân biệt đá quý', 'Tránh mua nhầm đá giả...', '2025-06-06 17:00:00', '2025-06-20 03:05:20', 3, 3, 'draft'),
(8, 'Lịch sử kim cương', 'Từ truyền thuyết đến biểu tượng quyền lực...', '2025-06-07 17:00:00', '2025-06-20 03:05:20', 3, 3, 'draft'),
(9, 'Một ngày làm việc tại cửa hàng', 'Cùng khám phá quá trình tạo sản phẩm...', '2025-08-08 17:00:00', '2025-06-20 03:05:20', 1, 1, 'draft'),
(10, 'Top vòng tay hè này', 'Xu hướng vòng tay đáng chú ý hè này...', '2025-06-09 17:00:00', '2025-06-20 03:05:20', 2, 2, 'draft'),
(11, 'Bạc bị đen? Cách xử lý!', 'Mẹo giữ trang sức luôn sáng bóng...', '2025-06-10 17:00:00', '2025-06-20 03:05:20', 3, 3, 'draft'),
(12, 'Thời trang trang sức cho nữ', 'Trang sức không chỉ dành cho nữ...', '2025-06-11 17:00:00', '2025-06-20 03:05:20', 2, 2, 'draft');

-- chèn data vào bảng chi tiết bài viết
INSERT INTO chi_tiet_bai_viet (id_bai_viet, noi_dung, hinh_anh, created_at) VALUES
(1, 'Khởi nguồn từ đam mê:Thương hiệu Jewelry Store ra đời từ tình yêu mãnh liệt với nghệ thuật chế tác trang sức. Vào năm 2015, những người sáng lập đã bắt đầu hành trình tại một xưởng nhỏ, nơi họ biến những viên đá quý thô thành những kiệt tác lộng lẫy. Hình ảnh minh họa: Một xưởng thủ công với các nghệ nhân đang làm việc.\r\n\r\nCam kết chất lượng: Chúng tôi luôn đặt chất lượng lên hàng đầu, chọn lọc từng viên ngọc trai và kim cương từ những nguồn cung cấp uy tín. Mỗi sản phẩm đều được kiểm định kỹ lưỡng để đảm bảo độ bền và vẻ đẹp vượt thời gian. Hình ảnh minh họa: Một viên kim cương lấp lánh dưới ánh sáng.\r\n\r\nHành trình lan tỏa vẻ đẹp:Từ những ngày đầu khiêm tốn, Jewelry Store đã vươn xa, mang vẻ đẹp trang sức đến tay hàng ngàn khách hàng trên toàn cầu. Mỗi món đồ không chỉ là trang sức mà còn là biểu tượng của phong cách và cá tính. Hình ảnh minh họa: Một khách hàng đeo vòng cổ tại sự kiện sang trọng.\r\n\r\nTương lai rực rỡ:Nhìn về phía trước, Jewelry Store cam kết tiếp tục đổi mới, kết hợp giữa truyền thống và xu hướng hiện đại để tạo ra những bộ sưu tập mới mẻ. Hãy cùng chúng tôi viết tiếp câu chuyện này! Hình ảnh minh họa: Một thiết kế trang sức mới với phong cách hiện đại.', 'bai_viet1.jpg', '2025-06-18 03:11:40'),
(2, 'Phong Cách Tối Giản Sang Trọng: Năm 2025 tiếp tục khẳng định sức hút của phong cách tối giản, với những thiết kế nhẫn trơn, dây chuyền mảnh và hoa tai nhỏ nhắn. Chất liệu bạc và vàng trắng được ưa chuộng nhờ sự thanh lịch, dễ phối hợp với mọi trang phục từ công sở đến dạo phố.\r\n\r\nCá Nhân Hóa Độc Đáo: Xu hướng trang sức cá nhân hóa bùng nổ với các món đồ khắc tên, ngày kỷ niệm hoặc biểu tượng ý nghĩa. Từ nhẫn khắc chữ cái đến vòng cổ gắn đá theo tháng sinh, đây là cách thể hiện cá tính và câu chuyện riêng của người sở hữu.\r\n\r\nLayering Đầy Sáng Tạo:Phối hợp nhiều lớp trang sức như dây chuyền dài ngắn khác nhau, nhẫn xếp chồng hoặc vòng tay đa chất liệu trở thành điểm nhấn thời thượng. Sự kết hợp này mang lại phong cách trẻ trung, năng động và rất linh hoạt.\r\n\r\nĐá Màu và Thiên Nhiên Lên Ngôi:Trang sức gắn đá màu như sapphire, ruby và thạch anh tím tạo nên sự rực rỡ, đồng thời mang ý nghĩa phong thủy. Họa tiết lấy cảm hứng từ thiên nhiên như lá cây, hoa cỏ cũng được yêu thích, kết hợp với chất liệu bền vững như bạc tái chế.\r\n\r\nCông Nghệ và Chức Năng Thông Minh:Trang sức thông minh với khả năng theo dõi sức khỏe hoặc tích hợp công nghệ AI bắt đầu thu hút giới trẻ. Những thiết kế này không chỉ đẹp mà còn tiện ích, như nhẫn đo nhịp tim hoặc vòng tay kết nối Bluetooth.', 'bai_viet2.jpg', '2025-06-18 03:11:40'),
(3, 'Đá Ruby - Biểu Tượng Của Tình Yêu và Năng Lượng: Ruby với màu đỏ rực rỡ tượng trưng cho tình yêu mãnh liệt và sự tự tin. Loại đá này được tin là mang lại năng lượng tích cực, giúp người đeo vượt qua khó khăn và bảo vệ sức khỏe tim mạch.\r\n\r\nĐá Sapphire - Trí Tuệ và Bình An: Sapphire xanh thẳm đại diện cho trí tuệ, sự trung thực và bình an nội tâm. Thường được chọn làm món quà trong các dịp đặc biệt, đá này còn được xem là lá chắn bảo vệ khỏi những năng lượng tiêu cực.\r\n\r\nĐá Emerald - Tái Sinh và Hạnh Phúc: Emerald mang sắc xanh lá cây tươi mới, tượng trưng cho sự tái sinh và sự thịnh vượng. Loại đá này được tin là tăng cường sức khỏe tinh thần, mang lại niềm vui và cân bằng cảm xúc cho người sở hữu.\r\n\r\nĐá Amethyst - Tâm Linh và Yên Tĩnh: Amethyst với màu tím dịu nhẹ là biểu tượng của sự thanh tịnh và giác ngộ tâm linh. Đá này giúp giảm căng thẳng, cải thiện giấc ngủ và hỗ trợ thiền định, rất được ưa chuộng trong các liệu pháp chữa lành.', 'bai_viet3.jpg', '2025-06-18 03:11:40'),
(4, 'Định nghĩa tối giản: Phong cách tối giản trong trang sức tập trung vào sự đơn giản, tinh tế và không rườm rà. Đây là sự kết hợp hoàn hảo giữa thiết kế mảnh mai và chất liệu cao cấp, giúp tôn lên vẻ đẹp tự nhiên mà không làm lu mờ phong cách cá nhân.\r\n\r\nĐặc Điểm Của Trang Sức Tối Giản: Những món trang sức tối giản thường có đường nét thanh thoát, như dây chuyền mảnh, nhẫn trơn hoặc hoa tai nhỏ. Chất liệu phổ biến là vàng trắng, bạc hoặc vàng 14K, kết hợp với đá quý nhỏ hoặc không đá để giữ sự nhẹ nhàng và tinh tế.\r\n\r\nCách Phối Đồ Tối Giản: Để áp dụng phong cách này, hãy chọn một món trang sức làm điểm nhấn như một chiếc nhẫn đơn hoặc dây chuyền mảnh, tránh lạm dụng nhiều phụ kiện cùng lúc. Kết hợp với trang phục trung tính để tạo sự hài hòa và thanh lịch.\r\n\r\nLợi Ích Và Xu Hướng 2025:Trang sức tối giản không chỉ dễ sử dụng hàng ngày mà còn là xu hướng nổi bật năm 2025 nhờ tính linh hoạt và bền vững. Đây là lựa chọn lý tưởng cho những ai yêu thích sự đơn giản nhưng vẫn muốn thể hiện gu thẩm mỹ cao cấp.', 'bai_viet4.jpg', '2025-06-18 03:11:40'),
(5, '1. Bối cảnh và Nguồn Gốc Thương Hiệu: Jewelry Store được thành lập vào năm 2015, khởi đầu từ một xưởng thủ công nhỏ tại trung tâm thủ đô, nơi người sáng lập – một nghệ nhân ẩn danh với hơn 20 năm kinh nghiệm – quyết định hiện thực hóa đam mê chế tác trang sức. Trong một cuộc phỏng vấn giả định (dựa trên bối cảnh chung của ngành), người sáng lập nhấn mạnh: \"Thương hiệu này ra đời từ mong muốn kết hợp nghệ thuật truyền thống với triết lý hiện đại, tạo ra những sản phẩm không chỉ là trang sức mà là biểu tượng văn hóa và cá nhân.\" Sự cam kết này được phản ánh qua quy trình chọn lọc nguyên liệu thô từ các nguồn bền vững, đặt nền móng cho sự phát triển bền vững của thương hiệu.\r\n\r\n2. Tầm Nhìn và Triết Lý của Người Sáng Lập: Người sáng lập Jewelry Store định hướng xây dựng một thương hiệu lấy khách hàng làm trung tâm, với trọng tâm là chất lượng và tính cá nhân hóa. Trong các tài liệu nội bộ (giả định), ông/ bà nhấn mạnh tầm quan trọng của việc sử dụng vàng tái chế và đá quý có nguồn gốc rõ ràng, nhằm giảm thiểu tác động môi trường. \"Mỗi món trang sức là một câu chuyện, và chúng tôi muốn khách hàng cảm nhận được giá trị đó qua từng chi tiết,\" ông/bà chia sẻ. Tầm nhìn này không chỉ định hình sản phẩm mà còn ảnh hưởng đến chiến lược tiếp thị, tập trung vào cộng đồng yêu thích phong cách sống bền vững.\r\n\r\n3. Phân Tích Xu Hướng Trang Sức 2025:\r\n3.1 Phong Cách Tối Giản và Tinh Tế: Nghiên cứu thị trường cho thấy xu hướng tối giản tiếp tục thống trị năm 2025, với 68% người tiêu dùng ưu tiên trang sức mảnh mai như nhẫn trơn và dây chuyền đơn (theo khảo sát giả định từ X và web). Jewelry Store đã tận dụng xu hướng này bằng cách giới thiệu dòng sản phẩm Minimal Luxe, sử dụng vàng 14K và đá quý nhỏ, phù hợp với lối sống hiện đại.\r\n\r\n3.2 Cá Nhân Hóa và Công Nghệ:Theo dữ liệu từ các nền tảng thương mại điện tử, nhu cầu về trang sức khắc tên hoặc tích hợp công nghệ (như nhẫn thông minh) tăng 45% trong nửa đầu 2025. Jewelry Store đáp ứng bằng cách hợp tác với các nhà thiết kế để cung cấp dịch vụ tùy chỉnh, đồng thời thử nghiệm tích hợp cảm biến sức khỏe – một bước đi táo bạo trong ngành.\r\n\r\n3.3 Vật Liệu Bền Vững và Đá Màu:Sự quan tâm đến trang sức bền vững tăng mạnh, với 73% khách hàng sẵn sàng chi trả cao hơn cho sản phẩm thân thiện môi trường (nguồn: phân tích web). Jewelry Store đã chuyển sang sử dụng bạc tái chế và đá màu như sapphire, ruby, được khai thác từ các mỏ có chứng nhận, khẳng định vị thế trong xu hướng này.\r\n\r\n4. Kết Luận và Triển Vọng Tương Lai:Jewelry Store, dưới sự dẫn dắt của người sáng lập, không chỉ là một thương hiệu trang sức mà còn là một phong trào văn hóa, phản ánh xu hướng toàn cầu vào năm 2025. Với sự kết hợp giữa di sản thủ công và đổi mới công nghệ, thương hiệu có tiềm năng mở rộng thị trường quốc tế. Nghiên cứu sâu hơn về phản hồi khách hàng và hiệu quả kinh doanh sẽ cần thiết để đánh giá toàn diện tiềm năng phát triển trong tương lai gần.', 'bai_viet5.jpg', '2025-06-18 03:11:40'),
(6, 'Tìm Hiểu Về Layering Dây Chuyền: Layering – nghệ thuật phối nhiều dây chuyền cùng lúc – là xu hướng nổi bật năm 2025, mang lại vẻ ngoài cá tính và hiện đại. Mục tiêu là tạo sự hài hòa giữa các lớp, với độ dài và thiết kế khác nhau để tôn lên phong cách riêng.\r\n\r\nCách Mix Dây Chuyền Tối Giản:\r\nChọn độ dài khác nhau: Sử dụng một dây chuyền ngắn (khoảng 40-45cm) với mặt dây hình tròn nhỏ, kết hợp dây dài (50-60cm) có mặt đá sapphire. Điều này tạo chiều sâu mà không rối mắt.\r\n\r\nChất liệu hài hòa: Kết hợp vàng trắng với bạc hoặc vàng hồng để giữ phong cách tối giản nhưng sang trọng.\r\n\r\nĐiểm nhấn tinh tế: Thêm một dây mảnh không mặt trang trí để làm nền, giúp các món khác nổi bật.\r\n\r\nMẹo Phối Đồ và Dịp Sử Dụng: Phối với áo cổ trễ hoặc áo sơ mi thùng để dây chuyền được chú ý. Với trang phục công sở, chọn 2-3 dây mảnh; còn tiệc tối, thêm mặt đá màu rực rỡ.\r\n\r\nTránh lạm dụng quá 3 dây để giữ vẻ thanh lịch, đặc biệt phù hợp với xu hướng bền vững của Jewelry Store.\r\n\r\nGợi Ý Từ Jewelry Store: Jewelry Store khuyến khích thử nghiệm với bộ sưu tập Minimal Luxe, nơi bạn có thể mix dây chuyền khắc tên cá nhân với dây đá quý nhỏ. Kết quả là một phong cách vừa độc đáo vừa thời thượng, phản ánh cá tính riêng biệt.\r\n\r\nHãy thử ngay và chia sẻ phong cách của bạn!', 'bai_viet6.jpg', '2025-06-18 03:11:40'),
(7, '1. Ruby - Đá Đỏ Rực Rỡ: \r\nNguồn gốc: Ruby là biến thể màu đỏ của corundum, chủ yếu khai thác tại Myanmar, Thái Lan và Mozambique.\r\nĐặc điểm nhận diện: Màu đỏ đậm do hàm lượng crom, độ cứng 9 trên thang Mohs. Dưới ánh sáng, có thể thấy hiệu ứng \"hồng ngọc sao\" nếu có tạp chất hợp chất titan.\r\nPhân biệt: So với garnet (đỏ nhạt hơn, độ cứng 6.5-7), ruby có độ bóng và giá trị cao hơn nhờ độ trong và màu sắc.\r\n\r\n2. Sapphire - Đá Xanh Thâm Thúy:\r\nNguồn gốc: Cũng thuộc corundum, sapphire phổ biến ở Sri Lanka, Kashmir và Madagascar, với màu xanh đặc trưng.\r\nĐặc điểm nhận diện: Độ cứng 9, thường có ánh xanh dương do sắt và titan. Một số sapphire hiếm có màu khác như hồng hoặc vàng.\r\nPhân biệt: Khác với aquamarine (màu xanh nhạt hơn, độ cứng 7.5-8), sapphire có độ trong suốt và giá trị cao hơn khi tự nhiên.\r\n\r\n3. Emerald - Đá Xanh Lá Tái Sinh:\r\nNguồn gốc: Thuộc họ beryl, khai thác chủ yếu tại Colombia, Zambia và Brazil.\r\nĐặc điểm nhận diện: Màu xanh lá do tạp chất crom, độ cứng 7.5-8 nhưng thường có vết nứt tự nhiên. Độ trong là yếu tố định giá.\r\nPhân biệt: So với peridot (xanh olive, độ cứng 6.5-7), emerald có sắc xanh đậm hơn và giá trị cao hơn nhờ độ quý hiếm.\r\n\r\n4. Amethyst - Đá Tím Thanh Lịch:\r\nNguồn gốc: Là một loại thạch anh tím, phổ biến tại Brazil, Uruguay và Nga.\r\nĐặc điểm nhận diện: Màu tím từ nhạt đến đậm do sắt, độ cứng 7. Có thể phai màu dưới ánh nắng mạnh.\r\nPhân biệt: Khác với topaz tím (độ cứng 8), amethyst rẻ hơn và thường có tông màu đồng đều hơn.\r\n\r\n5. Phương Pháp Phân Biệt Chung:\r\nKiểm tra độ cứng: Sử dụng thang Mohs để thử độ chống trầy (ruby, sapphire cao nhất với 9).\r\nQuan sát màu sắc: Ánh sáng tự nhiên hoặc kính phóng đại giúp phát hiện tạp chất và hiệu ứng quang học.\r\nChứng nhận: Đá quý thật thường đi kèm giấy chứng nhận từ viện kiểm định như GIA hoặc IGI.\r\n\r\nHiểu biết về đặc điểm này giúp người tiêu dùng và nhà thiết kế tại Jewelry Store lựa chọn đá quý phù hợp, đảm bảo chất lượng và giá trị bền vững.', 'bai_viet7.jpg', '2025-06-18 03:11:40'),
(8, '1. Khai Sinh và Khám Phá Ban Đầu:Kim cương, hình thành cách đây hơn 3 tỷ năm trong lòng đất dưới áp suất và nhiệt độ cực cao, được con người phát hiện lần đầu tiên vào khoảng 3000 TCN tại Ấn Độ, dọc theo sông Krishna. Ban đầu, kim cương được sử dụng như một vật liệu cắt khắc và trong các nghi lễ tôn giáo nhờ độ cứng 10 trên thang Mohs. Đến thế kỷ 4 TCN, Ấn Độ trở thành trung tâm khai thác kim cương, cung cấp đá thô cho vương triều và thương nhân.\r\n\r\n2. Sự Phát Triển Qua Các Thế Kỷ: Thời Trung Cổ: Kim cương lan rộng đến châu Âu qua tuyến thương mại với thế giới Ả Rập. Vào thế kỷ 13, chúng được mài dũa lần đầu tại Venice, đánh dấu bước ngoặt trong việc nâng cao giá trị thẩm mỹ.\r\nThế kỷ 15-16: Sự xuất hiện của kim cương trong hoàng gia châu Âu (như vương miện của Nữ hoàng Elizabeth I) biến chúng thành biểu tượng quyền lực và giàu có. Công nghệ mài cắt tiến bộ, với kiểu \"brilliant cut\" ra đời vào năm 1919.\r\nThế kỷ 19: Khám phá mỏ kim cương tại Nam Phi (1866) bởi Erasmus Jacobs mở ra kỷ nguyên khai thác công nghiệp. Công ty De Beers, thành lập năm 1888, kiểm soát gần 90% thị trường kim cương thế giới vào thời kỳ đỉnh cao.\r\n\r\n3. Kim Cương Trong Thế Kỷ 20 và Hiện Đại:Thương Mại Hóa: Chiến dịch quảng cáo \"A Diamond is Forever\" của De Beers vào năm 1947 do Frances Gerety sáng tạo đã định hình kim cương như biểu tượng tình yêu, thúc đẩy nhu cầu nhẫn cầu hôn.\r\nCông Nghệ và Bền Vững: Từ những năm 1990, kim cương nhân tạo (lab-grown) bắt đầu xuất hiện, chiếm khoảng 10% thị trường vào năm 2025 (dựa trên xu hướng hiện tại). Đồng thời, phong trào chống kim cương xung đột (conflict diamonds) thúc đẩy chứng nhận Kimberley Process.\r\nNăm 2025: Thị trường kim cương tiếp tục phát triển với sự kết hợp giữa truyền thống và đổi mới, như tích hợp công nghệ blockchain để truy xuất nguồn gốc.\r\n\r\n4. Ý Nghĩa Văn Hóa và Tương Lai: Kim cương không chỉ là đá quý mà còn mang ý nghĩa văn hóa sâu sắc, từ biểu tượng bất tử đến sự xa xỉ. Tại Jewelry Store, lịch sử này được tôn vinh qua các thiết kế lấy cảm hứng từ quá khứ, kết hợp với xu hướng bền vững. Với sự gia tăng của kim cương nhân tạo và ý thức bảo vệ môi trường, tương lai hứa hẹn một ngành công nghiệp cân bằng giữa di sản và tiến bộ.', 'bai_viet8.jpg', '2025-06-18 03:11:40'),
(9, 'Quá Trình Chế Tác:Công việc chế tác bắt đầu lúc 9:00 sáng, khi nghệ nhân tại Jewelry Store chọn lọc đá quý thô như ruby và sapphire. Với dụng cụ tinh xảo, họ mài dũa từng viên, đảm bảo độ bóng và cắt chuẩn xác, hoàn thành trong 4-6 giờ tùy độ phức tạp.\r\n\r\nKỹ Thuật và Sáng Tạo:Nghệ nhân sử dụng kỹ thuật mài brilliant cut, kết hợp công nghệ laser hiện đại để tạo điểm nhấn. Mỗi sản phẩm được kiểm tra kỹ lưỡng vào 3:00 chiều, phản ánh cam kết chất lượng cao của thương hiệu.', 'bai_viet9.jpg', '2025-06-18 03:11:40'),
(10, 'Vòng Tay Tối Giản:Vòng tay mảnh làm từ bạc hoặc vàng hồng, điểm xuyết đá sapphire nhỏ, là lựa chọn lý tưởng cho mùa hè. Thiết kế nhẹ nhàng, dễ phối với áo croptop hoặc váy maxi, mang lại vẻ thanh thoát và mát mẻ.\r\n\r\nVòng Tay Handmade Đa Màu:Những chiếc vòng đan thủ công với hạt cườm màu sắc tươi sáng như vàng chanh, xanh neon phù hợp với không khí hè. Phối cùng đồ bơi hoặc trang phục dạo biển, chúng tạo điểm nhấn vui tươi và cá tính.\r\n\r\nVòng Tay Charm Cá Nhân Hóa:Vòng tay charm với các hạt trang trí theo sở thích, như hình ngôi sao hoặc ký tự ban đầu, đang hot. Dễ dàng điều chỉnh để phù hợp với phong cách, đây là phụ kiện hoàn hảo cho các buổi tiệc ngoài trời.\r\n\r\nVòng Tay Đá Phong Thủy:Vòng tay làm từ thạch anh hoặc ngọc bích, mang ý nghĩa may mắn, rất được ưa chuộng. Thiết kế tự nhiên kết hợp với dây vải nhẹ giúp giữ mát, lý tưởng cho những ngày nắng nóng.', 'bai_viet10.jpg', '2025-06-18 03:11:40'),
(11, 'Nguyên Nhân Bạc Bị Đen:Bạc bị đen (hay còn gọi là xỉn màu) do phản ứng với lưu huỳnh trong không khí, mồ hôi hoặc hóa chất như nước hoa. Quá trình này thường xảy ra nhanh hơn trong môi trường ẩm hoặc khi không bảo quản đúng cách, làm giảm độ sáng bóng của trang sức bạc.\r\n\r\nCách Xử Lý:Dùng Baking Soda: Trộn 1 thìa baking soda với nước, nhúng bạc vào trong 5 phút, sau đó lau nhẹ bằng khăn mềm.\r\n\r\nGiấm và Muối: Ngâm bạc trong hỗn hợp giấm và muối (tỷ lệ 1:1) trong 10 phút, rồi rửa sạch và lau khô.\r\n\r\nBảo Quản: Lưu trữ bạc trong túi chống ẩm sau khi sử dụng để tránh xỉn màu.', 'bai_viet11.jpg', '2025-06-18 03:11:40'),
(12, 'Phong Cách Tối Giản và Layering:Năm 2025, phụ nữ yêu thích phong cách tối giản với dây chuyền mảnh, nhẫn trơn và hoa tai nhỏ, dễ phối cùng trang phục công sở. Layering – nghệ thuật phối nhiều lớp trang sức – cũng trở thành xu hướng, mang lại vẻ ngoài cá tính và hiện đại.', 'bai_viet12.jpg', '2025-06-18 03:11:40');

--chèn data vào bảng quản trị viên
INSERT INTO quan_tri_vien (id_quan_tri, ten_dang_nhap, mat_khau, email, ho_ten, quyen_han) VALUES
(1, 'Hine', '123456', 'hienttt2462@ut.edu.vn', 'Thu Hiền', 'admin'),
(2, 'chuyengia', '123456', 'chuyengiajs@gmail.com', 'Chuyên gia', 'admin'),
(3, 'nttung', '123456', 'nttung@gmail.com', 'Tùng Nguyễn', 'admin');
