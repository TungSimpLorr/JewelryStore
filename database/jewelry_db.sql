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
  `trang_thai_chung` tinyint(1) default 1,
  `url_anh_dai_dien` varchar(255) default null,
  `ngay_tao` timestamp not null default current_timestamp(),
  `ngay_cap_nhat` timestamp not null default current_timestamp() on update current_timestamp(),
  primary key (`id_san_pham`),
  foreign key (`id_thuong_hieu`) references `thuong_hieu`(`id_thuong_hieu`) on delete set null on update cascade,
  foreign key (`id_loai_san_pham`) references `loai_san_pham`(`id_loai_san_pham`) on delete set null on update cascade
) engine=innodb default charset=utf8mb4 collate=utf8mb4_unicode_ci;

-- bang anh san pham
create table `anh_san_pham` (
  `id_anh` int(11) not null auto_increment,
  `id_san_pham` int(11) not null,
  `url_anh` varchar(255) not null,
  primary key (`id_anh`),
  foreign key (`id_san_pham`) references `san_pham`(`id_san_pham`) on delete cascade on update cascade
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
(15, 'Doji');


-- chen vao bang san pham 
insert into `san_pham` (`id_san_pham`, `ma_san_pham`, `ten_san_pham`, `gia_san_pham`, `mo_ta`, `id_thuong_hieu`, `id_loai_san_pham`, `khoi_luong`, `trang_thai_chung`, `url_anh_dai_dien`, `ngay_tao`, `ngay_cap_nhat`) values
(1, 'VCJS001', 'VÒNG CỔ ALEXANDRA DIAMOND', 2000000.00, 'Với viên kim cương lấp lánh được cắt gọt tinh xảo, chiếc vòng cổ này là biểu tượng của vẻ đẹp cổ điển và sự sang trọng tuyệt đối. Alexandra Diamond không chỉ là một món trang sức, mà còn là tuyên ngôn về phong cách tinh tế, hoàn hảo cho những quý cô yêu thích sự lộng lẫy và đẳng cấp.', 1, 2, 110.00, 0, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300', '2025-05-24 17:00:00', '2025-05-24 17:00:00'),
(2, 'VCJS002', 'VÒNG CỔ DARKQUEEN DIAMOND', 5000000.00, 'Khám phá sức mạnh của bóng tối và sự quyến rũ bất tận với DarkQueen Diamond. Viên kim cương huyền bí, ánh lên vẻ đẹp sâu thẳm đầy mê hoặc, tạo nên một tuyên ngôn thời trang táo bạo và độc đáo. Chiếc vòng cổ này dành cho những ai dám thể hiện cá tính mạnh mẽ, biến mỗi khoảnh khắc thành sàn diễn của riêng mình. DarkQueen Diamond – nơi vẻ đẹp quyền lực được thăng hoa.', 1, 1, 120.00, 1, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2022/11/1-17.png', '2025-05-24 17:00:00', '2025-06-18 06:42:36'),
(3, 'VCJS003', 'VÒNG CỔ LONELY ROCKSTAR', 1000000.00, 'Lonely Rockstar không chỉ là một chiếc vòng cổ, mà là bản tình ca của sự tự do và cá tính nổi loạn. Với thiết kế độc đáo, góc cạnh và đầy phóng khoáng, chiếc vòng cổ này là biểu tượng cho tinh thần không ngừng khám phá, vượt qua mọi giới hạn. Dù bạn là người tiên phong hay một tâm hồn nghệ sĩ, Lonely Rockstar sẽ là điểm nhấn hoàn hảo, khẳng định phong cách khác biệt và không thể trộn lẫn của bạn.', 1, 1, 25.00, 1, 'https://i.pinimg.com/736x/86/12/d7/8612d79d4d15e81d2459e1af3998f077.jpg', '2025-05-24 17:00:00', '2025-05-24 17:00:00'),
(4, 'RRJS102', 'NHẪN CZ', 999000.00, 'Chiếc nhẫn được chế tác từ bạc S925 cao cấp được đính kèm viên đá Cubic Zirconia cao cấp. Thiết kế là lựa chọn hoàn hảo cho bạn trong những trang phục dự tiệc trang trọng.', 2, 2, 25.00, 0, 'https://lili.vn/wp-content/uploads/2021/11/Nhan-bac-nu-dinh-da-CZ-hinh-bong-hoa-dao-LILI_289467_4-768x768.jpg', '2025-05-25 17:00:00', '2025-05-25 17:00:00'),
(5, 'RRJS103', 'NHẪN ĐÔI', 49000000.00, 'Nhẫn đôi, biểu tượng của tình yêu và sự gắn kết, là một cặp nhẫn được thiết kế để nam và nữ cùng đeo, thể hiện mối quan hệ đặc biệt giữa họ. Dù là nhẫn đính hôn, nhẫn cưới hay đơn giản là nhẫn kỷ niệm, mỗi chiếc nhẫn đều mang ý nghĩa sâu sắc, tượng trưng cho sự cam kết, lòng chung thủy và hy vọng về một tương lai chung.', 2, 2, 25.00, 1, 'https://lili.vn/wp-content/uploads/2022/11/Nhan-cap-doi-bac-dinh-kim-cuong-Moissanite-Layla-LILI_054884_3-768x768.jpg', '2005-05-26 17:00:00', '2005-05-26 17:00:00'),
(6, 'VTJS112', 'VÒNG TAY XÍCH "SILVERLINK"', 2500100.00, 'Vòng tay "SilverLink" mang thiết kế tối giản nhưng đầy tính biểu tượng, lấy cảm hứng từ chuỗi mắt xích kim loại hiện đại. Mỗi mắt xích hình chữ nhật được gia công tỉ mỉ từ hợp kim bạc sáng bóng, tạo nên vẻ ngoài mạnh mẽ nhưng không kém phần thanh lịch. Kết cấu đều đặn cùng cơ chế khóa chắc chắn giúp vòng ôm vừa vặn cổ tay và dễ dàng điều chỉnh theo nhiều kích thước.', 3, 3, 25.00, 1, 'https://bizweb.dktcdn.net/thumb/1024x1024/100/461/213/products/01-vcb04-b-thumb.png?v=1687592003107', '2025-05-26 17:00:00', '2025-05-26 17:00:00'),
(7, 'KTJS202', 'HOA TAI CẨM THẠCH', 11500000.00, 'Đôi bông tai này nổi bật với thiết kế nụ tinh xảo, mang đến vẻ đẹp cổ điển nhưng không kém phần sang trọng. Điểm nhấn chính là viên đá quý lớn ở trung tâm, với sắc xanh lá cây đậm đà, hình bầu dục hoặc tròn dẹt, gợi liên tưởng đến ngọc bích quý giá.', 6, 5, 25.00, 0, 'https://ngoctham.com/wp-content/uploads/2023/07/bong-tai-cam-thach-vang-18k-dtbvlvv0000r120-ntj-01-1-688x774.jpg', '2025-05-26 17:00:00', '2025-05-26 17:00:00'),
(8, 'VTJS114', 'VÒNG TAY CHO BÉ', 999000.00, 'Chiếc vòng bạc tỏa sáng lấp lánh, phản chiếu ánh sáng dịu dàng trên bề mặt nhám. Những họa tiết ngôi sao nhỏ được khắc chìm tinh xảo, tạo điểm nhấn độc đáo và bắt mắt. Thiết kế dạng hở cho phép điều chỉnh, mang lại sự tiện lợi và vẻ đẹp thanh thoát. Chất liệu bạc cao cấp làm tăng thêm vẻ sang trọng, quý phái cho món trang sức. Tổng thể chiếc vòng toát lên vẻ đẹp tinh tế, nhẹ nhàng và đầy duyên dáng.', 6, 3, 25.00, 1, 'https://lili.vn/wp-content/uploads/2023/12/Lac-tay-bac-dac-cho-be-gai-trai-anh-sao-Bethany-LILI_097318_6-400x400.jpg', '2025-05-26 17:00:00', '2025-05-26 17:00:00'),
(9, 'VCJS005', 'VÒNG CỔ SWAROVSKI', 1000000.00, 'Dây chuyền mặt pha lê Swarovski trái tim đại dương  là một thiết kế vô cùng sang trọng và hấp dẫn đến từ trang sức LiLi. Hãy tưởng tượng viên pha lê đính trên dây chuyền bạc này sáng lấp lánh trên khuôn cổ của bạn, sẽ thật tuyệt vời đúng không nào.', 2, 1, 120.00, 1, 'https://lili.vn/wp-content/uploads/2020/12/day-chuyen-bac-mat-pha-le-swaroski-trai-tim-dai-duong-LILI_295787-1-1.jpg', '2025-06-18 09:07:26', '2025-06-18 09:07:26'),
(10, 'VCJS006', 'VÒNG CỔ DATE NIGHT ', 15000000.00, 'Tựa như vì sao sáng nhất trên bầu trời đêm, vòng cổ "Date Night" mang đến vẻ đẹp lấp lánh đầy cuốn hút, khiến bạn tỏa sáng trong những khoảnh khắc đáng nhớ. Mặt dây chuyền được thiết kế hình ngôi sao tỏa sáng rực rỡ, đính hàng loạt viên đá nhỏ li ti tạo hiệu ứng bắt sáng tuyệt vời, như ánh nhìn đầu tiên trong một buổi hẹn hò mộng mơ.', 3, 1, 200.00, 1, 'https://bizweb.dktcdn.net/100/461/213/products/vyn51-thumb-compressed.jpg?v=1687701501847', '2025-06-18 09:07:26', '2025-06-18 09:07:26'),
(11, 'VCJS008', 'VÒNG CỔ "BÁU VẬT ĐẠI DƯƠNG"', 29000000.00, 'Chiếc vòng cổ ngọc trai được đeo trên cổ của một người phụ nữ. Chiếc vòng cổ có những viên ngọc\r\n trai nhỏ, tròn, màu trắng ngà, được xâu chuỗi đều đặn. Điểm nhấn của chiếc vòng cổ là một viên \r\nngọc trai lớn hơn một chút ở trung tâm, được bao quanh bởi một thiết kế hình mặt trời \r\nbằng kim loại màu vàng, tạo nên sự nổi bật và tinh tế.', 6, 1, 110.00, 1, 'https://product.hstatic.net/200000351153/product/c9218_web_254e67b36467494f9131fe994ca8cc74_master.jpg', '2025-06-18 09:16:14', '2025-06-18 09:16:14'),
(12, 'VCJS009', 'VÒNG CỔ ES', 5000000.00, 'Đây là một chiếc vòng cổ/dây chuyền bạc tinh xảo và duyên dáng, nổi bật với mặt dây chuyền hình chùm sao lấp lánh. \r\nMặt dây chuyền gồm ba ngôi sao, trong đó có hai ngôi sao trơn và một ngôi sao được gắn hai viên đá CZ (Cubic Zirconia) \r\nnhỏ, tạo điểm nhấn lấp lánh như những vì tinh tú. Chiếc vòng được làm từ bạc trắng, mang lại vẻ đẹp thanh lịch và hiện đại.\r\n Dây chuyền có độ dài vừa phải, phù hợp để đeo hàng ngày hoặc kết hợp với các trang phục khác nhau.', 8, 1, 150.00, 1, 'https://estelle.vn/wp-content/uploads/2023/12/5ca8fa2487be97cee631e7a5d2a008be.jpg', '2025-06-18 09:16:14', '2025-06-18 09:16:14'),
(13, 'VCJS010', 'VÒNG CỔ GRADUATED LINK', 90835150.00, 'Tiffany HardWear là biểu hiện của sức mạnh biến đổi của tình yêu. Lấy cảm hứng từ chiếc vòng tay tinh túy từ năm 1962 được tìm thấy trong kho lưu trữ của Nhà, HardWear thể hiện sự bền bỉ và tinh thần phóng khoáng. Một chuỗi mắt xích được chia độ táo bạo tạo nên một tuyên bố tuyệt đẹp.', 10, 1, 180.00, 1, 'https://media.tiffany.com/is/image/Tiffany/EcomItemL2/tiffany-hardweargraduated-link-necklace-38086898_1011104_ED.jpg?&op_usm=1.0,1.0,6.0&$cropN=0.1,0.1,0.8,0.8&defaultImage=NoImageAvailableInternal&&defaultImage=NoImageAvailableInternal', '2025-06-18 09:16:14', '2025-06-18 09:16:14'),
(14, 'VCJS011', 'VÒNG CỔ CHỮ V ', 5933700.00, 'Tỏa sáng với sự tinh giản hiện đại, vòng cổ chữ cái "V" được chế tác từ chất liệu hợp kim cao cấp mạ vàng sáng bóng, tạo nên vẻ ngoài thanh lịch và cá tính. Mặt dây là chữ cái in hoa được thiết kế nổi bật theo phong cách tối giản, nhưng vẫn mang lại dấu ấn riêng biệt cho người đeo.', 12, 1, 80.00, 1, 'https://us.pandora.net/dw/image/v2/AAVX_PRD/on/demandware.static/-/Sites-pandora-master-catalog/default/dw461700c1/productimages/NAMPS8105.jpg?sw=1500&sh=1500&sm=fit&sfrm=png&bgcolor=F5F5F5', '2025-06-18 09:16:14', '2025-06-18 09:16:14'),
(15, 'VCX009', 'VÒNG CỔ XOẮN', 899999.00, 'sợi dây chuyền bạc nguyên chất, có thiết kế dạng xoắn (dây mì hoặc dây xoắn thừng nhỏ), tạo độ lấp lánh nhẹ nhàng \r\nkhi phản chiếu ánh sáng. Dây chuyền có khóa móc tròn truyền thống, đảm bảo sự an toàn khi đeo. Với vẻ đẹp đơn \r\ngiản và tinh tế, sợi dây này phù hợp để đeo một mình hoặc kết hợp với các mặt dây chuyền khác, mang đến vẻ đẹp\r\n thanh lịch cho phái nữ.', 13, 1, 80.00, 1, 'https://vienchibao.com/wp-content/uploads/2025/05/anh-1-1.webp', '2025-06-18 09:16:14', '2025-06-18 09:16:14'),
(16, 'RRJS101', 'NHẪN LIGHTSTAR RING ', 1009000.00, 'Lightstar Ring – mang ánh sáng của những vì sao đến với bạn. Với thiết kế tinh tế và viên đá lấp lánh tựa như ngôi sao dẫn lối, chiếc nhẫn này không chỉ là một phụ kiện mà còn là biểu tượng của niềm hy vọng và sự tỏa sáng. Nhẫn Lightstar Ring hoàn hảo để bạn tự tin tỏa sáng trong mọi khoảnh khắc, từ những buổi tiệc sang trọng đến cuộc sống hàng ngày.', 1, 2, 50.00, 1, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2023/03/round-elswin-sol-1.79ct-W-3.jpg', '2025-06-18 09:21:52', '2025-06-18 09:21:52'),
(17, 'RRJS104', 'NHẪN BLUELEAF ', 5000000.00, 'Nhẫn "BlueLeaf" là sự hòa quyện tinh tế giữa thiết kế thiên nhiên và vẻ đẹp hiện đại. Chiếc nhẫn được chế tác từ bạc sáng bóng, nổi bật với hình ảnh cành lá uốn lượn mềm mại ôm trọn ngón tay. Trên đỉnh nhẫn là viên đá trắng hình vuông nhỏ nhắn, đi kèm với cụm đá xanh dương lấp lánh như những giọt sương sớm, tạo cảm giác trong trẻo và tươi mới.', 4, 2, 10.00, 1, 'https://cdn.pnj.io/images/detailed/213/sp-snztxmw060011-nhan-bac-dinh-da-disney-pnj-inside-out-2-01.png', '2025-06-18 09:21:52', '2025-06-18 09:21:52'),
(18, 'RRJS106', 'NHẪN SPIRAL ', 69700000.00, 'Spiral có kiểu dáng hình xoắn thanh lịch, tạo nên một đường cong mềm mại và duyên dáng bao quanh ngón tay. Bề mặt nhẫn được đánh bóng mịn màng, phản chiếu ánh sáng một cách tinh tế. Nhẫn có màu trắng sáng của kim loại quý, mang đến vẻ đẹp hiện đại và tinh khiết.', 7, 2, 20.00, 1, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7c616b63/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGR600ALL_RGR600_GR68124_Hero_1.jpg?sw=3000&sh=3000', '2025-06-18 09:21:52', '2025-06-18 09:21:52'),
(19, 'RRJS107', 'NHẪN BOW TIE ', 99999999.99, 'Với họa tiết nơ vui tươi đính kim cương cắt tròn và cắt baguette, chiếc nhẫn quyến rũ nắm bắt được vẻ đẹp của một chiếc nơ lụa, được thắt thủ công mới. Được tái tạo bằng những hàng kim cương lấp lánh đính trên vàng trắng, mỗi viên đá cắt baguette đã được cắt thủ công riêng để phù hợp với những đường cong tinh tế của thiết kế.', 7, 2, 15.00, 1, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dwdbd12561/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGR507_RGR507_GR47776_Hero_1.jpg?sw=3000&sh=3000', '2025-06-18 09:21:52', '2025-06-18 09:21:52'),
(20, 'RRJS111', 'NHẪN CƯỚI LIMELIGHT ', 99999999.99, 'Chiếc nhẫn cưới mang đến cảm xúc độc đáo – mãnh liệt và đầy hứa hẹn – như thể đang sống với người bạn tâm giao. Chiếc nhẫn bạch kim tinh tế và mịn màng dẫn đến sự vĩnh hằng.', 9, 2, 10.00, 1, 'https://img.piaget.com/product-light-box-1/5e26d072d28f3ff43aca5e3b427ffaf5bbe8ef34.jpg', '2025-06-18 09:23:08', '2025-06-18 09:23:08');

-- chen vao bang anh san pham
insert into `anh_san_pham` (`id_anh`, `id_san_pham`, `url_anh`) values
(1, 1, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300'),
(2, 1, 'https://www.christies.com/img/LotImages/2023/HGK/2023_HGK_22175_1921_000(diamond_necklace055032).jpg?maxwidth=1390&maxheight=1300'),
(3, 1, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7f8dfdac/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGN677_RGN677_Hero_1.jpg?sw=800&sh=800'),
(4, 1, 'https://i.pinimg.com/736x/5f/aa/88/5faa882886d6a17f3e90b372b973a774.jpg'),
(5, 1, 'https://i.pinimg.com/736x/86/12/d7/8612d79d4d15e81d2459e1af3998f077.jpg'),
(6, 2, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2022/11/2-14.png'),
(7, 2, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2022/11/1-17.png'),
(8, 2, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2022/11/3-9.png'),
(9, 2, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2023/03/round-elswin-sol-1.79ct-W-2.jpg'),
(10, 2, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2023/03/round-elswin-sol-1.79ct-W-3.jpg'),
(11, 3, 'https://i.pinimg.com/736x/2f/d3/ee/2fd3eefca43905645d9f87cabe46bfcc.jpg'),
(12, 3, 'https://i.pinimg.com/736x/15/a0/0f/15a00f23ca4d6370ec29afa2b5e30e85.jpg'),
(13, 3, 'https://www.christies.com/img/LotImages/2023/HGK/2023_HGK_22175_1921_000(diamond_necklace055032).jpg?maxwidth=1390&maxheight=1300'),
(14, 3, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7f8dfdac/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGN677_RGN677_Hero_1.jpg?sw=800&sh=800'),
(15, 3, 'https://i.pinimg.com/736x/5f/aa/88/5faa882886d6a17f3e90b372b973a774.jpg'),
(16, 4, 'https://www.christies.com/img/LotImages/2008/HGK/2008_HGK_02628_3016_000(045425).jpg?maxwidth=1390&maxheight=1300'),
(17, 4, 'https://www.christies.com/img/LotImages/2023/HGK/2023_HGK_22175_1921_000(diamond_necklace055032).jpg?maxwidth=1390&maxheight=1300'),
(18, 4, 'https://www.graff.com/dw/image/v2/BFNT_PRD/on/demandware.static/-/Sites-master-catalog/default/dw7f8dfdac/sfcc-graff-staging/i/m/a/g/e/images_hi_res_RGN677_RGN677_Hero_1.jpg?sw=800&sh=800'),
(19, 4, 'https://i.pinimg.com/736x/5f/aa/88/5faa882886d6a17f3e90b372b973a774.jpg'),
(20, 4, 'https://i.pinimg.com/736x/86/12/d7/8612d79d4d15e81d2459e1af3998f077.jpg'),
(21, 5, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2022/11/2-14.png'),
(22, 5, 'https://www.christies.com/img/LotImages/2023/HGK/2023_HGK_22175_1921_000(diamond_necklace055032).jpg?maxwidth=1390&maxheight=1300'),
(23, 5, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2022/11/3-9.png'),
(24, 5, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2023/03/round-elswin-sol-1.79ct-W-2.jpg'),
(25, 5, 'https://image.flawlessfinejewelry.com/wp-content/uploads/2023/03/round-elswin-sol-1.79ct-W-3.jpg');


insert into `bai_viet` (`id_bai_viet`, `tieu_de`, `noi_dung`, `ngay_dang`, `ngay_cap_nhat`, `id_danh_muc`, `id_nguoi_tao`, `trang_thai`) values
(1, 'Câu chuyện thương hiệu', 'Từ năm 2000 đến nay...bai_viet', '2025-05-31 17:00:00', '2025-06-20 03:05:20', 1, 1, 'draft'),
(2, 'Xu hướng 2025', 'Thiết kế phát triển hiện đại...', '2025-06-01 17:00:00', '2025-06-20 03:05:20', 1, 2, 'draft'),
(3, 'Bảo quản đá quý', 'Trang sức mang lại nhiều...', '2025-06-02 17:00:00', '2025-06-20 03:05:20', 1, 3, 'draft'),
(4, 'Tối giản quay lại ', 'Xu hướng tối giản được ưa chuộng...', '2025-06-03 17:00:00', '2025-06-20 03:05:20', 1, 2, 'draft'),
(5, 'Người sáng lập nói gì?', 'Chia sẻ từ người thành thương hiệu...', '2025-08-04 17:00:00', '2025-06-20 03:05:20', 2, 1, 'draft'),
(6, 'Mix dây chuyền', 'Phối hợp cùng sản phẩm cá tính...', '2025-06-05 17:00:00', '2025-06-20 03:05:20', 2, 2, 'draft'),
(7, 'Phân biệt đá quý', 'Tránh mua nhầm đá giả...', '2025-06-06 17:00:00', '2025-06-20 03:05:20', 2, 3, 'draft'),
(8, 'Lịch sử kim cương', 'Từ truyền thuyết đến biểu tượng quyền lực...', '2025-06-07 17:00:00', '2025-06-20 03:05:20', 2, 3, 'draft'),
(9, 'Một ngày làm việc tại cửa hàng', 'Cùng khám phá quá trình tạo sản phẩm...', '2025-08-08 17:00:00', '2025-06-20 03:05:20', 3, 1, 'draft'),
(10, 'Top vòng tay hè này', 'Xu hướng vòng tay đáng chú ý hè này...', '2025-06-09 17:00:00', '2025-06-20 03:05:20', 3, 2, 'draft'),
(11, 'Bạc bị đen? Cách xử lý!', 'Mẹo giữ trang sức luôn sáng bóng...', '2025-06-10 17:00:00', '2025-06-20 03:05:20', 3, 3, 'draft'),
(12, 'Thời trang trang sức cho nữ', 'Trang sức không chỉ dành cho nữ...', '2025-06-11 17:00:00', '2025-06-20 03:05:20', 3, 2, 'draft');


