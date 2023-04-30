CREATE DATABASE MobileToyStore;

USE mobiletoystore;

CREATE TABLE Category (
	categoryID INTEGER PRIMARY KEY AUTO_INCREMENT,
	categoryName VARCHAR(255) NOT NULL,
	image VARCHAR(255),
	status TINYINT(1)
);

CREATE TABLE Product (
	productID INTEGER PRIMARY KEY AUTO_INCREMENT,
	productName VARCHAR(255) NOT NULL,
	description TEXT,
    images CHAR(255),
    status TINYINT(1) CHECK (status = 0 OR status = 1),
    quantity INT CHECK (quantity >= 0),
    price INTEGER,
    categoryID INT REFERENCES Category(categoryID)
);

CREATE TABLE Image (
	imageID INTEGER PRIMARY KEY AUTO_INCREMENT,
	imageName VARCHAR(255) NOT NULL,
	url TEXT NOT NULL,
    productID INTEGER REFERENCES Product(productID)
);

CREATE TABLE User (
	userID INTEGER PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100),
    gender INT CHECK(gender = 0 OR gender = 1 OR gender = 2),
    birthday TIMESTAMP,
	email VARCHAR(100) UNIQUE NOT NULL,
    address VARCHAR(255),
    phone CHAR(10),
    image CHAR(255),
    role TINYINT(1) CHECK (role = 0 OR role = 1),
    status TINYINT(1) CHECK (status = 0 OR status = 1),
    username CHAR(100) UNIQUE NOT NULL,
    password TEXT NOT NULL ,
    createdAt TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP
);

CREATE TABLE Cart (
	cartID INTEGER PRIMARY KEY AUTO_INCREMENT,
    userID INTEGER REFERENCES User(userID)
);

CREATE TABLE CartItem (
	cartItemID INTEGER PRIMARY KEY AUTO_INCREMENT,
    quantity INTEGER NOT NULL CHECK (quantity >= 0),
    cartID INTEGER REFERENCES Cart(cartID),
    productID INTEGER REFERENCES Product(productID)
);

CREATE TABLE `Order` (
	orderID INTEGER PRIMARY KEY AUTO_INCREMENT,
    orderedDate TIMESTAMP NOT NULL,
    receivedDate TIMESTAMP,
    cancelledDate TIMESTAMP,
    status INTEGER,
    receiverName VARCHAR(100),
    phone CHAR(10),
    address VARCHAR(255),
    total INTEGER,
    userID INTEGER REFERENCES User(userID)
);

CREATE TABLE OrderItem (
	orderItemID INTEGER PRIMARY KEY AUTO_INCREMENT,
    quantity INTEGER CHECK (quantity > 0),
    price INTEGER,
    orderID INTEGER REFERENCES `Order`(orderID),
    productID INTEGER REFERENCES Product(productID)
);

CREATE TABLE Review (
	reviewID INTEGER PRIMARY KEY AUTO_INCREMENT,
    star INTEGER CHECK (star >= 1 AND star <= 5),
    comment VARCHAR(255),
    images CHAR(255), 
    createdAt TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP,
    userID INTEGER REFERENCES User(userID),
    productID INTEGER REFERENCES Product(productID),
    orderItemID INTEGER REFERENCES OrderItem(orderItemID)
);

INSERT INTO Category(categoryName, image, status) VALUES
("Lắp ghép", "/images/category/Đồ chơi lắp ghép.jpg", 1),
("Sáng tạo", "/images/category/Đồ chơi sáng tạo.jpg", 1),
("Thú bông", "/images/category/Đồ chơi thú bông.jpg", 1),
("Đồ dùng học tập", "/images/category/Đồ dùng học tập.jpg", 1),
("Robot", "/images/category/Đồ chơi robot.jpg", 1),
("Búp bê", "/images/category/Đồ chơi búp bê.jpg", 1),
("Mô phỏng", "/images/category/Đồ chơi mô phỏng.jpg", 1);

-- Users
INSERT INTO User(firstname, lastname, gender, birthday, email, address, phone, image, role, status, username, password, createdAt, updatedAt) 
VALUES
("Hà", "Nguyễn", 1, "1998-02-14", "hanguyen98@gmail.com", "28 Lý Thường Kiệt, Hải Châu, Đà Nẵng", "0905028763", "/images/profile/A1.jpg", 0, 1, "hanguyen98", "392eb199d680ada0135ee1129834bd020f81643f0ed117795790e27be27fd96fb4aa1c5bd0f8a44e1966f89f54e1c3549ca0a57d5da29debd5b6950227732f83", "2021-03-22", "2021-03-22"),

("Vân", "Trần", 1, "1999-05-28", "vantran99@gmail.com", "61 Đồng Khởi, Nha Trang, Khánh Hòa", "0901357908", "/images/profile/A2.jpg", 0, 1, "vantran99", "60b9f7cb403031c06feb4db2ccc21f98d58da4cddebe7e9f79286a33f32a3e0a68420f0c7c79ed1c4ed40c19d6fdd4b338ec70190264ce48617f0bfb988c8246", "2022-02-10", null),

("Trung", "Phạm", 0, "2000-09-01", "trungpham00@gmail.com", "54 Trần Hưng Đạo, Hội An, Quảng Nam", "0935880164", "/images/profile/A3.jpg", 0, 1, "trungpham00", "1904eebe59eebc84c7fadf175940868bb9000c09241bdf3949cab1d3f5e5da0535d7ae6c6249c8ddff7fa50c8a173d8a9a41297b3fe040cfab6cf3e6b7d9ab0c", "2022-09-15", null),

("Hùng", "Lương", 0, "1995-07-07", "hungluong95@gmail.com", "85 Nguyễn Huệ, Vinh, Nghệ An", "0976116352", "/images/profile/A4.jpg", 1, 1, "hungluong95", "94a438112005698a4e9f193af723fd73fa78074bd7c8eefc8043e8d1a384bdb00adf51af71b886b4bf8e8611b419e80bb3a5c6a7da402c65dcc44eab52bf6f77", "2021-10-20", null),

('Nguyễn', 'Thị Hương', 1, '1990-01-01', 'nguyenhuong@gmail.com', 'Số 12, ngõ 34, đường Trần Thái Tông, P. Dịch Vọng Hậu, Cầu Giấy, Hà Nội', '0971234567', '/images/profile/A5.jpg', 1, 1, 'nguyenhuong', 'e4caacec868c400b0a17ece3986dffc1437339c28af87142ce7d61be8415c15075f24f89b69590204ca09f269143a926c768d8f6c9570177a87ea89af63dc8f7', '2022-05-01', '2023-01-01'),

('Phạm', 'Hữu Đông', 0, '1993-03-14', 'phamhuudong@gmail.com', 'Số 456, đường Điện Biên Phủ, P. 22, Q. Bình Thạnh, TP. Hồ Chí Minh', '0903456789', '/images/profile/A6.jpg', 1, 1, 'phamhuudong', '73c8b304ed4bb88a8c11ffbc6b8d28e0de07611b5e434d5bfa644dce8adf47e6689ed66cb6e6c949af0d5efc39402004faf9e926a150c82b56ec60b5e473042a', '2022-03-17', '2022-05-25'),

('Trần', 'Văn Tuấn', 0, '1995-05-01', 'tranvantuan@gmail.com', 'Số 23, ngõ 56, đường Lạc Long Quân, P. Phú Thượng, Q. Tây Hồ, Hà Nội', '0912345678', '/images/profile/A7.jpg', 1, 1, 'tranvantuan', 'af7d903026c7506ed4e26d8af571249402d72214729945616f7e5e6c9eb3276433c6f548dd9dbdf8fc4d07b361f1ee6bc422709d0a74ecf48249ca639979fee1', '2020-11-11', '2022-01-01'),

("Tú", "Lê", 0, "1999-10-15", "tule1234@gmail.com", "221, Phạm Văn Đồng, Hiệp Bình Chánh, TP. Thủ Đức, TP. Hồ Chí Minh", "0397845621", "/images/profile/A8.jpg", 1, 1, "tule1234", "f5f39b3c07ba973fc1e497a3e4dac08111901e2a12baba67aa0edb8cdf96033cc6b19463a18a076f6cbe24f30398404db47e12b06a1ea7a35eedbca2f757ae9c", 
"2020-05-10", null),

("Thuý Hạnh", "Trần", 1, "1987-03-10", "thuyhanh@gmail.com", "26 Ung Văn Khiêm, Phường 25, Bình Thạnh, TP. Hồ Chí Minh", "0789512542", "/images/profile/A9.jpg", 1, 1, "thuyhanhcute", "02ead583a00e05cfcab3ff32ccad99c25aefed11b30cb6ff16f548e071982e5b8d8a22e048793b75aa60987811a7b68fda2e6ecbac5a0196feb454a8f94ce041", 
"2022-02-10", null),

("Anh", "Phan", 0, "1987-03-21", "anhphan.1987@gmail.com", "142 Lê Văn Việt, TP. Thủ Đức, TP. Hồ Chí Minh", "0987541265", "/images/profile/A10.jpg", 1, 1, "anhhs12", "9e5f7c2f05f2db8366fafbd96d4f16e1f7bb806ac2d381987bf84f83b770d0337348a30e54b42d46175a1faf3dc37ca662f99901d26047783cede4f77bf515a8", 
"2021-01-23", "2021-02-10"),

("Văn Thuận", "Nguyễn", 0, "2002-12-10", "vanthuan2004@gmail.com", "An Lạc 1, Mỹ Hoà, Phù Mỹ, Bình Định", "0397252681", "/images/profile/A11.jpg", 1, 1, "vanthuan2004", "5bf9e1489092a2903744acf576b53086db03eede48c041722a79277bc409e236a761f752091fee2d2d85bb5a914df7c361cf4aeec6a4699934d0ffe5d4c0aa80", 
"2020-05-10", "2020-05-10"),

("Tâm", "Phạm", 1, "2000-05-05", "phamthitam0505@gmail.com", "08, đường 10, tổ 5, ấp 4A, Bình Mỹ, Củ Chi, TP. Hồ Chí Minh", "0384516541", 
"/images/profile/A12.jpg", 1, 0, "phamtam0505", "6eccf42038175456929bc3563c76ca5b60c0ea7d003db328332b1f9206f3a3ebb90210154615c1fc28c7e1aea1e55b9c470fba39fc3e3b3ea960064adb1f97a8", 
"2022-07-01", "2023-01-10"),

("Trang", "Lương", 1, "2001-03-22", "trangluong2001@gmail.com", "173 Nguyễn Văn Linh, Phường 12, Quận Gò Vấp, TP. Hồ Chí Minh", "0906214211", "/images/profile/A13.jpg", 1, 0,"trangluong2001", "09f5fb5bfc88b52fc69c36d92b0f2695ce89f5bc5d5c5ba53a775a85c7000c22e88055deba37fb3a1806660b2b03d0c1a3b84060a2c2342e73f0d83db3df7066", "2020-07-18", "2022-03-21"),

("Trung", "Hồ", 0, "1994-09-03", "trungho1994@gmail.com", "Tòa nhà Hancorp, 72 Trần Đại Nghĩa, Thanh Xuân, Hà Nội", "0912345678", "/images/profile/A14.jpg", 1, 1, "trungho1994","8a9155dc80b860a04c545e9c2b0ef28959168b663cc696f8e24c62f539a34191d98c6c47ca9081554eb05b752c576b3cc5cbb3cd382db9f48a92b12d751d77a6", "2020-01-01", null),

("Nga", "Đặng", 1, "1997-08-18", "ngadang97@gmail.com", "42 Lê Trọng Tấn, Phường Khương Mai, Thanh Xuân, Hà Nội", "0945678910", "/images/profile/A15.jpg", 1, 1, "ngadang97", "101913ee2061e969103411d801fb2a112c54fc85201afa86f8605c5847074c181b4734973bdf79a55b510b10c2e8a71e9687b6a37bb543d24f0169e548d3d194", "2020-11-15", "2020-11-15"),

("Hoa", "Nguyễn", 1, "1995-08-20", "hoa.nguyen95@gmail.com", "123/45 Trần Hưng Đạo, Quận 1, TP.HCM", "0912345678", "/images/profile/A16.jpg", 1, 1, "hoanguyen95", "2f9897ef7865d703ba570c78b978f675e1a751480e6dca32bb86806dd3638ebc9d21641b214ab09725d48c1402b950b91175fd4a220e2dc28f8754606438d354", "2022-01-01", null),

("Hùng", "Lê", 0, "1994-06-11", "hung.le94@gmail.com", "156/6 Tôn Thất Thuyết, Quận 4, TP.HCM", "0987654321", "/images/profile/A17.jpg", 1, 1, "hungle94", "496a60f6e240287c11be3db9165abcde01b0b080934efeea7713573cebf4f1086374fffa89472444f21bfc26dea8af534a2771a9c0b3cb31cf321c4bbfbcb850", "2023-01-11", "2023-01-12"),

("Minh", "Đặng", 0, "1998-12-25", "minh.dang98@gmail.com", "123 Hoàng Diệu, Quận 3, TP.HCM", "0918765432", "/images/profile/A18.jpg", 1, 1, "minhdang98", "5b8cf36e441c98737388820ff22bdf7d4e6071f9dfcfdea41d46293e9687ae088d049f7a6290e4ce388fae37341c92128881fc61b77ad0f03b38e2daf461eb6a", "2020-05-15", "2022-01-01"),

("Hải", "Trần", 0, "2000-02-18", "haitran00@gmail.com", "123 Nguyễn Thái Học, Quận 5, TP.HCM", "0901234567", "/images/profile/A19.jpg", 1, 1, "haitran00", "b146c3c02a6b271e4e6cae8db860b2307df6c5bc285b2641c48ffd7643a2185465c2cda978032605db98d154767e3b8db5ef6ca75fd39575dee183715fa174f1", "2022-07-01", null),

("Thu", "Ngô", 1, "1996-11-02", "thu.ngo96@gmail.com", "789 Phạm Văn Đồng, Quận Thủ Đức, TP.HCM", "0909876543", "/images/profile/A20.jpg", 1, 1, "thungo96", "d8f1a33c2c156a50d2c309eb47aa82b1b08b6947c2bce836f3289af8f6745ba02b97c22dccc964ce12f25c0a06e5cc543a019dcfd820cfab64530befe40f1e21", "2023-02-17", "2023-02-17"),

("Tuấn", "Trịnh", 0, "1997-09-13", "tuan.trinh97@gmail.com", "456 Lê Văn Việt, Quận 9, TP.HCM", "0987123456", "/images/profile/A21.jpg", 1, 0, "tuantrinh97", "d4a006cea3943dabfde0ce60dcfca4d3cf1290785662e86ce1e116e6f8bea25ec0419d9353403b37610cf128f90a5427dcfd63cc6291b741552721283775cd56", "2022-09-14", "2022-09-14"),

("Trung", "Nguyễn", 1, "1995-07-21", "trungnguyen@gmail.com", "123 Trần Phú, Phường 4, Đà Lạt, Lâm Đồng", "0987654321",  "/images/profile/A22.jpg", 1, 1, "trungnguyen", "1522e8bdc7ce6ce575571c51fd1cd6cdbd26192fab0409ab870e538a2cf0361722547075eb1f3793bf160b3d12a77ee13ce2e71d036f51ccf7fa1e15529fee77", "2020-06-20", "2020-06-20"),

("Thu", "Phạm", 1, "1996-05-15", "thupham@gmail.com", "18 Lê Duẩn, Hải Châu, Đà Nẵng", "0987654321", "/images/profile/A23.jpg", 1, 1, "thupham", "1af4f50c7f1f35541682748318e4368c215c9a9c0a397c330d96ff528106e9ca1388f084cbb6fc654084d4f28239ead58586af72971c392251142b7703fa078f", "2021-08-20", "2021-08-20"),

("Linh", "Đỗ", 1, "1993-03-20", "linhdo@gmail.com", "43 Trần Phú, Lộc Hòa, Bảo Lộc, Lâm Đồng", "0987654321", "/images/profile/A24.jpg", 1, 1, "linhdo", "e33ec6174a67f3c27c74770d6147d8512744af6a66e6c4a3d2b37d24d0d8d14f836b15ca4430ada2663d9ff2af3af5d2cdf1fcd3c37fc51737b7fbcc7ea6238d", "2020-08-20", "2020-08-20"),

("Huyền", "Phan", 1, "1994-01-30", "huyenphan@gmail.com", "16 Mai Thúc Loan, Lê Chân, Hải Phòng", "0987654321", "/images/profile/A25.jpg", 1, 1, "huyenphan", "793fd473d4ff1d78405f78f5ceeaa65cab46678b97b269974ba6b9f295632a53e549f6014b5e25a5b0d28930bbb5e2e6f3d20d6a10fe50cc1dce2ab78535919d", "2022-04-11", "2022-04-11");

-- Products
-- Lắp ghép
INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Kì nghỉ cắm trại cùng Autumn & Aliya"
, "Sẵn sàng đi cắm trại với Autumn và Aliya chưa? Cùng lái xe đi tìm điểm cắm trại hoàn hảo trong khu rừng của Thành phố Heartlake. Chụp ảnh những chú bướm quý hiếm bằng máy ảnh. Sắp xếp lều trại sẵn sàng cho buổi tối. Thưởng thức món kẹo dẻo nướng trên lửa trại . Sau đó leo vào trong xe cắm trại cho một giấc ngủ ấm cúng.
• Bộ mô hình cắm trại dành cho trẻ em từ 4 tuổi trở lên – Mang trẻ em đến với thế giới mô hình của LEGO® qua bộ lắp ráp LEGO Friends Kỳ Nghỉ Cắm Trại Cùng Autumn và Aliya (41726) này, có xe cắm trại với ô tô có thể gắn vào nhau
• Bao gồm 2 nhân vậth nhỏ – Món quà cắm trại thú vị này đi kèm với 2 nhân vật LEGO® Friends, Autumn yêu thiên nhiên và cô gái thành thị Aliya, đồng thời bao gồm một xe cắm trại lắp ráp với mái che có thể tháo rời
• Khuyến khích sáng tạo – Bộ cắm trại LEGO® Friends này đi kèm với các phụ kiện bao gồm máy ảnh, lửa trại và kẹo dẻo, vì vậy trẻ em có thể sáng tạo các câu chuyện khác nhau mỗi khi chơi"
, "/images/product/Kì nghỉ cắm trại cùng Autumn & Aliya_1_1.jpg", 1, 50, 662000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ cờ Nhà Hufflepuff"
, "Trẻ em có thể thể hiện màu sắc thật của mình với Mô hình Ngôi nhà LEGO® Harry Potter™ Hufflepuff (76412) này. 
Mô hình có một viên gạch in hình huy hiệu Hufflepuff và một móc treo để trưng bày nó trên tường. Biểu ngữ xây bằng gạch mở ra để lộ bản tái tạo chi tiết của phòng sinh hoạt chung Hufflepuff đầy cây cối với Hufflepuff's Cup, một quả bí ngô, một cái rương có thể xây dựng được và một chiếc bàn có các loại thực phẩm trên mặt bàn. Một tấm ván sau dạng thấu kính trượt vào tạo ra các hiệu ứng 3D kỳ diệu như Mandrake bật lên và hạ xuống phía sau bức màn và Niffler ăn cắp tiền từ phía sau thùng. 
Bộ này cũng bao gồm các nhân vật nhỏ của Cedric Diggory, Susan Bones và Hannah Abbott với các phụ kiện. Dễ dàng vận chuyển Được thiết kế để dễ dàng cất giữ và mang theo, bộ đồ chơi này là một món quà tuyệt vời dành cho trẻ em từ 9 tuổi trở lên và là 1 trong 4 biểu ngữ nhà Hogwarts™ có thể sưu tầm được. LEGO Builder Trẻ em có thể tận hưởng chuyến phiêu lưu xây dựng trực quan với ứng dụng LEGO Builder. Tại đây, họ có thể phóng to và xoay các mô hình ở chế độ 3D, lưu các bộ và theo dõi tiến trình của chúng."
, "/images/product/Bộ cờ Nhà Hufflepuff_2_1.jpg", 1, 40, 1099000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Ngôi Nhà Bóng Bay UP"
, "Tất cả chuẩn bị nào, đã đến lúc phiêu lưu! Tham gia cùng Carl và Russell khi họ đến thăm những địa điểm bí ẩn cùng bộ LEGO® thú vị này. Lắp ráp ngôi nhà độc quyền của Disney và Pixar từ Bộ phim Up, thả bóng bay lên ống khói và đi đến nơi gió đưa bạn đến. Khám phá các căn phòng với Russell, kê giường cho Dug và lắng nghe những câu chuyện của Carl khi bạn lênh đênh trên biển. Sau khi hạ cánh, hãy sắp xếp ba lô của bạn và đi khám phá!
• Niềm đam mê bất tận – Hãy mang đến món quà người hâm mộ điện ảnh hoặc bất kỳ đứa trẻ nào thích những cuộc phiêu lưu bay bổng bằng một món quà thú vị để khơi dậy trí tưởng tượng với bộ LEGO® ǀ Disney and Pixar Ngôi Nhà Bóng Bay UP (43217) này
• Sự sáng tạo vô tận – Bộ 598 chi tiết này bao gồm một phần ngôi nhà được nâng lên bằng bóng bay, các căn phòng khác nhau, 2 mô hình nhân vật, hình động vật LEGO® và nhiều phụ kiện đi kèm
• Các nhân vật được yêu thích – Với các mô hình nhỏ Carl Fredricksen và Russell LEGO® của Disney và Pixar, cùng với hình chú chó Dug LEGO, bộ sản phẩm được tạo ra cho những cuộc phiêu lưu không giới hạn trên đất liền hoặc lơ lửng trên mây"
, "/images/product/Ngôi Nhà Bóng Bay UP_3_1.jpg", 1, 30, 1779000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Cuộc Rượt Đuổi Phi Cơ Chiến Đấu"
, "Tái hiện lại một phân cảnh thú vị từ bộ phim Indiana Jones và Cuộc thập tự chinh cuối cùng. Indiana Jones™ và cha của anh ấy - Giáo sư Henry Jones Sr.™ đã trưng dụng một chiếc ô tô mui trần cổ điển và đang bị một chiếc máy bay chiến đấu truy đuổi trên không trung. Hãy cẩn thận khi chiếc máy bay xả đạn trước khi hạ cánh và phải đuổi theo Indy qua một đường hầm mà máy bay không bay qua được. Bạn cần phải giúp Indy và Henry trốn thoát!
• Bộ mô hình máy bay và ô tô Indiana Jones™ – Có tất cả những gì bạn cần để tái hiện lại hành động từ bộ phim Indiana Jones và Cuộc thập tự chinh cuối cùng với bộ đồ chơi LEGO® Cuộc Rượt Đuổi Phi Cơ Chiến Đấu (77012) này
• 3 mô hình nhân vật – Bao gồm Indiana Jones™ với cây roi đặc trưng và cha của anh ấy - Giáo sư Henry Jones Sr.™, đang cầm một cuốn nhật ký, ngồi trong chiếc ô tô, cùng với một phi công chiến đấu lái chiếc máy bay để săn lùng Indy
• Đầy đủ các tính năng – Máy bay chiến đấu có một cánh quạt, 2 ống ngắm và cánh có thể tháo rời; chiếc xe mui trần cổ điển bao gồm một cái rương ở phía sau chứa một chiếc ô và một khẩu súng lục."
, "/images/product/Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_1.jpg", 1, 50, 1159000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Nhân Vật LEGO Số 24"
, "Thỏa sức tưởng tượng tất cả những cuộc phiêu lưu mà bạn có thể thực hiện với Nhân Vật LEGO® Số 24! Có 12 nhân vật, bao gồm Trọng tài bóng đá, Người hóa trang Khủng Long T-Rex và Potter, và mỗi nhân vật đều có một phụ kiện thú vị đi kèm. Điểm thêm những nhân vật thú vị vào bộ sưu tập của bạn, bạn có thể trưng bày chúng hoặc thêm vào bộ mô hình hiện có để thêm phần thú vị. Bạn sẽ tìm thấy gì trong chiếc túi bí ẩn LEGO?
• Nhân vật bất ngờ – bé có thể bước vào thế giới phiêu lưu bất tận với các nhân vật LEGO® số 24 (71037) này. Có một nhân vật nhỏ bất ngờ trong mỗi chiếc túi được bọc kín.
• Mô hình nhân vật đáng để sưu tập – Người hâm mộ LEGO® có thể lắp ráp bộ sưu tập của mình với 1 trong 12 nhân vật từ bộ trong mỗi túi, kèm theo ít nhất một phụ kiện và thông tin nhân vật của người sưu tập
• Cuộc chơi sáng tạo không ngừng – Bộ mô hình nhỏ này khuyến khích bé từ 5 tuổi trở lên sử dụng trí tưởng tượng của mình để tự mình hoặc chơi với bạn bè những câu chuyện đầy hành động"
, "/images/product/Nhân Vật LEGO Số 24_5_1.jpg", 1, 70, 129000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Phòng Ngủ Của Leo"
, "Cùng làm quen với Leo khi đến thăm phòng của anh ấy. Anh ấy đã mời Olly đến quay nội dung mới cho kênh làm bánh của anh ấy. Nướng bánh trong phòng ngủ của Leo. Sử dụng chú cá mô hình để ngăn chú mèo Churro không phá phách. Sau khi quay phim xong, hãy thư giãn trên ban công hoặc tập đá bóng với khung thành dựng sẵn bên ngoài. Giả vờ thử ăn bánh – nếu Churro không ăn vụng trước!
• Bộ Phòng Ngủ Của Leo dành cho trẻ em từ 6 tuổi trở lên – Bé có thể tưởng tượng ra những câu chuyện sáng tạo với bộ đồ chơi này (41754) Phòng Ngủ Của Leo
• Bao gồm 2 nhân vật nhỏ – Bộ đồ chơi đi kèm với nhân vật LEGO® Friends Leo và Olly cùng với chú mèo Churro
• Các chi tiết theo chủ đề bãi biển – Ngôi nhà của Leo nằm cạnh Bãi biển Harmony ở Thành phố Heartlake, vì vậy có những phụ kiện theo chủ đề bãi biển thú vị để trang trí trong phòng ngủ"
, "/images/product/Phòng Ngủ Của Leo_6_1.jpg", 1, 20, 619000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Lâu Đài Công Chúa Bella"
, "Lắp ráp Lâu đài Disney cho nhân vật Công chúa Disney mà bạn yêu thích! Bộ LEGO® ǀ Disney cổ tích này cho phép bạn lắp ráp lâu đài nhỏ cho Công chúa Belle hoặc Cinderella và những người bạn của họ là Lumiere và Gus, sau đó kết hợp chúng lại với nhau để tạo nên những cặp đôi hoàn hảo. Thiết kế lâu đài cho cả hai nhân vật Công chúa hoặc nghĩ ra một thiết kế khác được lắp ráp từ trí tưởng tượng của bạn. Không có giới hạn – chỉ có tưởng tượng của bạn!
• Niềm vui không giới hạn – Tặng một người hâm mộ Công chúa Disney hoặc những bé gái yêu thích lâu đài, một món quà đầy niềm vui và cảm hứng với bộ LEGO® ǀ Disney Lâu đài của công chúa Bella (43219) này
• Niềm vui trong chiếc hộp – Bộ này bao gồm 2 hình búp bê nhỏ LEGO®, 2 hình LEGO, các phụ kiện để sáng tạo trò chơi và các chi tiết để xây dựng lâu đài cho mỗi nhân vật, một lâu đài tuyệt mỹ hoặc sáng tạo độc đáo của bé
• Các nhân vật được yêu thích – Có Công chúa Disney Belle và Cô bé Lọ Lem, cùng với các nhân vật LEGO® của Gus và Lumiere, bộ sản phẩm được thiết kế cho những cuộc phiêu lưu và sáng tạo bất tận
 thú vị để trang trí trong phòng ngủ"
