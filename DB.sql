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
    quantity INT CHECK (quantity > 0),
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

INSERT INTO Category VALUES(1, "Mô hình ô tô", "11111", 1);
INSERT INTO Category VALUES(2, "Đồ chơi Pokemon", "11111", 1);
INSERT INTO Category VALUES(3, "Đồ chơi đất nặn", "11111", 1);
INSERT INTO Category VALUES(4, "Đồ chơi gỗ", "11111", 1);
INSERT INTO Category VALUES(5, "Đồ chơi giáo dục", "11111", 1);
INSERT INTO Category VALUES(6, "Đồ chơi thông minh", "11111", 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Xe khủng long", "Sản phẩm xe tải chở khủng long kích thước lớn được thiết kế chắc chắn,
màu sắc tươi sang, hoạt động hoàn hảo tạo cảm giác thích thú cho bé khi chơi, bên cạnh đó xe được tặng kèm 3 chú khủng long dễ thương cho bé thỏa sức sáng tạo. 
Đồ chơi thiết kế thông minh, an toàn cho bé khi chơi", "/View/Customer/img/products/Oto/Xe_khung_long.jpg", 1, 20, 300000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Xe công trình chuyên dụng", "Chức năng chính của xe tải sàn thấp là vận chuyển các thiết bị máy móc ở công trường,
được làm từ nhựa ABS và kim loại cao cấp, khung xe chắc chắn, người lái có thể quay 360 độ giúp dễ dàng hơn trong việc vận chuyển. Hơn thế nữa, mô hình này đã thể hiện rõ như thực tế. 
Các bé hãy cùng nhau lái xe ra công trường và giúp các cô chú công nhân nào.", "/View/Customer/img/products/Oto/Xe_cong_trinh_chuyen_dung.jpg", 1, 20, 249000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Xe ô tô mini", "Màu sắc đa dạng, đẹp, nhỏ gọn bé có thể mang theo đi bất cứ đâu, không sắc nhọn, an toàn với trẻ nhỏ. 
Phù hợp với các bé nhỏ tuổi, chất liệu nhựa an toàn cho bé, lốp xe bằng cao su mềm có độ ma sát và độ bám rất tốt, xe có thể di chuyển dễ dàng trên nhiều địa hình khác nhau", "/View/Customer/img/products/Oto/Xe_o_to_mini.jpg", 1, 20, 139000, 1);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Lắp ráp Pokemon", "Mô hình KEEPPLAY được làm từ chất liệu nhựa ABS được cắt ghép thành từng mảnh, mô phỏng mô hình các xe tăng, thiết kế độc đáo và bắt mắt. 
Mang lại sự trải nghiệm thú vị khi tự tay lắp ghép các tuyệt tác, chất liệu bền đẹp.", "/View/Customer/img/products/Pokemon/Lap_rap_pokemon.jpg", 1, 20, 499000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Mô hình Pokemon", "Đồ chơi mô hình Pokemon bằng nhựa 24 con (5cm) là loại đồ chơi mô hình các chú pokemon được thiết kế với màu sắc tươi sáng, nhỏ nhắn, chân thật chắc chắn sẽ là món đồ chơi Pokemon được các bé yêu thích bộ phim hoạt hình này,
 muốn sưu tập cho mình những chú Pokemon dễ thương nhất. Sản phẩm dành cho các bé từ 5 tuổi trở lên.", "/View/Customer/img/products/Pokemon/Mo_hinh_pokemon.jpg", 1, 20, 100000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Quả cầu Pokemon", "Sản phẩm Mô hình Quả Cầu Pokemon Go, Anime, Đồ chơi tự động ném thú Pikachu bao gồm 1 quả cầu và 1 mô hình pokemon chất lượng đảm bảo.
Kích thước mô hình: 8x8cm, chất liệu: Nhựa ABS, sử dụng mô hình thực tế là một phương pháp hiệu quả để dạy trẻ, giúp trẻ dễ dàng khám phá và học hỏi hơn.", "/View/Customer/img/products/Pokemon/Qua_cau_pokemon.jpg", 1, 20, 60000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Thẻ bài Pokemon", "Rèn luyện khả năng: Phát triển trí tuệ, phối hợp tay và não, trau dồi sở thích, cảm xúc, đồ chơi tương tác, tăng thị giác. 
Gói hàng bao gồm: 1 Hộp gồm 36 gói, 1 gói gồm 9 thẻ,8 túi mỗi thẻ + 1 thẻ flash ,tổng cộng 324 thẻ. Với Pokémon TCG bạn có thể vừa sưu tập, vừa đấu bài với người khác, 
đấu bài online hoặc chỉ đơn giản là sưu tập những mẫu thẻ bài mình yêu thích", "/View/Customer/img/products/Pokemon/The_bai_pokemon.jpg",  1, 20, 229000, 2);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đất nặn 36 kèm khuôn", "Hộp đồ chơi đất sét 24 màu cho bé được làm từ nguyên liệu tự nhiên: bột gỗ, chất làm quánh. Không độc hại; Không dây bẩn ra sàn nhà. Bao gồm: 24 màu, 21 khuôn hình, dao cắt, và phụ kiện khác. 
Có sách hướng dẫn. Dễ chơi, dễ tạo hình, kích thích óc sáng tạo. Sản phẩm kèm hộp đựng tiện lợi. Hộp đồ chơi đất sét 24 màu cho bé tạo hình khối không độc hại cho trẻ em", "/View/Customer/img/products/Datnan/Dat_nan_36_mau_kem_khuon.jpg", 1, 20, 199000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đắt nặn làm bánh", "Đất nặn khay bánh ngọt ngào Play-doh B0307 với các gam màu tươi sáng và chất liệu bột mì an toàn, bé yêu của mẹ thỏa sức sáng tạo và nhào nặn ra những con vật, đồ vật đẹp mắt,
bé có thể tăng cường trí sáng tạo của mình bởi những sản phẩm tạo ra với hình thù ngộ nghĩnh và đáng yêu nhất.", "/View/Customer/img/products/Datnan/Dat_nan_lam_banh.jpg", 1, 20, 225000, 3);

INSERT INTO Product (productName, description, images, status, quantity, price, categoryID)
VALUES("Đất nặn Nara", "Đất nặn Nara bao gồm 12 màu sắc neol tươi sáng và dụng cụ tạo hình đát nặn giúp bé nhanh chóng ghi nhớ các màu sắc. 
Đây còn là trò chơi giúp trẻ phát triển trí tuệ bằng cách trẻ sẽ tự tay làm những mẫu vật khác nhau kèm theo những dụng cụ và khuôn hình cho bé tha hồ sáng tạo thế giới đầy màu sắc cho riêng mình.", "/View/Customer/img/products/Datnan/Dat_nan_Nara.jpg", 1, 20, 60000, 3);
    
-- Users
INSERT INTO User(firstname, lastname, gender, birthday, email, address, phone, image, role, status, username, password, createdAt, updatedAt) 
VALUES("Tú", "Lê", "0", "1999-10-15", "tule1234@gmail.com", "221, Phạm Văn Đồng, Hiệp Bình Chánh, TP. Thủ Đức, TP. Hồ Chí Minh", "0397845621", 
"/View/Admin/img/profile/A1.jpg", 0, 1, "tule1234", "61e461ed80e1b627a240352a58e8636d0de637ee2869c08af3eabd5c4f890283e438ed0592dc390996d3e179e43845b088a630ce125f3cfe96af63671a944b05", 
"2020-05-10", "2020-05-10");

INSERT INTO User(firstname, lastname, gender, birthday, email, address, phone, image, role, status, username, password, createdAt, updatedAt) 
VALUES("Thuý Hạnh", "Trần", "1", "1987-03-10", "thuyhanh@gmail.com", "26 Ung Văn Khiêm, Phường 25, Bình Thạnh, TP. Hồ Chí Minh", "0789512542", 
"/View/Admin/img/profile/A2.jpg", 1, 1, "thuyhanhcute", "9dbf07e24469808af773bf38d9b0f021c4288476658133e528af71e6042fca538447227b8d284ed0b8a7605dd39d291b4d236852a45d6451ffca32d087f0f602", 
"2022-02-10", "2022-02-10");

INSERT INTO User(firstname, lastname, gender, birthday, email, address, phone, image, role, status, username, password, createdAt, updatedAt) 
VALUES("Anh", "Phan", "0", "1987-03-21", "anhphan.1987@gmail.com", "142 Lê Văn Việt, TP. Thủ Đức, TP. Hồ Chí Minh", "0987541265", 
"/View/Admin/img/profile/A3.jpg", 1, 1, "anhhs12", "b71dae4d6b22bbd16bba6a29736caf5b61d5eb0b1d0476cc39f16f307c82ebbe2973efcc1d52665fe56fe32a672297331a1ed18988de60133de9745869379515", 
"2021-01-23", "2021-02-10");

INSERT INTO User(firstname, lastname, gender, birthday, email, address, phone, image, role, status, username, password, createdAt, updatedAt) 
VALUES("Văn Thuận", "Nguyen", "0", "2002-12-10", "vanthuan2004@gmail.com", "An Lạc 1, Mỹ Hoà, Phù Mỹ, Bình Định", "0397252681", 
"/View/Admin/img/profile/A4.jpg", 1, 1, "vanthuan2004", "d9e6762dd1c8eaf6d61b3c6192fc408d4d6d5f1176d0c29169bc24e71c3f274ad27fcd5811b313d681f7e55ec02d73d499c95455b6b5bb503acf574fba8ffe85", 
"2020-05-10", "2020-05-10");

INSERT INTO User(firstname, lastname, gender, birthday, email, address, phone, image, role, status, username, password, createdAt, updatedAt) 
VALUES("Tâm", "Pham", "1", "2000-05-05", "phamthitam0505@gmail.com", "08, đường 10, tổ 5, ấp 4A, Bình Mỹ, Củ Chi, TP. Hồ Chí Minh", "0384516541", 
"/View/Admin/img/profile/A5.jpg", 1, 0, "phamtam0505", "561d36e0acc9c3249d5803c20c087b2ab08572cfc453c3decc50ee743bef23c5005a301dcfedf73cfc539dd53746f0d8c77faf4bed0e9b217e99d119c76dba0a", 
"2022-07-01", "2023-01-10");

SELECT * FROM Product;

-- Order
INSERT INTO `Order`(orderedDate, receivedDate, cancelledDate, status, receiverName, phone, address, total, userID)
VALUES ("2020-10-10", "2020-10-15", null, 2, "Lê Tú", "0397845621", "Phạm Văn Đồng, Hiệp Bình Chánh, TP. Thủ Đức, TP. Hồ Chí Minh", 1048000, 1);

INSERT INTO `Order`(orderedDate, receivedDate, cancelledDate, status, receiverName, phone, address, total, userID)
VALUES ("2023-04-16", null, null, 1, "Văn Thuận", "0397252681", "An Lạc 1, Mỹ Hoà, Phù Mỹ, Bình Định", 220000, 4);

INSERT INTO `Order`(orderedDate, receivedDate, cancelledDate, status, receiverName, phone, address, total, userID)
VALUES ("2023-02-22", null, "2023-02-23", 3, "Phạm Thị Tâm", "0384516541", "08, đường 10, tổ 5, ấp 4A, Bình Mỹ, Củ Chi, TP. Hồ Chí Minh", 278000, 5);

-- Order Item
INSERT INTO OrderItem (quantity, price, orderID, productID)
VALUES(1, 300000, 1, 1);

INSERT INTO OrderItem (quantity, price, orderID, productID)
VALUES(1, 249000, 1, 2);

INSERT INTO OrderItem (quantity, price, orderID, productID)
VALUES(1, 499000, 1, 3);

INSERT INTO OrderItem (quantity, price, orderID, productID)
VALUES(1, 100000, 2, 5);

INSERT INTO OrderItem (quantity, price, orderID, productID)
VALUES(2, 60000, 2, 10);

INSERT INTO OrderItem (quantity, price, orderID, productID)
VALUES(2, 139000, 3, 3);

INSERT INTO Review (star, comment, images, createdAt, updatedAt, userID, productID, orderItemID)
VALUES (5, "Sản phẩm rất đẹp. Con mình rất thích", "2020-10-16", null, 1, 1, 1);

INSERT INTO Review (star, comment, images, createdAt, updatedAt, userID, productID, orderItemID)
VALUES (5, "Giao hàng nhanh. Tư vấn nhiệt tình.", "2020-10-16", "2020-10-17", 1, 2, 2);

INSERT INTO Review (star, comment, images, createdAt, updatedAt, userID, productID, orderItemID)
VALUES (5, "Sẽ quay lại lần sau", "2020-10-16", null, 1, 3, 3);