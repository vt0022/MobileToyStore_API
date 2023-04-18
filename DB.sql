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
    price INTEGER,
    categoryID INT REFERENCES Category(categoryID)
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
    password CHAR(100) NOT NULL CHECK (length(password) >= 8),
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
    phone CHAR,
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

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Xe khủng long", "Sản phẩm xe tải chở khủng long kích thước lớn được thiết kế chắc chắn,
màu sắc tươi sang, hoạt động hoàn hảo tạo cảm giác thích thú cho bé khi chơi, bên cạnh đó xe được tặng kèm 3 chú khủng long dễ thương cho bé thỏa sức sáng tạo. 
Đồ chơi thiết kế thông minh, an toàn cho bé khi chơi", "/View/Customer/img/products/Oto/Xe_khung_long.jpg", 1, 300000, 1);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Xe công trình chuyên dụng", "Chức năng chính của xe tải sàn thấp là vận chuyển các thiết bị máy móc ở công trường,
được làm từ nhựa ABS và kim loại cao cấp, khung xe chắc chắn, người lái có thể quay 360 độ giúp dễ dàng hơn trong việc vận chuyển. Hơn thế nữa, mô hình này đã thể hiện rõ như thực tế. 
Các bé hãy cùng nhau lái xe ra công trường và giúp các cô chú công nhân nào.", "/View/Customer/img/products/Oto/Xe_cong_trinh_chuyen_dung.jpg", 1, 249000, 1);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Xe ô tô mini", "Màu sắc đa dạng, đẹp, nhỏ gọn bé có thể mang theo đi bất cứ đâu, không sắc nhọn, an toàn với trẻ nhỏ. 
Phù hợp với các bé nhỏ tuổi, chất liệu nhựa an toàn cho bé, lốp xe bằng cao su mềm có độ ma sát và độ bám rất tốt, xe có thể di chuyển dễ dàng trên nhiều địa hình khác nhau", "/View/Customer/img/products/Oto/Xe_o_to_mini.jpg", 1,  139000, 1);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Lắp ráp Pokemon", "Mô hình KEEPPLAY được làm từ chất liệu nhựa ABS được cắt ghép thành từng mảnh, mô phỏng mô hình các xe tăng, thiết kế độc đáo và bắt mắt. 
Mang lại sự trải nghiệm thú vị khi tự tay lắp ghép các tuyệt tác, chất liệu bền đẹp.", "/View/Customer/img/products/Pokemon/Lap_rap_pokemon.jpg", 1, 499000, 2);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Mô hình Pokemon", "Đồ chơi mô hình Pokemon bằng nhựa 24 con (5cm) là loại đồ chơi mô hình các chú pokemon được thiết kế với màu sắc tươi sáng, nhỏ nhắn, chân thật chắc chắn sẽ là món đồ chơi Pokemon được các bé yêu thích bộ phim hoạt hình này,
 muốn sưu tập cho mình những chú Pokemon dễ thương nhất. Sản phẩm dành cho các bé từ 5 tuổi trở lên.", "/View/Customer/img/products/Pokemon/Mo_hinh_pokemon.jpg", 1, 100000, 2);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Quả cầu Pokemon", "Sản phẩm Mô hình Quả Cầu Pokemon Go, Anime, Đồ chơi tự động ném thú Pikachu bao gồm 1 quả cầu và 1 mô hình pokemon chất lượng đảm bảo.
Kích thước mô hình: 8x8cm, chất liệu: Nhựa ABS, sử dụng mô hình thực tế là một phương pháp hiệu quả để dạy trẻ, giúp trẻ dễ dàng khám phá và học hỏi hơn.", "/View/Customer/img/products/Pokemon/Qua_cau_pokemon.jpg", 1, 60000, 2);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Thẻ bài Pokemon", "Rèn luyện khả năng: Phát triển trí tuệ, phối hợp tay và não, trau dồi sở thích, cảm xúc, đồ chơi tương tác, tăng thị giác. 
Gói hàng bao gồm: 1 Hộp gồm 36 gói, 1 gói gồm 9 thẻ,8 túi mỗi thẻ + 1 thẻ flash ,tổng cộng 324 thẻ. Với Pokémon TCG bạn có thể vừa sưu tập, vừa đấu bài với người khác, 
đấu bài online hoặc chỉ đơn giản là sưu tập những mẫu thẻ bài mình yêu thích", "/View/Customer/img/products/Pokemon/The_bai_pokemon.jpg",  1, 229000, 2);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Đất nặn 36 kèm khuôn", "Hộp đồ chơi đất sét 24 màu cho bé được làm từ nguyên liệu tự nhiên: bột gỗ, chất làm quánh. Không độc hại; Không dây bẩn ra sàn nhà. Bao gồm: 24 màu, 21 khuôn hình, dao cắt, và phụ kiện khác. 
Có sách hướng dẫn. Dễ chơi, dễ tạo hình, kích thích óc sáng tạo. Sản phẩm kèm hộp đựng tiện lợi. Hộp đồ chơi đất sét 24 màu cho bé tạo hình khối không độc hại cho trẻ em", "/View/Customer/img/products/Datnan/Dat_nan_36_mau_kem_khuon.jpg", 1, 199000, 3);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Đắt nặn làm bánh", "Đất nặn khay bánh ngọt ngào Play-doh B0307 với các gam màu tươi sáng và chất liệu bột mì an toàn, bé yêu của mẹ thỏa sức sáng tạo và nhào nặn ra những con vật, đồ vật đẹp mắt,
bé có thể tăng cường trí sáng tạo của mình bởi những sản phẩm tạo ra với hình thù ngộ nghĩnh và đáng yêu nhất.", "/View/Customer/img/products/Datnan/Dat_nan_lam_banh.jpg", 1, 225000, 3);

INSERT INTO Product (productName, description, images, status, price, categoryID)
VALUES("Đất nặn Nara", "Đất nặn Nara bao gồm 12 màu sắc neol tươi sáng và dụng cụ tạo hình đát nặn giúp bé nhanh chóng ghi nhớ các màu sắc. 
Đây còn là trò chơi giúp trẻ phát triển trí tuệ bằng cách trẻ sẽ tự tay làm những mẫu vật khác nhau kèm theo những dụng cụ và khuôn hình cho bé tha hồ sáng tạo thế giới đầy màu sắc cho riêng mình.", "/View/Customer/img/products/Datnan/Dat_nan_Nara.jpg", 1, 60000, 3);
    