, "/images/product/Lâu Đài Công Chúa Bella_7_1.jpg", 1, 40, 1099000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Xe Đua Nascar Chevrolet Camaro ZL1"
, "Sẵn sàng chưa? Đã đến lúc trở thành nhà vô địch NASCAR® với LEGO® Technic™ Xe Đua NASCAR Chevrolet Camaro ZL1. Đưa tình yêu của bạn dành cho môn đua xe thể thao lên một tầm cao mới khi bạn lắp ráp phiên bản Chevrolet Camaro thế hệ tiếp theo NASCAR đích thực của riêng mình. Khám phá các tính năng của nó như hệ thống lái, mui xe mở và động cơ V8 với các pít-tông chuyển động. Cuối cùng, mô hình trông rất tuyệt khi được trưng bày.
• Bộ sưu tập NASCAR® – Trẻ em từ 9 tuổi trở lên yêu thích xe đua có rất nhiều niềm vui khi lắp ráp và khám phá bộ đồ chơi LEGO® Technic™ Xe Đua NASCAR Chevrolet Camaro ZL1 (42153) này
• Rất nhiều tính năng để khám phá – Bộ mô hình Chevy Camaro này có hệ thống lái, mui xe mở và động cơ V8 với các pít-tông chuyển động, mang đến cho trẻ nhiều điều để khám phá sau khi mô hình được hoàn thiện
• Quà tặng dành cho người hâm mộ NASCAR® – Bộ đồ chơi LEGO® Technic™ này là ý tưởng quà tặng sinh nhật hoặc bất cứ lúc nào cho trẻ em và người lớn yêu thích sưu tầm NASCAR và đua xe thể thao"
, "/images/product/Xe Đua Nascar Chevrolet Camaro ZL1_8_1.jpg", 1, 60, 1639000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Ngôi Nhà Tổ Chim"
, "Cùng làm quen với Leo khi đến thăm phòng của anh ấy. Anh ấy đã mời Olly đến quay nội dung mới cho kênh làm bánh của anh ấy. Nướng bánh trong phòng ngủ của Leo. Sử dụng chú cá mô hình để ngăn chú mèo Churro không phá phách. Sau khi quay phim xong, hãy thư giãn trên ban công hoặc tập đá bóng với khung thành dựng sẵn bên ngoài. Giả vờ thử ăn bánh – nếu Churro không ăn vụng trước!
• Bộ Phòng Ngủ Của Leo dành cho trẻ em từ 6 tuổi trở lên – Bé có thể tưởng tượng ra những câu chuyện sáng tạo với bộ đồ chơi này (41754) Phòng Ngủ Của Leo
• Bao gồm 2 nhân vật nhỏ – Bộ đồ chơi đi kèm với nhân vật LEGO® Friends Leo và Olly cùng với chú mèo Churro
• Các chi tiết theo chủ đề bãi biển – Ngôi nhà của Leo nằm cạnh Bãi biển Harmony ở Thành phố Heartlake, vì vậy có những phụ kiện theo chủ đề bãi biển thú vị để trang trí trong phòng ngủVui chơi ngoài trời để tạo ra những câu chuyện mê hoặc với những động vật đáng yêu. Hãy xem năm chú chim xinh đẹp chơi đùa trong tổ chim ấn tượng của riêng chúng ở trên cùng của giá đỡ và ngồi trên sào. Sau đó, hãy lắp ráp lại nó thành một con nhím và một con sóc đang đi chơi cùng nhau trên băng ghế công viên, hay một tổ ong với 4 chú ong và tổ ong. Sự lựa chọn là của bạn với bộ sản phẩm 3 trong 1 tuyệt vời này.
• Đồ chơi 3 trong 1 – Người hâm mộ LEGO® có thể sáng tạo những câu chuyện thú vị về động vật với LEGO Creator 3 trong 1 Ngôi Nhà Tổ Chim (31143), gồm 3 cảnh trong 1: chuồng chim, động vật ở băng ghế công viên và tổ ong
• Vô số cách để chơi – Trẻ có thể chọn chơi với 5 chú chim đồ chơi ở chuồng chim trên giá đỡ, một chú nhím và một chú sóc trên băng ghế công viên hoặc 4 chú ong vo ve quanh tổ ong
• Các loài chim đặc biệt – Nhà chim có 5 loài chim đồ chơi đầy màu sắc: chim bạc má xanh Á-Âu, chim hồng y phương bắc, chim sẻ vàng đuôi sọc, chim sẻ xanh châu Âu và chim sẻ nhà"
, "/images/product/Ngôi Nhà Tổ Chim_9_1.jpg", 1, 40, 999000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Kỳ Lân Sắc Màu"
, "Du hành đến một vùng đất thần thoại xa xôi để vui chơi với những sinh vật huyền bí. Hãy xem chú Kỳ lân ma thuật với chiếc sừng vàng băng qua cầu vồng. Để tạo nên những câu chuyện hấp dẫn hơn nữa, bạn có thể lắp ráp lại mô hình thành một con cá ngựa bơi dưới đáy biển hoặc biến nó thành một chú công dễ thương với chiếc đuôi đầy lông sặc sỡ.Sự lựa chọn là của bạn với bộ mô hình 3 trong 1 này.
• 3 sinh vật huyền bí trong 1 bộ – Các bé nhỏ có thể lắp ráp 3 mô hình nhiều màu sắc khác nhau với bộ đồ chơi LEGO® Creator 3 trong 1 Kỳ Lân Sắc Màu (31140) này
• Khoảnh khắc vui chơi dài lâu – Trẻ em có thể tưởng tượng những câu chuyện thú vị với 3 bối cảnh khác nhau ở vùng đất thần thoại: băng qua cầu vồng với Kỳ lân thần kỳ, bơi cùng cá ngựa hoặc đắm chìm trong vẻ đẹp với công
• Mô hình sáng tạo – Mỗi sinh vật trong số 3 sinh vật đều có các bộ phận cơ thể có thể tạo được: kỳ lân có thể di chuyển chân và móng guốc; cá ngựa cử động đuôi, vây và đầu; và công có đuôi và mắt có thể cử động được"
, "/images/product/Kỳ Lân Sắc Màu_10_1.jpg", 1, 30, 216000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Tàu Con Thoi Vũ Trụ"
, "Tận hưởng những cuộc phiêu lưu kỳ thú giữa các thiên hà với 3 đồ chơi không gian LEGO® khác nhau trong 1 bộ trò chơi. Phóng lên quỹ đạo bằng Tàu con thoi và vệ tinh có thể mở rộng. Sau đó, xây dựng lại nó thành một phi hành gia với tay và chân có thể cử động được – sẵn sàng chinh phục các hành tinh – hoặc xây dựng lại nó thành một con tàu vũ trụ siêu ngầu với đôi cánh đang di chuyển. Việc du hành giữa các vì sao vô tận là chuyện nhỏ với bộ đồ chơi 3 trong 1 tuyệt vời này.
• Đồ chơi 3 trong 1 – Những người hâm mộ trò chơi ngoài không gian có thể tận hưởng chuyến du hành giữa các thiên hà với bộ đồ chơi LEGO® Creator Tàu Con Thoi Vũ Trụ 3 trong 1 (31134), bao gồm Tàu con thoi, phi hành gia và tàu vũ trụ
• Vô số tùy chọn chơi – bé yêu có thể chọn chơi hành động với đồ chơi Tàu con thoi, hình đồ chơi phi hành gia với tay và chân có thể điều chỉnh được và tàu vũ trụ siêu ngầu
• Được đóng gói với các phụ kiện – Tàu con thoi có một cửa sập mở chứa một vệ tinh có thể tháo rời và nhân vật phi hành gia có một bộ phản lực và một lá cờ để cắm trên giá đỡ"
, "/images/product/Tàu Con Thoi Vũ Trụ_11_1.jpg", 1, 70, 216000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Gạch Sáng Tạo Pixel"
, "Khơi dậy niềm đam mê nghệ thuật và thiết kế của bé với 1.000 viên gạch LEGO® có màu sắc rực rỡ và vô số ý tưởng và cảm hứng! Từ những công trình xây dựng nhanh đến những dự án đầy thử thách hơn, bộ sản phẩm này mang đến niềm vui không giới hạn với đầy đủ màu sắc. Nó thậm chí còn bao gồm một tạp chí chứa đầy các hướng dẫn và đề xuất xây dựng dành cho nhà thiết kế bé bỏng của bạn.
• Bộ gạch đầy màu sắc – LEGO® Bộ Gạch Sáng Tạo Pixel (11030) tràn ngập ý tưởng, nguồn cảm hứng và tất nhiên là cả gạch dành cho các nhà thiết kế nhí từ 5 tuổi trở lên
• Mang đến giá trị giáo dục – Bộ bao gồm 1.000 viên gạch với 10 màu sắc tươi sáng, cùng với một cuốn tạp chí chứa đầy các hướng dẫn và đề xuất xây dựng
• Khả năng sáng tạo vô tận – Cùng với việc xây dựng bất cứ thứ gì mà chúng có thể tưởng tượng, trẻ em có thể sử dụng các hướng dẫn được in sẵn để xây dựng một chiếc ô tô, quả địa cầu, bông hoa, cây đàn ghi ta, ngôi nhà, biểu tượng cảm xúc mặt cười, con vẹt và nhiều mô hình vui nhộn khác
• Món quà lâu dài cho trẻ em – Món quà sinh nhật, ngày lễ hoặc bất kỳ ngày nào này sẽ mang đến nhiều năm niềm vui sáng tạo cho bất kỳ đứa trẻ nào từ 5 tuổi trở lên"
, "/images/product/Bộ Gạch Sáng Tạo Pixel_12_1.jpg", 0, 40, 1939000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đoàn Tàu Rau Củ Hữu Cơ"
, "Dạy bé yêu chăm sóc trang trại cùng bộ trò chơi LEGO DUPLO Đoàn Tàu Rau Củ Hữu Cơ. Các bé có thể học kỹ năng gieo trồng khi xây dựng các loại cây để chúng lớn lên và vui chơi bằng cách ghép thức ăn với xe kéo có màu sắc chính xác.
• Trò chơi nông trại dành cho bé yêu ham học hỏi– LEGO® DUPLO®Đoàn Tàu Rau Củ Hữu Cơ (10982) giúp bé phát triển các kỹ năng vận động và dạy trẻ về quá trình cây cối lớn lên
• Đồ chơi thú vị cho bé mầm non – Đi kèm với xe kéo có thể lái được là 3 chiếc xe kéo đồ chơi có màu sắc khác nhau, gạch để xếp bông cải xanh, cà chua và dứa, cùng với hình người nông dân.
• Đồ chơi giúp trẻ vui học – Bé yêu sẽ tham gia cùng người nông dân thu hoạch trái cây và rau quả bằng chiếc máy kéo linh hoạt của mình, sau đó phân loại trái cây và rau củ lên xe kéo đầy màu sắc.
• Quà tặng cho các bé yêu thích đồ chơi nông trại – Bộ trò chơi này chắc chắn sẽ là món quà đỉnh nhất dành cho những nông dân nhí từ 18 tháng tuổi trở lên trong các dịp sinh nhật, dịp đặc biệt hoặc bất cứ lúc nào"
, "/images/product/Đoàn Tàu Rau Củ Hữu Cơ_13_1.jpg", 1, 50, 433000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Trụ Sở Chính Của Người Nhện"
, "Rhino đang tấn công cửa hàng tạp hóa bằng những trái trứng. Hắn thậm chí còn kéo cửa sổ ra để ném trứng tung tóe vào bên trong! Người Nhện và những người bạn của anh ấy phải nhanh chóng ứng cứu thôi. Người Nhện và Ghosty nhảy vào buồng lái của trụ sở di động trong khi Miles và Chiến Binh Báo Đen lái xe của họ qua phía sau. Khi họ đến nơi, cả nhóm lao ra khỏi trụ sở di động và giăng lưới tấn công Rhino. Nhưng hắn ta đã chống trả bằng cách ném thức ăn ở cửa hàng tạp hóa!
• Siêu anh hùng hành động – LEGO® Marvel Trụ Sở Chính Của Người Nhện (10791) bao gồm các minifigures của Siêu anh hùng và siêu xe dành cho trẻ em từ 4 tuổi trở lên
• Các nhân vật mang tính biểu tượng – Bao gồm các minifigures Người Nhện, Miles Morales, Ghost-Spider, Chiến binh Báo Đen và Rhino, cùng với một trụ sở di động có thể xây dựng cho Người nhện và những người bạn của mình.
• Di chuyển linh hoạt – Bộ trò chơi với rất nhiều phương tiện để chiến đấu với kẻ thù bằng cách giăng lưới, ném trứng, v.v., trụ sở di động này sẽ đưa trí tưởng tượng của bé đến những nhiệm vụ bất tận"
, "/images/product/Trụ Sở Chính Của Người Nhện_14_1.jpg", 1, 50, 1639000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Chiến Giáp Hulk"
, "Biến Hulk hùng mạnh thành một cỗ máy chiến đấu thậm chí còn lớn hơn và tốt hơn! Đặt Avenger màu xanh lá cây vào buồng lái của Hulk Mech Armor và tận hưởng những pha hành động siêu hạng với cánh tay, chân và bàn tay khổng lồ, có thể di chuyển được của mech. 
• Điều trị thực hành – Các siêu anh hùng trẻ tuổi sẽ tận hưởng những pha hành động bất tận và trò chơi giàu trí tưởng tượng với LEGO® Marvel Chiến Giáp Hulk (76241), cỗ máy chiến đấu khổng lồ, có thể di chuyển
• Siêu anh hùng mang tính biểu tượng – Bao gồm một mô hình nhỏ Hulk và một mech Hulk có thể chế tạo được với các cánh tay, chân và ngón tay được nối hoàn chỉnh
• Các chi có thể di chuyển để chơi và trưng bày – Mô hình nhỏ của Hulk phù hợp với buồng lái mở của cỗ máy được nối hoàn toàn, dễ dàng điều chỉnh cho hành động chơi và trưng bày bất tận
• Điều trị cho người hâm mộ Marvel – Đồ chơi xây dựng và chơi thực hành này là một món quà linh hoạt cho sinh nhật, ngày lễ hoặc món quà bất ngờ dành cho trẻ em từ 6 tuổi trở lên "
, "/images/product/Chiến Giáp Hulk_15_1.jpg", 0, 5, 328000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Chiến Giáp Thanos"
, "Đặt Thanos vào buồng lái cỗ máy của hắn và biến siêu ác nhân mạnh nhất vũ trụ trở nên tuyệt vời hơn nữa! Với cánh tay, chân và ngón tay có thể di chuyển, cộng với thanh kiếm hai mặt của Thanos, Găng tay Vô cực và Đá Vô cực, Bộ giáp Mech của Thanos là không thể ngăn cản!
• Siêu phản diện ngoại cỡ – LEGO® Marvel Chiến Giáp Thanos (76242) là một gã khổng lồ có khớp hoàn chỉnh mang đến những pha hành động tưởng tượng bất tận trong tay trẻ em
• Hành động Marvel đích thực – Bao gồm một mô hình nhỏ của Thanos và một cỗ máy Thanos có thể chế tạo với cánh tay, chân và ngón tay có thể điều chỉnh, cùng với thanh kiếm hai mặt mang tính biểu tượng, Găng tay Vô cực và Đá Vô cực
• Dễ định vị và tạo dáng – Mô hình nhỏ của Thanos vừa với buồng lái mở của cỗ máy, có các chi có thể di chuyển được điều chỉnh để có khả năng chơi và trưng bày vô tận
• Quà tặng dành cho người hâm mộ Marvel – Tặng trẻ em từ 6 tuổi trở lên đồ chơi lắp ráp và chơi thực hành này như một món quà sinh nhật, ngày lễ hoặc món quà bất ngờ"
, "/images/product/Chiến Giáp Thanos_16_1.jpg", 1, 20, 469000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Xe Đua Mô Tô Của Ma Tốc Độ"
, "Đặt Ghost Rider vào mech của anh ấy và thực hiện một chuyến đi hoang dã trên chiếc mô tô siêu ngầu, siêu ngầu của anh ấy! Kẻ xấu không có cơ hội khi đối mặt với cánh tay, chân, bàn tay nghiền nát và dây chuyền bắt linh hồn của cỗ máy tuyệt vời này.
• Máy móc và xe máy – Các siêu anh hùng trẻ tuổi sẽ tận hưởng trò chơi giàu trí tưởng tượng vô tận với LEGO® Marvel Xe Đua Mô Tô Của Ma Tốc Độ (76245), cỗ máy khổng lồ, có thể di chuyển trên bánh xe
• Nhân vật mang tính biểu tượng – Bao gồm mô hình nhỏ Ghost Rider, Chiến Giáp Ghost Rider có thể chế tạo với cánh tay, chân và ngón tay được nối hoàn chỉnh và một mô tô phóng to mà mech gắn vào
• Một chuyến đi hoang dã – Kẻ xấu không có cơ hội với cánh tay, chân, bàn tay nghiền nát và dây chuyền bắt linh hồn của cỗ máy mô tô này
• Quà tặng cho trẻ em – Người hâm mộ mechs, xe máy hoặc phim Marvel từ 7 tuổi trở lên sẽ thích nhận món đồ chơi có thể lắp ráp, thực hành này như một món quà sinh nhật, ngày lễ hoặc món quà bất ngờ"
, "/images/product/Xe Đua Mô Tô Của Ma Tốc Độ_17_1.jpg", 1, 20, 1099000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Mô Tô Chiến Đấu Của Lloyd"
, "Bạn cần phải nhanh chóng - Bone Guard đã đánh cắp Thanh kiếm rồng vàng quý giá! Bạn phải hợp tác với Lloyd trên chiếc mô tô tuyệt vời của anh ấy để bắt tên Bone Guard độc ác và giật lại thanh kiếm. Khởi động động cơ và sẵn sàng cho một cuộc rượt đuổi siêu tốc! Nhưng hãy coi chừng: có một tay súng ẩn trong Ngôi đền Xương đang bắn ra những chiếc đĩa! Bạn có những gì nó cần để giành chiến thắng trong trận chiến quan trọng này?
• Bộ LEGO® dành cho người mới bắt đầu – Trẻ em từ 4 tuổi trở lên có thể học cách xây dựng trong thế giới giả tưởng của NINJAGO® với bộ đồ chơi Mô Tô Chiến Đấu Của Lloyd của Lloyd (71788)
• 2 mô hình nhỏ – Bao gồm Lloyd và Bone Guard, cả hai đều có kiếm, dành cho các nhà xây dựng nhỏ nhập vai vào các trận chiến vui nhộn
• Trẻ em có thể sử dụng trí tưởng tượng của mình để dàn dựng các câu chuyện giữa Lloyd trên xe máy và Kẻ bảo vệ Xương của kẻ thù
• Ngôi đền xương – Trẻ em có thể thêm niềm vui vào cuộc phiêu lưu của mình với ngôi đền nhỏ xây bằng gạch này có vũ khí bằng vàng và một game bắn súng bí mật bắn ra đĩa
• Phần thưởng nhỏ dành cho trẻ em từ 4 tuổi trở lên – Bộ đồ chơi lâu bền này sẽ mang đến cho người hâm mộ ninja vô số lựa chọn chơi khi các em học cách xây dựng mô hình và sáng tạo câu chuyện"
, "/images/product/Mô Tô Chiến Đấu Của Lloyd_18_1.jpg", 0, 40, 309000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Xe cứu hộ rái cá"
, "Lấy bộ đàm và máy ảnh của bạn, nhảy lên chiếc xe cứu hộ cùng nhân viên kiểm lâm của công viên LEGO® City. Lái xe đến khu vực nơi bạn có thể quan sát rái cá khi chúng bơi lội, kiếm ăn và chơi đùa trong môi trường sống tự nhiên của chúng. Chụp một vài bức ảnh và xem chú ếch dễ thương trên bông súng trước khi bạn quay trở lại căn cứ.
• Bộ đồ chơi chủ đề thiên nhiên – Những cuộc phiêu lưu hoang dã giàu trí tưởng tượng đang chờ đợi với bộ đồ chơi LEGO® City Xe Cứu Hộ Rái Cá (60394) dành cho những người yêu động vật từ 5 tuổi trở lên
• Có cái gì trong hộp vậy? – Tất cả trẻ em cần xây dựng một chiếc ATV đồ chơi và môi trường sống của rái cá, cộng với một nhân vật kiểm lâm công viên và các hình rái cá, ếch, cá và chim
• Cùng khám phá – Trẻ em có thể cho nhân vật kiểm lâm ngồi sau tay lái của chiếc ATV đồ chơi và bắt đầu cuộc phiêu lưu khám phá động vật
• Ý tưởng quà tặng thú vị dành cho trẻ em và những người yêu động vật từ 5 tuổi trở lên – Kỷ niệm sinh nhật hoặc món quà bất ngờ khác với bộ đồ chơi xếp hình LEGO® City này"
, "/images/product/Xe cứu hộ rái cá_19_1.jpg", 1, 20, 263000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Máy Kéo Trồng Cây Công Viên"
, "Lấy xẻng và vật dụng cần thiết và chất lên xe kéo để bắt đầu chuyến trồng cây trên chiếc máy kéo màu xanh lá cây. Chiếc máy này hoàn hảo cho lái xe đường rừng! Tìm một vị trí đẹp để trồng cây lớn và cây con. Nhớ tưới nước đầy đủ cho chúng nhé! Những cái cây mới đã thu hút một loài bọ rùa đầy màu sắc và một con sóc. Cho sóc ăn một quả sồi và dọn dẹp trước khi đi về nhà.
• Giới thiệu cho trẻ em cách trồng cây xanh tại thành phố LEGO® City
• Có cái gì trong hộp vậy? – Bộ đồ chơi LEGO® City Máy Kéo Trồng Cây Công Viên (60390) bao gồm máy kéo đồ chơi, xe kéo, cây cối, cây con, dụng cụ làm vườn, mô hình người làm vườn mini, bọ rùa và sóc
• Thỏa sức tưởng tượng – Trẻ em có thể tham gia các chuyến thám hiểm trồng cây và cho chú sóc tò mò ăn một quả sồi
• Được thiết kế cho trẻ em từ 5 tuổi trở lên – Món quà LEGO® thú vị cho ngày sinh nhật, ngày lễ hoặc bất kỳ dịp nào khác"
, "/images/product/Máy Kéo Trồng Cây Công Viên_20_1.jpg", 1, 10, 263000, 1);
-- Sáng tạo
INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ Chơi Rubik's Race Thách Đấu SPIN GAMES"
, "Rubik là một trò chơi trí tuệ giải khối lập phương thú vị và hấp dẫn nhiều người, đặc biệt là giới trẻ, rất tốt cho trẻ để giải trí đồng thời giúp nâng cao khả năng toán học hiệu quả
Lần này Rubik’s sẽ mang đến cho các bạn một thiết kế hoàn toàn mới. Rubik’s Race là một trò chơi rubik dạng bảng có nhịp độ nhanh được thiết kế để kích thích trí não và các ngón tay của bạn hoạt động nhanh nhất có thể. Trượt các ô màu trong khay để nhanh chóng hoàn thành thử thách.
Rubik’s là thương hiệu đến từ Canada với các sản phẩm đa dạng và đảm bảo về chất lượng. Các sản phẩm của Rubik’s được cải tiến, các khớp nối luôn luôn mượt mà, giúp việc giải rubik luôn luôn chính xác và nhanh nhất có thể. Những miếng dán truyền thống đã được thay thế bằng những miếng ốp nhựa, đảm bảo không bị phai màu hay bong tróc."
, "/images/product/Đồ Chơi Rubik's Race Thách Đấu SPIN GAMES_21_1.jpg", 1, 30, 679000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ Chơi Rubik's Speed Tốc Độ SPIN GAMES"
, "Rubik là một trò chơi trí tuệ giải khối lập phương thú vị và hấp dẫn nhiều người, đặc biệt là giới trẻ, rất tốt cho trẻ để giải trí đồng thời giúp nâng cao khả năng toán học hiệu quả
Khối Rubik’s quen thuộc với mọi người nay đã trở lại cùng sự lợi hại mới. Với thiết kế cải tiến, sử dụng nam châm để tăng độ ổn định và hoạt động như một hệ thống cố định, giúp căn chỉnh Khối rubik cho các vòng xoay nhanh hơn, linh hoạt hơn. Không còn hiện tượng bị kẹt cứng.
Rubik’s là thương hiệu đến từ Canada với các sản phẩm đa dạng và đảm bảo về chất lượng. Các sản phẩm của Rubik’s được cải tiến, các khớp nối luôn luôn mượt mà, giúp việc giải rubik luôn luôn chính xác và nhanh nhất có thể. Những miếng dán truyền thống đã được thay thế bằng những miếng ốp nhựa, đảm bảo không bị phai màu hay bong tróc."
, "/images/product/Đồ Chơi Rubik's Speed Tốc Độ SPIN GAMES_22_1.jpg", 1, 40, 549000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA"
, "Bộ dụng cụ trang điểm màu hồng Make It Real 2506MIR với bảng màu phong phú, bé có thể thỏa sức sáng tạo phối màu mắt với nhau. Sản phẩm được làm từ nguyên liệu an toàn cho bé sử dụng.
Make It Real là thương hiệu chuyên sản xuất đồ chơi cho bé gái đến từ Anh Quốc. Với sự mệnh truyền cảm hứng cho các bé, hỗ trợ phát triển sự sáng tạo, hứng thú cho trẻ trong việc chăm sóc bản thân, đồng thời, đồ chơi của hãng còn giúp xây dựng sự tự tin về kỹ năng và tư duy nghệ thuật.
Sản phẩm bao gồm:
- Gương
- 20 màu phấn mắt
- 2 màu má hồng
- 2 son bóng
- 3 màu sơn móng tay
- Sách hướng dẫn"
, "/images/product/Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_1.jpgg", 0, 2, 599000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR"
, "Một bộ vòng tay ngọt ngào đến mức có thể khiến bé yêu không thể cưỡng lại được! . Bộ trò chơi bao gồm mọi thứ mà bé yêu cần để sáng tạo cho mình những bộ vòng tay và dây đeo ngọt ngào nhất. Bộ trò chơi này chắc chắn sẽ mang đến cho bé những hoạt động vui nhộn, đồng thời kích thích sự sáng tạo của bé. Không có gì ngọt ngào hơn là chia sẻ những kỷ niệm phải không nào, còn chờ gì nữa mà không cùng sắm ngay bộ trò chơi và chơi cùng với bạn bè thôi nào.
Make It Real là thương hiệu chuyên sản xuất đồ chơi cho bé gái đến từ Anh Quốc, có mặt ở hơn 70 quốc gia. Với sứ mệnh truyền cảm hứng cho các bé, hỗ trợ phát triển sự sáng tạo, hứng thú cho trẻ trong việc chăm sóc bản thân, đồng thời, đồ chơi của hãng còn giúp xây dựng sự tự tin về kỹ năng và tư duy nghệ thuật. Mỗi sản phẩm Make It Real là trải nghiệm thực tế mở ra cửa sổ cho giấc mơ thiết kế, định hình gout mỹ thuật của trẻ em.
Bao gồm:
 - 1 sợi dây thun trong suốt dài 4m
 - 4 sợi ren giả da dài 50 cm
 - 1 sợi dây cotton 50 cm
 - 66 charm hình chữ cái
 - 168 hạt các loại
 - 20 vòng nhỏ
 - 6 mặt charm
 - 1 chuỗi vòng tay
 - 1 khay chơi"
, "/images/product/Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_1.jpg", 1, 20, 409000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR"
, "Thỏa sức bay bổng với Bộ thiết kế vòng tay cánh bướm siêu đáng yêu! Bộ thiết kế trang sức DIY này mang đến những hoạt động thú vị và sáng tạo cho bé yêu của bạn! Bộ thiết kế với đầy đủ phụ kiện để thiết kế đến 5 chiếc vòng tay, 1 chiếc vòng cổ và một chiếc kẹp tóc đính cườm bằng những vật liệu siêu thời trang
Bộ trò chơi cực kỳ thích hợp cho bé yêu khi kết hợp với những bộ trang phục của mình, mang đến cho bé sự tự tin ở bất cứ đâu, dù là ở nhà hay trong những bữa tiệc.
Make It Real là thương hiệu chuyên sản xuất đồ chơi cho bé gái đến từ Anh Quốc, có mặt ở hơn 70 quốc gia. Với sứ mệnh truyền cảm hứng cho các bé, hỗ trợ phát triển sự sáng tạo, hứng thú cho trẻ trong việc chăm sóc bản thân, đồng thời, đồ chơi của hãng còn giúp xây dựng sự tự tin về kỹ năng và tư duy nghệ thuật. Mỗi sản phẩm Make It Real là trải nghiệm thực tế mở ra cửa sổ cho giấc mơ thiết kế, định hình gout mỹ thuật của trẻ em.
Bộ trò chơi gồm:
 - 1 sợi dây thun trong suốt dài 4m
 - 1 dây nylon dài 2m
 - 271 hạt các loại
 - 1 kẹp tóc hình con bướm
 - 1 vòng cổ
 - 3 mặt charm
 - 1 khay chơi"
, "/images/product/Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_1.jpg", 1, 40, 229000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282"
, "Bộ phun sơn thú cưng mini bí ẩn là một sản phẩm của thương hiệu Style4ever đến từ Pháp.
Bộ sản phẩm mang đến trải nghiệm cực kỳ thú vị khi bé có thể tự trang trí thú cưng với súng phun màu và màu có thể giặt rửa được. Bên trong mỗi bộ sản phầm gồm 1 thú cưng bất ngờ, liệu bé sẽ nhận được bé thú cưng nào đây nhỉ.
Thú cưng được làm bằng vải mềm, kèm với 3 khuôn phun sơn, bé có thể tha thồ sáng tạo nhiều tạo hình khác nhau. Màu nhanh khô, có thể giặt sạch giúp niềm vui trở nên không giới hạn.
Cách chơi:
Bước 1: Đặt sticker/khung phun sơn lên thú bông
Bước 2: Đặt bút vào máy và phun sơn
Bước 3: Chờ mực khô và tiếp tục tạo hình
Bộ sản phẩm bao gồm:
- 1 thú cưng mini bằng bông
- 1 súng phun sơn
- 1 cặp găng tay
- 2 bút màu
- 25 khuôn phun sơn
- 1 sách hướng dẫn chơi"
, "/images/product/Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_1.jpg", 1, 30, 299000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196"
, "Một chiếc vạc ma thuật để tạo ra slime ma thuật của riêng bạn! Với hiệu ứng màn sương ma thuật và ánh sáng mờ ảo, bộ trò chơi này có thể tạo đến 10 lọ slime. Điều chế dung dịch slime và thuốc tiên ma thuật bằng cách trộn bột và các thành phần ma thuật. Giữ chúng gần bạn bằng cách cho vào những chiếc lọ nhỏ và đeo ở cổ để làm biến mong muốn của bạn trở thành sự thật!
BAO GỒM·:
 - 1 cái vạc thần kỳ
 - 1 túi bột slime (cho 10 chất nhờn)
 - 3 Túi bột tiết lộ màu sắc
 - 3 lọ màu
 - 1 thìa khuấy
 - 1 muỗng đong
 - 1 tấm ticker
 - 5 Túi ma thuật
 - Đồ trang trí"
, "/images/product/Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_1.jpg", 1, 20, 859000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201"
, "Chiếc lọ ma thuật để tạo ra slime ma thuật của riêng bạn! Điều chế dung dịch slime và thuốc tiên ma thuật cực dễ dàng chỉ với các bước đơn giản. Trộn bột và các thành phần ma thuật theo thẻ công thức trong hộp, thêm nước, lắc đều, vậy là hoàn thành. Cùng xem màu sắc bạn tạo ra sẽ tiết lộ tương lai của mình như thế nào nhé.
BAO GỒM:
 - 1 bình chứa
 - 1 túi bột slime
 - 1 túi bột ma thuật
 - 1 thẻ công thức
 - 1 túi đồ trang trí"
, "/images/product/Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_1.jpg", 1, 40, 139000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180"
, "Thiết kế và trang trí chiếc Đèn Lava DIY Style4Ever của riêng mình. Bật và xem đèn màu thay đổi! Thể hiện phong cách độc đáo của bạn và trang trí đèn dung nham của mình với các hạt, hình nền, màu sắc và hình dán đi kèm. Chỉ cần thêm nước và các hạt trang trí đi kèm, sau đó bật đèn và tận hưởng ánh sáng kỳ ảo của chiếc đèn. Sản phẩm sẽ giúp căn phòng của bé thêm ấm áp và rực rỡ hơn đó nha."
, "/images/product/Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_1.jpg", 1, 50, 599000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Trò chơi Domino SPIN GAMES"
, "Bộ trò chơi Cờ Domino là trò chơi vô cùng hấp dẫn được rất nhiều người yêu thích và phù hợp với nhiều lứa tuổi. Là trò chơi nổi tiếng trên khắp thế giới bởi luật chơi đơn giản nhưng đòi hỏi bạn phải có sự khéo léo của đôi tay và khả năng vận dụng trí óc. Sản phẩm thích hợp với nhiều đối tượng khác nhau, bạn có thể chơi cùng gia đình, bạn bè... để cùng tạo nên những giờ giải trí thú vị. Sản phẩm được làm bằng chất liệu cao cấp, siêu bền và đẹp, thiết kế hộp nhỏ gọn, bạn có thể xếp gọn gàng vào hộp sau khi chơi, thuận tiện cho việc di chuyển và cất giữ."
, "/images/product/Trò chơi Domino SPIN GAMES_30_1.jpg", 1, 40, 159000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY"
, "Bánh kem ngọt ngào Super Fluffy Slimy - 33447 nói riêng và chất nhờn ma quái nói chung được lấy cảm hứng từ câu chuyện về những quái vật ma quái biết biến hình thành nhiều hình dạng khác nhau để tránh sự truy đuổi của những người xấu. Món đồ chơi kỳ diệu này đã ra đời với mục đích trở thành đồ chơi mà bạn nhỏ nào cũng mong muốn có được.
Bánh kem ngọt ngào Super Fluffy Slimy - 33447 không chỉ đơn giản là món đồ chơi cho trẻ nhỏ mà thông qua việc tạo hình, bé sẽ phần nào tạo được nền tảng về nghệ thuật, cách phối màu, tạo hình cho sự vật.
Đồ chơi Slime có những đặc tính sau:
Trọng lượng: 300g/cup. Chất slime mềm mịn, siêu đàn hồi, chơi cực vui tay. Bé có thể ""mix and match"" với 2 loại phụ kiện đi kèm gồm hạt màu tinh nghịch và các hạt bóng xốp dễ thương.
Màu sắc tự nhiên, hương liệu dùng trong thực phẩm, thành phần không độc hại hay gây kích ứng cho trẻ nhỏ khi tiếp xúc thường xuyên.
Bộ sản phẩm Bánh kem ngọt ngào Super Fluffy Slimy - 33447 gồm:
 - 01 cup chất nhờn ma quái slime siêu mềm, siêu mịn được mix từ 3 loại màu
 - 01 hộp hạt màu tinh nghịch (9g)
 - 01 hộp bóng xốp dễ thương (1g)"
, "/images/product/Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_1.jpg", 1, 30, 269000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Cát động lực - Kho báu dưới đáy biển"
, "Playset Kinetic sand Lâu Đài Pha Lê
Cùng khám phá kho báu dưới đại dương của những nàng tiên cá xinh đẹp. Bộ trò chơi kinetic sand bao gồm 481g cát động lực với 2 loại cát thường và cát vàng lấp lánh. Bộ trò chơi còn bao gồm các dụng cụ như hòm kho báu của công chúa, khuôn vỏ sò, con lăn,… Bé có thể thỏa thích sáng tạo theo trí tưởng tượng của bản thân và tạo nên những câu chuyện của riêng mình.
Kinetic sand là thương hiệu đến từ Canada:
- Thành phần của từ cát tự nhiên và đảm bảo an toàn cho bé.
-Cát không bị khô, có thể chơi đi chơi lại nhiều lần"
, "/images/product/Cát động lực - Kho báu dưới đáy biển_32_1.jpg", 1, 50, 569000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết"
, "Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 13 Chi Tiết - Gồm các phụ kiện:
- 1 Đèn UV.
- 1 Kính bảo bộ.
- 1 ly đo lường,
- 1 thanh cọ vệ sinh ống thí nghiệm.
- 1 ống hút
- 1 muỗng.
- 2 ống thí nghiệm có nắp .
- 1 thanh trộn dung dịch.
- 1 bịch bông gòn.
- 1 bịch bột canxi clorua.
- 1 bịch Baking soda (natri bicacbonat/ muối nở).
- 1 bịch bột quỳ
- 1 sách hướng dẫn cung cấp rõ các bước thực hiện hơn 25 thí nghiệm hóa học
Bé trở thành nhà khoa học uyên bác, tự do khám phá:
- Khám phá sự kỳ diệu khi soi đèn UV vào trái cây.
- Khám phá về chất diệp lục trong lá cây.
- Thí nghiệm tạo ga thú vị
- Thí nghiệm tạo bọt xà phòng hấp dẫn
- Thí nghiệm về phản ứng của bộ quỳ lạ kỳ
.. Và nhiều thí nghiệm hóa học hay ho khác!
Đồ chơi khoa học STEAM hàng đầu nước Mỹ của nhãn hàng DISCOVERY hợp tác cùng kênh truyền hình nổi tiếng DISCOVERY, đem lại cho bé những trải nghiệm khoa học ứng dụng vừa học, vừa chơi."
, "/images/product/Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_1.jpg", 1, 50, 389000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Thí Nghiệm Làm Tuyết"
, "Bộ thí nghiệm làm tuyết – 1423011200 của thương hiệu DISCOVERY. Bé hóa thân thành nhà hóa học siêu xịn. Gồm các dụng cụ sau:
1 x Bột tạo tuyết ngay lập tức
1 x Bột tạo hạt lấp lánh
1 x Ly đo lường
1 x Muỗng
- Chỉ cần thêm nước, tuyết đã có thể xuất hiện ở bất cứ đâu. Định hình tuyết và sau đó phơi khô tuyết và chơi lại. Đó là cách thú vị để tìm hiểu về khoa học trái đất và kỹ thuật!"
, "/images/product/Bộ Thí Nghiệm Làm Tuyết_34_1.jpg", 1, 30, 279000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu"
, "** Ở lứa tuổi lên 3 bé sẽ bắt đầu khám phá mọi thứ xung quanh,và phát triển sự sáng tạo của mình qua việc vẽ ,hoặc viết những gì bé thích. Điều đó có thể khiến ba mẹ đau đầu khi bé thường vẽ khắp nhà hoặc những nơi ba mẹ khó vệ sinh.Vì vậy một chiếc Bảng Vẽ Nam Châm là giải pháp giúp bé tự do phát triển sáng tạo,ba mẹ cũng yên tâm hơn.
- Phù hợp cho bé từ 3+
- Giúp bé phát triển được tư duy Logic, sự sáng tạo và khéo léo
- Bảng vẽ bao gồm: bảng nam châm, bút vẽ, 3 con dấu hình dáng dễ thương
- Chất liệu làm từ nhựa an toàn, có thể tái chế được
- Bảng vẽ có 4 màu cho bé tự do sáng tạo và nhận biết màu sắc
- Xóa dễ dàng với 1 cái gạt cần ngang qua, giữ cho tay bé luôn được sạch sẽ.
- Đặc biệt bút nam châm được liên kết với dây tránh bị rơi hoặc mất.
- PEEK A BOO là thương hiệu đồ chơi - đồ dùng trẻ em Độc quyền của Mykingdom và hoàn toàn xuất xứ tại Việt Nam với mong muốn mang lại tất cả những sản phẩm cần thiết nhất trên từng chặng đường phát triển của bé với chất lượng tốt, an toàn, giá cả phải chăng."
, "/images/product/Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_1.jpg", 1, 20, 239000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Trò chơi thử thách trí tuệ hạt đậu logic Vàng"
, "Sản phẩm Trò chơi thử thách trí tuệ Hạt đậu logic xanh/vàng là một món đồ chơi giải trí vừa chơi vừa học. Gồm những viên banh tròn như hạt đậu nhiều màu sắc sặc sỡ. Bằng trí thông minh và sự linh hoạt của các ngón tay, bé cần đưa những viên banh cùng màu về chung 1 ô với nhau. Sản phẩm được thiết kế như một câu đố, trò chơi trí tuệ mang đến cho người chơi
- Thư giãn
- Phát triển trí não
- Rèn luyện sự linh hoạt các ngón tay
Đồ chơi đặc biệt giúp bé:
- Phát triển tư duy logic
- Rèn luyện tính kiên nhẫn
Sản phẩm bao gồm: 1 khay chơi với 4 rãnh màu khác nhau, và trục giữa có thể xoay 360 độ, sang trái và phải linh hoạt."
, "/images/product/Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_1.jpg", 1, 20, 79000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini"
, "Đồ chơi bột nặn Playdoh - Khuôn tạo hình cơ bản và bột nặn 4 màu mini CBE8534/E8530-2324 là một sản phẩm hoàn hảo trong việc giáo dục cho trẻ về các hình khối, bên cạnh đó còn phát huy sự sáng tạo và trí tưởng tượng của trẻ. Đồ chơi khuôn tạo hình cơ bản của Play Doh bao gồm 9 khuôn hình và 6 hộp bột nặn Play Doh đầy màu sắc, cho bé những giờ phút vui chơi và học tập đầy thú vị.
Đồ chơi bột nặn Play Doh khuôn tạo hình cơ bản có các đặc điểm nổi bật sau :
 - Bột nặn được làm hoàn toàn bằng nguyên liệu tự nhiên, lành tính với da của bé, phụ huynh hoàn toàn yên tâm khi cho bé vui chơi lâu dài
 - Từng khuôn chữ được nghiên cứu kỹ lưỡng, bo đều các góc, an toàn cho bàn tay nhỏ của bé
 - Màu sắc đa dạng, sinh động, có thể sáng tạo trộn các màu với nhau để tạo thành màu mới.
 - Kích thích sáng tạo, truyền cảm hứng thực hành mô phỏng đồ vật xung quanh, phát triển tư duy nhận dạng hình khối.
Bộ sản phẩm đồ chơi bột nặn Play Doh - Khuôn tạo hình cơ bản CBE8534/E8530-2324 bao gồm :
 - 9 khuôn hình
 - 6 chậu bột nặn 
 - 4 bột nặn màu mini tặng kèm"
, "/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_1.jpg", 1, 10, 270000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi sáng tạo Slimy Foam và Pop It cực giải trí Đỏ"
, "Đồ chơi sáng tạo Slimy Foam và Pop It cực giải trí 32701 Đồ chơi sáng tạo Slimy Foam và Pop It cực giải trí 32701 với cách chơi cực mới lạ và thú vị sẽ mang đến cho bé những giờ phút thư giãn cực vui. Đặc biệt, Slimy foam xốp là một món đồ chơi rất tốt cho bé, giúp kích thích khả năng sáng tạo và trí tưởng tượng thông qua cách chơi nhào nặn các hình thù đa dạng khác nhau.
Đồ chơi sáng tạo Slimy Foam và Pop It cực giải trí 32701 bao gồm:
- 250cm3 Chất foam kết dính, tạo hình cực dễ
- 1 Pop-It chất lượng, chơi hoài không chán, giải trí cực đỉnh
- Cực ít dính tay, sạch sẽ khi chơi
- Âm thanh giòn tan cực đã - Nổi trên mặt nước và không tan trong nước, chơi được trong hồ bơi, bồn tắm,…
- Không khô khi để bên ngoài"
, "/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_1.jpg", 1, 40, 119000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Nhà thiết kế thời trang tương lai"
, "Cùng trở thành nhà thiết kế thời trang tương lai với Style4ever – thương hiệu đồ chơi đến từ Pháp. Bộ sản phẩm mang đến mọi thứ bé cần từ bảng vẽ, khung model, bút màu, giấy và cả vải thật. Bé sẽ đắm chìm trong thế giới sáng tạo vô tận.
Bộ sản phẩm bao gồm:
- 1 khung vẽ
- 6 bút chì màu
- 20 trang giấy vẽ sẵn hình người mẫu
- 6 cuộn giấy màu in họa tiết
- 1 bút highlight
- 3 khuôn tô hình quần áo và phụ kiện
- 5 tấm vải thật
- 10 tờ giấy màu in họa tiết
- 50 hạt ngọc trang trí
- 1 keo dán giấy
- 2 tấm sticker
- 1 cuốn sách hướng dẫn sử dụng"
, "/images/product/Nhà thiết kế thời trang tương lai_39_1.jpg", 1, 50, 709000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ Chơi Rubik's Twist"
, "Rubik’s là thương hiệu đến từ Canada với các sản phẩm đa dạng và đảm bảo về chất lượng. Các sản phẩm của Rubik’s được cải tiến, các khớp nối luôn luôn mượt mà, giúp việc giải rubik luôn luôn chính xác và nhanh nhất có thể. Những miếng dán truyền thống đã được thay thế bằng những miếng ốp nhựa, đảm bảo không bị phai màu hay bong tróc.
Nếu bạn đã cảm thấy chán các khối rubik hình vuông cổ điển, thì đây sẽ là món đồ chơi rất thích hợp cho bạn. Đồ chơi Rubik’s Twist gồm 24 khối có dạng các lăng kính đầy màu sắc. Các khối được liên kết với nhau bằng các bu-lông lò xo, đảm bảo cho việc xoay và sắp xếp theo đủ các loại hình dạng nhưng vẫn rất chắc chắn và không bị rơi ra. Bạn có thể xoay và tạo đủ các hình dạng theo trí tưởng tượng của mình, ví dụ như trái bóng, một chú cún, một con vịt, hình chữ nhật… Hãy để trí tượng tượng của bạn được bay bổng và tạo ra nhiều hình dạng của riêng bạn."
, "/images/product/Đồ Chơi Rubik's Twist_40_1.jpg", 1, 20, 429000, 2);

-- Thú bông
INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Tigger người tuyết 8\""
, "Những người bạn bước ra từ bộ phim nổi tiếng Winnie The Pooh với Pooh; Tigger; Piglet đang hóa trang thành những người tuyết thật đáng yêu cùng những phụ kiện ấm áp cho mùa Giáng sinh.
- Người tuyết Pooh dễ thương với chiếc khăn có màu đỏ đặc trưng của mình.
- Người tuyết Tigger xinh xắn với chiếc nón và khăn choàng cam như màu lông bình thường của bạn ý.
- Người tuyết Piglet mềm mịn với chiếc áo choàng hồng xinh xắn như màu da trước khi hóa trangcủa bạn ấy.
Hãy để Disney Plush trở thành những người bạn thân thiết của bé yêu. Bé yêu sẽ có một người bạn dồng hành trung thành xuyên suốt cùng sẻ chia những khoảnh khắc vui vẻ. Các người bạn gấu bông mền mịn, êm ái đang chờ bé và bố mẹ đón về."
, "/images/product/Đồ chơi thú bông bạn Tigger người tuyết 8_41_1.jpg", 1, 40, 195000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Cún con R/C - Pomeranian IWAYA 3159-2VN/JS"
, "Vui cùng cún con Baby đến từ Nhật Bản
Bé nào cũng luôn muốn được sở hữu một chú cún đáng yêu. Vậy thì tại sao không tậu ngay cho bé một chú cún Iwaya đến từ Nhật Bản
Bé cún có thể:
- Sủa
- Vẫy đuôi
- Đi
Lớp lông được làm từ len siêu mềm mịn, an toàn cho da
Thiết kế dựa trên hình mẫu những con chó thật, đảm bảo là món quà trong mơ của các em bé"
, "/images/product/Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_1.jpg", 1, 20, 399000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8\""
, "Những người bạn bước ra từ bộ phim nổi tiếng Winnie The Pooh với Pooh; Tigger; Piglet đang hóa trang thành những người tuyết thật đáng yêu cùng những phụ kiện ấm áp cho mùa Giáng sinh.
- Người tuyết Pooh dễ thương với chiếc khăn có màu đỏ đặc trưng của mình.
- Người tuyết Tigger xinh xắn với chiếc nón và khăn choàng cam như màu lông bình thường của bạn ý.
- Người tuyết Piglet mềm mịn với chiếc áo choàng hồng xinh xắn như màu da trước khi hóa trangcủa bạn ấy.
Hãy để Disney Plush trở thành những người bạn thân thiết của bé yêu. Bé yêu sẽ có một người bạn dồng hành trung thành xuyên suốt cùng sẻ chia những khoảnh khắc vui vẻ. Các người bạn gấu bông mền mịn, êm ái đang chờ bé và bố mẹ đón về."
, "/images/product/Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_1.jpg", 1, 20, 195000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Daisy đáng yêu 10\""
, "Những người bạn đến từ DISNEY, hóa trang thành những chú ong vô cùng dễ thương với 2 chiếc râu trên đầu và đôi cánh phía sau.
- Minnie dễ thương với những đường sọc vàng và hồng, chiếc nơ đỏ
- Daisy – duyên dáng với những đường sọc hồng và tím, chiếc nơ hồng
- Donald – tinh nghịch với những đường sọc vàng và xanh, chiếc nón xanh.
- Piglet – đáng yêu với những đường sọc hồng đỏ
Hãy để Disney Plush trở thành những người bạn thân thiết của bé yêu. Bé yêu sẽ có một người bạn dồng hành trung thành xuyên suốt cùng sẻ chia những khoảnh khắc vui vẻ. Các người bạn gấu bông mền mịn, êm ái đang chờ bé và bố mẹ đón về."
, "/images/product/Đồ chơi thú bông bạn Daisy đáng yêu 10_44_1.jpg", 0, 20, 249000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Minnie đáng yêu 10\""
, "Những người bạn đến từ DISNEY, hóa trang thành những chú ong vô cùng dễ thương với 2 chiếc râu trên đầu và đôi cánh phía sau.
- Minnie dễ thương với những đường sọc vàng và hồng, chiếc nơ đỏ
- Daisy – duyên dáng với những đường sọc hồng và tím, chiếc nơ hồng
- Donald – tinh nghịch với những đường sọc vàng và xanh, chiếc nón xanh.
- Piglet – đáng yêu với những đường sọc hồng đỏ
Hãy để Disney Plush trở thành những người bạn thân thiết của bé yêu. Bé yêu sẽ có một người bạn dồng hành trung thành xuyên suốt cùng sẻ chia những khoảnh khắc vui vẻ. Các người bạn gấu bông mền mịn, êm ái đang chờ bé và bố mẹ đón về."
, "/images/product/Đồ chơi thú bông bạn Minnie đáng yêu 10_45_1.jpg", 1, 20, 249000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10\""
, "Những người bạn bước ra từ bộ phim nổi tiếng Winnie The Pooh với Pooh; Mickey Mouse và những người bạn được giữ nguyên thiết kế và đường nét giống hệt trên phim.
- Pooh dễ thương với chiếc áo đỏ đặc trưng thêu tên cảu mình trước ngực.
- Donald - một chú vịt thủy thủ: mang trên mình chiếc nón xanh, áo xanh và một chiếc nơ đỏ tươi tắn
- Daisy – cô bạn dịu dàng cùng chiếc áo hồng xinh xắn và chiếc nơ điệu đà hồng xinh.
Hãy để Disney Plush trở thành những người bạn thân thiết của bé yêu. Bé yêu sẽ có một người bạn dồng hành trung thành xuyên suốt cùng sẻ chia những khoảnh khắc vui vẻ. Các người bạn gấu bông mền mịn, êm ái đang chờ bé và bố mẹ đón về."
, "/images/product/Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_1.jpg", 1, 50, 299000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Eeyore thân yêu 16\""
, "Những người bạn thân đến từ DISNEY chính hãng đã chính thức có mặt độc quyền tại Việt Nam.
• Sản phẩm gấu bông hình nhân vật DISNEY quen thuộc với tất cả chúng ta từ bộ phim nổi tiếng Winnie The Pooh với Pooh; Tigger; Piglet; Eeyore;
• Các bạn gấu bông mềm mịn đang chờ bé đón về để cùng chia sẻ thật nhiều khoảnh khắc vui vẻ
• Thiết kế tinh xảo, màu sắc sống động
• Bé sẽ được giải trí thư giãn, chơi cùng bạn bè và gia đình.
• Kích thích phát triển tư duy của bé"
, "/images/product/Đồ chơi thú bông bạn Eeyore thân yêu 16_47_1.jpg", 1, 0, 479000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Daisy Duck nguyên bản 10\""
, "Những người bạn bước ra từ bộ phim nổi tiếng Winnie The Pooh với Pooh; Mickey Mouse và những người bạn được giữ nguyên thiết kế và đường nét giống hệt trên phim.
- Pooh dễ thương với chiếc áo đỏ đặc trưng thêu tên cảu mình trước ngực.
- Donald - một chú vịt thủy thủ: mang trên mình chiếc nón xanh, áo xanh và một chiếc nơ đỏ tươi tắn
- Daisy – cô bạn dịu dàng cùng chiếc áo hồng xinh xắn và chiếc nơ điệu đà hồng xinh.
Hãy để Disney Plush trở thành những người bạn thân thiết của bé yêu. Bé yêu sẽ có một người bạn dồng hành trung thành xuyên suốt cùng sẻ chia những khoảnh khắc vui vẻ. Các người bạn gấu bông mền mịn, êm ái đang chờ bé và bố mẹ đón về."
, "/images/product/Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_1.jpg", 1, 20, 299000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Thú nhồi bông Among Us Trứng rán ngộ nghĩnh"
, "Among Us là một tựa game online nổi tiếng trên toàn cầu - làm mưa làm gió trong giới trẻ những năm gần đây. Among Us - by Toikido - là sản phẩm đồ chơi với bản quyền chính thức từ game Among Us. Thú nhồi bông Among Us với chất liệu mềm mại, kiểu dáng cực đáng yêu sẽ là món quà ưng ý đối với các bạn nhỏ thích nhân vật Among Us.
+ Kích thước: 30 cm
+ Được làm từ chất liệu bông mềm mại, cao cấp, đảm bảo an toàn cho da bé
+ Có thể tự đứng được bằng hai chân
+ Có 6 mẫu khác nhau để bé sưu tầm trọn bộ: Đỏ tai dơi huyền bí / Bé Hồng vương giả / Kỳ lân hồng phấn / Mũ phù thủy ánh sao / Trứng rán ngộ nghĩnh / Mũ tai mèo đáng yêu
Sản phẩm phù hợp với mọi lứa tuổi."
, "/images/product/Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_1.jpg", 1, 30, 329000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Cún con R/C - Toypoodle"
, "Vui cùng cún con Baby đến từ Nhật Bản
Bé nào cũng luôn muốn được sở hữu một chú cún đáng yêu. Vậy thì tại sao không tậu ngay cho bé một chú cún Iwaya đến từ Nhật Bản
Bé cún có thể:
- Sủa
- Vẫy đuôi
- Đi
Lớp lông được làm từ len siêu mềm mịn, an toàn cho da
Thiết kế dựa trên hình mẫu những con chó thật, đảm bảo là món quà trong mơ của các em bé", "/images/product/Cún con R_C - Toypoodle_50_1.jpg", 1, 20, 399000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Tigger thân yêu"
, "Những người bạn thân đến từ DISNEY chính hãng đã chính thức có mặt độc quyền tại Việt Nam.
• Sản phẩm gấu bông hình nhân vật DISNEY quen thuộc với tất cả chúng ta từ bộ phim nổi tiếng Winnie The Pooh với Pooh; Tigger; Piglet; Eeyore;
• Các bạn gấu bông mềm mịn đang chờ bé đón về để cùng chia sẻ thật nhiều khoảnh khắc vui vẻ
• Thiết kế tinh xảo, màu sắc sống động
• Bé sẽ được giải trí thư giãn, chơi cùng bạn bè và gia đình.
• Kích thích phát triển tư duy của bé"
, "/images/product/Đồ chơi thú bông bạn Tigger thân yêu_51_1.jpg", 1, 50, 479000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Mickey Mouse thân yêu"
, "Những người bạn thân đến từ DISNEY chính hãng đã chính thức có mặt độc quyền tại Việt Nam.
• Sản phẩm gấu bông hình nhân vật DISNEY quen thuộc với tất cả chúng ta từ bộ phim nổi tiếng Mickey Mouse với Mickey; Minnie; Donald; Daisy; Goofy; Pluto
• Các bạn gấu bông mềm mịn đang chờ bé đón về để cùng chia sẻ thật nhiều khoảnh khắc vui vẻ
• Thiết kế tinh xảo, màu sắc sống động
• Bé sẽ được giải trí thư giãn, chơi cùng bạn bè và gia đình. • Kích thích phát triển tư duy của bé"
, "/images/product/Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_1.jpg", 1, 70, 479000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Donald Duck thân yêu"
, "Những người bạn thân đến từ DISNEY chính hãng đã chính thức có mặt độc quyền tại Việt Nam.
• Sản phẩm gấu bông hình nhân vật DISNEY quen thuộc với tất cả chúng ta từ bộ phim nổi tiếng Mickey Mouse với Mickey; Minnie; Donald; Daisy; Goofy; Pluto
• Các bạn gấu bông mềm mịn đang chờ bé đón về để cùng chia sẻ thật nhiều khoảnh khắc vui vẻ
• Thiết kế tinh xảo, màu sắc sống động
• Bé sẽ được giải trí thư giãn, chơi cùng bạn bè và gia đình.
• Kích thích phát triển tư duy của bé"
, "/images/product/Đồ chơi thú bông bạn Donald Duck thân yêu_53_1.jpg", 1, 20, 479000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi thú bông bạn Piglet thân yêu"
, "Những người bạn thân đến từ DISNEY chính hãng đã chính thức có mặt độc quyền tại Việt Nam.
• Sản phẩm gấu bông hình nhân vật DISNEY quen thuộc với tất cả chúng ta từ bộ phim nổi tiếng Winnie The Pooh với Pooh; Tigger; Piglet; Eeyore;
• Các bạn gấu bông mềm mịn đang chờ bé đón về để cùng chia sẻ thật nhiều khoảnh khắc vui vẻ
• Thiết kế tinh xảo, màu sắc sống động
• Bé sẽ được giải trí thư giãn, chơi cùng bạn bè và gia đình. • Kích thích phát triển tư duy của bé"
, "/images/product/Đồ chơi thú bông bạn Piglet thân yêu_54_1.jpg", 1, 10, 199000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Pony bông 30 cm - Spike"
, "Thú nhồi bông Pony Spike My Little Pony C1064/B9817 với hình dáng đáng yêu sẽ là món quà các bé gái cực kỳ yêu thích. Nàng ngựa xinh đẹp này đã sẵn sàng để chia sẻ cuộc phiêu lưu và vui vẻ với bé! Mỗi Pony đều có cá tính riêng của mình, hãy chọn một Pony hoặc sưu tập trọn bộ Pony Bộng mà bé yêu thích nhé.
- Sản phẩm là nhân vật Pony từ bộ phim hoạt hình nổi tiếng My Little Pony của Mỹ.
- Chất liệu siêu mềm, an toàn cho bé có thể ôm dễ dàng.
- Sản phẩm cao 30 cm."
, "/images/product/Pony bông 30 cm - Spike_55_1.jpg", 1, 40, 281000, 3);

-- Học tập / 56
INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ sổ bút - Graffiti Light Up Rainbow"
, "Khám phá khả năng sáng tạo của bé qua bộ sản phẩm sổ tay lấp lánh và bút gel cầu vồng. Bộ sản phẩm gồm:
+ Sổ tay 192 trang với họa tiết cầu vồng xinh xắn và bắt mắt, giúp bé thỏa thích ghi lại những ý tưởng sáng tạo, những tâm tư hay những câu chuyện riêng của bản thân.
+ Bút gel được tích hợp nhiều màu khác nhau, bút sẽ đổi màu khác khi bé dùng hết mực hiện tại.
Đây chắc chắn sẽ là một món quà tuyệt vời dành cho bé yêu, giúp bé có thể ghi lại những suy nghĩ, ước mơ hay những ý tưởng thông qua nét vẽ của mình."
, "/images/product/Bộ sổ bút - Graffiti Light Up Rainbow_56_1.jpg", 1, 50, 287000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Combo sổ tay, bút chì màu - Pink & Gold"
, "Combo sổ tay, bút chì màu - Pink & Gold – 12029 - Lưu lại những tâm tư của bé Viết nhật ký chính là một hình thức để thể hiện bản thân, và cũng là cơ hội tuyệt vời để bé yêu thể hiện khả năng sáng tạo của mình. Sản phẩm gồm:
+ 1 quyển sổ tay với họa tiết màu hồng và vàng gold rất quyến rũ với 200 trang, tha hồ cho bé ghi chép lại những suy nghĩ của minh, hay phác họa lên những ý tưởng sáng tạo.
+ 6 bút màu với màu sắc tươi tắn
+ 2 cục gôm
+ 1 gọt bút chì
+ 1 bộ sticker đáng yêu."
, "/images/product/Combo sổ tay, bút chì màu - Pink & Gold_57_1.jpg", 1, 30, 207000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Combo tô màu và Sketchbook - Choose Happy"
, "Bộ sản phẩm với đầy đủ đồ dùng cho bé yêu của bạn thỏa sức sáng tạo. Mô tả sản phẩm:
+ Sổ tay xinh xắn với họa tiết những chú bươm bướm đầy màu sắc.
+ Set 12 màu sáp với màu sắc tươi tắn.
+ 4 cây bút chì màu.
+ 1 bút gel với charm hình chú bướm xinh xắn.
+ 1 bộ sticker với những thiết kế siêu cute.
+ Tất cả được đặt trong một chiếc hộp với khóa nam châm, bé có thể dung chiếc hộp này để đựng những món đồ khác của mình nữa đó. Đây chắc chắn sẽ là một món quà tuyệt vời dành cho bé yêu, giúp bé có thể ghi lại những suy nghĩ, ước mơ hay những ý tưởng thông qua nét vẽ của mình.", "/images/product/Combo tô màu và Sketchbook - Choose Happy_58_1.jpg", 1, 20, 399000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bút bi hình xoắn ốc"
, "Khi việc học hành không còn là một sự áp lực! Một chiếc bút bi thông thường có quá nhàm chán với bé? Vậy tại sao không thử chiếc bút bi với thiết kế mới lạ đến từ thương hiệu 3C4G!!
Chiếc bút bi này với phần trên đầu bút có thể đẩy và quay riêng biệt. Bé có thể xoắn, tạo hình cái cây, tạo hình bông hoa, một con rắn, hay bất cứ thứ gì bé có thể nghĩ ra. Chiếc bút này chắc chắn sẽ khiến những giây phút học tập của bé không còn cảm giác buồn chán, mang đến sự phấn khích cho bé, kích thích niềm vui học tập của bé.", "/images/product/Bút bi hình xoắn ốc_59_1.jpg", 1, 20, 71000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng"
, "Combo sổ tay Sparkle Star bao gồm sổ tay và bút Squishy Surprise hứa hẹn sẽ là món đồ học tập khiến các bé gái mê mẫn. Sổ tay Sparkle Star lung linh với hình ảnh ngôi sao 3D và thật nhiều kim tuyến vô cùng lấp lánh nổi bật trên nền bìa vải lông vô cùng mềm mại và đáng yêu. Ngôi sao may mắn với dòng chữ Lucky hồng ngọt ngào hi vọng mang đến thật nhiều may mắn cho \"chủ nhân\" của sổ tay.
Bật mí, combo còn bút Squishy surprise mềm mại với các hình ảnh ngộ nghĩnh chờ đợi các bé khám phá và viết ra thế giới của riêng mình.
Ngoài ra, sổ tay còn có các điểm nổi bật sau mà bé không thể nào bỏ qua:
- Trang bìa là hình ảnh chú Hà mã đáng yêu cùng những người bạn sắc màu.
- Trang đầu của sổ được thiết kế cho bé điền thông tin \"đánh dấu chủ quyền\" món đồ của mình.
- Các trang ghi chép được thiết kế kẻ dòng, giúp bé nắn nót nét chữ và ghi chú ngay ngắn hơn.
Thông số kỹ thuật:
- Chất liệu: Vải lông và giấy
- Sổ 160 trang, định lượng giấy 80gsm. Chất liệu giấy dày và chống lem.
- Kích thước: sổ A5 (14.8 x 21 cm)
Cảnh báo! Sản phẩm có những chi tiết nhỏ không dử dụng cho trẻ dưới 3 tuổi.", "/images/product/Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_1.jpg", 1, 20, 233000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Ba lô Hoodie - Kì Lân Ngân Hà Tím"
, "KÍCH THƯỚC: 15 x 29 x 36
TRỌNG LƯỢNG: 520g
CHẤT LIỆU: Vải chính & vải lót 100% Polyester
Cùng hóa thân thành cô nàng kỳ lân mộng mơ với mẫu ba lô Hoodie. Phần nón được làm từ chất liệu vải lông mềm mại, với điểm nhấn là phần sừng được may từ vải kim tuyến. Sản phẩm có các đặc điểm:
- Phần nón hình ảnh nhân vật hoạt hình có thể gấp gọn và cất vào ngăn ẩn phía sau lưng khi không sử dụng. Hoàn toàn không gây khó chịu cho bé khi sử dụng
- Phần đệm lưng và vai vô cùng êm ái
- Quai đeo dễ dàng tùy chỉnh để phù hợp với dáng người của các bé
- Chất liệu vải trượt nước
Đây là một mẫu sản phẩm của thương hiệu Clever Hippo hiện đang được bán tại shop Clever Collection", "/images/product/Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_1.jpg", 1, 50, 679000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Ba lô Easy Go - Clever Monster Vàng"
, "KÍCH THƯỚC: 13 x 29 x 40cm
TRỌNG LƯỢNG: 450g
CHẤT LIỆU: Vải chính & vải lót 100% Polyester
Nếu đang tìm kiếm một mẫu ba lô với chủ đề mới lạ, tông màu độc đáo cùng với một phong cách mới lạ - thì đây chính là mẫu sản phẩm sẽ đáp ứng được các tiêu chí trên. Mẫu ba lô chủ đề Clever Monster có các tính năng:
- Kiểu dáng ba lô nhỏ gọn, thời trang.
- Trọng lượng siêu nhẹ đi cùng chất liệu vải trượt nước, có thể dễ dàng vệ sinh.
- Các ngăn chứa rộng rãi và phân bổ hợp lí, đựng vừa kích thước khổ A4. Có 02 ngăn hông đựng bình nước tiện lợi
- Ba lô có phần bảng tên ở bên trong để ghi thông tin của bé.
- Khóa kéo HKK chất lượng
Đây là một mẫu sản phẩm của thương hiệu Clever Hippo hiện đang được bán tại shop Clever Collection", "/images/product/Ba lô Easy Go - Clever Monster Vàng_62_1.jpg", 1, 10, 489000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Ba lô Easy Go - Racing Car Xanh dương"
, "KÍCH THƯỚC: 13 x 29 x 40cm
TRỌNG LƯỢNG: 450g
CHẤT LIỆU: Vải chính & vải lót 100% Polyester
Racing car - chủ đề dành riêng cho các bé trai yêu thích những mẫu xe đua, xe mô hình đồ chơi. Bổ sung ngay vào bộ sưu tập xe của bé mẫu ba lô thời trang với chủ đề này để phong phú thêm bộ sưu tập thôi nào. Cùng điểm qua các tính năng nổi trội của sản phẩm:
- Kiểu dáng ba lô nhỏ gọn, thời trang.
- Trọng lượng siêu nhẹ đi cùng chất liệu vải trượt nước, có thể dễ dàng vệ sinh.
- Các ngăn chứa rộng rãi và phân bổ hợp lí, đựng vừa kích thước khổ A4. Có 02 ngăn hông đựng bình nước tiện lợi
- Ba lô có phần bảng tên ở bên trong để ghi thông tin của bé.
- Khóa kéo HKK chất lượng
Đây là một mẫu sản phẩm của thương hiệu Clever Hippo hiện đang được bán tại shop Clever Collection", "/images/product/Ba lô Easy Go - Racing Car Xanh dương_63_1.jpg", 1, 40, 489000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bóp viết Classic - Clever Monster Vàng"
, "KÍCH THƯỚC: 8 X 22 X 7 cm
TRỌNG LƯỢNG: 70g
CHẤT LIỆU: Vải chính & vải lót 100% Polyester
TÍNH NĂNG:
- Thiết kế nổi bật và đồng bộ ba lô cùng dây kéo phao cá tính.
- Các ngăn chứa rộng rãi, thoải mái.
- Chất liệu nhẹ vải polyester trượt nước, dễ dàng vệ sinh.
- Bộ tay – đầu kéo HKK chất lượng", "/images/product/Bóp viết Classic - Clever Monster Vàng_64_1.jpg", 1, 40, 161000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("30 bút gel pen"
, "Đặc điểm sản phẩm:
Bộ sản phẩm gồm: 30 bút gel cộng với hơn 100 nhãn dán (Sticker) màu sắc khác.
+ 8 bút màu ánh kim
+ 6 bút gam màu pastel
+ 7 bút gam màu neon
+ 2 bút màu cầu vồng
+ 7 bút màu kim tuyến
Màu sắc rực rỡ với loại mực không độc hại mang đến cho những bộ óc nghệ thuật nhiều không gian để sáng tạo những tác phẩm mới lạ, đầy thú vị và có thể làm nổi bật những thông tin, kiến thức bổ ích
Bé còn có thể tô màu trong hơn 100 nhãn dán và dán nhãn sticker này lên các vật dụng cá nhân như sổ tay ghi chép, hộp bút, bình nước, mũ báo hiểm.., chính những nhãn dán sticker này sẽ tạo nên dấu ấn riêng biệt cho bé.
Hộp đựng bút màu trong suốt, kiểu dáng gọn gàng, tiện lợi giúp cố định mọi bút chì màu ở vị trí hoàn hảo, giúp bé dễ dàng mang theo và tận hưởng niềm vui mọi lúc mọi nơi, dù đi học hay đi chơi, du lịch.
Những cây bút màu đến từ thương hiệu 3C4G có tuổi thọ cao này chắc chắn sẽ làm hài lòng những người đam mê vẽ và viết nhật ký ở mọi lứa tuổi.
Thương hiệu: 3C4G – Đến từ vương quốc Anh. Tuổi: 6+ Giới tính: Unisex", "/images/product/30 bút gel pen_65_1.jpg", 1, 20, 219000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ"
, "Nghệ thuật là một trong những hình thức tốt nhất để thể hiện bản thân và cũng là cơ hội định hình và phát triển trí sáng tạo cho bé. Hãy sớm khai phá tiềm năng của bé với bộ sản phẩm phác thảo cực kỳ thú vị này, hãy giúp bé biến các ý tưởng độc đáo thành hiện thực với bộ sản phẩm Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ
Đặc điểm sản phẩm:
- Bộ sản phẩm lấy cảm hứng từ nghệ thuật Tie-dye (nhuộm màu) gồm:
+ 1 cuốn sổ phác thảo có gáy là lò xo xoắn ốc dễ dàng lật mở
+ 6 bút chì màu,
+ 2 tẩy, gọt bút chì và sticker được đóng gói rất lý tưởng để có thể mang đi du lịch, hay đi học
- Bộ sản phẩm giúp phát triển trí tưởng tượng
- Những sticker theo chủ đề sẽ thật hoàn hảo đề giúp bé trang trí vào trang giấy, hay tượng tưởng và vẽ thêm các họa tiết khác.
- Bộ sản phẩm giúp phát triển khả năng tự hiện thực hóa trí tưởng tượng và sáng tạo cho bé.
Thương hiệu: 3C4G
Xuất xứ thương hiệu: Đến từ vương quốc Anh.
Tuổi: 6+ Giới tính: Nam/ Nữ", "/images/product/Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_1.jpg", 1, 20, 229000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Ba lô HiPock - Street Style Trắng"
, "Bộ Sưu tập Street Style được truyền cảm hứng từ phong cách đường phố, cùng với xu hướng Hiphop đang lên ngôi. Các sản phẩm trong bộ sưu tập Street sẽ giúp các bạn trẻ trở nên thật trendy, cá tính và siêu nổi bật dù là đang ở đâu.
Đây là thiết kế độc quyền từ Úc, thuộc nhãn hàng Clever Hippo - là thương hiệu cao cấp chuyên về ba lô, văn phòng phẩm và phụ kiện với chất lượng luôn đặt lên hàng đầu.
Dòng ba lô thời trang Hi-pock có nhiều tính năng nổi bật:
- Trọng lượng siêu nhẹ, thiết kế năng động, thời trang, sử dụng được nhiều mục đích và trang phục khác nhau.
- Các ngăn chứa rộng rãi, ngăn chính có ngăn chống sốc đựng vừa laptop 15 inches .
- Chất liệu polyester trượt nước, dễ dàng vệ sinh.
- Phần túi nhỏ phía trước đựng vừa điện thoại 6.8 inches
- Phần lưng & quai đeo có đệm êm ái, thoáng khí, giúp trợ lực & tạo sự thoải mái khi sử dụng
- Kích thước sản phẩm: 15 x 30 x 43 (cm)
- Trọng lượng: 500g", "/images/product/Ba lô HiPock - Street Style Trắng_67_1.jpg", 1, 30, 656000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Kool Urban - Ba lô Roller Camo Xanh"
, "Bộ sưu ba lô KOOL URBAN đến từ thương hiệu Clever Hippo dành riêng cho các bạn trẻ năng động, cá tính, được thiết kế với các tông màu hiện đại và họa tiết \"on trend\", đi cùng kiểu dáng thời trang. Các sản phẩm trong KOOL URBAN chính là lựa chọn vô cùng phù hợp để đồng hành cùng bạn khám phá khắp nơi.
Các dòng ba lô thời trang còn có nhiều tính năng nổi bật:
- Trọng lượng siêu nhẹ, thiết kế năng động, thời trang, sử dụng được nhiều mục đích và trang phục khác nhau.
- Các ngăn chứa rộng rãi; với thiết kế thông minh mở nhanh từ bên hông giúp cất/lấy đồ nhanh chóng từ ba lô mà không cần mở ngăn chính phía trên như các ba lô thông thường khác
- Đựng vừa laptop 15 inches, thêm ngăn đựng cục sạc kèm theo, đảm bảo gọn gàng và an toàn cho các thiết bị điện tử của bạn
- Hỗ trợ 01 ngăn hông may vải kháng khuẩn giúp cất giữ khẩu trang an toàn.
- Có đệm lưng êm ái, thoáng khí ở phần lưng & vai, giúp trợ lực & tạo sự thoải mái khi sử dụng
- Chất liệu polyester trượt nước, dễ dàng vệ sinh.
- Kích thước sản phẩm: 12 x 30 x 39 (cm)
- Trọng lượng: 550g"
, "/images/product/Kool Urban - Ba lô Roller Camo Xanh_68_1.jpg", 1, 40, 685000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bóp viết 3D - Shark Cage Xanh"
, "Bóp viết 3D Shark Cage với nhiều tính năng và thiết kế nổi bật:
- Thiết kế dập nổi 3D hình ảnh cá mập trên nền họa tiết đại dương giúp sản phẩm nổi bật và ấn tượng.
- Tay charm trang trí chất liệu silicone mềm.
- Các ngăn chứa rộng rãi và phân bổ hợp lí.
- Bề mặt dễ dàng vệ sinh, lau chùi.
- Kích thước sản phẩm: 22 x 13 x 5 (cm)
Shark Cage là thiết kế độc quyền tại Úc , thuộc nhãn hàng Clever Hippop - là thương hiệu cao cấp chuyên về ba lô, văn phòng phẩm và phụ kiện với chất lượng luôn đặt lên hàng đầu."
, "/images/product/Bóp viết 3D - Shark Cage Xanh_69_1.jpg", 1, 40, 207000, 4);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Ba lô dây rút - Joy"
, "Ba lô dây rút - Joy Các mẫu ba lô dây rút Joy có nhiều họa tiết vô cùng đáng yêu ngọt ngào như Panda, Bubble Tea,… dành riêng cho các cô bé điệu đà và năng động, chắc chắn là món phụ kiện không thể thiếu trong các chuyến dã ngoại, vui chơi cuối tuần cùng bạn bè, gia đình. Bên cạnh thiết kế độc đáo, ba lô dây rút còn có các tính năng nổi bật:
- Trọng lượng siêu nhẹ.
- Không gian đựng thoải mái.
- Dễ dàng vệ sinh, giặt sạch.
Kích thước sản phẩm: 31 x 39 (cm)
Các thiết kế đều độc quyền (thiết kế từ Úc hoặc các nhân vật được mua bản quyền), thuộc nhãn hàng Clever Hippo - là thương hiệu cao cấp chuyên về ba lô, văn phòng phẩm và phụ kiện với chất lượng luôn đặt lên hàng đầu.
*Giao hàng ngẫu nhiên"
, "/images/product/Ba lô dây rút - Joy_70_1.jpg", 1, 50, 176000, 4);
 
 -- Robot 
INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443"
, "Robot biến hình cỡ lớn Jerome cuồng phong và thú cưng Jerome có thể biến hình từ máy bay đồ chơi thành robot siêu năng động! Thiết kế mô phỏng như trong phim hoạt hình SuperWings.
Với 10 bước biến hình từ robot sang máy bay và ngược lại. Mỗi bước biến hình sẽ kích thích niềm hứng thú và phấn khởi của trẻ.
Kích thước lớn, thiết kế đẹp mắt tích hợp đèn và âm thanh sôi nổi, độc đáo.
Thú cưng siêu cấp Jerome đi kèm vô cùng dễ thương, ấn nút để thay đổi ánh mắt. Đây sẽ món quà tuyệt vời giành cho các bé
Sản phẩm có sử dụng pin"
, "/images/product/Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_1.jpg", 1, 60, 499000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239"
, "Robot biến hình cỡ lớn Shine lấp lánh đến từ Hàn Quốc, nhận được sự yêu thích của trẻ em trên toàn thế giới.Robot biến hình cỡ lớn - Shine lấp lánh:
- Biến đổi linh hoạt từ robot sang máy bay và ngược lại với 10 bước
- Màu sắc đáng yêu, gần gũi và giống với nguyên tác trong phim
- Sản phẩm không cần sử dụng pin, sử dụng nhựa cao cấp đảm bảo an toàn cho bé."
, "/images/product/Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_1.jpg", 1, 40, 379000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039"
, "Gọi ngay Shine lấp lánh, bạn sẽ cực bất ngờ với các giải pháp dọn dẹp đầy thú vị và siêu gọn gàng
Shine luôn yêu thích sự sạch sẽ bởi vì anh ấy là một chuyến trực thăng chuyên dọn dẹp. Shine chuyên giải quyết các vấn đề lộn xộn, phức tạp. Trợ thủ Caddy, một bộ dụng cụ làm sạch tuyệt vời, dễ dàng biến thành một chiếc xe rác xịn xò với đầy đủ dụng cụ dọn dẹp cần thiết.
Với khả năng biến đổi 2 trạng thái máy bay trực thăng và siêu robot dọn dẹp
Robot có thể chuyển đổi từ mô hình robot sang máy bay và ngược lại chỉ với 3 bước đơn giản.
Màu sắc nguyên bản như bản gốc của phim cùng thiết kế tinh xảo, các góc được bo tròn an toàn cho bàn tay của bé.
Tích hợp các bánh xe có thể di chuyển được
Mỗi nhân vật khác nhau có sức mạnh khác biệt
Sản phẩm được làm từ chất liệu nhựa cao cấp, an toàn tuyệt đối với trẻ nhỏ nên phụ huynh có thể hoàn toàn an tâm cho bé sử dụng.
Siêu robot có kích thước nhỏ gọn, dễ dàng cất giữ và mang theo ở mọi chuyến du lịch.
Màu sắc đồ chơi phong phú, nổi bật cùng thiết kế tinh xảo nhưng vô cùng an toàn, không góc cạnh, mang đến cho bé những giây phút vui chơi thoải mái nhất.
Để trò chơi nhập vai thêm hấp dẫn, các bé ơi sưu tập ngay trọn bộ biệt đội này nha!"
, "/images/product/Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_1.jpg", 1, 50, 129000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288"
, "Căn cứ di chuyển trên không biến hình thành Robot khổng lồ được thiết kế sinh động và giống như nguyên tác từ bộ phim hoạt hình nổi tiếng trên toàn thế giới Superwings
- Biến hình từ trạm căn cứ trên không thành robot khổng lồ và ngược lại.
- Các khớp linh hoạt cho bé thoải mái tạo kiểu chiến đấu.
- Có thể kết hợp và chơi với các nhân vật đồ chơi khác, sưu tập đủ các nhân vật để tạo nên một biệt đội bay siêu đẳng.
- Sản phẩm không sử dụng pin."
, "/images/product/Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_1.jpg", 1, 30, 415000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431"
, "Đồ chơi thú cưng Golden tốc độ, một sản phẩm từ series phim hoạt hình nổi tiếng được yêu thích trên toàn thế giới - SuperWings
- Đội Bay Siêu Đẳng Thú cưng đáng yêu được mô phỏng như phim. Các thú cưng là hỗ trợ tuyệt vời cho biệt đội Super Wings.
- Ấn nút để nhân vật chuyển đổi mắt và phát sáng, mang lại sự đáng yêu ngộ nghĩnh. - Màu sắc đáng yêu, gần gũi và nguyên bản như phim.
- Sưu tập trọn bộ thú cưng để đội bay thật trọn vẹn
- Sản phẩm an toàn và phù hợp cho các bé làm quà tặng.
- Sản phẩm có sử dụng pin"
, "/images/product/Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_1.jpg", 1, 40, 159000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam"
, "Mô hình chất lượng cao đến từ Nhật Bản Chi tiết đặc biệt tinh xảo đến từ các nhân vật trong thế giới Anime Manga Nhật"
, "/images/product/Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_1.jpg", 1, 80, 699000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa"
, "Là dòng Robot thú cưng thế hệ mới của Vecto, với ngoại hình cực kỳ dễ thương, cùng khuôn mặt đáng yêu chắc chắn làm các bé thích mê khi lần đầu nhìn thấy. Bên cạnh đó, còn có hàng loạt chức năng hiện đại có thể kể đến như:
-Tương tác với tiếng vỗ tay
-Hệ thống lập trình thông minh
-Di chuyển nhiều hướng khác nhau
-Chú Robot còn có thể trồng cây chuối, hít đất.
-Nhảy múa theo nhạc cực kỳ điêu luyện
THÔNG TIN VỀ SẢN PHẨM:
Kích thước hộp hàng: 39 x 17 x 28 cm
Chủ đề: VECTO ROBOT
Năm sản xuất: 2022
Xuất xứ thương hiệu: Việt Nam
Chất liệu: Nhựa và kim loại  (An toàn tuyệt đối với bé)
Bộ sản phẩm đồ chơi Robot chú khủng long vui nhộn điều khiển từ xa bao gồm:
1 x Robot khủng long vui nhộn điều khiển từ xa (dụng pin tiểu, không kèm pin)
1 x Remote điều khiển (sử dụng pin tiểu, không kèm pin)
Khoảng cách điều khiển tối ưu: 10 ~ 15m (Không bị ngăn cách bởi tường hoặc vật cản)"
, "/images/product/Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_1.jpg", 1, 80, 599000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương"
, "Robot điều khiển từ xa Mực tuần tra với vẻ ngoài dễ thương đi kèm cùng nhiều chức năng mới lạ như:
- Khả năng phát sáng toàn thân ấn tượng
- Di chuyển mượt mà
- Nhảy múa theo nhạc sống động
THÔNG TIN VỀ SẢN PHẨM:
Kích thước hộp hàng: 19 x 13 x 23 cm
Chủ đề: VECTO ROBOT
Năm sản xuất: 2022
Xuất xứ thương hiệu: Việt Nam
Chất liệu: Nhựa và kim loại  (An toàn tuyệt đối với bé)
Bộ sản phẩm đồ chơi Hộ vệ thép điều khiển từ xa bao gồm:
1 x Robot điều khiển từ xa Mực tuần tra (sử dụng pin tiểu, không kèm pin)
1 x Remote điều khiển (sử dụng pin tiểu, không kèm pin)
Khoảng cách điều khiển tối ưu: 10 ~ 15m (Không bị ngăn cách bởi tường hoặc vật cản)"
, "/images/product/Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_1.jpg", 1, 50, 349000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)"
, "Đáng yêu và nhí nhảnh, nghịch ngợm và thông thái. Robot mèo con thông thái đã đến rồi đây. Ba mẹ đã sẵn sàng rước chú về học tập vui chơi với bé nhà mình chưa?
 - Đố vui các câu hỏi thường thức hay các câu hỏi toán học cùng bé (các câu hỏi sẽ được hỏi bằng tiếng anh – Bé có thể chọn đáp án đúng bằng cách nhấn A,B,C ở trên Remote)
 - Hệ thống lập trình chuỗi hành động độc đáo.
 - Điều khiển linh hoạt tới, lui, trái , phải
 - Chức năng tự động trình diễn
Còn chần chờ gì nữa mà ba mẹ không rước ngay một chú mèo cực kỳ thông minh về nhà để bầu bạn cùng bé.
*Bộ câu hỏi và câu trả lời (tiếng anh) có tích hợp trong sách Hướng dẫn sử dụng đi kèm.
Bộ sản phẩm Robot mèo con thông thái bao gồm:
1 x Mèo con thông thái (xài pin tiểu, không kèm pin)
1 x Remote điều khiển (xài pin tiểu, không kèm pin)
1 x sách hướng dẫn câu hỏi/ cách chơi"
, "/images/product/Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_1.jpg", 1, 30, 479000, 5);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Robot biến hình TOBOT ARCBOLT chiến binh tân tiến"
, "Robot biến hình mini TOBOT ARCBOLT chiến binh tân tiến mạnh mẽ - 301126 là sản phẩm thuộc thương hiệu YOUNG TOYS.INC., một sản phẩm đến từ Series phim hoạt hình được nhiều bạn nhỏ yêu thích – TOBOT. Sản phẩm có các đặc điểm nổi bật như sau:
- Bước 1: Lắp ráp thành chiếc xe thông minh thời thượng Arcbolt.
- Bước 2: Dễ dàng biến hình thành Robot Arcbolt
Thông tin sản phẩm:
- Chứa các chi tiết đều được làm hoàn toàn từ chất liệu nhựa ABS cao cấp, ráp nối với nhau một cách tỉ mỉ, đảm bảo độ chắc chắn cũng như tính mỹ quan của sản phẩm.
- Chất liệu nhựa không bao gồm những thành phần độc hại cho sức khoẻ của trẻ nhỏ khi sử dụng trong thời gian dài."
, "/images/product/Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_1.jpg", 1, 20, 329000, 5);

 -- Búp bê / 80
INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240"
, "Bé Lily Tập Uống Nước Và Đi Bô - DW60240 là dòng búp bê thân mềm với vẻ ngoài xinh xắn, đáng yêu. Các sản phẩm búp bê Dollsworld luôn là sự lựa chọn hàng đầu của các bậc phụ huynh trong việc giáo dục cho con em mình cách yêu thương và quan tâm, chăm sóc cho người khác.
Bé Joy bập bẹ có các đặc điểm nổi bật:
- Búp bê được làm bằng chất liệu mềm mại, nhẹ nhàng, an toàn với sức khỏe của trẻ.
- Thiết kế búp bê được trau chuốt tinh tế, tỉ mỉ, màu sắc tươi sáng, hình dáng búp bê đáng yêu cùng làn da mềm mịn, các chi tiết mắt mũi miệng đều rất tinh xảo.
- Bộ trang phục xinh xắn với mũ trùm đầu đi kèm núm ti giả
- Set gồm bô đi tè, bình sữa, tã và ti giả.
Sản phẩm dành cho các bậc phụ huynh muốn dạy con thông minh qua việc đánh giá, phát triển các năng lực của bé như: độ khéo léo của đôi tay, khả năng tượng tượng, khả năng tập trung, mức độ kiên nhẫn."
, "/images/product/Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_1.jpg", 1, 20, 699000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Thời Trang Du Lịch của Teresa"
, "Cùng đi khắp thế giới với búp bê Teresa™ lấy cảm hứng từ Barbie® It Takes Two™!
Cô nàng Teresa nhỏ nhắn đã sẵn sàng cho cuộc phiêu lưu lớn tiếp theo cùng chú cún cưng và hơn 10 phụ kiện du lịch.
Trang trí vali của cô ấy bằng tấm sticker, sau đó đóng gói ba lô và hành lý của cô ấy - cả dạng mở và dạng đóng để phù hợp với những vật dụng cần thiết khi đi du lịch của cô ấy!
Búp bê Teresa™ đã sẵn sàng cất cánh trong bộ trang phục du lịch dễ thương và các thiết bị như gối kê cổ, bàn chải đánh răng, điện thoại, máy ảnh, v.v.!"
, "/images/product/Thời Trang Du Lịch của Teresa_82_1.jpg", 1, 40, 679000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ"
, "Cô nàng búp bê OMG Sunshine tỏa tắng - Bubblegum DJ vẻ ngoài vô cùng ấn tượng và khả năng đổi màu đầy bất ngờ. Cô ấy thích kết hợp những bộ thời trang đầy màu sắc của mình từ đầu đến chân giống như cách cô ấy kết hợp âm nhạc của mình.
Chắc chắn bạn sẽ vô cùng bất ngờ với khả năng đổi màu của cô nàng. Chỉ cần tiếp xúc với ánh sáng ngoài trời, tất cả vẻ ngoài của cô nàng sẽ đổi màu, từ mái tóc, trang phục, vớ + giày.
Chi tiết sản phẩm:
+ 1 búp bê sành điệu
+ Các phụ kiện thời trang: lược, trang phục, nơ, mắt kính, bông tai
+ Khả năng thay đổi màu sắc khi tiếp xúc với ánh sáng mặt trời.
+ Bé có thể lặp đi lặp lại các thay đổi màu sắc nhiều lần. Quay trở lại trong nhà để cô nàng trở lại hình dáng ban đầu và đưa ra ngoài sánh sáng mặt trời để trải nghiệm lại những màn biến đổi tuyệt đẹp của cô ấy."
, "/images/product/Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_1.jpg", 1, 20, 922000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi búp bê-ONE PIECE IT'S A BANQUET!!-MONKEY.D.LUFFY"
, "Mô hình chất lượng cao đến từ Nhật Bản Chi tiết đặc biệt tinh xảo đến từ các nhân vật trong thế giới Anime Manga Nhật"
, "/images/product/Đồ chơi búp bê-ONE PIECE IT'S A BANQUET!!-MONKEY.D.LUFFY_84_1.jpg", 1, 30, 869000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)"
, "Mô hình chất lượng cao đến từ Nhật Bản Chi tiết đặc biệt tinh xảo đến từ các nhân vật trong thế giới Anime Manga Nhật"
, "/images/product/Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_1.jpg", 1, 40, 869000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Búp bê Barbie Mini Mini Extra - TURQUOISE / PINK CANDY"
, "Barbie® Extra Mini Minis™ là những con búp bê nhỏ 3,25 inch (8,2cm) làm nổi bật những kiểu thời trang và kiểu tóc tuyệt vời.
Con búp bê Barbie® Extra Mini Minis™ này mang đến một làn gió điệu đà cũng những phụ kiện xinh xắn
Bốn phụ kiện nâng tầm bộ trang phục của cô ấy: kính râm màu, hoa tai dài màu hồng, túi đeo chéo hồng và đôi boost vàng.
Với bộ trang phục bắt mắt như vậy, con búp bê này được dùng để trưng bày! Cô ấy đi kèm với một giá đỡ búp bê có logo Barbie® Extra Mini Minis™.
Búp bê Barbie® Extra Mini Minis™ khuyến khích khám phá phong cách sáng tạo và chơi thời trang, tạo ra những món quà tuyệt vời cho những người yêu thời trang."
, "/images/product/Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_1.jpg", 1, 50, 259000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Búp bê Barbie Mini Mini Extra - BLUE/PINK HAIR"
, "Barbie® Extra Mini Minis™ là những con búp bê nhỏ 3,25 inch (8,2cm) làm nổi bật những kiểu thời trang và kiểu tóc tuyệt vời.
Con búp bê Barbie® Extra Mini Minis™ này mang đến cảm giác thể thao! Cô ấy có mái tóc dài màu xanh sọc hồng và mặc áo cầu vồng, váy hồng với áo khoác trong suốt.
Bốn phụ kiện nâng tầm bộ trang phục của cô ấy: kính râm màu, hoa tai hình trái tim, túi xách và giày trượt patin màu đỏ - bởi vì còn gì tuyệt hơn là lướt trên bánh xe?!
Với bộ trang phục bắt mắt như vậy, con búp bê này được dùng để trưng bày! Cô ấy đi kèm với một giá đỡ búp bê có logo Barbie® Extra Mini Minis™.
Búp bê Barbie® Extra Mini Minis™ khuyến khích khám phá phong cách sáng tạo và chơi thời trang, tạo ra những món quà tuyệt vời cho những người yêu thời trang."
, "/images/product/Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_1.jpg", 1, 30, 259000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Thời Trang Du Lịch của Barbie"
, "Hãy cùng Barbie Malibu đi khắp thế giới cùng những phụ kiện du lịch thời trang.
Búp bê Barbie® đã sẵn sàng cho cuộc phiêu lưu mới tiếp theo cùng với chú cún cưng của mình và hơn 10 phụ kiện du lịch.
Trang trí vali của cô ấy bằng tấm sticker, sau đó đóng gói ba lô và hành lý của cô ấy - cả dạng mở và dạng đóng để phù hợp với những vật dụng cần thiết khi đi du lịch của cô ấy!
Búp bê Barbie® đã sẵn sàng cất cánh bay trong bộ trang phục du lịch dễ thương (có váy in hình bầu trời) và có các món phụ kiện theo chủ đề du lịch như gối kê cổ hình mèo con, bàn chải đánh răng, tai nghe, máy ảnh, v.v.!"
, "/images/product/Thời Trang Du Lịch của Barbie_88_1.jpg", 1, 40, 679000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây"
, "Với 7 điều bất ngờ bên trong, búp bê Barbie® Color Reveal™ mang đến đủ niềm vui -- khám phá Barbie kết hợp Dòng trái cây ngọt ngào với Cải tiến mới.
Tháo lớp bao bì bên ngoài, mở chiếc hộp hình ống và lấy ra một con búp bê Barbie® có vẻ ngoài được bao phủ bởi lớp phủ in hình trái cây và 4 chiếc túi được trang trí bí ẩn!
Đổ đầy nước ấm vào ống, đặt búp bê vào trong và xoay tròn -- nước chuyển sang màu tím đẹp mắt để tạo hiệu ứng kỳ diệu!
Búp bê sẽ lộ ra diện mạo thật -- mỗi con búp bê trong sê-ri đều có mái tóc dài nhiều màu sắc, áo có hoa văn và mùi hương trái cây ngọt ngào. Có thể bao gồm anh đào, dâu tây, dưa hấu, chanh và dứa.
Mở 4 chiếc túi bí ẩn để tiết lộ những điều bất ngờ -- một chiếc áo và váy có in hình trái cây phù hợp, một đôi giày, một cặp kính râm và một chiếc vòng cổ; cất giữ chúng trong hộp hình ống sau khi chơi!
Sử dụng nước ấm và lạnh để chuyển đổi màu sắc có thể lặp đi lặp lại nhiều lần -- thay đổi màu mắt và màu môi của búp bê!
Búp bê Barbie® Color Reveal™ Sweet Fruit hiếm có ví quả dứa và phần tóc nối màu hồng sáng, hãy tìm ngay!"
, "/images/product/Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_1.jpg", 1, 50, 567000, 6);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Búp bê LOL SURPRISE - SOO MINI"
, "Giới thiệu búp bê LOL SURPRISE hoàn toàn mới với thiết kế kiểu tóc độc đáo, không chỉ thế, bé có thể khám phá các phụ kiện bên trong bộ tóc của các cô nàng búp bê Đặc điểm sản phẩm:
+ 1 búp bê LOL Surprise và 7 phụ kiện đi kèm
+ Mở từng lớp bất ngờ để khám phá phụ kiện bí ẩn bên trong các kiểu tóc
+ Mỗi bạn búp bê sẽ ẩn chứa khả năng đặc biệt khi được cho vào nước
+ Sưu tập trọn bộ 12 cô nàng LOL Surprise Soo Mini đáng yêu"
, "/images/product/Búp bê LOL SURPRISE - SOO MINI_90_1.jpg", 1, 60, 379000, 3);

 -- Mô phỏng / 91
INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Vali bác sĩ màu hồng"
, "Đồ chơi vali bác sĩ màu hồng ECOIFFIER 002875 mô phỏng dụng cụ y tế, bé cùng bạn bè sẽ đóng vai y tá hoặc bác sĩ. Thông qua món đồ chơi nhập vai này, bố mẹ có thể giúp con có nhận thức về lĩnh vực y tế, có cái nhìn bao quát về sức khỏe, hơn nữa là không làm con sợ hãi khi đi khám bệnh. 
 Vali bác sĩ màu hồng được yêu thích bởi những đặc điểm nổi bật sau:
Đồ chơi được làm từ nhựa cao cấp, không gây kích ứng da cho trẻ.
Màu sắc bắt mắt, kích thích thị giác của trẻ.
Có nhiều phụ kiện như ống nghe, băng keo cá nhân,… thích hợp để bé chơi cùng bạn bè hay người thân, từ đó giúp bé phát triển khả năng ngôn ngữ.
Hiểu được công dụng của từng món đồ chơi sẽ giúp bé có cái nhìn thực tế, biết cách chăm sóc bản thân và những người xung quanh.
Tất cả các phụ kiện đều được sắp xếp gọn gàng trong vali, dễ dàng bảo quản.
Đồ chơi được thiết kế chắc chắn, không góc cạnh, không làm trầy xước da bé khi chơi.
Sản phẩm được khuyên dành cho các bé trai và bé gái trên 1 tuổi."
, "/images/product/Vali bác sĩ màu hồng_91_1.jpg", 1, 30, 379000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ đồ ăn cho bé"
, "Đồ chơi đồ dùng nhà bếp Ecoiffier - Bộ đồ ăn cho bé ECOIFFIER 002877 là một bộ sản phẩm không thể thiếu đối với các bé có đam mê về lĩnh vực nấu ăn. Với bộ dụng cụ phong phú đa dạng các bé có thể thỏa sức sáng tạo hóa thân thành một đầu bếp thực thụ, chế biến ra những món ăn, thức uống ngon miệng dành tặng cho bản thân, bạn bè và gia đình.
Đồ chơi bộ dụng cụ nhà bếp Ecoiffier- Bộ đồ ăn cho bé hứa hẹn sẽ mang đến cho bé những giây phút vui chơi thú vị và những bài học mới về các kỹ năng trong cuộc sống. Sản phẩm có các đặc điểm sau:
Tất cả chi tiết đều sử dụng chất liệu cao cấp, an toàn, thân thiện với trẻ em cũng như tính bền đẹp, chắc chắn, dễ dàng bảo quản.
Bộ Ecoiffier 002877 gồm các dụng cụ đa dạng như: máy xay sinh tố, bình sữa, cốc, chai sữa, rau củ, hoa quả, đĩa, thìa, nĩa,… 
Bề mặt các chi tiết đều được mài nhẵn, không góc cạnh, không gây trầy xước da bé.
Màu sắc sản phẩm sinh động, tươi sáng, giúp kích thích thị giác của bé.
Tất cả các dụng cụ nhà bếp được sắp xếp gọn gàng trong chiếc giỏ màu hồng, giúp bé rèn luyện tính ngăn nắp ngay khi còn nhỏ."
, "/images/product/Bộ đồ ăn cho bé_92_1.jpg", 1, 40, 370000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi bé làm bác sĩ"
, "Đồ chơi B.BRAND bé làm bác sĩ BX1230Z là đồ chơi hàng đầu tại Canada, sử dụng công nghệ tiên tiến giúp bé có thể vừa vui chơi vừa làm quen với các hoạt động gần gũi với thế giới quan. Các sản phẩm đồ chơi B.Brand đều có một giá trị nhất định về giáo dục, phát triển kỹ năng vận động, tư duy logic, sự sáng tạo qua các dòng sản phẩm đồ chơi của hãng.
Đồ chơi bác sĩ B.BRAND bé làm bác sĩ BX1230Z gây ấn tượng với những đặc điểm nổi bật sau đây:
Bộ đồ chơi gọn nhẹ, được bỏ trong cặp xinh xắn giúp bé hay bố mẹ có thể mang đi mọi lúc mọi nơi để bé có thể chơi cùng bạn bè, người thân ở bất cứ đâu. Điều này hỗ trợ bé có sự tương tác, tăng thêm tình cảm của bé đối với những người xung quanh.
Bộ đồ chơi nhập vai bác sĩ giúp bé hóa thân thành bác sĩ để có thể hiểu biết thêm về công việc. Từ đây giúp bé hiểu hơn về 1 trong các ngành nghề trong xã hội và phần nào định hướng được nghề nghiệp của bé sau này.
Đồ chơi giúp bé giải trí, phát triển trí não và tính cách của bé. 
Sản phẩm được làm từ nhựa cao cấp không góc cạnh giúp đảm bảo an toàn cho bé trong quá trình chơi.
Bộ sản phẩm có thiết kế sinh động, gần giống như thật nhằm tăng thêm cảm giác thích thú cho bé khi chơi.
Sản phẩm phù hợp với các bé có độ tuổi từ 1 tuổi trở lên."
, "/images/product/Đồ chơi bé làm bác sĩ_93_1.jpg", 1, 70, 879000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ đồ chơi bác sĩ thú cưng"
, "Đồ Chơi BATTAT bộ đồ chơi bác sĩ thú cưng BT2538Z là đồ chơi số 1 tại Canada, sử dụng công nghệ tiên tiến giúp bé có thể vừa vui chơi vừa làm quen với các hoạt động gần gũi với thế giới quan. Đồ chơi Battar sẽ mang đến nhiều lợi ích, giúp bé phát triển toàn diện về trí não lẫn thể chất. Sản phẩm được đánh giá cao về chất lượng an toàn với sức khỏe của trẻ em.
Đồ chơi nhập vai BATTAT bộ đồ chơi bác sĩ thú cưng BT2538Z gây ấn tượng với những đặc điểm nổi bật sau đây:
Sản phẩm được làm từ nhựa cao cấp không góc cạnh giúp đảm bảo an toàn cho bé trong quá trình chơi.
Bộ sản phẩm có thiết kế sinh động, gần giống như thật nhằm tăng thêm cảm giác thích thú cho bé khi chơi.
Bộ đồ chơi gọn nhẹ, được bỏ trong cặp xinh xắn giúp bé hay bố mẹ có thể mang đi mọi lúc mọi nơi để bé có thể chơi cùng bạn bè, người thân ở bất cứ đâu. Điều này hỗ trợ bé có sự tương tác, tăng thêm tình cảm của bé đối với những người xung quanh.
Đồ chơi giúp bé giải trí, phát triển trí não và tính cách của bé. 
Bộ đồ chơi nhập vai bác sĩ thú cưng giúp bé hóa thân thành bác sĩ để có thể hiểu biết thêm về công việc. Từ đây giúp bé hiểu hơn về 1 trong các ngành nghề trong xã hội và phần nào định hướng được nghề nghiệp của bé sau này.
Sản phẩm phù hợp với các bé có độ tuổi từ 2 tuổi trở lên."
, "/images/product/Bộ đồ chơi bác sĩ thú cưng_94_1.jpg", 1, 30, 779000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Tủ Lạnh Mini Đỏ SWEET HEART SH6537"
, "Đồ chơi tủ lạnh với 34 chi tiết. Tủ lạnh được tích hợp đèn và âm thanh. Có bếp tạo hiệu ứng hơi nước mô phỏng hơi lạnh khi lấy đá ra khỏi tủ lạnh. Ngoài ra còn có các loại đồ ăn thức uống khác như kem, trái cây, đồ hộp, nước ngọt,...
Sản phẩm đến từ thương hiệu Sweet Heart. Các thành phần của đồ chơi được làm bằng nhựa cao cấp, thiết kế sản phẩm không góc cạnh mang đến sự an toàn cho bé."
, "/images/product/Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_1.jpg", 1, 30, 399000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073"
, "Sweet Heart Đồ Chơi Chuồng Thú Cưng Mini Chó Nâu 5070/SH5073 Đồ chơi chuồng thú cưng Mini Chó Nâu bao gồm 1 chuồng chú cưng, 1 em cún nhỏ nhắn đáng yêu cùng các phụ kiện ngộ nghĩnh đi kèm để bé thoả sức tương tác và chơi cùng em cún. Bé yêu cún, muốn có một em cún để chơi cùng nhưng bố mẹ ngại dơ nhà, ngại vệ sinh, ngại chăm ăn thì đây chắc chắn là món đồ chơi có thể xử lý được các quan ngại của bố mẹ. Với đồ chơi chuồng thú cưng, ngoài giúp cho bé biết khả năng chăm cún mà còn tạo cho bé có tình yêu với động vật."
, "/images/product/Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_1.jpg", 1, 30, 499000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ quầy siêu thị di động hiện đại"
, "Tận hưởng trải nghiệm mua sắm cho bé yêu với bộ trò chơi Quầy siêu thị di động hiện đại.
Bộ trò chơi mô phỏng một quầy bán hàng tại siêu thị với đầy đủ vật dụng cần thiết cho bé cưng của bạn như:
Máy tính tiền chuyên nghiệp. Bé có thể nhấn nút để mở hộc đựng tiền.
Giỏ siêu thị màu xanh xinh xắn.
Quầy siêu thị kèm bánh xe dễ dàng vận chuyển
Các loại thực phẩm như sữa, đồ hộp và rau củ trái cây các loại
Bộ trò chơi mang đến cho bé những giây phút vui chơi cùng bạn bè hoặc anh chị. Giúp bé yêu có thể vừa học vừa chơi, phân biệt được các loại thực phẩm khác nhau.
Sản phẩm đến từ thương hiệu Sweet Heart. Thành phần của đồ chơi được làm từ nhựa cao cấp, thiết kế sản phẩm không góc cạnh, đảm bảo an toàn cho bé."
, "/images/product/Bộ quầy siêu thị di động hiện đại_97_1.jpg", 1, 70, 447000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092"
, "Chiếc bàn trang điểm cực xinh cho bé yêu thích làm điệu. Với thiết kế chắc chắn, màu sắc tươi tắn, chiếc bàn trang điểm này chắc chắn sẽ mang đến cho bé những giây phút vui chơi bổ ích.
Bàn trang điểm được tích hợp với 1 chiếc đàn piano với âm thanh trong trẻo. Bé có thể tự đàn hoặc mở những bài nhạc vui nhộn có sẵn trong máy. Chiếc gương của bàn trang điểm cũng có những âm thanh vui tai khác nữa. Ngoài ra khi bé ấn nút ở gương, nhạc sẽ phát và hình ảnh nàng công chúa xinh đẹp sẽ hiện lên trong gương. Bộ trò chơi còn đi kèm các phụ kiện khác như ghế ngồi, máy sấy tóc, các phụ kiện trang điểm, dây chuyền…
Sản phẩm đến từ thương hiệu Sweet Heart. Thành phần của đồ chơi được làm từ nhựa cao cấp, thiết kế sản phẩm không góc cạnh, đảm bảo an toàn cho bé."
, "/images/product/Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_1.jpg", 1, 100, 622000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đồ chơi lò nướng bánh diệu kỳ"
, "Gồm 16 phụ kiện để chuẩn bị thức ăn như: Bánh Piza, bánh mì, trứng ốp la, khay, dĩa ,...
Có 30 bài hát + từ vựng Tiếng Anh cho bé
5 chế độ độ nướng bánh giúp bé học đếm số và biết được thời gian nhiệt độ
Phát triển tư duy Logic, toán học qua việc cắt, chia thức ăn ra thành 2,3 hoặc 4 phần bằng nhau.
Phù hợp cho bé từ 2 tuổi
Sử dụng pin 3AA"
, "/images/product/Đồ chơi lò nướng bánh diệu kỳ_99_1.jpg", 1, 80, 879000, 7);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Bộ đồ chơi bữa tiệc trà chiều"
, "Bộ đồ chơi bữa tiệc trà chiều - SH328-2. Còn gì tuyệt vời hơn nhâm nhi một ly trà và một miếng bánh vào buổi chiều mát mẻ nhỉ! Thông tin sản phẩm : Bộ trò chơi gồm 1 ấm trà, 4 tách trà, 4 khay đựng cốc, 2 thìa, 2 nĩa, 2 bánh kem, 1 bánh cupcake, 2 bánh donut và nhiều phụ kiện khác. Bé có thể cho nước vào ấm trà và chơi cùng. Một buổi tiệc trà nho nhỏ với những người bạn của bé chắc chắn sẽ rất thú vị đúng không nào. Bộ sản phẩm đến từ thương hiệu Sweet Heart. Thành phần của đồ chơi được làm từ thành phần tự nhiên, thiết kế sản phẩm không góc cạnh, đảm bảo an toàn cho bé. Đây chắc chắn sẽ là món quà tuyệt vời cho bé yêu của bạn, giúp thúc đẩy sự sáng tạo, khả năng vận động và sự phối hợp giữa tay và mắt. Mang đến cho bé những giây phút vui chơi bổ ích."
, "/images/product/Bộ đồ chơi bữa tiệc trà chiều_100_1.jpg", 1, 90, 299000, 7);

-- Insert image 
INSERT INTO Image(imageName, url, productID) VALUES ('30 bút gel pen_65_1.jpg', '/images/product/30 bút gel pen_65_1.jpg', 65);

INSERT INTO Image(imageName, url, productID) VALUES ('30 bút gel pen_65_2.jpg', '/images/product/30 bút gel pen_65_2.jpg', 65);

INSERT INTO Image(imageName, url, productID) VALUES ('30 bút gel pen_65_3.jpg', '/images/product/30 bút gel pen_65_3.jpg', 65);

INSERT INTO Image(imageName, url, productID) VALUES ('30 bút gel pen_65_4.jpg', '/images/product/30 bút gel pen_65_4.jpg', 65);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô dây rút - Joy_70_1.jpg', '/images/product/Ba lô dây rút - Joy_70_1.jpg', 70);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô dây rút - Joy_70_2.jpg', '/images/product/Ba lô dây rút - Joy_70_2.jpg', 70);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô dây rút - Joy_70_3.jpg', '/images/product/Ba lô dây rút - Joy_70_3.jpg', 70);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô dây rút - Joy_70_4.jpg', '/images/product/Ba lô dây rút - Joy_70_4.jpg', 70);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Clever Monster Vàng_62_1.jpg', '/images/product/Ba lô Easy Go - Clever Monster Vàng_62_1.jpg', 62);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Clever Monster Vàng_62_2.jpg', '/images/product/Ba lô Easy Go - Clever Monster Vàng_62_2.jpg', 62);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Clever Monster Vàng_62_3.jpg', '/images/product/Ba lô Easy Go - Clever Monster Vàng_62_3.jpg', 62);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Clever Monster Vàng_62_4.jpg', '/images/product/Ba lô Easy Go - Clever Monster Vàng_62_4.jpg', 62);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Racing Car Xanh dương_63_1.jpg', '/images/product/Ba lô Easy Go - Racing Car Xanh dương_63_1.jpg', 63);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Racing Car Xanh dương_63_2.jpg', '/images/product/Ba lô Easy Go - Racing Car Xanh dương_63_2.jpg', 63);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Racing Car Xanh dương_63_3.jpg', '/images/product/Ba lô Easy Go - Racing Car Xanh dương_63_3.jpg', 63);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Easy Go - Racing Car Xanh dương_63_4.jpg', '/images/product/Ba lô Easy Go - Racing Car Xanh dương_63_4.jpg', 63);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô HiPock - Street Style Trắng_67_1.jpg', '/images/product/Ba lô HiPock - Street Style Trắng_67_1.jpg', 67);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô HiPock - Street Style Trắng_67_2.jpg', '/images/product/Ba lô HiPock - Street Style Trắng_67_2.jpg', 67);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô HiPock - Street Style Trắng_67_3.jpg', '/images/product/Ba lô HiPock - Street Style Trắng_67_3.jpg', 67);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô HiPock - Street Style Trắng_67_4.jpg', '/images/product/Ba lô HiPock - Street Style Trắng_67_4.jpg', 67);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_1.jpg', '/images/product/Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_1.jpg', 61);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_2.jpg', '/images/product/Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_2.jpg', 61);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_3.jpg', '/images/product/Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_3.jpg', 61);

INSERT INTO Image(imageName, url, productID) VALUES ('Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_4.jpg', '/images/product/Ba lô Hoodie - Kì Lân Ngân Hà Tím_61_4.jpg', 61);

INSERT INTO Image(imageName, url, productID) VALUES ('Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_1.jpg', '/images/product/Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_1.jpg', 31);

INSERT INTO Image(imageName, url, productID) VALUES ('Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_2.jpg', '/images/product/Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_2.jpg', 31);

INSERT INTO Image(imageName, url, productID) VALUES ('Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_3.jpg', '/images/product/Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_3.jpg', 31);

INSERT INTO Image(imageName, url, productID) VALUES ('Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_4.jpg', '/images/product/Bánh kem ngọt ngào Super Fluffy Slimy Vàng SLIMY_31_4.jpg', 31);

INSERT INTO Image(imageName, url, productID) VALUES ('Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_1.jpg', '/images/product/Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_1.jpg', 81);

INSERT INTO Image(imageName, url, productID) VALUES ('Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_2.jpg', '/images/product/Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_2.jpg', 81);

INSERT INTO Image(imageName, url, productID) VALUES ('Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_3.jpg', '/images/product/Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_3.jpg', 81);

INSERT INTO Image(imageName, url, productID) VALUES ('Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_4.jpg', '/images/product/Bé Lily Tập Uống Nước Và Đi Bô DOLLSWORLD DW60240_81_4.jpg', 81);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết 3D - Shark Cage Xanh_69_1.jpg', '/images/product/Bóp viết 3D - Shark Cage Xanh_69_1.jpg', 69);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết 3D - Shark Cage Xanh_69_2.jpg', '/images/product/Bóp viết 3D - Shark Cage Xanh_69_2.jpg', 69);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết 3D - Shark Cage Xanh_69_3.jpg', '/images/product/Bóp viết 3D - Shark Cage Xanh_69_3.jpg', 69);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết 3D - Shark Cage Xanh_69_4.jpg', '/images/product/Bóp viết 3D - Shark Cage Xanh_69_4.jpg', 69);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết Classic - Clever Monster Vàng_64_1.jpg', '/images/product/Bóp viết Classic - Clever Monster Vàng_64_1.jpg', 64);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết Classic - Clever Monster Vàng_64_2.jpg', '/images/product/Bóp viết Classic - Clever Monster Vàng_64_2.jpg', 64);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết Classic - Clever Monster Vàng_64_3.jpg', '/images/product/Bóp viết Classic - Clever Monster Vàng_64_3.jpg', 64);

INSERT INTO Image(imageName, url, productID) VALUES ('Bóp viết Classic - Clever Monster Vàng_64_4.jpg', '/images/product/Bóp viết Classic - Clever Monster Vàng_64_4.jpg', 64);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_1.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_1.jpg', 87);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_2.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_2.jpg', 87);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_3.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_3.jpg', 87);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_4.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - BLUE_PINK HAIR_87_4.jpg', 87);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_1.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_1.jpg', 86);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_2.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_2.jpg', 86);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_3.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_3.jpg', 86);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_4.jpg', '/images/product/Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_4.jpg', 86);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_1.jpg', '/images/product/Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_1.jpg', 89);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_2.jpg', '/images/product/Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_2.jpg', 89);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_3.jpg', '/images/product/Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_3.jpg', 89);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_4.jpg', '/images/product/Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_4.jpg', 89);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê LOL SURPRISE - SOO MINI_90_1.jpg', '/images/product/Búp bê LOL SURPRISE - SOO MINI_90_1.jpg', 90);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê LOL SURPRISE - SOO MINI_90_2.jpg', '/images/product/Búp bê LOL SURPRISE - SOO MINI_90_2.jpg', 90);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê LOL SURPRISE - SOO MINI_90_3.jpg', '/images/product/Búp bê LOL SURPRISE - SOO MINI_90_3.jpg', 90);

INSERT INTO Image(imageName, url, productID) VALUES ('Búp bê LOL SURPRISE - SOO MINI_90_4.jpg', '/images/product/Búp bê LOL SURPRISE - SOO MINI_90_4.jpg', 90);

INSERT INTO Image(imageName, url, productID) VALUES ('Bút bi hình xoắn ốc_59_1.jpg', '/images/product/Bút bi hình xoắn ốc_59_1.jpg', 59);

INSERT INTO Image(imageName, url, productID) VALUES ('Bút bi hình xoắn ốc_59_2.jpg', '/images/product/Bút bi hình xoắn ốc_59_2.jpg', 59);

INSERT INTO Image(imageName, url, productID) VALUES ('Bút bi hình xoắn ốc_59_3.jpg', '/images/product/Bút bi hình xoắn ốc_59_3.jpg', 59);

INSERT INTO Image(imageName, url, productID) VALUES ('Bút bi hình xoắn ốc_59_4.jpg', '/images/product/Bút bi hình xoắn ốc_59_4.jpg', 59);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_1.jpg', '/images/product/Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_1.jpg', 98);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_2.jpg', '/images/product/Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_2.jpg', 98);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_3.jpg', '/images/product/Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_3.jpg', 98);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_4.jpg', '/images/product/Bộ Bàn Trang Điểm Kèm Piano SWEET HEART SH0092_98_4.jpg', 98);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_1.jpg', '/images/product/Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_1.jpg', 27);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_2.jpg', '/images/product/Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_2.jpg', 27);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_3.jpg', '/images/product/Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_3.jpg', 27);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_4.jpg', '/images/product/Bộ Chế Tạo Độc Dược Thần Kỳ STYLE4EVER SSC196_27_4.jpg', 27);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ cờ Nhà Hufflepuff_2_1.jpg', '/images/product/Bộ cờ Nhà Hufflepuff_2_1.jpg', 2);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ cờ Nhà Hufflepuff_2_2.jpg', '/images/product/Bộ cờ Nhà Hufflepuff_2_2.jpg', 2);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ cờ Nhà Hufflepuff_2_3.jpg', '/images/product/Bộ cờ Nhà Hufflepuff_2_3.jpg', 2);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ cờ Nhà Hufflepuff_2_4.jpg', '/images/product/Bộ cờ Nhà Hufflepuff_2_4.jpg', 2);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_1.jpg', '/images/product/Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_1.jpg', 23);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_2.jpg', '/images/product/Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_2.jpg', 23);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_3.jpg', '/images/product/Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_3.jpg', 23);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_4.jpg', '/images/product/Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_4.jpg', 23);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Gạch Sáng Tạo Pixel_12_1.jpg', '/images/product/Bộ Gạch Sáng Tạo Pixel_12_1.jpg', 12);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Gạch Sáng Tạo Pixel_12_2.jpg', '/images/product/Bộ Gạch Sáng Tạo Pixel_12_2.jpg', 12);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Gạch Sáng Tạo Pixel_12_3.jpg', '/images/product/Bộ Gạch Sáng Tạo Pixel_12_3.jpg', 12);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Gạch Sáng Tạo Pixel_12_4.jpg', '/images/product/Bộ Gạch Sáng Tạo Pixel_12_4.jpg', 12);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_1.jpg', '/images/product/Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_1.jpg', 26);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_2.jpg', '/images/product/Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_2.jpg', 26);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_3.jpg', '/images/product/Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_3.jpg', 26);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_4.jpg', '/images/product/Bộ Phun Sơn Thú Cưng Mini Bí Ẩn STYLE4EVER OFG282_26_4.jpg', 26);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ quầy siêu thị di động hiện đại_97_1.jpg', '/images/product/Bộ quầy siêu thị di động hiện đại_97_1.jpg', 97);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ quầy siêu thị di động hiện đại_97_2.jpg', '/images/product/Bộ quầy siêu thị di động hiện đại_97_2.jpg', 97);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ quầy siêu thị di động hiện đại_97_3.jpg', '/images/product/Bộ quầy siêu thị di động hiện đại_97_3.jpg', 97);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ quầy siêu thị di động hiện đại_97_4.jpg', '/images/product/Bộ quầy siêu thị di động hiện đại_97_4.jpg', 97);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ sổ bút - Graffiti Light Up Rainbow_56_1.jpg', '/images/product/Bộ sổ bút - Graffiti Light Up Rainbow_56_1.jpg', 56);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ sổ bút - Graffiti Light Up Rainbow_56_2.jpg', '/images/product/Bộ sổ bút - Graffiti Light Up Rainbow_56_2.jpg', 56);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ sổ bút - Graffiti Light Up Rainbow_56_3.jpg', '/images/product/Bộ sổ bút - Graffiti Light Up Rainbow_56_3.jpg', 56);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ sổ bút - Graffiti Light Up Rainbow_56_4.jpg', '/images/product/Bộ sổ bút - Graffiti Light Up Rainbow_56_4.jpg', 56);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_1.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_1.jpg', 25);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_2.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_2.jpg', 25);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_3.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_3.jpg', 25);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_4.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_4.jpg', 25);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_1.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_1.jpg', 24);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_2.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_2.jpg', 24);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_3.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_3.jpg', 24);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_4.jpg', '/images/product/Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_4.jpg', 24);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_1.jpg', '/images/product/Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_1.jpg', 29);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_2.jpg', '/images/product/Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_2.jpg', 29);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_3.jpg', '/images/product/Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_3.jpg', 29);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_4.jpg', '/images/product/Bộ Thiết Kế Đèn Lava STYLE4EVER OFG180_29_4.jpg', 29);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_1.jpg', '/images/product/Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_1.jpg', 33);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_2.jpg', '/images/product/Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_2.jpg', 33);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_3.jpg', '/images/product/Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_3.jpg', 33);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_4.jpg', '/images/product/Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_4.jpg', 33);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Làm Tuyết_34_1.jpg', '/images/product/Bộ Thí Nghiệm Làm Tuyết_34_1.jpg', 34);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Làm Tuyết_34_2.jpg', '/images/product/Bộ Thí Nghiệm Làm Tuyết_34_2.jpg', 34);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Làm Tuyết_34_3.jpg', '/images/product/Bộ Thí Nghiệm Làm Tuyết_34_3.jpg', 34);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ Thí Nghiệm Làm Tuyết_34_4.jpg', '/images/product/Bộ Thí Nghiệm Làm Tuyết_34_4.jpg', 34);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bác sĩ thú cưng_94_1.jpg', '/images/product/Bộ đồ chơi bác sĩ thú cưng_94_1.jpg', 94);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bác sĩ thú cưng_94_2.jpg', '/images/product/Bộ đồ chơi bác sĩ thú cưng_94_2.jpg', 94);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bác sĩ thú cưng_94_3.jpg', '/images/product/Bộ đồ chơi bác sĩ thú cưng_94_3.jpg', 94);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bác sĩ thú cưng_94_4.jpg', '/images/product/Bộ đồ chơi bác sĩ thú cưng_94_4.jpg', 94);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bữa tiệc trà chiều_100_1.jpg', '/images/product/Bộ đồ chơi bữa tiệc trà chiều_100_1.jpg', 00);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bữa tiệc trà chiều_100_2.jpg', '/images/product/Bộ đồ chơi bữa tiệc trà chiều_100_2.jpg', 00);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bữa tiệc trà chiều_100_3.jpg', '/images/product/Bộ đồ chơi bữa tiệc trà chiều_100_3.jpg', 00);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ chơi bữa tiệc trà chiều_100_4.jpg', '/images/product/Bộ đồ chơi bữa tiệc trà chiều_100_4.jpg', 00);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_1.jpg', '/images/product/Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_1.jpg', 60);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_2.jpg', '/images/product/Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_2.jpg', 60);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_3.jpg', '/images/product/Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_3.jpg', 60);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_4.jpg', '/images/product/Bộ đồ dùng văn phòng phẩm - Sparkle Star Hồng_60_4.jpg', 60);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ ăn cho bé_92_1.jpg', '/images/product/Bộ đồ ăn cho bé_92_1.jpg', 92);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ ăn cho bé_92_2.jpg', '/images/product/Bộ đồ ăn cho bé_92_2.jpg', 92);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ ăn cho bé_92_3.jpg', '/images/product/Bộ đồ ăn cho bé_92_3.jpg', 92);

INSERT INTO Image(imageName, url, productID) VALUES ('Bộ đồ ăn cho bé_92_4.jpg', '/images/product/Bộ đồ ăn cho bé_92_4.jpg', 92);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Hulk_15_1.jpg', '/images/product/Chiến Giáp Hulk_15_1.jpg', 15);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Hulk_15_2.jpg', '/images/product/Chiến Giáp Hulk_15_2.jpg', 15);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Hulk_15_3.jpg', '/images/product/Chiến Giáp Hulk_15_3.jpg', 15);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Hulk_15_4.jpg', '/images/product/Chiến Giáp Hulk_15_4.jpg', 15);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Thanos_16_1.jpg', '/images/product/Chiến Giáp Thanos_16_1.jpg', 16);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Thanos_16_2.jpg', '/images/product/Chiến Giáp Thanos_16_2.jpg', 16);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Thanos_16_3.jpg', '/images/product/Chiến Giáp Thanos_16_3.jpg', 16);

INSERT INTO Image(imageName, url, productID) VALUES ('Chiến Giáp Thanos_16_4.jpg', '/images/product/Chiến Giáp Thanos_16_4.jpg', 16);

INSERT INTO Image(imageName, url, productID) VALUES ('Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_1.jpg', '/images/product/Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_1.jpg', 96);

INSERT INTO Image(imageName, url, productID) VALUES ('Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_2.jpg', '/images/product/Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_2.jpg', 96);

INSERT INTO Image(imageName, url, productID) VALUES ('Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_3.jpg', '/images/product/Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_3.jpg', 96);

INSERT INTO Image(imageName, url, productID) VALUES ('Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_4.jpg', '/images/product/Chuồng Thú Cưng Mini Chó Nâu SWEET HEART SH5073_96_4.jpg', 96);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_1.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_1.jpg', 37);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_2.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_2.jpg', 37);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_3.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_3.jpg', 37);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_4.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_37_4.jpg', 37);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_1.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_1.jpg', 38);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_2.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_2.jpg', 38);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_3.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_3.jpg', 38);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_4.jpg', '/images/product/Combo khuôn tạo hình cơ bản và bột nặn 4 màu mini_38_4.jpg', 38);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_1.jpg', '/images/product/Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_1.jpg', 66);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_2.jpg', '/images/product/Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_2.jpg', 66);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_3.jpg', '/images/product/Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_3.jpg', 66);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_4.jpg', '/images/product/Combo sổ tay, bút chì màu - Mùa hẻ rực rỡ_66_4.jpg', 66);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Pink & Gold_57_1.jpg', '/images/product/Combo sổ tay, bút chì màu - Pink & Gold_57_1.jpg', 57);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Pink & Gold_57_2.jpg', '/images/product/Combo sổ tay, bút chì màu - Pink & Gold_57_2.jpg', 57);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Pink & Gold_57_3.jpg', '/images/product/Combo sổ tay, bút chì màu - Pink & Gold_57_3.jpg', 57);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo sổ tay, bút chì màu - Pink & Gold_57_4.jpg', '/images/product/Combo sổ tay, bút chì màu - Pink & Gold_57_4.jpg', 57);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo tô màu và Sketchbook - Choose Happy_58_1.jpg', '/images/product/Combo tô màu và Sketchbook - Choose Happy_58_1.jpg', 58);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo tô màu và Sketchbook - Choose Happy_58_2.jpg', '/images/product/Combo tô màu và Sketchbook - Choose Happy_58_2.jpg', 58);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo tô màu và Sketchbook - Choose Happy_58_3.jpg', '/images/product/Combo tô màu và Sketchbook - Choose Happy_58_3.jpg', 58);

INSERT INTO Image(imageName, url, productID) VALUES ('Combo tô màu và Sketchbook - Choose Happy_58_4.jpg', '/images/product/Combo tô màu và Sketchbook - Choose Happy_58_4.jpg', 58);

INSERT INTO Image(imageName, url, productID) VALUES ('Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_1.jpg', '/images/product/Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_1.jpg', 4);

INSERT INTO Image(imageName, url, productID) VALUES ('Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_2.jpg', '/images/product/Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_2.jpg', 4);

INSERT INTO Image(imageName, url, productID) VALUES ('Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_3.jpg', '/images/product/Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_3.jpg', 4);

INSERT INTO Image(imageName, url, productID) VALUES ('Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_4.jpg', '/images/product/Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_4.jpg', 4);

INSERT INTO Image(imageName, url, productID) VALUES ('Cát động lực - Kho báu dưới đáy biển_32_1.jpg', '/images/product/Cát động lực - Kho báu dưới đáy biển_32_1.jpg', 32);

INSERT INTO Image(imageName, url, productID) VALUES ('Cát động lực - Kho báu dưới đáy biển_32_2.jpg', '/images/product/Cát động lực - Kho báu dưới đáy biển_32_2.jpg', 32);

INSERT INTO Image(imageName, url, productID) VALUES ('Cát động lực - Kho báu dưới đáy biển_32_3.jpg', '/images/product/Cát động lực - Kho báu dưới đáy biển_32_3.jpg', 32);

INSERT INTO Image(imageName, url, productID) VALUES ('Cát động lực - Kho báu dưới đáy biển_32_4.jpg', '/images/product/Cát động lực - Kho báu dưới đáy biển_32_4.jpg', 32);

INSERT INTO Image(imageName, url, productID) VALUES ('Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_1.jpg', '/images/product/Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_1.jpg', 83);

INSERT INTO Image(imageName, url, productID) VALUES ('Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_2.jpg', '/images/product/Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_2.jpg', 83);

INSERT INTO Image(imageName, url, productID) VALUES ('Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_3.jpg', '/images/product/Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_3.jpg', 83);

INSERT INTO Image(imageName, url, productID) VALUES ('Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_4.jpg', '/images/product/Cô nàng búp bê OMG Sunshine tỏa nắng - Bubblegum DJ_83_4.jpg', 83);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_1.jpg', '/images/product/Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_1.jpg', 42);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_2.jpg', '/images/product/Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_2.jpg', 42);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_3.jpg', '/images/product/Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_3.jpg', 42);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_4.jpg', '/images/product/Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_4.jpg', 42);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Toypoodle_50_1.jpg', '/images/product/Cún con R_C - Toypoodle_50_1.jpg', 50);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Toypoodle_50_2.jpg', '/images/product/Cún con R_C - Toypoodle_50_2.jpg', 50);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Toypoodle_50_3.jpg', '/images/product/Cún con R_C - Toypoodle_50_3.jpg', 50);

INSERT INTO Image(imageName, url, productID) VALUES ('Cún con R_C - Toypoodle_50_4.jpg', '/images/product/Cún con R_C - Toypoodle_50_4.jpg', 50);

INSERT INTO Image(imageName, url, productID) VALUES ('Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_1.jpg', '/images/product/Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_1.jpg', 74);

INSERT INTO Image(imageName, url, productID) VALUES ('Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_2.jpg', '/images/product/Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_2.jpg', 74);

INSERT INTO Image(imageName, url, productID) VALUES ('Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_3.jpg', '/images/product/Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_3.jpg', 74);

INSERT INTO Image(imageName, url, productID) VALUES ('Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_4.jpg', '/images/product/Căn Cứ Di Chuyển Trên Không Biến Hình Thành Robot SUPERWINGS YW760288_74_4.jpg', 74);

INSERT INTO Image(imageName, url, productID) VALUES ('Kool Urban - Ba lô Roller Camo Xanh_68_1.jpg', '/images/product/Kool Urban - Ba lô Roller Camo Xanh_68_1.jpg', 68);

INSERT INTO Image(imageName, url, productID) VALUES ('Kool Urban - Ba lô Roller Camo Xanh_68_2.jpg', '/images/product/Kool Urban - Ba lô Roller Camo Xanh_68_2.jpg', 68);

INSERT INTO Image(imageName, url, productID) VALUES ('Kool Urban - Ba lô Roller Camo Xanh_68_3.jpg', '/images/product/Kool Urban - Ba lô Roller Camo Xanh_68_3.jpg', 68);

INSERT INTO Image(imageName, url, productID) VALUES ('Kool Urban - Ba lô Roller Camo Xanh_68_4.jpg', '/images/product/Kool Urban - Ba lô Roller Camo Xanh_68_4.jpg', 68);

INSERT INTO Image(imageName, url, productID) VALUES ('Kì nghỉ cắm trại cùng Autumn & Aliya_1_1.jpg', '/images/product/Kì nghỉ cắm trại cùng Autumn & Aliya_1_1.jpg', 1);

INSERT INTO Image(imageName, url, productID) VALUES ('Kì nghỉ cắm trại cùng Autumn & Aliya_1_2.jpg', '/images/product/Kì nghỉ cắm trại cùng Autumn & Aliya_1_2.jpg', 1);

INSERT INTO Image(imageName, url, productID) VALUES ('Kì nghỉ cắm trại cùng Autumn & Aliya_1_3.jpg', '/images/product/Kì nghỉ cắm trại cùng Autumn & Aliya_1_3.jpg', 1);

INSERT INTO Image(imageName, url, productID) VALUES ('Kì nghỉ cắm trại cùng Autumn & Aliya_1_4.jpg', '/images/product/Kì nghỉ cắm trại cùng Autumn & Aliya_1_4.jpg', 1);

INSERT INTO Image(imageName, url, productID) VALUES ('Kỳ Lân Sắc Màu_10_1.jpg', '/images/product/Kỳ Lân Sắc Màu_10_1.jpg', 10);

INSERT INTO Image(imageName, url, productID) VALUES ('Kỳ Lân Sắc Màu_10_2.jpg', '/images/product/Kỳ Lân Sắc Màu_10_2.jpg', 10);

INSERT INTO Image(imageName, url, productID) VALUES ('Kỳ Lân Sắc Màu_10_3.jpg', '/images/product/Kỳ Lân Sắc Màu_10_3.jpg', 10);

INSERT INTO Image(imageName, url, productID) VALUES ('Kỳ Lân Sắc Màu_10_4.jpg', '/images/product/Kỳ Lân Sắc Màu_10_4.jpg', 10);

INSERT INTO Image(imageName, url, productID) VALUES ('Lâu Đài Công Chúa Bella_7_1.jpg', '/images/product/Lâu Đài Công Chúa Bella_7_1.jpg', 7);

INSERT INTO Image(imageName, url, productID) VALUES ('Lâu Đài Công Chúa Bella_7_2.jpg', '/images/product/Lâu Đài Công Chúa Bella_7_2.jpg', 7);

INSERT INTO Image(imageName, url, productID) VALUES ('Lâu Đài Công Chúa Bella_7_3.jpg', '/images/product/Lâu Đài Công Chúa Bella_7_3.jpg', 7);

INSERT INTO Image(imageName, url, productID) VALUES ('Lâu Đài Công Chúa Bella_7_4.jpg', '/images/product/Lâu Đài Công Chúa Bella_7_4.jpg', 7);

INSERT INTO Image(imageName, url, productID) VALUES ('Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_1.jpg', '/images/product/Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_1.jpg', 28);

INSERT INTO Image(imageName, url, productID) VALUES ('Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_2.jpg', '/images/product/Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_2.jpg', 28);

INSERT INTO Image(imageName, url, productID) VALUES ('Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_3.jpg', '/images/product/Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_3.jpg', 28);

INSERT INTO Image(imageName, url, productID) VALUES ('Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_4.jpg', '/images/product/Lọ Slime Ma Thuật Tiên Tri STYLE4EVER SSC201_28_4.jpg', 28);

INSERT INTO Image(imageName, url, productID) VALUES ('Máy Kéo Trồng Cây Công Viên_20_1.jpg', '/images/product/Máy Kéo Trồng Cây Công Viên_20_1.jpg', 20);

INSERT INTO Image(imageName, url, productID) VALUES ('Máy Kéo Trồng Cây Công Viên_20_2.jpg', '/images/product/Máy Kéo Trồng Cây Công Viên_20_2.jpg', 20);

INSERT INTO Image(imageName, url, productID) VALUES ('Máy Kéo Trồng Cây Công Viên_20_3.jpg', '/images/product/Máy Kéo Trồng Cây Công Viên_20_3.jpg', 20);

INSERT INTO Image(imageName, url, productID) VALUES ('Máy Kéo Trồng Cây Công Viên_20_4.jpg', '/images/product/Máy Kéo Trồng Cây Công Viên_20_4.jpg', 20);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_1.jpg', '/images/product/Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_1.jpg', 76);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_2.jpg', '/images/product/Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_2.jpg', 76);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_3.jpg', '/images/product/Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_3.jpg', 76);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_4.jpg', '/images/product/Mô hình GUNDAM SEED Structure ZGMF-X10A Freedom Gundam_76_4.jpg', 76);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô Tô Chiến Đấu Của Lloyd_18_1.jpg', '/images/product/Mô Tô Chiến Đấu Của Lloyd_18_1.jpg', 18);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô Tô Chiến Đấu Của Lloyd_18_2.jpg', '/images/product/Mô Tô Chiến Đấu Của Lloyd_18_2.jpg', 18);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô Tô Chiến Đấu Của Lloyd_18_3.jpg', '/images/product/Mô Tô Chiến Đấu Của Lloyd_18_3.jpg', 18);

INSERT INTO Image(imageName, url, productID) VALUES ('Mô Tô Chiến Đấu Của Lloyd_18_4.jpg', '/images/product/Mô Tô Chiến Đấu Của Lloyd_18_4.jpg', 18);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Bóng Bay UP_3_1.jpg', '/images/product/Ngôi Nhà Bóng Bay UP_3_1.jpg', 3);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Bóng Bay UP_3_2.jpg', '/images/product/Ngôi Nhà Bóng Bay UP_3_2.jpg', 3);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Bóng Bay UP_3_3.jpg', '/images/product/Ngôi Nhà Bóng Bay UP_3_3.jpg', 3);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Bóng Bay UP_3_4.jpg', '/images/product/Ngôi Nhà Bóng Bay UP_3_4.jpg', 3);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Tổ Chim_9_1.jpg', '/images/product/Ngôi Nhà Tổ Chim_9_1.jpg', 9);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Tổ Chim_9_2.jpg', '/images/product/Ngôi Nhà Tổ Chim_9_2.jpg', 9);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Tổ Chim_9_3.jpg', '/images/product/Ngôi Nhà Tổ Chim_9_3.jpg', 9);

INSERT INTO Image(imageName, url, productID) VALUES ('Ngôi Nhà Tổ Chim_9_4.jpg', '/images/product/Ngôi Nhà Tổ Chim_9_4.jpg', 9);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhà thiết kế thời trang tương lai_39_1.jpg', '/images/product/Nhà thiết kế thời trang tương lai_39_1.jpg', 39);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhà thiết kế thời trang tương lai_39_2.jpg', '/images/product/Nhà thiết kế thời trang tương lai_39_2.jpg', 39);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhà thiết kế thời trang tương lai_39_3.jpg', '/images/product/Nhà thiết kế thời trang tương lai_39_3.jpg', 39);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhà thiết kế thời trang tương lai_39_4.jpg', '/images/product/Nhà thiết kế thời trang tương lai_39_4.jpg', 39);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhân Vật LEGO Số 24_5_1.jpg', '/images/product/Nhân Vật LEGO Số 24_5_1.jpg', 5);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhân Vật LEGO Số 24_5_2.jpg', '/images/product/Nhân Vật LEGO Số 24_5_2.jpg', 5);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhân Vật LEGO Số 24_5_3.jpg', '/images/product/Nhân Vật LEGO Số 24_5_3.jpg', 5);

INSERT INTO Image(imageName, url, productID) VALUES ('Nhân Vật LEGO Số 24_5_4.jpg', '/images/product/Nhân Vật LEGO Số 24_5_4.jpg', 5);

INSERT INTO Image(imageName, url, productID) VALUES ('Phòng Ngủ Của Leo_6_1.jpg', '/images/product/Phòng Ngủ Của Leo_6_1.jpg', 6);

INSERT INTO Image(imageName, url, productID) VALUES ('Phòng Ngủ Của Leo_6_2.jpg', '/images/product/Phòng Ngủ Của Leo_6_2.jpg', 6);

INSERT INTO Image(imageName, url, productID) VALUES ('Phòng Ngủ Của Leo_6_3.jpg', '/images/product/Phòng Ngủ Của Leo_6_3.jpg', 6);

INSERT INTO Image(imageName, url, productID) VALUES ('Phòng Ngủ Của Leo_6_4.jpg', '/images/product/Phòng Ngủ Của Leo_6_4.jpg', 6);

INSERT INTO Image(imageName, url, productID) VALUES ('Pony bông 30 cm - Spike_55_1.jpg', '/images/product/Pony bông 30 cm - Spike_55_1.jpg', 55);

INSERT INTO Image(imageName, url, productID) VALUES ('Pony bông 30 cm - Spike_55_2.jpg', '/images/product/Pony bông 30 cm - Spike_55_2.jpg', 55);

INSERT INTO Image(imageName, url, productID) VALUES ('Pony bông 30 cm - Spike_55_3.jpg', '/images/product/Pony bông 30 cm - Spike_55_3.jpg', 55);

INSERT INTO Image(imageName, url, productID) VALUES ('Pony bông 30 cm - Spike_55_4.jpg', '/images/product/Pony bông 30 cm - Spike_55_4.jpg', 55);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_1.jpg', '/images/product/Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_1.jpg', 71);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_2.jpg', '/images/product/Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_2.jpg', 71);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_3.jpg', '/images/product/Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_3.jpg', 71);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_4.jpg', '/images/product/Robot biến hình cỡ hơn Jerome Cuồng phong và thú cưng Jerome SUPERWINGS YW770443_71_4.jpg', 71);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_1.jpg', '/images/product/Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_1.jpg', 80);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_2.jpg', '/images/product/Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_2.jpg', 80);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_3.jpg', '/images/product/Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_3.jpg', 80);

INSERT INTO Image(imageName, url, productID) VALUES ('Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_4.jpg', '/images/product/Robot biến hình TOBOT ARCBOLT chiến binh tân tiến_80_4.jpg', 80);

INSERT INTO Image(imageName, url, productID) VALUES ('Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_1.jpg', '/images/product/Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_1.jpg', 49);

INSERT INTO Image(imageName, url, productID) VALUES ('Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_2.jpg', '/images/product/Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_2.jpg', 49);

INSERT INTO Image(imageName, url, productID) VALUES ('Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_3.jpg', '/images/product/Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_3.jpg', 49);

INSERT INTO Image(imageName, url, productID) VALUES ('Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_4.jpg', '/images/product/Thú nhồi bông Among Us Trứng rán ngộ nghĩnh_49_4.jpg', 49);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Barbie_88_1.jpg', '/images/product/Thời Trang Du Lịch của Barbie_88_1.jpg', 88);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Barbie_88_2.jpg', '/images/product/Thời Trang Du Lịch của Barbie_88_2.jpg', 88);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Barbie_88_3.jpg', '/images/product/Thời Trang Du Lịch của Barbie_88_3.jpg', 88);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Barbie_88_4.jpg', '/images/product/Thời Trang Du Lịch của Barbie_88_4.jpg', 88);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Teresa_82_1.jpg', '/images/product/Thời Trang Du Lịch của Teresa_82_1.jpg', 82);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Teresa_82_2.jpg', '/images/product/Thời Trang Du Lịch của Teresa_82_2.jpg', 82);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Teresa_82_3.jpg', '/images/product/Thời Trang Du Lịch của Teresa_82_3.jpg', 82);

INSERT INTO Image(imageName, url, productID) VALUES ('Thời Trang Du Lịch của Teresa_82_4.jpg', '/images/product/Thời Trang Du Lịch của Teresa_82_4.jpg', 82);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi Domino SPIN GAMES_30_1.jpg', '/images/product/Trò chơi Domino SPIN GAMES_30_1.jpg', 30);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi Domino SPIN GAMES_30_2.jpg', '/images/product/Trò chơi Domino SPIN GAMES_30_2.jpg', 30);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi Domino SPIN GAMES_30_3.jpg', '/images/product/Trò chơi Domino SPIN GAMES_30_3.jpg', 30);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi Domino SPIN GAMES_30_4.jpg', '/images/product/Trò chơi Domino SPIN GAMES_30_4.jpg', 30);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_1.jpg', '/images/product/Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_1.jpg', 36);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_2.jpg', '/images/product/Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_2.jpg', 36);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_3.jpg', '/images/product/Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_3.jpg', 36);

INSERT INTO Image(imageName, url, productID) VALUES ('Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_4.jpg', '/images/product/Trò chơi thử thách trí tuệ hạt đậu logic Vàng_36_4.jpg', 36);

INSERT INTO Image(imageName, url, productID) VALUES ('Trụ Sở Chính Của Người Nhện_14_1.jpg', '/images/product/Trụ Sở Chính Của Người Nhện_14_1.jpg', 14);

INSERT INTO Image(imageName, url, productID) VALUES ('Trụ Sở Chính Của Người Nhện_14_2.jpg', '/images/product/Trụ Sở Chính Của Người Nhện_14_2.jpg', 14);

INSERT INTO Image(imageName, url, productID) VALUES ('Trụ Sở Chính Của Người Nhện_14_3.jpg', '/images/product/Trụ Sở Chính Của Người Nhện_14_3.jpg', 14);

INSERT INTO Image(imageName, url, productID) VALUES ('Trụ Sở Chính Của Người Nhện_14_4.jpg', '/images/product/Trụ Sở Chính Của Người Nhện_14_4.jpg', 14);

INSERT INTO Image(imageName, url, productID) VALUES ('Tàu Con Thoi Vũ Trụ_11_1.jpg', '/images/product/Tàu Con Thoi Vũ Trụ_11_1.jpg', 11);

INSERT INTO Image(imageName, url, productID) VALUES ('Tàu Con Thoi Vũ Trụ_11_2.jpg', '/images/product/Tàu Con Thoi Vũ Trụ_11_2.jpg', 11);

INSERT INTO Image(imageName, url, productID) VALUES ('Tàu Con Thoi Vũ Trụ_11_3.jpg', '/images/product/Tàu Con Thoi Vũ Trụ_11_3.jpg', 11);

INSERT INTO Image(imageName, url, productID) VALUES ('Tàu Con Thoi Vũ Trụ_11_4.jpg', '/images/product/Tàu Con Thoi Vũ Trụ_11_4.jpg', 11);

INSERT INTO Image(imageName, url, productID) VALUES ('Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_1.jpg', '/images/product/Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_1.jpg', 95);

INSERT INTO Image(imageName, url, productID) VALUES ('Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_2.jpg', '/images/product/Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_2.jpg', 95);

INSERT INTO Image(imageName, url, productID) VALUES ('Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_3.jpg', '/images/product/Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_3.jpg', 95);

INSERT INTO Image(imageName, url, productID) VALUES ('Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_4.jpg', '/images/product/Tủ Lạnh Mini Đỏ SWEET HEART SH6537_95_4.jpg', 95);

INSERT INTO Image(imageName, url, productID) VALUES ('Vali bác sĩ màu hồng_91_1.jpg', '/images/product/Vali bác sĩ màu hồng_91_1.jpg', 91);

INSERT INTO Image(imageName, url, productID) VALUES ('Vali bác sĩ màu hồng_91_2.jpg', '/images/product/Vali bác sĩ màu hồng_91_2.jpg', 91);

INSERT INTO Image(imageName, url, productID) VALUES ('Vali bác sĩ màu hồng_91_3.jpg', '/images/product/Vali bác sĩ màu hồng_91_3.jpg', 91);

INSERT INTO Image(imageName, url, productID) VALUES ('Vali bác sĩ màu hồng_91_4.jpg', '/images/product/Vali bác sĩ màu hồng_91_4.jpg', 91);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe cứu hộ rái cá_19_1.jpg', '/images/product/Xe cứu hộ rái cá_19_1.jpg', 19);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe cứu hộ rái cá_19_2.jpg', '/images/product/Xe cứu hộ rái cá_19_2.jpg', 19);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe cứu hộ rái cá_19_3.jpg', '/images/product/Xe cứu hộ rái cá_19_3.jpg', 19);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe cứu hộ rái cá_19_4.jpg', '/images/product/Xe cứu hộ rái cá_19_4.jpg', 19);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Mô Tô Của Ma Tốc Độ_17_1.jpg', '/images/product/Xe Đua Mô Tô Của Ma Tốc Độ_17_1.jpg', 17);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Mô Tô Của Ma Tốc Độ_17_2.jpg', '/images/product/Xe Đua Mô Tô Của Ma Tốc Độ_17_2.jpg', 17);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Mô Tô Của Ma Tốc Độ_17_3.jpg', '/images/product/Xe Đua Mô Tô Của Ma Tốc Độ_17_3.jpg', 17);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Mô Tô Của Ma Tốc Độ_17_4.jpg', '/images/product/Xe Đua Mô Tô Của Ma Tốc Độ_17_4.jpg', 17);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Nascar Chevrolet Camaro ZL1_8_1.jpg', '/images/product/Xe Đua Nascar Chevrolet Camaro ZL1_8_1.jpg', 8);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Nascar Chevrolet Camaro ZL1_8_2.jpg', '/images/product/Xe Đua Nascar Chevrolet Camaro ZL1_8_2.jpg', 8);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Nascar Chevrolet Camaro ZL1_8_3.jpg', '/images/product/Xe Đua Nascar Chevrolet Camaro ZL1_8_3.jpg', 8);

INSERT INTO Image(imageName, url, productID) VALUES ('Xe Đua Nascar Chevrolet Camaro ZL1_8_4.jpg', '/images/product/Xe Đua Nascar Chevrolet Camaro ZL1_8_4.jpg', 8);

INSERT INTO Image(imageName, url, productID) VALUES ('Đoàn Tàu Rau Củ Hữu Cơ_13_1.jpg', '/images/product/Đoàn Tàu Rau Củ Hữu Cơ_13_1.jpg', 13);

INSERT INTO Image(imageName, url, productID) VALUES ('Đoàn Tàu Rau Củ Hữu Cơ_13_2.jpg', '/images/product/Đoàn Tàu Rau Củ Hữu Cơ_13_2.jpg', 13);

INSERT INTO Image(imageName, url, productID) VALUES ('Đoàn Tàu Rau Củ Hữu Cơ_13_3.jpg', '/images/product/Đoàn Tàu Rau Củ Hữu Cơ_13_3.jpg', 13);

INSERT INTO Image(imageName, url, productID) VALUES ('Đoàn Tàu Rau Củ Hữu Cơ_13_4.jpg', '/images/product/Đoàn Tàu Rau Củ Hữu Cơ_13_4.jpg', 13);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bé làm bác sĩ_93_1.jpg', '/images/product/Đồ chơi bé làm bác sĩ_93_1.jpg', 93);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bé làm bác sĩ_93_2.jpg', '/images/product/Đồ chơi bé làm bác sĩ_93_2.jpg', 93);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bé làm bác sĩ_93_3.jpg', '/images/product/Đồ chơi bé làm bác sĩ_93_3.jpg', 93);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bé làm bác sĩ_93_4.jpg', '/images/product/Đồ chơi bé làm bác sĩ_93_4.jpg', 93);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_1.jpg', '/images/product/Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_1.jpg', 85);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_2.jpg', '/images/product/Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_2.jpg', 85);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_3.jpg', '/images/product/Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_3.jpg', 85);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_4.jpg', '/images/product/Đồ chơi búp bê-DRAGON BALL Z Q POSKET-VIDEL-(VER.A)_85_4.jpg', 85);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_1.jpg', '/images/product/Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_1.jpg', 84);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_2.jpg', '/images/product/Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_2.jpg', 84);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_3.jpg', '/images/product/Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_3.jpg', 84);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_4.jpg', '/images/product/Đồ chơi búp bê-ONE PIECE IT\'S A BANQUET!!-MONKEY.D.LUFFY_84_4.jpg', 84);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_1.jpg', '/images/product/Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_1.jpg', 35);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_2.jpg', '/images/product/Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_2.jpg', 35);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_3.jpg', '/images/product/Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_3.jpg', 35);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_4.jpg', '/images/product/Đồ chơi bảng vẽ nam châm cho bé - Cá voi cam đáng yêu_35_4.jpg', 35);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi lò nướng bánh diệu kỳ_99_1.jpg', '/images/product/Đồ chơi lò nướng bánh diệu kỳ_99_1.jpg', 99);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi lò nướng bánh diệu kỳ_99_2.jpg', '/images/product/Đồ chơi lò nướng bánh diệu kỳ_99_2.jpg', 99);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi lò nướng bánh diệu kỳ_99_3.jpg', '/images/product/Đồ chơi lò nướng bánh diệu kỳ_99_3.jpg', 99);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi lò nướng bánh diệu kỳ_99_4.jpg', '/images/product/Đồ chơi lò nướng bánh diệu kỳ_99_4.jpg', 99);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_1.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_1.jpg', 72);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_2.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_2.jpg', 72);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_3.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_3.jpg', 72);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_4.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Lớn Shine Lấp Lánh SUPERWINGS YW770239_72_4.jpg', 72);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_1.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_1.jpg', 73);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_2.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_2.jpg', 73);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_3.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_3.jpg', 73);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_4.jpg', '/images/product/Đồ Chơi Robot Biến Hình Cỡ Nhỏ Shine Lấp Lánh SUPERWINGS YW770039_73_4.jpg', 73);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_1.jpg', '/images/product/Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_1.jpg', 77);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_2.jpg', '/images/product/Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_2.jpg', 77);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_3.jpg', '/images/product/Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_3.jpg', 77);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_4.jpg', '/images/product/Đồ chơi robot chú chó kháu khỉnh điều khiển từ xa_77_4.jpg', 77);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_1.jpg', '/images/product/Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_1.jpg', 79);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_2.jpg', '/images/product/Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_2.jpg', 79);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_3.jpg', '/images/product/Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_3.jpg', 79);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_4.jpg', '/images/product/Đồ chơi robot mèo con thông thái điều khiển từ xa (hồng)_79_4.jpg', 79);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_1.jpg', '/images/product/Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_1.jpg', 78);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_2.jpg', '/images/product/Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_2.jpg', 78);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_3.jpg', '/images/product/Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_3.jpg', 78);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_4.jpg', '/images/product/Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_4.jpg', 78);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_1.jpg', '/images/product/Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_1.jpg', 21);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_2.jpg', '/images/product/Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_2.jpg', 21);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_3.jpg', '/images/product/Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_3.jpg', 21);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_4.jpg', '/images/product/Đồ Chơi Rubik\'s Race Thách Đấu SPIN GAMES_21_4.jpg', 21);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_1.jpg', '/images/product/Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_1.jpg', 22);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_2.jpg', '/images/product/Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_2.jpg', 22);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_3.jpg', '/images/product/Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_3.jpg', 22);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_4.jpg', '/images/product/Đồ Chơi Rubik\'s Speed Tốc Độ SPIN GAMES_22_4.jpg', 22);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Twist_40_1.jpg', '/images/product/Đồ Chơi Rubik\'s Twist_40_1.jpg', 40);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Twist_40_2.jpg', '/images/product/Đồ Chơi Rubik\'s Twist_40_2.jpg', 40);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Twist_40_3.jpg', '/images/product/Đồ Chơi Rubik\'s Twist_40_3.jpg', 40);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Rubik\'s Twist_40_4.jpg', '/images/product/Đồ Chơi Rubik\'s Twist_40_4.jpg', 40);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_1.jpg', '/images/product/Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_1.jpg', 48);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_2.jpg', '/images/product/Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_2.jpg', 48);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_3.jpg', '/images/product/Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_3.jpg', 48);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_4.jpg', '/images/product/Đồ chơi thú bông bạn Daisy Duck nguyên bản 10_48_4.jpg', 48);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy đáng yêu 10_44_1.jpg', '/images/product/Đồ chơi thú bông bạn Daisy đáng yêu 10_44_1.jpg', 44);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy đáng yêu 10_44_2.jpg', '/images/product/Đồ chơi thú bông bạn Daisy đáng yêu 10_44_2.jpg', 44);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy đáng yêu 10_44_3.jpg', '/images/product/Đồ chơi thú bông bạn Daisy đáng yêu 10_44_3.jpg', 44);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Daisy đáng yêu 10_44_4.jpg', '/images/product/Đồ chơi thú bông bạn Daisy đáng yêu 10_44_4.jpg', 44);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Donald Duck thân yêu_53_1.jpg', '/images/product/Đồ chơi thú bông bạn Donald Duck thân yêu_53_1.jpg', 53);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Donald Duck thân yêu_53_2.jpg', '/images/product/Đồ chơi thú bông bạn Donald Duck thân yêu_53_2.jpg', 53);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Donald Duck thân yêu_53_3.jpg', '/images/product/Đồ chơi thú bông bạn Donald Duck thân yêu_53_3.jpg', 53);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Donald Duck thân yêu_53_4.jpg', '/images/product/Đồ chơi thú bông bạn Donald Duck thân yêu_53_4.jpg', 53);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Eeyore thân yêu 16_47_1.jpg', '/images/product/Đồ chơi thú bông bạn Eeyore thân yêu 16_47_1.jpg', 47);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Eeyore thân yêu 16_47_2.jpg', '/images/product/Đồ chơi thú bông bạn Eeyore thân yêu 16_47_2.jpg', 47);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Eeyore thân yêu 16_47_3.jpg', '/images/product/Đồ chơi thú bông bạn Eeyore thân yêu 16_47_3.jpg', 47);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Eeyore thân yêu 16_47_4.jpg', '/images/product/Đồ chơi thú bông bạn Eeyore thân yêu 16_47_4.jpg', 47);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_1.jpg', '/images/product/Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_1.jpg', 52);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_2.jpg', '/images/product/Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_2.jpg', 52);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_3.jpg', '/images/product/Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_3.jpg', 52);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_4.jpg', '/images/product/Đồ chơi thú bông bạn Mickey Mouse thân yêu_52_4.jpg', 52);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Minnie đáng yêu 10_45_1.jpg', '/images/product/Đồ chơi thú bông bạn Minnie đáng yêu 10_45_1.jpg', 45);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Minnie đáng yêu 10_45_2.jpg', '/images/product/Đồ chơi thú bông bạn Minnie đáng yêu 10_45_2.jpg', 45);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Minnie đáng yêu 10_45_3.jpg', '/images/product/Đồ chơi thú bông bạn Minnie đáng yêu 10_45_3.jpg', 45);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Minnie đáng yêu 10_45_4.jpg', '/images/product/Đồ chơi thú bông bạn Minnie đáng yêu 10_45_4.jpg', 45);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Piglet thân yêu_54_1.jpg', '/images/product/Đồ chơi thú bông bạn Piglet thân yêu_54_1.jpg', 54);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Piglet thân yêu_54_2.jpg', '/images/product/Đồ chơi thú bông bạn Piglet thân yêu_54_2.jpg', 54);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Piglet thân yêu_54_3.jpg', '/images/product/Đồ chơi thú bông bạn Piglet thân yêu_54_3.jpg', 54);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Piglet thân yêu_54_4.jpg', '/images/product/Đồ chơi thú bông bạn Piglet thân yêu_54_4.jpg', 54);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger người tuyết 8_41_1.jpg', '/images/product/Đồ chơi thú bông bạn Tigger người tuyết 8_41_1.jpg', 41);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger người tuyết 8_41_2.jpg', '/images/product/Đồ chơi thú bông bạn Tigger người tuyết 8_41_2.jpg', 41);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger người tuyết 8_41_3.jpg', '/images/product/Đồ chơi thú bông bạn Tigger người tuyết 8_41_3.jpg', 41);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger người tuyết 8_41_4.jpg', '/images/product/Đồ chơi thú bông bạn Tigger người tuyết 8_41_4.jpg', 41);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger thân yêu_51_1.jpg', '/images/product/Đồ chơi thú bông bạn Tigger thân yêu_51_1.jpg', 51);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger thân yêu_51_2.jpg', '/images/product/Đồ chơi thú bông bạn Tigger thân yêu_51_2.jpg', 51);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger thân yêu_51_3.jpg', '/images/product/Đồ chơi thú bông bạn Tigger thân yêu_51_3.jpg', 51);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Tigger thân yêu_51_4.jpg', '/images/product/Đồ chơi thú bông bạn Tigger thân yêu_51_4.jpg', 51);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_1.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_1.jpg', 46);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_2.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_2.jpg', 46);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_3.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_3.jpg', 46);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_4.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh nguyên bản 10_46_4.jpg', 46);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_1.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_1.jpg', 43);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_2.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_2.jpg', 43);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_3.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_3.jpg', 43);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_4.jpg', '/images/product/Đồ chơi thú bông bạn Winnie the Pooh người tuyết 8_43_4.jpg', 43);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_1.jpg', '/images/product/Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_1.jpg', 75);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_2.jpg', '/images/product/Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_2.jpg', 75);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_3.jpg', '/images/product/Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_3.jpg', 75);

INSERT INTO Image(imageName, url, productID) VALUES ('Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_4.jpg', '/images/product/Đồ Chơi Thú Cưng Golden Tốc Độ SUPERWINGS EU770431_75_4.jpg', 75);

-- Cart 
INSERT INTO Cart (userID)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21), (22), (23), (24), (25);

-- CartItem
INSERT INTO CartItem (quantity, cartID, productID) VALUES(3, 11, 53), 
(2, 15, 17),
(1, 4, 41), 
(4, 7, 68),
(2, 12, 22), 
(3, 3, 82),
(1, 22, 60),
(2, 19, 33),
(1, 1, 15),
(4, 10, 91),
(3, 23, 5),
(2, 9, 98),
(1, 8, 48),
(3, 16, 24),
(2, 2, 73),
(1, 6, 55),
(4, 24, 81),
(3, 14, 19),
(1, 21, 36),
(2, 5, 58),
(3, 18, 89),
(1, 13, 39),
(4, 25, 65),
(2, 20, 96),
(1, 17, 10),
(3, 7, 75),
(2, 4, 31),
(1, 11, 63),
(2, 11, 44),
(1, 11, 77);
 
--- Order
INSERT INTO `Order`(orderedDate, receivedDate, cancelledDate, status, receiverName, phone, address, total, userID) VALUES 
("2021-03-22", "2021-03-28", null, 2, "Hà Nguyễn", "0905028763", "28 Lý Thường Kiệt, Hải Châu, Đà Nẵng", 791000, 1),

("2022-07-23", "2022-07-28", null, 2, "Hà Nguyễn", "0905028763", "28 Lý Thường Kiệt, Hải Châu, Đà Nẵng", 1297000, 1),

("2022-02-10", "2022-02-10", null, 2, "Vân Trần", "0901357908", "61 Đồng Khởi, Nha Trang, Khánh Hòa", 1179000, 2),

("2022-09-15", "2022-09-25", null, 2, "Trung Phạm", "0935880164", "54 Trần Hưng Đạo, Hội An, Quảng Nam", 627000, 3),

("2021-11-06", "2021-11-12", null, 2, "Lương Hùng", "0976116352", "85 Nguyễn Huệ, Vinh, Nghệ An", 2258000, 4),

("2022-10-20", "2022-10-27", null, 2, "Lương Hùng", "0976116352", "85 Nguyễn Huệ, Vinh, Nghệ An", 2522000, 4),

("2022-05-01", null, "2022-05-02", 3, "Nguyễn Thị Hương", "0976116352", "Số 12, ngõ 34, đường Trần Thái Tông, P. Dịch Vọng Hậu, Cầu Giấy, Hà Nội", 3852000, 5),

("2022-07-13", "2022-07-15", null, 2, "Phạm Hữu Đông", "0903456789", "Số 456, đường Điện Biên Phủ, P. 22, Q. Bình Thạnh, TP. Hồ Chí Minh", 2601000, 6),

("2020-06-10", "2020-06-15", null, 2, "Tú Lê", "0397845621", "221, Phạm Văn Đồng, Hiệp Bình Chánh, TP. Thủ Đức, TP. Hồ Chí Minh", 429000, 8),

("2020-05-10", "2020-05-15", null, 2, "Nguyễn Văn Thuận", "0397252681", "An Lạc 1, Mỹ Hoà, Phù Mỹ, Bình Định", 2296000, 11),

("2021-12-15", null, "2021-12-15", 3, "Nguyễn Văn Thuận", "0397252681", "An Lạc 1, Mỹ Hoà, Phù Mỹ, Bình Định", 1764000, 11),

("2023-04-29", null, null, 1, "Nguyễn Văn Thuận", "0397252681", "An Lạc 1, Mỹ Hoà, Phù Mỹ, Bình Định", 2086000, 11),

("2020-05-02", null, null, 0, "Nguyễn Văn Thuận", "0397252681", "An Lạc 1, Mỹ Hoà, Phù Mỹ, Bình Định", 505000, 11),

("2023-01-19", "2023-01-23", null, 2, "Lê Minh Hùng", "0987654321", "156/6 Tôn Thất Thuyết, Quận 4, TP.HCM", 2038000, 17),

("2023-03-15", "2023-03-18", null, 2, "Minh Đặng", "0918765432", "123 Hoàng Diệu, Quận 3, TP.HCM", 2288000, 18),

("2023-05-10", null, null, 1, "Minh Đặng", "0918765432", "123 Hoàng Diệu, Quận 3, TP.HCM", 7860000, 18),

("2023-04-17", "2023-04-21", null, 2, "Ngô Minh Thu", "0909876543", "789 Phạm Văn Đồng, Quận Thủ Đức, TP.HCM", 1119000, 20),

("2022-09-14", "2022-09-17", null, 2, "Trịnh Thanh Tuấn", "0987123456", "456 Lê Văn Việt, Quận 9, TP.HCM", 1675000, 21),

("2022-09-20", "2022-09-24", null, 2, "Trung Nguyễn", "0987654321", "123 Trần Phú, Phường 4, Đà Lạt, Lâm Đồng", 4176000, 22),

("2022-04-11", "2022-04-17", null, 2, "Phan Thanh Thu Huyền", "0987654321", "16 Mai Thúc Loan, Lê Chân, Hải Phòng", 867000, 25),

("2023-04-01", "2023-04-04", null, 2, "Hải Trần", "0901234567", "123 Nguyễn Thái Học, Quận 5, TP.HCM", 2272000, 19),

("2023-03-04", "2023-03-09", null, 2, "Phạm Thu", "0987654321", "18 Lê Duẩn, Hải Châu, Đà Nẵng", 687000, 25),

("2023-04-27", "2023-04-24", null, 2, "Đỗ Ngọc Linh", "0987654321", "43 Trần Phú, Lộc Hòa, Bảo Lộc, Lâm Đồng", 4527000, 25);

-- Order Item 
INSERT INTO OrderItem(quantity, price, orderID, productID) VALUES
(1, 662000, 1, 1),

(1, 129000, 1, 5),

(2, 349000, 2, 78),

(1, 599000, 2, 1),

(1, 1779000, 3, 3),

(3, 209000, 4, 25),

(1, 1159000, 5, 4),

(1, 1099000, 5, 17),

(2, 662000, 6, 1),

(2, 599000, 6, 23),

(5, 299000, 7, 26),

(2, 359000, 7, 33),

(1, 1639000, 7, 14),

(2, 567000, 8, 89),

(3, 489000, 8, 53),

(1, 429000, 9, 40),

(1, 299000, 10, 100),

(1, 599000, 10, 23),

(2, 699000, 10, 1),

(1, 1099000, 11, 17),

(1, 665000, 11, 1),

(3, 129000, 12, 5),

(1, 1699000, 12, 8),

(1, 229000, 13, 25),

(4, 69000, 13, 36),

(1, 399000, 14, 42),

(1, 1639000, 14, 8),

(1, 1939000, 15, 12),

(1, 349000, 15, 78),

(10, 219000, 16, 65),

(10, 567000, 16, 89),

(1, 1119000, 17, 4),

(5, 129000, 18, 5),

(5, 206000, 18, 10),

(6, 129000, 19, 5),

(6, 567000, 19, 68),

(1, 409000, 20, 24),

(2, 229000, 20, 25),

(4, 229000, 21, 44),

(4, 339000, 21, 33),

(2, 229000, 22, 25),

(1, 229000, 22, 86),

(3, 319000, 23, 15),

(3, 119000, 23, 38);

------------- Review 
INSERT INTO Review (star, comment, images, createdAt, updatedAt, userID, productID, orderItemID) VALUES
(5, "Sản phẩm rất đẹp và chất lượng tốt. Con tôi rất thích và không chịu buông tay.", "/images/review/Kì nghỉ cắm trại cùng Autumn & Aliya_1_1.jpg", "2021-03-28", NULL, 1, 1, 1),

(4, "Giao hàng nhanh chóng, sản phẩm đáng giá tiền. Tuy nhiên hộp bị rách nhẹ khi giao hàng.", "/images/review/Nhân Vật LEGO Số 24_5_3.jpg", "2021-03-29", NULL, 1, 5, 2),

(3, "Đồ chơi khá dễ thương, nhưng có một số chi tiết hơi kém chất lượng.", "/images/review/Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_3.jpg", "2022-07-28", NULL, 1, 78, 3),

(5, "Rất thích sản phẩm này, chất lượng tốt và giá cả hợp lý. Con tôi rất vui và chơi rất thích.", "/images/review/Kì nghỉ cắm trại cùng Autumn & Aliya_1_4.jpg", "2022-07-28", "2022-07-28", 1, 1, 4),

(2, "Không hài lòng với sản phẩm này. Hình ảnh khác với thực tế, chất lượng kém, giá cả quá cao.", "/images/review/Ngôi Nhà Bóng Bay UP_3_4.jpg", "2022-02-10", NULL, 2, 3, 5),

(4, "Sản phẩm đáng mua, giá cả phải chăng. Tuy nhiên thời gian giao hàng hơi lâu.", "/images/review/Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_2.jpg", "2022-09-25 17:00:00", NULL, 3, 25, 6),

(5, "Sản phẩm chất lượng tốt, đáng mua. Giao hàng nhanh chóng, nhân viên giao hàng nhiệt tình.", "/images/review/Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_3.jpg", "2021-11-12 18:00:00", "2021-11-15 18:03:00", 4, 4, 7),

(3, "Không hài lòng với sản phẩm này, chất lượng kém, giá cả cao hơn so với sản phẩm tương tự.", "/images/review/Xe Đua Mô Tô Của Ma Tốc Độ_17_4.jpg", "2021-11-12 19:00:00", NULL, 4, 17, 8),

(4, 'Đồ chơi này rất thú vị, bé nhà mình rất thích. Chất lượng sản phẩm tốt, giá cả hợp lý. Tôi sẽ tiếp tục mua sản phẩm ở đây!', NULL, '2022-10-28 10:15:00', NULL, 4, 1, 9),

(5, 'Sản phẩm rất đẹp, giá cả hợp lý, bé nhà mình rất thích. Dịch vụ của cửa hàng cũng rất tốt và nhiệt tình. Chắc chắn sẽ quay lại đây nếu có nhu cầu mua đồ chơi cho con.', '/images/review/Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_2.jpg', '2022-10-27 09:20:00', '2022-10-27 09:28:00', 4, 23, 10),

(3, 'Sản phẩm này hơi nhỏ nhưng vẫn tốt, bé nhà mình vui vẻ chơi cả ngày. Đóng gói sản phẩm cẩn thận, chất lượng sản phẩm tương đối tốt, giá cả hợp lý.', '/images/review/Búp bê Barbie Đổi Màu - Phiên bản Thời Trang Trái Cây_89_4.jpg', '2022-07-15 14:30:00', NULL, 6, 89, 14),

(4, 'Sản phẩm đẹp, giá cả hợp lý. Tôi rất hài lòng với dịch vụ của cửa hàng, nhân viên rất nhiệt tình và thân thiện. Chắc chắn sẽ quay lại đây để mua sắm!', '/images/review/Đồ chơi thú bông bạn Donald Duck thân yêu_53_4.jpg', '2022-07-15 16:45:00', '2022-07-15 16:56:00', 6, 53, 15),

(5, 'Đồ chơi rất đẹp, bé nhà mình thích lắm. Chất lượng sản phẩm tốt, giá cả hợp lý. Dịch vụ của cửa hàng rất tốt và chuyên nghiệp. Tôi rất hài lòng!', '/images/review/Đồ Chơi Rubik\'s Twist_40_3.jpg', '2020-06-15 11:00:00', NULL, 8, 40, 16),

(3, 'Sản phẩm này không được như mong đợi lắm, chất lượng tương đối kém. Tôi đã liên hệ với cửa hàng để đổi sản phẩm nhưng không được giải quyết tốt.', NULL, '2020-05-15 08:50:00', NULL, 11, 100, 17),

(4, 'Sản phẩm tuyệt vời, chất lượng đảm bảo, con tôi rất thích', '/images/review/Bộ Dụng Cụ Trang Điểm Màu Hồng Sành Điệu MAKE IT REAL 2506MIRA_23_3.jpg', '2020-05-15 14:20:00', NULL, 11, 23, 18),

(3, 'Chất lượng sản phẩm tốt, tuy nhiên giá cả hơi đắt so với các sản phẩm cùng loại', NULL, '2020-05-15 15:10:00', NULL, 11, 1, 19),

(5, 'Tôi rất hài lòng với sản phẩm này, chất lượng tuyệt vời, giao hàng nhanh chóng', '/images/review/Cún con R_C - Pomeranian IWAYA 3159-2VN_JS_42_3.jpg', '2023-01-23 11:25:00', NULL, 17, 42, 26),

(2, 'Sản phẩm không tốt, độ bền thấp, giá cả cao hơn so với chất lượng', '/images/review/Xe Đua Nascar Chevrolet Camaro ZL1_8_4.jpg', '2023-01-23 09:30:00', NULL, 17, 8, 27),

(4, 'Mua cho cháu, cháu rất thích. Sản phẩm đúng như mô tả, giá thành hợp lý', '/images/review/Bộ Gạch Sáng Tạo Pixel_12_3.jpg', '2023-03-18 14:40:00', NULL, 18, 12, 28),

(4, "Rất vui vì mua đồ chơi cho con của mình ở đây. Các sản phẩm đều rất đẹp và chất lượng tốt.", "/images/review/Đồ chơi Robot điều khiển từ xa Mực tuần tra xanh dương_78_4.jpg", "2023-03-18 20:10:29", NULL, 18, 78, 29),

(5, "Sản phẩm tuyệt vời, chất lượng tốt, giá cả phải chăng và dịch vụ tuyệt vời!", "/images/review/Cuộc Rượt Đuổi Phi Cơ Chiến Đấu_4_4.jpg", "2023-04-23 20:10:29", "2023-04-24 20:10:29", 20, 4, 32),

(3, "Sản phẩm này hơi đắt nhưng đúng như mô tả. Chất lượng tốt và được làm rất cẩn thận.", "/images/review/Nhân Vật LEGO Số 24_5_4.jpg", "2022-07-19 14:10:29", NULL, 21, 5, 33),

(2, "Tôi không hài lòng với sản phẩm này. Chất lượng kém và không đáng giá với giá tiền của nó.", "/images/review/Kỳ Lân Sắc Màu_10_2.jpg", "2022-09-17 08:10:29", NULL, 21, 10, 34),

(5, "Một trong những địa điểm tốt nhất để mua đồ chơi ở thành phố này. Sản phẩm tuyệt vời và giá cả hợp lý.", NULL, "2022-09-24", NULL, 22, 5, 35),

(4, "Sản phẩm rất đẹp và chất lượng tốt. Chỉ có điều giá hơi cao so với các cửa hàng khác.", "/images/review/Kool Urban - Ba lô Roller Camo Xanh_68_2.jpg", "2023-09-24 13:18:29", NULL, 22, 68, 36),

(5, "Rất hài lòng với mua hàng tại đây. Sản phẩm chất lượng cao và giá cả rất phải chăng.", "/images/review/Bộ Thiết Kế Vòng Tay Kẹo Ngọt MAKE IT REAL 1728MIR_24_3.jpg", "2022-04-17 20:40:29", NULL, 25, 24, 37),

(5, "Sản phẩm tuyệt vời và giá cả phải chăng. Con tôi rất thích nó.", "/images/review/Bộ Thiết Kế Vòng Tay Cánh Bướm Lung Linh MAKE IT REAL 1323MIR_25_3.jpg", "2022-04-17 20:50:29", NULL, 25, 25, 38),

(4, "Đồ chơi tuyệt vời với giá cả phải chăng. Tôi rất hài lòng với mua hàng tại đây.", "/images/review/Đồ chơi thú bông bạn Daisy đáng yêu 10_44_4.jpg", "2023-04-04 14:50:29", NULL, 19, 44, 39),

(2, "Sản phẩm này không hoạt động tốt như mô tả. Tôi không hài lòng với mua hàng tại đây.", "/images/review/Bộ Thí Nghiệm Hóa Học Kỳ Thú Có 14 Chi Tiết_33_2.jpg
", "2023-04-04 13:10:58", NULL, 19, 33, 40),

(5, "Rất hài lòng với mua hàng tại đây. Sản phẩm đẹp và chất lượng tốt.", "", "2023-03-09 14:50:29", NULL, 25, 25, 41),

(4, "Sản phẩm này chất lượng tốt và được làm rất tốt. Tôi rất hài lòng với mua hàng tại đây.", "/images/review/Búp bê Barbie Mini Mini Extra - TURQUOISE _ PINK CANDY_86_2.jpg", "2023-03-09 07:50:13", NULL, 25, 86, 42),

(5, 'Rất thích, mua cho con đẹp, chất lượng ok', NULL, "2023-04-24 9:27:35", NULL, 25, 15, 43),

(5, 'Con yêu rất thích, chất lượng tốt, giá cả hợp lý', NULL, "2023-04-24 13:10:29", NULL, 25, 38, 44);
