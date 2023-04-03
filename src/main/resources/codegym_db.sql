drop database if exists truemart;
create database truemart;
use truemart;
CREATE TABLE `users`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `role` VARCHAR(255) NOT NULL,
    `firstname` VARCHAR(255) NOT NULL,
    `lastname` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phonenumber` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL
);

CREATE TABLE `payments`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `order_details_id` INT NOT NULL,
    `shop_id` INT NOT NULL,
    `quantity` INT NOT NULL,
    `status` VARCHAR(255) NOT NULL,
    `payment_type` VARCHAR(255) NOT NULL
);

CREATE TABLE `order_details`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `total` VARCHAR(255) NOT NULL
);

CREATE TABLE `cart_details`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `total` INT NOT NULL
);

CREATE TABLE `cart_item`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `product_id` INT NOT NULL,
    `carts_id` INT NOT NULL,
    `quantity` INT NOT NULL
);
CREATE TABLE `product`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `brand` VARCHAR(45),
    `category_id` INT NOT NULL,
    `shop_id` INT NOT NULL,
    `image` VARCHAR(255) NOT NULL,
    `price` VARCHAR(45) NOT NULL,
    `description` TEXT,
    `details` TEXT,
    `quantity` INT NOT NULL
);

CREATE TABLE `category`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `category_name` VARCHAR(255) NOT NULL
);

CREATE TABLE `notification`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `shop_id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);

CREATE TABLE `shop`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `id_users` INT NOT NULL,
	`shop_name` VARCHAR(255) NOT NULL,
	`shopper_details_id` INT NOT NULL,
    `address` VARCHAR(255) NOT NULL
);

CREATE TABLE `shopper_details` (
	`id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL,
    `phonenumber` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `category` VARCHAR(255) NOT NULL,
    `quantity` INT NOT NULL,
    `date_created` date,
    `avatar` varchar(255)
);

CREATE TABLE `comment`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `post_id` INT NOT NULL,
    `comment` TEXT NOT NULL
);

create table contact(
	id int primary key auto_increment,
    fullname varchar(255),
    email varchar(255),
    website varchar(255),
    subject varchar(255),
    content text
);

CREATE TABLE `post`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `shop_id` INT NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `body` TEXT NOT NULL,
    `post_date` DATETIME NOT NULL
);

CREATE TABLE `order_item`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `order_details_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `quantity` INT NOT NULL
);

CREATE TABLE `discount`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `shop_id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `discount_percent` DECIMAL(8, 2) NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `modified_at` TIMESTAMP NOT NULL
);

CREATE TABLE `review`(
    `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `user_review` VARCHAR(255) NOT NULL,
	`email_review` VARCHAR(255) NOT NULL,
    `product_id` INT NOT NULL,
    `content` VARCHAR(255) NOT NULL,
    `rating` VARCHAR(255) NOT NULL,
    `post_date` DATETIME NOT NULL
);

CREATE TABLE `message`(
   `id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   `sender_id` INT NOT NULL,
   `receiver_id` INT NOT NULL,
   `message` TEXT NOT NULL,
   `submit_date` DATETIME NOT NULL
);
CREATE TABLE `truemart`.`payment_method` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `payment_method_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `truemart`.`invoice` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `date_payment` DATETIME NOT NULL,
  `quantity` INT NOT NULL,
  `price` VARCHAR(45) NOT NULL,
  `payment_method` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  INDEX `payment_idx` (`payment_method` ASC) VISIBLE,
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `truemart`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `truemart`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `payment`
  FOREIGN KEY (`payment_method`)
  REFERENCES `truemart`.`payment_method` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION);

ALTER TABLE
    `message` ADD CONSTRAINT `message_sender_id_foreign` FOREIGN KEY(`sender_id`) REFERENCES `users`(`id`);
 ALTER TABLE
    `message` ADD CONSTRAINT `message_receiver_id_foreign` FOREIGN KEY(`receiver_id`) REFERENCES `users`(`id`);
    
ALTER TABLE
    `notification` ADD CONSTRAINT `notification_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `order_details` ADD CONSTRAINT `order_details_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `cart_details` ADD CONSTRAINT `cart_details_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `cart_item` ADD CONSTRAINT `cart_item_carts_id_foreign` FOREIGN KEY(`carts_id`) REFERENCES `cart_details`(`id`);
ALTER TABLE
    `cart_item` ADD CONSTRAINT `cart_item_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `product`(`id`);
ALTER TABLE
    `review` ADD CONSTRAINT `review_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `product`(`id`);
ALTER TABLE
    `product` ADD CONSTRAINT `product_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `category`(`id`);
ALTER TABLE
    `product` ADD CONSTRAINT `product_shop_id_foreign` FOREIGN KEY(`shop_id`) REFERENCES `shop`(`id`);
ALTER TABLE
    `notification` ADD CONSTRAINT `notification_shop_id_foreign` FOREIGN KEY(`shop_id`) REFERENCES `shop`(`id`);
ALTER TABLE
    `post` ADD CONSTRAINT `post_shop_id_foreign` FOREIGN KEY(`shop_id`) REFERENCES `shop`(`id`);
ALTER TABLE
    `comment` ADD CONSTRAINT `comment_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `comment` ADD CONSTRAINT `comment_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `post`(`id`);
ALTER TABLE
    `order_item` ADD CONSTRAINT `order_item_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `product`(`id`);
ALTER TABLE
    `order_item` ADD CONSTRAINT `order_item_order_details_id_foreign` FOREIGN KEY(`order_details_id`) REFERENCES `order_details`(`id`);
ALTER TABLE
    `discount` ADD CONSTRAINT `discount_shop_id_foreign` FOREIGN KEY(`shop_id`) REFERENCES `shop`(`id`);
-- ALTER TABLE
--     `review` ADD CONSTRAINT `review_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `payments` ADD CONSTRAINT `payments_shop_id_foreign` FOREIGN KEY(`shop_id`) REFERENCES `shop`(`id`); 
ALTER TABLE
    `payments` ADD CONSTRAINT `payments_order_details_id_foreign` FOREIGN KEY(`order_details_id`) REFERENCES `order_details`(`id`);
ALTER TABLE
    `shop` ADD CONSTRAINT `shop_shopper_details_id_foreign` FOREIGN KEY(`shopper_details_id`) REFERENCES `shopper_details`(`id`);  
  
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'Admin', 'Robert', 'Smith', 'pallen@yahoo.com', '(801) 798-0344', '24645 Valerie Unions Suite 582');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('2', 'shop01', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Robert', 'Smith', 'pallen@yahoo.com', '(801) 798-0344', '24645 Valerie Unions Suite 582');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('3', 'shop02', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'James', 'Johnson', 'mstephens@davidson-herman.com', '(908) 351-0330', 'Cobbborough, DC 99414-7564');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('4', 'shop03', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Michael', 'Johnson', 'alvareznancy@lucas.biz', '(763) 271-5600', '14023 Rodriguez Passage');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('5', 'dontlookatme20', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'William', 'Smith', 'katherine20@yahoo.com', '(641) 747-2407', 'Port Jacobville, PR 37242-1057');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('6', 'dogerlove', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'James', 'Williams', 'awatkins@yahoo.com', '(712) 722-4787', '645 Martha Park Apt. 611');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('7', 'theblacktaco', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Robert', 'Johnson', 'vchurch@walter-martinez.com', '(812) 522-3964', 'Jeffreychester, MN 67218-7250');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('8', 'idkwhattodoy', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Mary', 'Smith', 'bonnie69@lin.biz', '(845) 434-8115', '68388 Reyes Lights Suite 692');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('9', 'hahahahhahelpme', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'James', 'Brown', 'andrew06@peterson.com', '(360) 659-6251', 'Josephbury, WV 92213-0247');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('10', 'vicsloan', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'David', 'Johnson', 'knelson@gmail.com', '(209) 599-2121', 'Unit 6538 Box 8980');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('11', 'Xsxcx', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Maria', 'Garcia', 'taylormason@gmail.com', '(507) 237-4600', 'DPO AP 09026-4941');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('12', 'BizzarGhostGaming', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'James', 'Jones', 'rebecca45@hale-bauer.biz', '(803) 276-5803', '860 Lee Key');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('13', 'AmazingDieudo', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Maria', 'Rodriguez', 'alejandro75@hotmail.com', '(812) 678-3471', 'West Debra, SD 97450-0495');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('14', 'RayShmurda6', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Robert', 'Brown', 'samuel46@love-west.net', '(574) 858-2514', 'PSC 2734, Box 5255');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('15', 'randomstuff063', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Maria', 'Martinez', 'ijones@schaefer-carr.net', '(603) 742-1050', 'APO AA 98456-7482');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('16', 'llIlIllilIlllI', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Charles', 'Smith', 'heatherhall@yahoo.com', '(334) 585-2268', '26104 Alexander Groves');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('17', 'pego_tinn', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'David', 'Brown', 'tinasmith@martinez.info', '(218) 346-2500', 'Alexandriaport, WY 28244-9149');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('18', 'user01', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'James', 'Smith', 'mstephenson@fernandez.com', '(908) 282-7900', '6705 Miller Orchard Suite 186');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('19', 'user02', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Michael', 'Smith', 'hduke@hotmail.com', '(912) 449-5700', 'Lake Shanestad, MO 75696-5051');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('20', 'user03', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'David', 'Smith', 'riverarebecca@gmail.com', '(618) 245-3301', '7773 Powell Springs Suite 190');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('21', 'The_real_Schnitzel', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'John', 'Smith', 'ryanwerner@freeman.biz', '(908) 282-7900', 'Samanthaland, ND 44358');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('22', 'katajin31309', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Michael', 'Brown', 'wrightpeter@yahoo.com', '(360) 458-6966', '8982 Burton Row');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('23', 'porchcoors50', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Michael', 'Williams', 'jstark@anderson.com', '(920) 648-7826', 'Wilsonton, PW 88606');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('24', 'idiociest', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Michael', 'Jones', 'wjennings@gmail.com', '(219) 335-2087', '64475 Andre Club Apt. 795');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('25', 'Lost-n-Confused28', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Michael', 'Miller', 'megan33@gmail.com', '(503) 651-0000', 'Port Dannytown, PW 63227');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('26', 'GrimmMarshal', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Robert', 'Jones', 'agolden@yahoo.com', '(908) 282-7900', '544 Alexander Heights Suite 768');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('27', 'inception73', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Robert', 'Williams', 'vstafford@hotmail.com', '(660) 886-3381', 'North Johnview, MT 57912');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('28', 'Rahulkumar18', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'William', 'Johnson', 'denise22@hernandez-townsend.com', '(570) 425-2910', '657 Judith Crossroad');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('29', 'MBSUPERSPAZZ', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'James', 'Davis', 'youngbarbara@yahoo.com', '(845) 434-7560', 'Hancockchester, VI 75658-5788');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('30', 'eriktheredhead', 'e10adc3949ba59abbe56e057f20f883e', 'Customer ', 'Mary', 'Johnson', 'william25@mcconnell.com', '(661) 327-1456', '8522 Regina Port Suite 782');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('31', 'Jaquelin', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Jaquelin', 'Marisa"', 'Jaquelin@martinez.info', '(178) 367-2789', 'Princeton NJ 08544-0070 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('32', 'pego_tinn', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'David', 'Brown', 'tinasmith@martinez.info', '(123) 704-5282', '1 Maybeck Place Elsah IL 62028-9799 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('33', 'crystalssniff', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Lisa', 'Miller', 'chithanh.ha@yahoo.com', '(375) 168-5919', '3 Executive Campus Rt 70, Suite 280 Cherry Hill NJ 08002 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('34', 'deltasopening', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Bryan', 'Logan', 'tatbinh.tang@yahoo.com', '(348) 690-7523', '8040 Roosevelt Boulevard Philadelphia PA 19152 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('35', 'burplumbar', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Duane ', 'Martinez', 'vanchi76@gmail.com', '(440) 498-4664', '6800 Market Street Upper Darby PA 19082 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('36', 'brokercenter', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Jack ', 'Howard', 'nhattien_to6@yahoo.com', '(313) 279-4956', '5684 Memorial Dr Stone Mountain GA 30083-3254 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('37', 'hillfrightened', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Joshua', 'Clark', 'monghang_doan@hotmail.com', '(824) 346-3068', '210 Burruss Hall, 800 Drillfield Dr. Blacksburg VA 24061-0131 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('38', 'disclosepicky', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Cynthia ', 'Lowe', 'kimxuan26@hotmail.com', '(566) 459-9715', '101 West Queens Way Hampton VA 23669 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('39', 'regardabdomen', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'James ', 'Hampton', 'baothuy_nguyen@yahoo.com', '(473) 353-5274', '153 Zan Road Charlottesville VA 22901 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('40', 'glorysquat', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Sarah ', 'Johnson', 'ngocyen.dao62@hotmail.com', '(946) 155-1951', '1033 S Broadway St Los Angeles CA 90015-4001 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('41', 'fielderchoice', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'David', 'Mendoza', 'thusuong81@hotmail.com', '(113) 932-2377', '1033 S Broadway St Los Angeles CA 90015-4001 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('42', 'stillfarmer', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Kyle ', 'White', 'khanhmai_dang82@hotmail.com', '(508) 207-8242', '1 Hayden Drive Petersburg VA 23806 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('43', 'horseradishdown', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Kimberly', 'Brown', 'honggiang_dinh69@hotmail.com', '(889) 199-6731', '2 Riverside Circle Roanoke VA 24016-4950 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('44', 'phantomcoalition', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'David', 'Andersen', 'tuyloan41@yahoo.com', '(922) 617-4973', '8565 Eagle Point Circle Lake Elmo MN 55042-8624 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('45', 'bootwrack', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'David', 'Brown', 'viquyen39@hotmail.com', '(973) 672-9125', '18600 Fernview St Land O\'Lakes FL 34638-9558 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('46', 'gaseousoffended', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Jerry', 'Hernandez', 'baotien.vu@yahoo.com', '(697) 729-1486', '1400 Madison Avenue Mankato MN 56001-5476 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('47', 'craftingremnant', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Christina ', 'Mathis', 'huyentrang.mai13@yahoo.com', '(347) 269-8103', '8650 West Spring Lake Road Mokena IL 60448-6219 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('48', 'gushwound', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Rebecca ', 'Williams', 'thuanhoa.trinh23@yahoo.com', '(618) 239-9185', '8661 Citizens Drive,  Suite 300 New Port Richey FL 34654-5559 USA');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('49', 'leftprobably', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Melissa ', 'Taylor', 'hongthu54@hotmail.com', '(881) 287-1976', 'Alexandriaport, WY 28244-9149');
INSERT INTO users (id, username, password, role, firstname, lastname, email , phonenumber, address) VALUES ('50', 'ethicalmacaw', 'e10adc3949ba59abbe56e057f20f883e', 'Producter', 'Evans', 'Brown', 'quochung_dao67@yahoo.com', '(478) 879-1415', '1400 West Normantown Road Romeoville IL 60446-6219 USA');


INSERT INTO `truemart`.`payment_method` (`id`, `payment_method_name`) VALUES ('1', 'Cash');
INSERT INTO `truemart`.`payment_method` (`id`, `payment_method_name`) VALUES ('2 ', 'VNPay');
INSERT INTO `truemart`.`payment_method` (`id`, `payment_method_name`) VALUES ('3', 'Paypal');



INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('1', 'dongnguyen_to@hotmail.com', '', '98 Wadsworth Blvd, Suite 115 Lakewood CO 80226 USA', 'Computers & Laptop', '222', '2018-07-24', '01.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('2', 'thanhdanh.to26@yahoo.com', '', '3415 East Saginaw Street, Suite E Lansing MI 48912 USA', 'Phone & Tablets', '293', '2021-02-27', '02.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('3', 'thucoanh_dinh@gmail.com', '', '2325 South Stemmons Freeway, Suite 404 Lewisville TX 75067 USA', 'Accessories ', '270', '2022-06-07', '03.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('4', 'lenhi71@yahoo.com', '', '2614 South Shackleford Road Little Rock AR 72205 USA', 'Sports', '259', '2021-10-05', '04.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('5', 'daiduong_doan93@gmail.com', '', '2358 East Springs Drive, Suite 300 Madison WI 53704 USA', 'Electronics', '235', '2016-10-14', '05.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('6', 'quynhtrang.mai@gmail.com', '', '11740 Sudley Manor Drive Manassas VA 20109 USA', 'Furnitures', '250', '2020-03-26', '06.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('7', 'bathinh.pham34@gmail.com', '', '4500 New Brunswick Ave Piscataway NJ 08854 USA', 'TV', '291', '2019-11-23', '07.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('8', 'thuymai91@gmail.com', '', '5450 W Sahara Ave, #320 Las Vegas NV 89146-0383 USA', 'Fashions', '256', '2018-08-31', '08.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('9', 'chigiang.truong23@gmail.com', '', '4500 S. Garnett Rd. Suite 110 Tulsa OK 74146 USA', 'Beauty', '278', '2020-02-03', '09.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('10', 'tuyettam18@gmail.com', '', '440 S 54th Avenue Phoenix AZ 85043-4729 USA', 'Computers & Laptop', '257', '2020-04-15', '10.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('11', 'hungthinh_nguyen38@hotmail.com', '', '2363 Lakewood Rd Toms River NJ 08755 USA', 'Phone & Tablets', '250', '2017-11-16', '11.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('12', 'quocthinh.phung@hotmail.com', '', '6600 Peachtree Dunwoody Road, 500 Embassy Row Atlanta GA 30328 USA', 'Accessories ', '216', '2022-09-18', '12.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('13', 'huuthang79@gmail.com', '', '200 Riverview Parkway Santee CA 92071 USA', 'Sports', '295', '2021-05-06', '13.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('14', 'thanhloi_lam@yahoo.com', '', '1313 Park Boulevard San Diego CA 92101-4787 USA', 'Electronics', '269', '2019-01-25', '14.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('15', 'mynga_mai@yahoo.com', '', '3350 Market St Ste C San Diego CA 92102 USA', 'Furnitures', '298', '2018-04-15', '15.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('16', 'bachyen5@hotmail.com', '', '3375 Camino Del Rio S San Diego CA 92108-3883 USA', 'TV', '207', '2021-08-31', '16.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('17', 'ngocanh_duong@hotmail.com', '', '8024 La Mesa Blvd San Diego CA 91942 USA', 'Fashions', '207', '2021-07-28', '17.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('18', 'huyviet38@hotmail.com', '', '7250 Mesa College Dr San Diego CA 92111-4998 USA', 'Beauty', '223', '2015-02-23', '18.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('19', 'quynhtho.dang@hotmail.com', '', '917 Saginaw St Bay City MI 48708-5614 USA', 'Computers & Laptop', '231', '2020-08-07', '19.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('20', 'tantai_dao@gmail.com', '', '105 E Main St Leesburg FL 34748 USA', 'Phone & Tablets', '290', '2021-03-10', '20.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('21', 'bangbang.dinh27@yahoo.com', '', '99 Farm Road Bangor ME 04401 USA', 'Accessories ', '273', '2020-09-24', '21.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('22', 'songke.ha@gmail.com', '', '1221 SW 12th Avenue Portland OR 97205 USA', 'Sports', '272', '2016-11-22', '22.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('23', 'danthu_trinh@gmail.com', '', '2201 Lloyd Center Portland OR 97232-1315 USA', 'Electronics', '294', '2020-08-27', '23.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('24', 'mongnguyet_duong26@gmail.com', '', '791 W. Middle Turnpike Manchester CT 06040 USA', 'Furnitures', '211', '2019-03-28', '24.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('25', 'lienhuong33@yahoo.com', '', '70 Sip Avenue Jersey City NJ 07306 USA', 'TV', '201', '2015-10-29', '25.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('26', 'honggiang.vuong@yahoo.com', '', '80 Vandenburgh Ave Troy NY 12180 USA', 'Fashions', '263', '2020-01-26', '26.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('27', 'trucphuong.bui@gmail.com', '', '#41 Hector R Bunker St Caguas PR 00725 USA', 'Beauty', '258', '2016-01-19', '27.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('28', 'thuyminh.trinh@yahoo.com', '', '1 Education Street Cambridge MA 02141 USA', 'Computers & Laptop', '232', '2014-04-26', '28.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('29', 'thanhkieu61@hotmail.com', '', '1 Harpst Street Arcata CA 95521-8299 USA', 'Phone & Tablets', '220', '2018-03-28', '29.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('30', 'hanhnhon_nguyen@gmail.com', '', '15 Ward Street Bloomfield NJ 07003 USA', 'Accessories ', '209', '2022-07-03', '30.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('31', 'phuonguyen99@gmail.com', '', '9749 Lyndale Ave S Bloomington MN 55420-4232 USA', 'Sports', '275', '2015-11-19', '31.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('32', 'huudinh_hoang@yahoo.com', '', '610 Rt 206 Bordentown NJ 08505 USA', 'Electronics', '243', '2018-11-11', '32.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('33', 'ngocloan_nguyen@gmail.com', '', '30 West Street Boston MA 02111 USA', 'Furnitures', '213', '2021-12-03', '33.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('34', 'vietduong.ha@gmail.com', '', '2384 86th St Brooklyn NY 11214 USA', 'TV', '282', '2020-01-26', '34.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('35', 'bichhau_vu@gmail.com', '', '2190 Walden Avenue Cheektowaga NY 14225-5177 USA', 'Fashions', '214', '2018-01-03', '35.jpg');
INSERT INTO shopper_details (id, email, phonenumber, address, category, quantity, date_created, avatar) VALUES ('36', 'batruc_dang68@yahoo.com', '', '111 S.W. C Ave. Lawton OK 73501 USA', 'Beauty', '238', '2016-10-03', '36.jpg');

INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('1', '2', 'BuyBusters', '1', '98 Wadsworth Blvd, Suite 115 Lakewood CO 80226 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('2', '3', 'Star Square', '2', '3415 East Saginaw Street, Suite E Lansing MI 48912 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('3', '4', 'East Elm', '3', '2325 South Stemmons Freeway, Suite 404 Lewisville TX 75067 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('4', '5', 'SunSide ', '4', '2614 South Shackleford Road Little Rock AR 72205 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('5', '6', 'Hues of Blues', '5', '2358 East Springs Drive, Suite 300 Madison WI 53704 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('6', '7', 'Green Team', '6', '11740 Sudley Manor Drive Manassas VA 20109 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('7', '8', 'Blessed Rest ', '7', '4500 New Brunswick Ave Piscataway NJ 08854 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('8', '9', 'The Home Dome', '8', '5450 W Sahara Ave, #320 Las Vegas NV 89146-0383 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('9', '10', 'Peak Performance', '9', '4500 S. Garnett Rd. Suite 110 Tulsa OK 74146 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('10', '11', 'Sweet Street', '10', '440 S 54th Avenue Phoenix AZ 85043-4729 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('11', '12', 'SnapStitch', '11', '2363 Lakewood Rd Toms River NJ 08755 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('12', '13', 'Code Creations', '12', '6600 Peachtree Dunwoody Road, 500 Embassy Row Atlanta GA 30328 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('13', '14', 'Treasure Trove', '13', '200 Riverview Parkway Santee CA 92071 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('14', '15', 'FlashFresh', '14', '1313 Park Boulevard San Diego CA 92101-4787 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('15', '16', 'Pristine Purpose', '15', '3350 Market St Ste C San Diego CA 92102 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('16', '17', 'Ignition', '16', '3375 Camino Del Rio S San Diego CA 92108-3883 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('17', '31', 'Elegata ', '17', '8024 La Mesa Blvd San Diego CA 91942 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('18', '32', 'Dionysus', '18', '7250 Mesa College Dr San Diego CA 92111-4998 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('19', '33', 'WabiSabi', '19', '917 Saginaw St Bay City MI 48708-5614 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('20', '34', 'Tyche', '20', '105 E Main St Leesburg FL 34748 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('21', '35', 'Saudade', '21', '99 Farm Road Bangor ME 04401 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('22', '36', 'Elevation', '22', '1221 SW 12th Avenue Portland OR 97205 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('23', '37', 'Kilig', '23', '2201 Lloyd Center Portland OR 97232-1315 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('24', '38', 'Subliminate', '24', '791 W. Middle Turnpike Manchester CT 06040 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('25', '39', 'Wednesdays', '25', '70 Sip Avenue Jersey City NJ 07306 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('26', '40', 'Morarity', '26', '80 Vandenburgh Ave Troy NY 12180 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('27', '41', 'Whatsits', '27', '#41 Hector R Bunker St Caguas PR 00725 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('28', '42', 'Randominium', '28', '1 Education Street Cambridge MA 02141 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('29', '43', 'Bizarrify', '29', '1 Harpst Street Arcata CA 95521-8299 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('30', '44', 'Oksana', '30', '15 Ward Street Bloomfield NJ 07003 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('31', '45', 'Odds And Ends', '31', '9749 Lyndale Ave S Bloomington MN 55420-4232 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('32', '46', 'Handy Help', '32', '610 Rt 206 Bordentown NJ 08505 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('33', '47', 'Knick Knacks', '33', '30 West Street Boston MA 02111 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('34', '48', 'Nick’S Knacks', '34', '2384 86th St Brooklyn NY 11214 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('35', '49', 'Etc.', '35', '2190 Walden Avenue Cheektowaga NY 14225-5177 USA');
INSERT INTO shop (id, id_users, shop_name, shopper_details_id, address) VALUES ('36', '50', 'Et Cetera Systems', '36', '111 S.W. C Ave. Lawton OK 73501 USA');


insert into category(id,category_name) values
(1,"Computers & Laptops"),
(2,"Phones & Tablets"),
(3,"Accessories "),
(4,"Sports"),
(5,"Electronics"),
(6,"Furnitures"),
(7,"TV"),
(8,"Fashions"),
(9,"Beauty");

-- insert into order_details(id,user_id,total) values
-- (1,1,"30"),
-- (2,2,"10"),
-- (3,3,"20"),
-- (4,4,"30"),
-- (5,5,"40"),
-- (6,6,"10"),
-- (7,7,"10"),
-- (8,8,"10"),
-- (9,9,"10"),
-- (10,10,"10"),
-- (11,11,"10"),
-- (12,12,"10");

-- INSERT INTO payments (id,order_details_id, shop_id, quantity, status, payment_type) VALUES 
-- (1, 5, 1,6, 'sent', 'check'),
-- (2, 1, 2, 7, 'paid', 'credit card'),
-- (3, 4, 4, 5, 'issued', 'store value card'),
-- (4, 2, 3, 4, 'partially paid', 'cash'),
-- (5, 3, 5, 3, 'sent', 'Electronic bank transfers');

INSERT INTO product (id, Name, brand, category_id, shop_id, image, price, description, details, quantity) VALUES ('1', 'Apple 2020 MacBook Air Laptop M1 Chip, Backlit Keyboard', 'Apple', '1', '3', '1.jpg', '23.200.000', 'MacBook Air 13.3" with Retina Display - 30W USB Type-C Power Adapter - USB Type-C Charge Cable (2m) - Apple 1 Year Limited Warranty with 90 Day Technical Support
Apple M1 chip with 8-core CPU and 7-core GPU
16-core Neural Engine
8GB unified memory
512GB SSD storage', 'Brand	Apple \n
Series	MacBook Air \n
Screen Size	13.3 Inches \n
Color	Space Gray \n
Hard Disk Size	512 GB \n
CPU Model	Apple M1 \n
Ram Memory Installed Size	8 GB
Operating System	Mac OS
Card Description	Integrated
Graphics Coprocessor	M1', '10')
,('2', 'Apple 2021 MacBook Pro - Space Gray - Z14X000HQ', 'Apple', '1', '3', '1.jpg', '24.500.000', 'Apple M1 Max chip for a massive leap in CPU, GPU, and machine learning performance
10-core CPU delivers up to 2x faster performance to fly through pro workflows quicker than ever
32-core GPU with up to 4x faster performance for graphics-intensive apps and games
16-core Neural Engine for up to 5x faster machine learning performance
Longer battery life, up to 21 hours
64GB of unified memory so everything you do is fast and fluid
2TB of superfast SSD storage launches apps and opens files in an instant', 'Brand	Apple
Series	MacBook pro
Screen Size	16.2 Inches
Hard Disk Size	2 TB
CPU Model	ARM 7100
Ram Memory Installed Size	64 GB
Operating System	Mac OS
Card Description	Integrated
Graphics Coprocessor	M1 Max
CPU Speed	3.2 GHz
', '10')
, ('3', 'Apple 2022 MacBook Air Laptop with M2 chip 13.6-inch Liquid Retina Display', 'Apple', '1', '3', '1.jpg', '23.220.000', 'STRIKINGLY THIN DESIGN — The redesigned MacBook Air is more portable than ever and weighs just 2.7 pounds. It’s the incredibly capable laptop that lets you work, play or create just about anything — anywhere.
SUPERCHARGED BY M2 — Get more done faster with a next-generation 8-core CPU, up to 10-core GPU and up to 24GB of unified memory.
UP TO 18 HOURS OF BATTERY LIFE — Go all day and into the night, thanks to the power-efficient performance of the Apple M2 chip.
BIG, BEAUTIFUL DISPLAY — The 13.6-inch Liquid Retina display features over 500 nits of brightness, P3 wide color and support for 1 billion colors for vibrant images and incredible detail.
ADVANCED CAMERA AND AUDIO — Look sharp and sound great with a 1080p FaceTime HD camera, three-mic array and four-speaker sound system with Spatial Audio.
VERSATILE CONNECTIVITY — MacBook Air features a MagSafe charging port, two Thunderbolt ports and a headphone jack.
EASY TO USE — Your Mac feels familiar from the moment you turn it on, and works seamlessly with all your Apple devices.', 'Brand	Apple
Model Name	MacBook Air
Screen Size	13.6 Inches
Color	Silver
Hard Disk Size	512 GB
CPU Model	Unknown
Ram Memory Installed Size	8 GB
Operating System	Mac OS
Graphics Card Description	Integrated
Graphics Coprocessor	Apple M2', '10')
, ('4', 'Apple MacBook Pro 16 with Liquid Retina XDR Display', 'Apple', '1', '3', '1.jpg', '26.500.000', 'Apple MacBook Pro 16" with Liquid Retina XDR Display - 140W USB-C Power Adapter - USB-C to MagSafe 3 Cable (2m) - Apple 1 Year Limited Warranty
Apple M1 Max chip for a massive leap in CPU, GPU, and machine learning performance
10-core CPU delivers up to 2x faster performance to fly through pro workflows quicker than ever
24-core GPU with up to 4x faster performance for graphics-intensive apps and games
16-core Neural Engine for up to 5x faster machine learning performance', 'Brand	Apple
Screen Size	16 Inches
CPU Model	Apple M1
Ram Memory Installed Size	32 GB
Operating System	Mac OS
Card Description	Dedicated
Resolution	8K
Item Weight	8.4 Pounds
Chipset Brand	Apple
CPU Manufacturer	Apple', '10')
, ('5', 'ASUS ROG Strix G15 (2022) Gaming Laptop G513RC-IS74', 'Asus', '1', '3', '1.jpg', '37.000.000', 'SUPERCHARGED RTX GRAPHICS - Gameplay graphics are silky smooth with the NVIDIA GeForce RTX 3050 4GB GDDR6 at 95W with ROG Boost, with cutting-edge AI features like NVIDIA DLSS and Ray-Tracing
MUX SWITCH BOOST - A MUX Switch lets the GPU communicate directly with the display, increasing performance and decreasing latency
ROG INTELLIGENT COOLING - a robust thermal system with Thermal Grizzly Liquid Metal Thermal Compound and self cleaning dual fans with anti-dust technology extend system longevity
READY FOR ANYTHING - Use your gaming laptop to stream and multi-task with ease thanks to an AMD Ryzen 7 6800H CPU with 20MB Cache, up to 4.7 GHz, 8 cores/16 threads and 16GB of blisteringly fast 4800MHz DDR5 RAM on Windows 11 Home
SWIFT VISUALS – Stay one step ahead of the competition thanks to its 300Hz/3ms 15.6” Full HD (1920 x 1080) IPS Type Display, which covers 100% sRGB color space
AMPLE STORAGE FOR ALL YOUR GAMES - Store all your game library, and load them fast on your 1TB PCIe NVMe M.2 SSD to take advantage of the full RTX gaming experience
AURA SYNC - 4-zone RGB Keyboard, RGB light bar, RGB Logo', 'Brand	ASUS
Series	ROG Strix G15
Screen Size	15.6 Inches
Color	Gray
Hard Disk Size	1 TB
CPU Model	Ryzen 7
Ram Memory Installed Size	16 GB
Operating System	Windows 11 Home
Card Description	GeForce RTX 3050
Graphics Coprocessor	NVIDIA GeForce RTX 3050', '10')
, ('6', 'ASUS ROG Strix G16 (2023) Gaming Laptop G614JI-AS94', 'Asus', '1', '3', '1.jpg', '16.000.000', 'POWER UP YOUR PLAY - Draw more frames and win more games with Windows 11, a 13th Gen Intel Core i9-13980HX processor, and an NVIDIA GeForce RTX 4070 Laptop GPU at 140W Max TGP.
BLAZING FAST MEMORY AND STORAGE – Multitask swiftly with 16GB of DDR5-4800MHz memory and speed up loading times with 1TB of PCIe 4x4.
ROG INTELLIGENT COOLING – To put this amount of power in a gaming laptop, you need an even better cooling solution. The Strix features Thermal Grizzly’s Conductonaut Extreme liquid metal on the CPU, and a third intake fan among other premium features, to allow for better sustained performance over long gaming sessions.
SWIFT VISUALS – The Strix G16 has a fast FHD 165Hz panel to make sure you never miss a moment. It also covers 100% of the sRGB color space and feature Dolby Vision, Adaptive-Sync support, and an 90% screen-to-body ratio for a stellar gaming and viewing experience.
MUX SWITCH WITH ADVANCED OPTIMUS - A MUX Switch increases laptop gaming performance by 5-10% by routing frames directly from the dGPU to the display bypassing the iGPU. With Advanced Optimus the switch between iGPU and dGPU becomes automatic based on the task, optimizing battery life.', 'Brand	ASUS
Series	ROG Strix G16
Screen Size	16 Inches
Color	Eclipse Gray
CPU Model	Intel Core i9
Ram Memory Installed Size	16 GB
Operating System	Windows 11 Home
Card Description	Dedicated
Graphics Coprocessor	NVIDIA GeForce RTX 4070
CPU Speed	5.6 GHz', '10')
, ('7', 'ASUS TUF Dash 15 (2022) Gaming Laptop Off Black, FX517ZM-AS73', 'Asus', '1', '3', '1.jpg', '23.000.000', 'SUPERCHARGED RTX GRAPHICS - Gameplay graphics are silky smooth with the NVIDIA GeForce RTX 3060 6GB GDDR6 at 1050W with Dynamic Boost, with cutting-edge AI features like NVIDIA DLSS and Ray-Tracing
MUX SWITCH BOOST - A MUX Switch lets the GPU communicate directly with the display, increasing performance and decreasing latency
READY FOR ANYTHING - Use your gaming laptop to stream and multi-task with ease thanks to an  Intel Core i7-12650H Processor with 24MB Cache, up to 4.7 GHz, 10 cores (6 P-cores and 4 E-cores) and 16GB of blisteringly fast 4800MHz DDR5 RAM on Windows 11
SWIFT VISUALS – Stay one step ahead of the competition thanks to its 144Hz 15.6” Full HD (1920 x 1080) IPS Type Display
AMPLE STORAGE FOR ALL YOUR GAMES - Store all your game library, and load them fast on your 512GB PCIe NVMe M.2 SSD to take advantage of the full RTX gaming experience
STAY COOL - Dual Self cleaning Arc Flow fans with anti-dust technology extend system longevity
MILITARY GRADE TOUGHNESS - Durable MIL-STD-810H military standard lives in the TUF line as the devices are tested against drops, vibration, humidity and extreme temperatures to ensure reliability', 'Brand	ASUS
Series	TUF Dash 15 (2022)
Screen Size	15.6 Inches
Color	Off Black
Hard Disk Size	512 GB
CPU Model	Core i7
Ram Memory Installed Size	16 GB
Operating System	Windows 11 Home
Card Description	RTX 3060
Graphics Coprocessor	NVIDIA GeForce RTX 3060', '10')
, ('8', 'ASUS VivoBook 15X OLED Laptop M1503QA-ES74', 'Asus', '1', '3', '1.jpg', '29.650.000', '15.6” FHD (1920 x 1080) OLED 16:9 aspect ratio display with ultra-slim NanoEdge bezels
0.2ms response time, 600nits peak brightness, 100% DCI-P3 color gamut, 1,000,000:1 Contrast ratio, VESA CERTIFIED Display HDR True Black 600
Latest AMD Ryzen 7 5800H Mobile Processor (8-core/16-thread, 20MB cache, up to 4.4 GHz max boost) and AMD Radeon Graphics
Fast storage and memory featuring 512GB M.2 NVMe PCIe 3.0 SSD and 8GB DDR4 on board + 8GB DDR4 SO-DIMM RAM, Windows 11 Home
Extensive connectivity with 2x USB 3.2 Gen 1 Type-C, USB 2.0 Type A, 3.5mm Combo Audio Jack, Wi-Fi 6(802.11ax)+Bluetooth 5.0 (Dual band) 2*2 (*USB transfer speed may vary. Learn more at ASUS.com)', 'Brand	ASUS
Series	M1503QA-ES74
Screen Size	15.6
Color	Quiet Blue
Hard Disk Size	512 GB
CPU Model	Ryzen 7
Ram Memory Installed Size	16 GB
Operating System	Windows 11 Home
Card Description	Integrated
Graphics Coprocessor	AMD Radeon GPU', '10')
, ('9', 'ASUS Vivobook Laptop L210 11.6 Ultra Thin Laptop L210MA-DS04', 'Asus', '1', '3', '1.jpg', '24.500.000', 'Powerful Productivity: Efficient Intel Celeron N4020 Processor 1.1 GHz (4M Cache, up to 2.8 GHz) and Intel UHD graphics delivers unmatched speed and intelligence, enabling impressive creating and productivity
Visibly Stunning: Experience sharp details and crisp colors on the 11.6” HD (1366 x 768) Slim Display with 73% screen-to-body ratio, 16:9 aspect ratio
Internal Specifications: 128GB eMMC Flash Storage and 4GB DDR4 RAM to store your files
Secure Operating System: Windows 11 Home in S mode comes with advanced security features built right in, like protections against phishing and malicious software so you don\'t have to think twice when navigating to a new webpage or downloading an app
Ports For All Your Accessories: USB 3.2 Gen 1 Type-C, USB 3.2 Gen 1 Type-A, HDMI (*USB Transfer speed may vary. Learn more at ASUS website)
Slim and Portable: 0.7” thin and weighs only 2.31 lbs (battery included)
What\'s In the Box: ASUS Vivobook laptop, AC adapter, Power Cord, User manual, Warranty card', 'Brand	ASUS
Series	ASUS Vivobook Go 12
Screen Size	11.6
Color	Star Black
Hard Disk Size	128 GB
CPU Model	Celeron
Ram Memory Installed Size	4 GB
Operating System	Windows 11 S
Card Description	Integrated
CPU Speed	2.8 GHz', '10')
, ('10', 'Lenovo 14inch HD Laptop, Intel Pentium Silver ', 'Lenovo', '1', '3', '1.jpg', '27.420.000', '14inch HD LED Backlit Display with Anti-Glare Technology (1366 x 768), Integrated Intel UHD 605 Graphics
Intel Pentium Silver Quad-Core N5030 Processor Up to 3.10 GHz, 128GB NVMe SSD, 4GB DDR4 Ram
1x HDMI, 2x USB Ports, 1x Media Card Reader, 1x Headphone/microphone Combo Jack
Integrated Webcam and Dual Array Microphones, Dolby Audio, 802. 11AC Wi-Fi and Bluetooth 4.1 Combo
Windows 10 OS in S Mode, A JJTK 16GB USB Drive Included', 'Brand	Lenovo
Model Name	Lenovo 14inch Laptop
Screen Size	14 Inches
Hard Disk Size	128 GB
CPU Model	Mobile Intel Pentium 4 Processor
Ram Memory Installed Size	4 GB
Operating System	Windows 10
Graphics Card Description	Intel UHD Graphics
Graphics Coprocessor	Intel UHD Graphics 605
CPU Speed	1.1 GHz', '10')
, ('11', 'Lenovo 2022 Newest Ideapad 3 Laptop', 'Lenovo', '1', '3', '1.jpg', '19.300.000', '【Memory & Storage】Memory is 8GB high-bandwidth RAM to smoothly run multiple applications and browser tabs all at once. Hard Drive is 256GB PCIe Solid State Drive which allows to fast bootup and data transfer
【Processor】11th Gen Intel Core i3-1115G4 Dual-Core 3.0GHz Processor (6MB Intel Smart Cache, up to 4.10GHz) Intel UHD Graphics
【Screen】15.6" HD Touchscreen (1366 x 768) Display
【Ports】2 x USB 3.2 Gen 1 Type-A, 1 x USB 2.0 Type-A, 1 x HDMI, 1 x Combination Audio Jack, 1 x Multi-format SD Media Card Reader, Wireless-AC Wi-Fi 5 + Bluetooth Combo
【Operating System】Windows 11 Home', 'Brand	Lenovo
Series	IdeaPad 3 81X800ENUS
Screen Size	15.6 Inches
Color	Almond
Hard Disk Size	256 GB
CPU Model	Core i3
Ram Memory Installed Size	20 GB
Operating System	Windows 11
Card Description	Integrated
Graphics Coprocessor	Intel UHD Graphics', '10')
, ('12', 'Lenovo 2023 Newest IdeaPad 3i Laptop Bundle wit', 'Lenovo', '1', '3', '1.jpg', '26.400.000', '【Processor】Equipped with Intel Core i5-1235U, 1.3GHz (Up to Turbo Boost 4.4 GHz, 10 cores, 12 threads). The 12th 10-core laptop provides perfect performance, which makes you unstopabble. This is an ideal laptop to help you to get things done fast.
【15.6 Inch FHD IPS Display】 1920 x 1080 resolution 300nits for stunning clear visuals. Intel Iris Xe Graphics provides solid image quality for Internet use. The thickness is only 0.78 inch, which is easy to be carried.The screen\'s 4-sided narrow bezels give you more available viewing screen
【Upgraded】 Up to 24GB RAM is designed for basic tasks, the high-bandwith DDR4 RAM run your applications smoothly, as well as multiple programs and files all at once. Up to 1TB storage capacity is suitable for saving all your files and provides enough space to save more data.
【Connectivity 】 Connect to WiFi 6E-802.11 ax to experience GB Wi-Fi speeds nearly 3X faster vs. standard Wi-Fi 5 with improved responsiveness for even more devices. Keep your desk from cluttering with a full-function Type-C port for faster data transfer, power delivery, and 4K display connectivity; USB 3.2 Gen 1 Type-A, USB 2.0 Type-A, and HDMI ports also included
【Operating System】Windows 11 Pro, experience the most secure Windows ever built with fast boot times, increased responsiveness, and added protection against phishing and malware, and keeps going with long battery life.', 'Brand	Lenovo
Series	Lenovo IdeaPad 3i
Screen Size	15.6 Inches
Color	Gray
Hard Disk Size	1 TB
CPU Model	Intel Core i5
Ram Memory Installed Size	8 GB
Operating System	Windows 11 Pro
Card Description	Integrated
Graphics Coprocessor	Intel Iris Xe Graphics', '10')
, ('13', 'Lenovo IdeaPad 3i Laptop Grey', 'Lenovo', '1', '3', '1.jpg', '29.999.000', '【High Speed RAM And Enormous Space】20GB DDR4 RAM to smoothly run multiple applications and browser tabs all at once; 512GB PCIe M.2 Solid State Drive allows to fast bootup and data transfer
【Processor】Intel Core i3-1115G4 3.00 GHz 2 Cores Processor (6MB Cache, up to 4.10 GHz), Intel UHD Graphics
【Dazzling Display】15.6" HD touchscreen display with narrow bezels
【Tech Specs】2 x SuperSpeed USB Type-A, 1 x USB 2.0 Type-A, 1 x HDMI, 1 x Headphone/Microphone Combo; SD Card Reader; Wi-Fi 6
【Operating System】Windows 11 Home-Beautiful, more consistent new design, Great window layout options, Better multi-monitor functionality, Improved performance features, New videogame selection and capabilities, Compatible with Android Apps', 'Brand	Lenovo
Series	IdeaPad
Screen Size	15.6 Inches
Color	Gray
Hard Disk Size	512 GB
CPU Model	Core i3
Ram Memory Installed Size	20 GB
Operating System	Windows 11 Home
Card Description	Integrated
Graphics Coprocessor	Intel UHD Graphics', '10')
, ('14', 'SAMSUNG Galaxy S22 Ultra Cell Phone, US Version, Bur', 'Samsung', '2', '3', '1.jpg', '37.000.000', '8K SUPER STEADY VIDEO: Shoot videos that rival how epic your life is with stunning 8K recording, the highest recording resolution available on a smartphone; Video captured is effortlessly smooth, thanks to Auto Focus Video Stabilization on Galaxy S22 Ultra.Form_factor : Smartphone
NIGHTOGRAPHY plus PORTAIT MODE: Capture the night with crystal clear, bright pics and videos, no matter the lighting with Night Mode; Portrait Mode auto-detects and adjusts to what you want front and center, making all your photos worthy of a frame
108MP PHOTO RESOLUTION plus BRIGHT DISPLAY: Capture premium detail with 108MP resolution— the highest available on a cell phone; Your favorite content will look even more epic on our brightest display ever with Vision Booster
ADAPTIVE COLOR CONTRAST: Streaming on the go, working from your patio or binge-watching late into the night. The Galaxy S22 Ultra adaptive screen automatically optimizes color and brightness, outdoors and indoors
LONG LASTING BATTERY plus FAST CHARGING: Power every scroll, click, tap and stream all day long and then some with an intelligent, long-lasting battery; Dive back into action at a moment’s notice with 45W Super-Fast Charging
EMBEDDED S PEN: New phone, new S Pen; Now you can unleash your creativity on Galaxy S22 Ultra with an embedded S Pen; Edit photos and videos with pinpoint accuracy, and do it all with that pen-to-paper feel
PREMIUM DESIGN & CRAFTMANSHIP: With a classy, eye-catching glass-metal-glass design, we’re setting a standard for smart phones; With our strongest aluminum frame and the latest Gorilla Glass, this phone is lightweight and durable to help endure scratches and dings
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.
', 'Brand	SAMSUNG
Model Name	S22 Ultra
Wireless Carrier	Unlocked
Operating System	Android 12.0
Cellular Technology	GSM, CDMA, HSPA, EVDO, LTE, 5G
Memory Storage Capacity	128 GB
Connectivity Technology	Bluetooth, Wi-Fi
Color	Burgundy
Screen Size	6.8 Inches
Wireless network technology	GSM, CDMA, LTE', '10')
, ('15', 'SAMSUNG Galaxy Z Flip 4 Cell Phone US Version, Bora Purple', 'Samsung', '2', '3', '1.jpg', '41.000.000', 'FLEX, POSE, POST: Getting that post-worthy solo shot is easy with a phone that stands on its own; Put Galaxy Z Flip4 in Flex Mode and capture hands-free selfies, record your epic dance moves and never worry about your makeshift tripod falling over again.Form_factor : Flip
CAPTURE ON ONE SCREEN, TEXT ON THE OTHER: Catch up with friends on the top and find the perfect pic to post on the bottom; Flex Mode makes doing two things at once a breeze
NEVER MISS A NOTIFICATION: The customizable cover screen on Galaxy Z Flip4 allows you to see just what you need while keeping your full screen private; Respond to texts, skip songs and change settings all while keeping your cellphone conveniently compact
PERFECTLY POCKET SIZED: Ditch the bag and travel light; The compact, foldable design lets you say bye to the bulk without sacrificing a big screen; Slide your smart phone easily into even your front pocket
UNFOLD A FASHION STATEMENT: Your phone is your most-used accessory, so why not make it an extension of your style, Choose from a wide array of colors and customize your cover screen so your mobile fits your vibe
STAY IN SYNC: Stay up to date on notifications or track your workout right on your wrist; Galaxy Z Flip4 easily syncs to your Galaxy Watch, and with an array of color options, you can get one to match your vibe
GALAXY Z Flip4 & BUDS ARE BETTER TOGETHER: Pair your Galaxy Z Flip4 with Galaxy Buds and stay up to date on notifications or tune in to your playlists or podcasts on the go; Simply sync your devices and keep your world connected', 'Brand	SAMSUNG
Model Name	Galaxy Z Flip4
Wireless Carrier	Unlocked
Operating System	Android 12.0
Cellular Technology	LTE, GSM, WCDMA, UMTS
Memory Storage Capacity	128 GB
Connectivity Technology	Bluetooth, Wi-Fi, USB, NFC
Color	Bora Purple
Wireless network technology	Wi-Fi
Ram Memory Installed Size	8 GB', '10')
, ('16', 'SAMSUNG Galaxy Z Fold 4 Cell Phone S Pen Compatible, US Version, Beige', 'Samsung', '2', '3', '1.jpg', '22.000.000', 'FLEX MODE: Free up your hands with Flex Mode on the Galaxy Z Fold4; This smartphone stands on its own so you can take notes during a conference call or follow along with instructional videos in real time.Form_factor : Fold
HANDS FREE VIDEO: Don’t stay stuck to your cellphone; Set up your phone in Flex Mode and check off your to-dos while catching up with friends; Hands-free video chat lets you multitask and move freely while staying in frame
MULTI-VIEW WINDOW: Easily attend a virtual work meeting and capture important notes at the same time, or catch up on your favorite shows as you answer texts; With multiple windows, doing different tasks is easy with Galaxy Z Fold4
S PEN READY: Transform your Galaxy Z Fold4 into a multifunctional device with S Pen; It gives you that pen-on-paper feeling and makes it easy to take notes while attending virtual meetings, drag and drop content, and get more done
YOUR APPS, YOUR WAY: App display optimization allows you to customize how you see apps on the edge-to-edge screen of Galaxy Z Fold4; Also, use multiple apps to their full potential by dragging and dropping content from one window to the other
YOUR PHONE & WATCH WORK AS ONE: Unfold the possibilities of your Galaxy Z Fold4 connected to your Galaxy Watch; Use your Watch to snap hands-free selfies with Flex Mode; Plus, keep track of your day by easily switching between your Galaxy Watch and phone
BIG SCREEN, BIG SOUND: Need to head out while you’re in the middle of your favorite podcast, Slide Galaxy Z Fold4 into your pocket and keep listening with your Galaxy Buds; Unfold connectivity with your smart phone and Buds working together
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand	SAMSUNG
Model Name	Galaxy Z Fold4
Wireless Carrier	Unlocked for All Carriers
Operating System	Android
Cellular Technology	5G
Memory Storage Capacity	256 GB
Connectivity Technology	Bluetooth, USB
Color	Beige
Wireless network technology	Wi-Fi
Ram Memory Installed Size	12 GB', '10')
,('17', 'Apple 2021 10.2-inch iPad (Wi-Fi, 64GB) - Space Gray', 'Apple', '2', '3', '1.jpg', '32.000.000', 'Gorgeous 10.2-inch Retina display with True Tone
A13 Bionic chip with Neural Engine
8MP Wide back camera, 12MP Ultra Wide front camera with Center Stage
Up to 256GB storage
Stereo speakers
Touch ID for secure authentication and Apple Pay
802.11ac Wi-Fi
Up to 10 hours of battery life
Lightning connector for charging and accessories
Works with Apple Pencil (1st generation) and Smart Keyboard', 'Brand	Apple
Model Name	iPad
Memory Storage Capacity	64 GB
Screen Size	10.2 Inches
Display Resolution Maximum	2160x1620 Pixels', '10')
, ('18', 'iPhone 13 Pro, 256GB, Sierra Blue - Unlocked (Renewed Premium)', 'Apple', '2', '3', '1.jpg', '26.500.000', 'Unlocked
Tested for battery health and guaranteed to come with a battery that exceeds 90% of original capacity.
Inspected and guaranteed to have minimal cosmetic damage, which is not noticeable when the device is held at arm’s length. Successfully passed a full diagnostic test which ensures like-new functionality and removal of any prior-user personal information.
Includes a brand new, generic charging cable that is certified Mfi (Made for iPhone) and a brand new, generic wall plug that is UL certified for performance and safety. Also includes a SIM tray removal tool but does not come with headphones or a SIM card.
Backed by the same one-year satisfaction guarantee as brand new Apple products.
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand	Apple
Model Name	iPhone 13 Pro
Wireless Carrier	Unlocked for All Carriers
OS	iOS 16
Cellular Technology	5G
Memory Storage Capacity	256 GB
Connectivity technologies	Wi-Fi
Color	Sierra Blue
Screen Size	6.1 Inches
Wireless network technology	GSM', '10')
,('19', 'iPhone 13, 128GB, Midnight - Unlocked (Renewed Premium)', 'Apple', '2', '3', '1.jpg', '27.000.000', '6.1" Super Retina XDR display. 5G Superfast downloads, high?quality streaming
Cinematic mode in 1080p at 30 fps. Dolby Vision HDR video recording up to 4K at 60 fps. 2X Optical zoom range
A15 Bionic chip. New 6-core CPU with 2 performance and 4 efficiency cores. New 4-core GPU. New 16-core Neural Engine
Up to 19 hours video playback. Face ID. Ceramic Shield front. Aerospace-grade aluminum
Water resistant to a depth of 6 meters for up to 30 minutes. Compatible with MagSafe accessories and wireless chargers
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand	Apple
Model Name	iPhone 13
Wireless Carrier	Unlocked for All Carriers
OS	iOS 16
Cellular Technology	5G
Memory Storage Capacity	128 GB
Connectivity technologies	Bluetooth
Color	Midnight
Screen Size	6.1 Inches
Wireless network technology	GSM', '10');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('20', 'OLLY Undeniable Beauty Gummy, For Hair, Skin, Nails, Biotin, Vitamin C, Keratin', '9', '9', '1.jpg', '300.000', "OLLY UNDENIABLE BEAUTY: Delicious OLLY beauty gummies are packed with the perfect blend of active ingredients to help keep your hair and nails in tip-top shape and your skin shining bright*
Product Note: Exposure to heat or sunlight may lead to melting/damage of product. Hence customers are expected to be available during the product delivery
THE GOODS INSIDE: Biotin is an essential nutrient to support healthy hair and nails. Vitamin C is a key nutrient in the production of collagen (the protein that contributes to your skin's strength and youthful glow) and Keratin helps nourish hair*
HOW TO TAKE: Chew two gummies, no food or water needed
NATURALLY DELICIOUS: These beauty gummies come in naturally flavored Grapefruit Glam with no artificial colors or flavors and are gluten free. 60 gummies per bottle (30 day supply)
MIX AND MATCH: Delightful and delicious OLLY products can be taken together—mix and match as you please
MORE OLLY GOODNESS: We create products that are just as effective as they are delicious—gummies, multivitamins, premium softgels and more ways to feel happy inside out
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.", '
Brand        OLLY
Item Form        Gummy
Diet Type        Gluten Free
Flavor        Grapefruit Glam
Product Benefits        Nail Support, Hair Support, Skin Brightening
Special Ingredients        Collagen
Age Range (Description)        Adult
Package Information        Bottle
Unit Count        60 Count
Number of Items        1', '17');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('21', 'Pacifica Beauty, Glow Baby Booster Serum For Face, Vitamin C and Glycolic acid, Brightens and Supports,', '9', '36', '1.jpg', '250.000', "GIVE YOUR SKIN A HYDRATION BOOST with this concentrated bioactive serum that moisturizes and relieves dull, dry skin for improved texture and brightness
FORMULATED FOR ALL SKIN TYPES our Glow Baby booster serum can be used on its own or for prepping your skin before applying makeup to keep skin looking soft while minimizing shininess
MADE WITH NATURAL AND VEGAN INGREDIENTS including vitamin C and glycolic acid, a combination of a powerhouse antioxidant and an AHA that bring back your skin's youthful glow
CAN BE USED DAY AND NIGHT and reapplied to clean skin whenever extra hydration is needed, or added to your favorite moisturizer for an extra boost
FREE OF HARSH CHEMICALS including parabens, phthalates, SLS, mineral oil and petrolatum, as well as sulfate-free and silicone-free", 'Available at a lower price from other sellers that may not offer free Prime shipping.
Skin Type        Normal
Product Benefits        Hydrating
Scent        Vanilla, Orange
Brand        Pacifica
Item Form        Serum', '4');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('22', 'Real Techniques Mini Miracle Complexion Sponge Makeup Blender, Beauty Sponge For Touch Ups', '9', '9', '1.jpg', '150.000', 'The Real Techniques Mini Miracle Complexion Sponges are 3 in 1 multifunctional mini miracle complexion sponges leave skin with a smooth and natural-looking finish
Set of 4 Mini Miracle Complexion Sponges
Best used with liquid or cream foundations
Latex-free revolutionary foam technology made from polyurethane foam
Great for touch-ups on the go and travel.
100% Cruelty-Free, Vegan, and Latex Free
Great gift for daughters, wife, girlfriend, spouse, or significant other', 'Brand        Real Techniques
Color        Assorted Colors
Material        Foam, Polyurethane
Item Dimensions LxWxH        2.91 x 1.69 x 4.31 inches
Skin Type        Oily, Combination, Sensitive, Dry, Normal', '3');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('23', 'NYX PROFESSIONAL MAKEUP Butter Gloss, Non-Sticky Lip Gloss - Sugar Glass', '9', '36', '1.jpg', '120.000', "Butter Gloss: Buttery soft and silky smooth, our decadent Butter Gloss is available in a wide variety of sumptuous shades; Each glossy color delivers sheer to medium coverage that melts onto your lips
Kissable Lips: Our best selling Butter Gloss goes on smooth and creamy and is never sticky, leaving your lips soft, supple and kissable; Try all of our delicious shades, from Angel Food Cake to Tiramisu
Lip Products for the Perfect Pout: Doll your lips in creamy, long lasting perfection; Try our complete line of lip makeup including liquid lipstick, lip gloss, lip cream, lip liner and butter gloss
Cruelty Free Cosmetics: We believe animals belong in our arms, not in a lab; All of our makeup is certified and acknowledged by PETA as a cruelty free brand; We don't test any of our products on animals
Discover NYX Professional Makeup: Try all of our professional makeup products today from eyeshadow, eyeliner, and false lashes to liquid lipstick, lip gloss, primer, concealer, setting sprays and eyebrow makeup", 'Brand        NYX PROFESSIONAL MAKEUP
Color        54 Sugar Glass
Skin Type        All
Item Form        Liquid
Finish Type        Glossy', '6');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('24', 'Tree of Life Vitamin C Serum, Retinol Serum and Hyaluronic Acid Serum for Brightening', '9', '27', '1.jpg', '300.000', "A power trio for your best skin yet. Use the Vitamin C Serum followed by the Hyaluronic Acid Serum in the morning to visibly brighten, reduce dark spots, smooth, and hydrate the skin. Reach for the Retinol Serum followed by the Hyaluronic Acid Serum in the evening to reduce the appearance of fine lines and wrinkles, fade the look of age spots, support elasticity, and soothe the skin.
All of our products are cruelty-free, dermatologist-tested, and made for all skin types and tones. Plus, they're packed with thoughtfully-chosen ingredients you can feel good about.
Directions: Apply Vitamin C Serum in the morning followed by Hyaluronic Acid Serum. Apply Retinol Serum in the evening followed by Hyaluronic Acid Serum. Apply 3-5 drops to clean, dry skin on face, neck, and décolleté. Use sunscreen daily, as retinol increases sun sensitivity. For best results, follow serums with a moisturizer.
True radiance for the taking. Tree of Life is all about clean, effective, attainable skincare — and we won't give you anything less.
Quality at the core. We're so sure you'll love our products that we offer a 30-day money back guarantee. If you're not fully satisfied, you can return it for a full refund.
", 'Skin Type        All
Product Benefits        Anti-Aging
Use for        Face
Scent        Green Tea
Brand        Tree of Life Beauty', '13');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('25', 'Love Beauty and Planet Volume and Bounty Thickening Shampoo and Conditioner For Hair Volume and Fine Hair Care Coconut Water', '9', '27', '1.jpg', '260.000', 'OUR HAIR CARE PROMISE: Love Beauty and Planet Coconut Water & Mimosa Flower Volumizing Shampoo and Conditioner duo gently cleanses and detangles hair with a lightweight formula
HAIR VOLUMIZER SHAMPOO AND CONDITIONER FOR THIN HAIR: Our vegan shampoo and conditioner for hair volume are infused with Coconut Oil for hair and provide volume to fine hair and thin strands
VOLUMIZING HAIR PRODUCTS INSPIRED BY NATURE: Infused with Organic Coconut Water, this volume shampoo and conditioner duo energizes hair with a burst of delicate Mimosa Flowers
YES color safe hair care, YES vegan shampoo and conditioner, YES with plant-based cleansers and detanglers, YES Coconut Oil for hair
HAIR VOLUME SHAMPOO AND CONDITIONER FORMULAS: Paraben free shampoo and conditioner, Silicone free shampoo and conditioner, Cruelty-free shampoo and conditioner
HAIR VOLUME PRODUCTS: This thickening shampoo and conditioner for hair volume are safe to use on all hair types, including color-treated hair', 'Product Benefits        Volumizing, Moisturizing, Softening, Thickening, Cleansing
Material Type Free        Silicone Free, Paraben Free
Item Form        Discrete Subunit
Brand        Love Beauty And Planet
Hair Type        Fine', '16');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('26', 'Love Beauty And Planet Hope and Repair Shampoo and Conditioner Dry Hair and Damaged Hair Care Coconut Oil', '9', '9', '1.jpg', '299.999', 'HOPE AND REPAIR SHAMPOO AND CONDITIONER HAIR CARE: Our Coconut Oil and Ylang Ylang Shampoo and Conditioner work to repair damaged hair to reveal healthy-looking tresses.
COCONUT OIL SHAMPOO AND CONDITIONER FOR DRY HAIR: let your hair bask in the early morning freshness of ylang ylang flower oil with these damaged hair products
NATURAL COCONUT OIL SHAMPOO AND CONDITIONER: All Love Beauty And Planet hair products are infused with Natural Coconut Oil for hair
HELP PREVENT SPLIT ENDS AND BREAKAGE: This damage repair shampoo and conditioner duo, infused with coconut oil for hair, nourishes while helping to prevent hair breakage and split ends
YES color safe hair care, YES vegan shampoo and conditioner, YES with plant-based cleansers/detanglers, YES Coconut Oil for hair, YES formulated without phthalates
Paraben free shampoo and conditioner, Silicone free shampoo and conditioner, Cruelty-free Shampoo and Conditioner, Damaged Hair Care, Repair Shampoo, Repair Conditioner
', 'Product Benefits        Damage Control, Color Protection, Split End Treatment, Repairing, Nourishing
Material Type Free        Silicone Free, Phthalate Free, Paraben Free
Item Form        Discrete Subunit
Brand        Love Beauty And Planet
Hair Type        Dry', '14');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('27', 'LifeAround2Angels Bath Bombs Gift Set 12 USA made Fizzies, Shea & Coco Butter Dry Skin Moisturize, Perfect for Bubble & Spa Bath', '9', '18', '1.jpg', '210.000', 'HOPE AND REPAIR SHAMPOO AND CONDITIONER HAIR CARE: Our Coconut Oil and Ylang Ylang Shampoo and Conditioner work to repair damaged hair to reveal healthy-looking tresses.
COCONUT OIL SHAMPOO AND CONDITIONER FOR DRY HAIR: let your hair bask in the early morning freshness of ylang ylang flower oil with these damaged hair products
NATURAL COCONUT OIL SHAMPOO AND CONDITIONER: All Love Beauty And Planet hair products are infused with Natural Coconut Oil for hair
HELP PREVENT SPLIT ENDS AND BREAKAGE: This damage repair shampoo and conditioner duo, infused with coconut oil for hair, nourishes while helping to prevent hair breakage and split ends
YES color safe hair care, YES vegan shampoo and conditioner, YES with plant-based cleansers/detanglers, YES Coconut Oil for hair, YES formulated without phthalates
Paraben free shampoo and conditioner, Silicone free shampoo and conditioner, Cruelty-free Shampoo and Conditioner, Damaged Hair Care, Repair Shampoo, Repair Conditioner
', 'Product Benefits        Damage Control, Color Protection, Split End Treatment, Repairing, Nourishing
Material Type Free        Silicone Free, Phthalate Free, Paraben Free
Item Form        Discrete Subunit
Brand        Love Beauty And Planet
Hair Type        Dry', '17');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('28', '2Pcs UCANBE Twilight Dusk + Aromas Nude Eyeshadow Palette Makeup Set', '9', '18', '1.jpg', '270.000', "12 uniquely handcrafted bath bombs. Functional and relaxing. Great Mothers day gifts.
Truly made in California, USA freshly with premium USA natural ingredients - fizzes with colors, will not stain your tub!
Therapeutic and Moisturizing bath bombs, formulated for Normal/Dry skin
Developed and Created by us, a bath bomb company with passion
Bath Bomb Individually Wrapped. Perfect gift ideas for party favors and wedding. This bath bomb gift sets is on many's wish list. Perfect for Fathers Day gifts, birthday gift, gifts for her, spa/bath gifts, for the special one, perfect gifts for mom, wife, girlfriend or women you love.", 'Brand        Lifearound2angels
Scent        Lavender, Vanilla, Strawberry, Coconut, Mango, Rose, Melon
Age Range (Description)        Adult
Recommended Uses For Product        Hydrating,Moisturizing,Relaxing
Product Benefits        Moisturizing,Relaxing', '13');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('29', 'Honest Beauty Tinted Lip Balm | Antioxidant-rich Acai Extracts + Avocado Oil', '9', '18', '1.jpg', '160.000', 'Twilight Dust palette with 18 shades:10 smooth mattes,highly-pigmented shades in vibrant purples and ochres, and soft sandy nude-tones providextended wear. 7 Pressed shimmers,pressed pearls in plum, bronze and rose hues create a shimmery,velvety finish that layer effortlessly on top of mattes.1 pure metallic glitter in gold color for a bold eye look
Aromas Palette includes 18 shades which are smooth and velvety texture powder, consisting of 10 highly-pigmented matte,4 reflective shades,2 glitter,1 pressed pearl and 1 concealer base shade
Cruelty-free ingredient and lightweight formula, it provide creamy butter-like application. It also blendable and buildable no matter use as transition or topper colors. Waterproof and long lasting that you can keep your stunning eye makeup all day long and not fall out
The both palettes perfect for the daily girl, special events or occasions etc all makeup.Such as professional smoky eyes makeup, wedding makeup, party makeup or casual makeup etc
Our product is beautiful and high quality that we are sure you will like it. Eye shadow may will be damaged during the shipment,If you received the broken goods,or you not satisfied with our product.We will offer a solution to you.atisfied with our product.We will offer a solution to you.', 'Color: Twilight/Aromas
Color        Twilight/Aromas
Brand        CHARMCODE
Item Form        Powder
Finish Type        Shimmery,Glitter,Metallic,Shimmer,Matte,Velvet,Natural
Special Feature        Long last, Waterproof, Blendable, Smooth, Versatile, Cruelty-free, Highly pigmented', '19');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('30', 'Makeup Brushes Makeup Brush Set - 16 Pcs BESTOPE PRO Premium', '9', '27', '1.jpg', '250.000', 'Pucker up babes; Vegan Lip Balm that helps keep lips smooth and moisturized all day
Swipe on for nourishing sheer color that locks in hydration
Made with: Antioxidant-rich Acai Extracts + Avocado Oil; Works for all skin types
Made without: Petrolatum, Paraffins, Parabens, Synthetic Fragrances, Silicones, Mineral Oil
EWG Certified, Dermatologist Tested, Physician Tested, Cruelty Free, Vegan', 'Brand        Honest Beauty
Item Form        Balm
Finish Type        Natural
Skin Type        Dry
Color        Lychee Fruit', '6');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('31', 'New York Biology Dead Sea Mud Mask for Face and Body', '9', '18', '1.jpg', '449.999', '💄Millions of Buyers and 5 Million sold💄：BESTOPE PRO makeup brushes has been sold on Amazon for more than ten years, and the cumulative sales volume has exceeded 5 million. Millions of buyers have chosen this makeup brush, which is your trustworthy choice
💄Get A Complete Makeup Brush Set💄: This 16 pcs makeup brushes is a pro-level brush set featuring all brush essentials – 5 big kabuki brushes and 11pcs precision brushes, foundation brushes, eye shadow brushes, concealer brush, and powder brush in an all-inclusive brush kit.
💄Forget All About Skin Irritations:💄 Our makeup set includes cruelty free makeup brushes made of skin-friendly synthetic fibers, which feel velvety-soft on the skin and have finer tips than most eyeshadow brushes, for max precision in use.
💄Contour, Blend, Shade, Or Highlight Like A Pro💄: Whether you want to create smoky eyes or chiseled cheekbones, this face brush kit is for you. It is shed-free and makes it easy to sweep, swirl, and blend eye shadows, blush, and highlighter into place.
💄Apply Your Makeup Without Tiring Your Hand💄: With a nonslip handle made of high-end ferrule and natural wood, each make up brush in our set is comfortable, easy to use, and makes makeup application effortless and fast. Spoil Your Girlfriend, Wife, Mom, Or Best Friend: The face makeup brushes are sturdy, functional, and elegant, making the best makeup brushes for women, young girls, teens, and an awesome gift idea for any occasion.', 'Brand        BESTOPE PRO
Recommended Uses For Product        For Eyeshadow, For Concealing, For Setting Powder, For Blush, For Foundation
Color        Black RoseGold
Material        Wood
Skin Type        Normal
Item Form        Wand', '14');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('32', 'Finishing Touch Flawless Facial Hair Remover for Women, White/Rose', '9', '27', '1.jpg', '269.999', 'BEST HOLIDAY GIFT GUIDE: works for all skin types, including dry, normal, oily, combination, sensitive, and irritated. This daily acne treatment has been designed to be highly effective yet gentle enough for everyday use and is a great gift for the holidays 2022.
MINERAL-INFUSED Clarifying Mud Mask is based on an advanced formula composed of Dead Sea mineral mud, aloe vera, calendula oil, Vitamin E and Jojoba oil that gently purifies and cleans clogged pores.
PURE DEAD SEA MUD helps cleanse the skin and provide a soothing sensation. Rich in minerals, it aids skin renewal, creating a gentle exfoliation effect that removes excess oil, toxins, and dead skin cells for a softer feel and radiant glow.
REDUCES PORES & ABSORBS EXCESS OIL our Spa Quality Mud removes dead skin cells and toxins to reveal fresh, soft skin and is also known to stimulate blood circulation.
OUR DEAD SEA FACIAL MASK is made with high quality ingredients and is alcohol, parabens, sulfates free and Cruelty Free.', 'Brand        NEW YORK BIOLOGY THE ULTIMATE COSMECEUTICALS
Item Form        Cream
Product Benefits        Softening
Scent        Unscented
Material Type Free        Sulfate Free, Alcohol Free, Paraben Free', '18');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('33', 'Amazon Basics Moisture Rich Conditioner, 28 Fluid Ounce', '9', '9', '1.jpg', '50.000', 'One Finishing Touch Flawless Facial Hair Remover, White/Rose Gold stainless steel bladed hair remover for women features 18 karat gold plating and LED light for precision
Use the face hair trimmer to instantly remove peach fuzz and hair from lips, chin, neck and cheeks or use as an eyebrow shaper to maintain flawless brows between, or instead of, waxing and plucking
Hypoallergenic and dermatologist recommended, this electric face razor allows anyone to painlessly remove unwanted hair by simply pressing to the face and making small circular motions, leaving skin smooth and hair-free
Made with 18 karat gold and shaped like a tube of lipstick for discreet hair removal anywhere, this womens electric razor utilizes revolutionary Butterfly Technology that removes hair by microscopically paring it down by a spinning head covered by a plate
Flawless facial hair removal device is gentle enough to use everyday before putting on makeup, no need to wait for regrowth, so you can enjoy hairless skin everyday without nicks, bumps or razor burn', '
Brand        Finishing Touch
Recommended Uses For Product        Lip, Face
Special Feature        Not-Applicable
Power Source        Battery Powered
Item Weight        0.04 Kilograms', '1');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('34', 'FREEMAN Facial Mask Variety Set: Clay, Peel-Off, Gel, & Mud Masks, Clearing', '9', '36', '1.jpg', '170.000', "One 28-fluid ounce bottle of Amazon Basics Moisture Rich Conditioner
Made with Vitamin E
Formaldehyde Donor Free/Free From DMDM Hydantoin. Paraben & Phthalate Free
Helps restore vibrancy and makes dry, damaged hair soft without weighing it down
This product not tested on animals. Made in the U.S.A. with U.S. and foreign components.
If you like Tresemme Rich Moisture Conditioner, we invite you to try Amazon Basics Moisture Rich Conditioner
'Alexa, reorder Amazon Basics Conditioner.'
Satisfaction Guarantee: We're proud of our products. If you aren't satisfied, we'll refund you for any reason within a year of purchase. 1-877-485-0385
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.", 'Brand        Amazon Basics
Hair Type        Dry, Damaged
Age Range (Description)        Adult
Recommended Uses For Product        Conditioner,Moisturizing
Unit Count        28 Fl Oz', '15');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('35', 'ParaFaciem Reusable V Line lifting Mask Facial Slimming Strap', '9', '27', '1.jpg', '318.000', 'Includes: (2) Cucumber Pink Salt Masks, (2) Manuka Honey Masks, (2) Sweet Tea Lemon Masks, (2) Charcoal Black Sugar Masks, (2) Glacier Water Pink Peony Masks, and (2) Dead Sea Minerals Masks
Rejuvenating Cucumber + Pink Salt Clay Mask instantly detoxes clears pores for renewed skin
Clearing Sweet Tea + Lemon Peel-Off Clay Mask removes impurities tones for radiant skin
Deep Clearing Manuka Honey + Tea Tree Oil Clay Mask + Cleanser instantly deep cleans absorbs oil without over-drying
Anti-Stress Dead Sea Minerals Clay Mask instantly clears pores balances for renewed skin
Detoxifying Charcoal + Black Sugar Mud Mask instantly detoxes clears pores for renewed skin
Hydrating Glacier Water + Pink Peony Gel Cream Mask leave on mask instantly calms and softens for glowing skin
Made with clean ingredients and perfect for all skin types- Freeman products are free of parabens, sulfates, silicone, phthalates, and mineral oils
At Freeman, we believe in loving your body naturally and are proud to be free of harsh chemicals
100% Cruelty Free and Vegan - Freeman products are never tested on animals', 'Brand        FREEMAN
Item Form        Clay,Gel
Product Benefits        Hydrating,Deep Cleans,Cleanser,Detoxifying
Scent        Lemon
Material Type Free        Paraben Free', '1');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('36', 'SeoulCeuticals Korean Skin Care Korean Beauty - 20% Vitamin C', '9', '9', '1.jpg', '420.000', "💕 Bandage: ParaFaciem bandage is an effective and useful method to relieve the double chin and saggy skin along the facial contour. It can be used for men and women.
💎Chin Strap: ParaFaciem chin slimmping strap is specially designed to tighten the skin, lift up the skin and reshape a slim and youthful face. It is suitable for all types of skin.
💕 Comfortable and breathable: ParaFaciem V line bandage choose breathable fabrics. It is elastic and sturdy, fitting to different features of faces.
💎Sticky and Adjustable: ParaFaciem double chin mask bandage can stick well on the top of your head and provide you with the even force. The sticky part of the bandage is long enough for you to adjust the length.
💕 Regular use to achieve best effect: We recommend using ParaFaciem bandage for four weeks and use it daily for one hour.", 'Brand        ParaFaciem
Unit Count        1 Count
Number of Items        1', '4');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('37', 'Neutrogena Hydro Boost Face Moisturizer with Hyaluronic Acid for Dry Skin', '9', '36', '1.jpg', '620.000', "THIS KOREAN SKIN CARE VITAMIN C serum contains the same potent, active ingredients as more expensive CE Ferulic Serums
EXTREMELY EFFECTIVE - WE PROMISE you'll begin to see results with this K beauty product within 3 weeks when used daily
POTENT ANTI AGING, ANTI WRINKLE serum is proven to help reduce the appearance of wrinkles, fine lines & crows feet
THIS TOPICAL VITAMIN C ALSO helps to fade sun spots and is guaranteed to provide you with a brighter more youthful complexion
THIS FACIAL SERUM HELPS TO shrink pores, clear up acne, prevent breakouts, and minimize the appearance of acne scars & perfect under korean makeup", "Skin Type        Oily, Combination, Dry, Normal
Product Benefits        Anti Aging, Anti Wrinkle, Minimizes Fine Lines, Wrinkles, Crow's Feet, Dullness for Brighter, More Youthful GlowAnti Aging, Anti Wrinkle, Minimizes Fine Lines, Wrinkles, Crow's Feet, Dullness for Brighter, More Youthful Glow
Use for        Face
Scent        Citrus
Special Ingredients        Natural, Organic, Vitamin C, Plant-Based Hyaluronic Acid, Ferulic Acid, Vitamin E, Citrus Stem Cells, Centella (Cica), Organic AloeNatural, Organic, Vitamin C, Plant-Based Hyaluronic Acid, Ferulic Acid, Vitamin E, Citrus Stem Cells, Centella (Cica), Organic Aloe", '18');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('38', 'VANELC 24k Gold Eye Mask，Collagen Under Eye Patches，Eye Treatment Mask', '9', '36', '1.jpg', '340.000', "THIS KOREAN SKIN CARE VITAMIN C serum contains the same potent, active ingredients as more expensive CE Ferulic Serums
EXTREMELY EFFECTIVE - WE PROMISE you'll begin to see results with this K beauty product within 3 weeks when used daily
POTENT ANTI AGING, ANTI WRINKLE serum is proven to help reduce the appearance of wrinkles, fine lines & crows feet
THIS TOPICAL VITAMIN C ALSO helps to fade sun spots and is guaranteed to provide you with a brighter more youthful complexion
THIS FACIAL SERUM HELPS TO shrink pores, clear up acne, prevent breakouts, and minimize the appearance of acne scars & perfect under korean makeup", "Skin Type        Oily, Combination, Dry, Normal
Product Benefits        Anti Aging, Anti Wrinkle, Minimizes Fine Lines, Wrinkles, Crow's Feet, Dullness for Brighter, More Youthful GlowAnti Aging, Anti Wrinkle, Minimizes Fine Lines, Wrinkles, Crow's Feet, Dullness for Brighter, More Youthful Glow
Use for        Face
Scent        Citrus
Special Ingredients        Natural, Organic, Vitamin C, Plant-Based Hyaluronic Acid, Ferulic Acid, Vitamin E, Citrus Stem Cells, Centella (Cica), Organic AloeNatural, Organic, Vitamin C, Plant-Based Hyaluronic Acid, Ferulic Acid, Vitamin E, Citrus Stem Cells, Centella (Cica), Organic Aloe", '12');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('39', 'Andalou Naturals CannaCell Happy Day Cream, Coconut, 1.7 Ounce', '9', '18', '1.jpg', '225.000', "Packaging may vary: 1.7-ounce jar of Neutrogena Hydro Boost hydrating water-gel daily face and neck moisturizer with hyaluronic acid to hydrate dry skin
Gel facial moisturizer formula provides hydration to skin, leaving it looking smooth and supple day after day
Oil-free gel moisturizer for dry skin is formulated with hyaluronic acid, a hydrator naturally found in skin that binds to water and holds it in for more supple and smooth skin
Unique face moisturizer absorbs quickly like a gel, so you can wear it under makeup, but provides long-lasting and intense moisturizing power of a cream, making it the perfect addition to your hydrating skincare routine
Designed with the Earth in mind. We've removed the window and plastic tray from this carton for easier recycling
Instantly quenches skin
Clinically proven to keep skin hydrated for 48 hours
Oil-Free, Dye-free, Non-Comedogenic
Fast-Absorbing
Suitable for all skin types", 'Brand        Neutrogena
Scent        Oil-Free
Item Form        Gel
Active Ingredients        hyaluronic acid
Unit Count        1.7 Ounce', '5');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('40', 'adidas Women\'s Squadra 21 Shorts', '8', '17', '1.jpg', '200.000', "100% Polyester
Imported
Drawstring closure
Women's sweat-wicking shorts
Moisture-absorbing AEROREADY helps you stay dry
Drawcord on elastic waist for secure fit
This product is made with Primegreen, a series of high-performance recycled materials", "100% Polyester
Imported
Drawstring closure
Women's sweat-wicking shorts
Moisture-absorbing AEROREADY helps you stay dry
Drawcord on elastic waist for secure fit
This product is made with Primegreen, a series of high-performance recycled materials", '5');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('41', 'Hanes Women\'s Crewneck Sweatshirt', '8', '8', '1.jpg', '120.000', "50% Cotton, 50% Polyester
Imported
Pull On closure
Machine Wash
FASHION TO FEEL GOOD ABOUT - Hanes EcoSmart mid-weight, year-round sweatshirt for women is made with cotton sourced from American farms.
SOFT, PLUSH, AND MADE TO STAY THAT WAY - Thick fleece women's pullover sweatshirt stays warm and cozy, so it can be a longtime favorite.
THE CLASSIC LOOK YOU WANT - This women's sweatshirt has a classic silhouette and ribbed details at the collar, cuffs, and waistband that stretch to keep you comfortable.
OUR BEST FIT YET - Longer length sits below your natural waistline to give you more coverage.
QUALITY YOU EXPECT - This women's workout sweatshirt is reinforced with a high-stitch density.
TAGLESS - Stay itch-free with a Tagless neck for added comfort.
COLD WATER WASH – Hanes recommends machine washing this product in cold water.", "50% Cotton, 50% Polyester
Imported
Pull On closure
Machine Wash
FASHION TO FEEL GOOD ABOUT - Hanes EcoSmart mid-weight, year-round sweatshirt for women is made with cotton sourced from American farms.
SOFT, PLUSH, AND MADE TO STAY THAT WAY - Thick fleece women's pullover sweatshirt stays warm and cozy, so it can be a longtime favorite.
THE CLASSIC LOOK YOU WANT - This women's sweatshirt has a classic silhouette and ribbed details at the collar, cuffs, and waistband that stretch to keep you comfortable.
OUR BEST FIT YET - Longer length sits below your natural waistline to give you more coverage.
QUALITY YOU EXPECT - This women's workout sweatshirt is reinforced with a high-stitch density.
TAGLESS - Stay itch-free with a Tagless neck for added comfort.
COLD WATER WASH – Hanes recommends machine washing this product in cold water.", '26');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('42', 'Invicta Men\'s Pro Diver Stainless Steel Quartz Watch', '8', '35', '1.jpg', '1.200.000', "Imported
Gold tone stainless steel case 48mm diameter x 16.8mm thick; Black dial; Luminous hands and hour markers
Japanese quartz movement, VD53 Caliber; Assembled in Japan; SR920SW battery included; Watch weight: 190 grams
Gold tone stainless steel and black silicone band, 220mm L x 26mm W; Buckle clasp
Flame Fusion crystal; Push/pull crown; Uni-directional stainless steel bezel with black top bezel ring; Functional Subdials: 60min, 60sec, 24hr; 100 meter water resistant: Suitable for recreational surfing, swimming, snorkeling, sailing and water sports. Not suitable for diving.", 'Size: 48mm
Color: Black', '11');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('43', 'PUMA Evercat Mesh Stretch Fit Cap ', '8', '26', '1.jpg', '290.000', '80% Polyester, 20% Cotton
Imported
No Closure closure
Machine Wash
80% Polyester, 20% Cotton
Imported
No Closure closure
Machine Wash
Curved brim with PUMA Cat logo
6 panel design
Moisture wicking
Breathable mesh fabric
Stretch fit
Woven', '80% Polyester, 20% Cotton
Imported
No Closure closure
Machine Wash
80% Polyester, 20% Cotton
Imported
No Closure closure
Machine Wash
Curved brim with PUMA Cat logo
6 panel design
Moisture wicking
Breathable mesh fabric
Stretch fit
Woven', '24');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('44', 'Goodthreads Men\'s Full-Zip Fleece Hoodie', '8', '26', '1.jpg', '420.000', '90% Cotton, 10% Polyester
Imported
No Closure closure
Machine Wash
Easy through chest and tapered through waist
Soft, warm, and oh-so-comfortable midweight brushed back fleece
Elasticized cuff
Drawstring with metal ends
Two-way zipper closure
An Amazon brand', '90% Cotton, 10% Polyester
Imported
No Closure closure
Machine Wash
Easy through chest and tapered through waist
Soft, warm, and oh-so-comfortable midweight brushed back fleece
Elasticized cuff
Drawstring with metal ends
Two-way zipper closure
An Amazon brand', '21');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('45', 'Amazon Essentials Women\'s Classic-Fit 3/4 Sleeve Poplin Shirt', '8', '35', '1.jpg', '500.000', '100% Cotton
Imported
Button closure
Machine Wash
This casual wardrobe-essential tee features a lightweight fit for comfortable everyday wear
Everyday made better: we listen to customer feedback and fine-tune every detail to ensure quality, fit, and comfort', '100% Cotton
Imported
Button closure
Machine Wash
This casual wardrobe-essential tee features a lightweight fit for comfortable everyday wear
Everyday made better: we listen to customer feedback and fine-tune every detail to ensure quality, fit, and comfort', '7');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('46', 'Amazon Essentials Women\'s Long-Sleeve Lightweight French', '8', '26', '1.jpg', '240.000', '60% Cotton, 40% Polyester
Imported
Zipper closure
Machine Wash
Close-but-comfortable fit with easy movement
Soft and comfortable French terry fleece
Long-sleeve design
Kangaroo pocket
Ribbing at collar
An Amazon brand', '60% Cotton, 40% Polyester
Imported
Zipper closure
Machine Wash
Close-but-comfortable fit with easy movement
Soft and comfortable French terry fleece
Long-sleeve design
Kangaroo pocket
Ribbing at collar
An Amazon brand', '8');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('47', 'Nine West Women\'s Mesh Bracelet Watch', '8', '17', '1.jpg', '620.000', 'Mineral crystal lens; taupe dial with rose gold-tone hands and markers; black printed inner minute track
Silver-tone mesh bracelet with adjustable end links; jewelry clasp and extender
Japanese-quartz Movement
Case Diameter: 29mm
Not water resistant
Band Size: Womens-Standard', 'Mineral crystal lens; taupe dial with rose gold-tone hands and markers; black printed inner minute track
Silver-tone mesh bracelet with adjustable end links; jewelry clasp and extender
Japanese-quartz Movement
Case Diameter: 29mm
Not water resistant
Band Size: Womens-Standard', '17');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('48', 'Carhartt Women\'s Relaxed Fit Midweight Logo Sleeve Graphic Sweatshirt', '8', '26', '1.jpg', '370.000', "55% Cotton, 45% Polyester
Imported
Pullover closure
Machine Wash
RELAXED FIT
10.5-ounce, 55% cotton/45% polyester
Pullover with attached three-piece hood
Carhartt signature logo printed on left sleeve with Carhartt 'C' graphic on front' '55% Cotton, 45% Polyester"
,"Imported
Pullover closure
Machine Wash
RELAXED FIT
10.5-ounce, 55% cotton/45% polyester
Pullover with attached three-piece hood
Carhartt signature logo printed on left sleeve with Carhartt 'C' graphic on front", '16');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('49', 'Carhartt Men\'s Loose Fit Heavyweight Long-Sleeve Pocket T-Shirt', '8', '26', '1.jpg', '510.000', 'Solids: 100% cotton; Heather Gray: 90% cotton, 10% polyester; All other heathers, Brite Lime and Brite Orange: 60% cotton, 40% polyester
Imported
Pull On closure
Machine Wash
Rib-knit crewneck and cuffs
Side-seamed construction minimizes twisting
Left-chest pocket with sewn-on Carhartt label
Tagless neck label', 'Solids: 100% cotton; Heather Gray: 90% cotton, 10% polyester; All other heathers, Brite Lime and Brite Orange: 60% cotton, 40% polyester
Imported
Pull On closure
Machine Wash
Rib-knit crewneck and cuffs
Side-seamed construction minimizes twisting
Left-chest pocket with sewn-on Carhartt label
Tagless neck label', '9');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('50', 'Just My Size Women\'s Sweatshirt, Plus Size Slub Jersey Full-Zip Hoodie, Women\'s T-Shirt Hoodie, JMS Zip-up for Women', '8', '35', '1.jpg', '275.000', "100% Cotton
Imported
Zipper closure
Machine Wash
SLUB FABRIC - Made of 100 percent slub cotton jersey, these hoodies for women boast a distinctive uneven texture.
FULL ZIP - A dyed-to-match front zipper makes for easy-on and easy-off.
ALL IN THE DETAILS - Featuring a 29 length, this women's loungewear has wide cuffs and waistband.
SPLIT POCKETS - Warm your hands or stow your essentials in the split pouch pockets.
HOOD IT - A classic hood features a drawcord for adjustability.
TAGLESS – No tags for itch-free comfort.
SIZING NOTE - For a roomier fit, go up one size.
COLD WATER WASH - Machine wash cold with like colors. Use only nonchlorine bleach when needed. Tumble dry low. Cool iron if needed.", "100% Cotton
Imported
Zipper closure
Machine Wash
SLUB FABRIC - Made of 100 percent slub cotton jersey, these hoodies for women boast a distinctive uneven texture.
FULL ZIP - A dyed-to-match front zipper makes for easy-on and easy-off.
ALL IN THE DETAILS - Featuring a 29 length, this women's loungewear has wide cuffs and waistband.
SPLIT POCKETS - Warm your hands or stow your essentials in the split pouch pockets.
HOOD IT - A classic hood features a drawcord for adjustability.
TAGLESS – No tags for itch-free comfort.
SIZING NOTE - For a roomier fit, go up one size.
COLD WATER WASH - Machine wash cold with like colors. Use only nonchlorine bleach when needed. Tumble dry low. Cool iron if needed.", '4');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('51', 'Converse Men\'s Run Star Hike High Top Sneakers', '8', '26', '1.jpg', '1.400.000', "100% Synthetic
Imported
Rubber sole
Converse
Unisex Shoes
Casual Shoes
Black
Synthetic", "100% Synthetic
Imported
Rubber sole
Converse
Unisex Shoes
Casual Shoes
Black
Synthetic", '27');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('52', 'PUMA Men\'s Fusion Evo Golf Shoe', '8', '35', '1.jpg', '1.199.000', 'Made in USA or Imported
Synthetic sole
BOOTIE CONSTRUCTION-Bootie construction provides step in comfort and 360-degrees of support around the foot.
PWRSTRAP FIT SYSTEM-Advanced nylon webbing straps integrated with the lacing system that wrap the foot to provide a secure, personalized fit.
SOFTFOAM-Dual Density insole provides two unique layers of cushioning for customized comfort, fit and long lasting durability.
FUSION FOAM-Mix of super soft EVA foam and ultra-responsive rubber combine to provide energy return and cushioning to keep you comfortable all day long.', 'Made in USA or Imported
Synthetic sole
BOOTIE CONSTRUCTION-Bootie construction provides step in comfort and 360-degrees of support around the foot.
PWRSTRAP FIT SYSTEM-Advanced nylon webbing straps integrated with the lacing system that wrap the foot to provide a secure, personalized fit.
SOFTFOAM-Dual Density insole provides two unique layers of cushioning for customized comfort, fit and long lasting durability.
FUSION FOAM-Mix of super soft EVA foam and ultra-responsive rubber combine to provide energy return and cushioning to keep you comfortable all day long.', '28');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('53', 'Signature by Levi Strauss & Co. Gold Label Women\'s Totally Shaping Skinny Jeans (Standard and Plus)', '8', '8', '1.jpg', '480.000', "79% Cotton, 19% Polyester, 2% Elastane
Imported
Zipper closure
Machine Wash
Also available in Totally Shaping High Rise Skinny
Super stretch lasts from day to night; Snug fit doesn't lose shape
Vintage, worn-in look
Mid-rise waistband with tummy-slimming panel
Skinny through hip and thigh
Inseam: Short=28, Medium=30, Long=32", "79% Cotton, 19% Polyester, 2% Elastane
Imported
Zipper closure
Machine Wash
Also available in Totally Shaping High Rise Skinny
Super stretch lasts from day to night; Snug fit doesn't lose shape
Vintage, worn-in look
Mid-rise waistband with tummy-slimming panel
Skinny through hip and thigh
Inseam: Short=28, Medium=30, Long=32", '7');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('54', 'Levi\'s Men\'s 511 Slim Fit Jeans (Regular and Big & Tall) ', '8', '8', '1.jpg', '320.000', "99% Cotton, 1% Elastane
Imported
Zipper closure
Wash And Dry Inside Out With Like Colors; Liquid Detergent Is Recommended
Sits below waist
Slim through seat and thigh
Levi's Men's 511 Slim Fit Jean, Throttle - Stretch, 26W x 29L
The model in the image is and is wearing 32 x 32.', '99% Cotton, 1% Elastane"
,"Imported
Zipper closure
Wash And Dry Inside Out With Like Colors; Liquid Detergent Is Recommended
Sits below waist
Slim through seat and thigh
Levi's Men's 511 Slim Fit Jean, Throttle - Stretch, 26W x 29L
The model in the image is and is wearing 32 x 32.', '26');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('55', 'Gildan Men\'s Crew T-Shirts, Multipack, Style G1100', '8', '26', '1.jpg', '320.000', 'Solids: 100% Cotton; Sport Grey: 90% Cotton, 10% Polyester
Imported
Pull On closure
Machine Wash
Soft, breathable cotton
Moisture wicking technology keeps you cool and dry
Tag-free to prevent irritation
Classic length for easy tucking
Durable stitching
Lay-flat collar', 'Solids: 100% Cotton; Sport Grey: 90% Cotton, 10% Polyester
Imported
Pull On closure
Machine Wash
Soft, breathable cotton
Moisture wicking technology keeps you cool and dry
Tag-free to prevent irritation
Classic length for easy tucking
Durable stitching
Lay-flat collar", '15');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('56', 'Gildan Men\'s Heavy Cotton 3/4 Raglan T-Shirt, Style G5700, 2-Pack', '8', '8', '1.jpg', '275.000', 'Solids: 100% Cotton; Sport Grey: 90% Cotton, 10% Polyester
Imported
Pull On closure
Machine Wash
Fabric Weight: 5.3 oz/sq.yd. 100% U.S. Cotton
Classic Fit, tubular body
Versatile mid-weight fabric for year-round wear
Contrast color collar and 3/4 raglan sleeves
Tear away label for customizable comfort
Screen printing, embroidery, heat transfers, bleaching and tie dye', "Solids: 100% Cotton; Sport Grey: 90% Cotton, 10% Polyester
Imported
Pull On closure
Machine Wash
Fabric Weight: 5.3 oz/sq.yd. 100% U.S. Cotton
Classic Fit, tubular body
Versatile mid-weight fabric for year-round wear
Contrast color collar and 3/4 raglan sleeves
Tear away label for customizable comfort
Screen printing, embroidery, heat transfers, bleaching and tie dye", '7');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('57', 'Men\'s Short Sets Outfits 2 Piece Summer Tracksuit Short', '8', '8', '1.jpg', '600.000', "polyester
Drawstring closure
Hand Wash Only
The Size is US Size.Please check the SIZE CHART details before bidding.Thank you for the kind understand. Fabric:breathable.
Track Suit set. It's well made and breathable. Design:The traction rope on the trousers can be adjusted to your own comfortable lengh.Also a good gift choice for your father, son, Boyfriend and friends
men pants,clothes men,ropa de hombre,tracksuit women,man clothes set,men outfit,sweat suit,clothes for men,mens tracksuits ,2 piece set women,jogger set,mens sweat suits,sweatsuit men,sweat suits,camouflage,mens track suit,ropa hombre,ropa para hombre,mens sweatsuits set,sweatsuits,shirt,suit men,mens shits,man clothes,mens jogger suit sets,men fashions,men sets,tracksuit men set,mens fashion,track suit men,mens pants fashions men,men clothing ,men two piece set,
shirts,2 piece tracksuit,mens tracksuits,mens outfit,tracksuit,gym clothing,men fashion,mens romper,sweat pants ,running clothing,bike outfit men,linen outfit for men full,men white outfit cycling,biking outfit men all,white linen outfit for men red, outfit men shorts,tennis outfit for men,men outfit sets camo,hawaiian outfit for men july,men linen outfit joggers,jogging outfit men,white linen outfit for men two piece,men outfit sets hunting,american outfit mens ,shorts outfit for men new,
Sport set for men,summer suit for men,men suit,sweatpants set,hip hop plus size sweatsuit,shorts and shirts for men,men sweat suit set,two piece set men,summer clothes for men,men 2 piece set,sweat suits women,track suits,backwoods,men summer clothes,ropa de hombre moda,clothing,mens sets of clothing,men set,men track suits ,tracksuit,mens tracksuit,mens sports suits,pants men,men outfits,men outfit setsweatsuits men,men short sets,men sweatsuit,romper,tracksuits,", "polyester
Drawstring closure
Hand Wash Only
The Size is US Size.Please check the SIZE CHART details before bidding.Thank you for the kind understand. Fabric:breathable.
Track Suit set. It's well made and breathable. Design:The traction rope on the trousers can be adjusted to your own comfortable lengh.Also a good gift choice for your father, son, Boyfriend and friends
men pants,clothes men,ropa de hombre,tracksuit women,man clothes set,men outfit,sweat suit,clothes for men,mens tracksuits ,2 piece set women,jogger set,mens sweat suits,sweatsuit men,sweat suits,camouflage,mens track suit,ropa hombre,ropa para hombre,mens sweatsuits set,sweatsuits,shirt,suit men,mens shits,man clothes,mens jogger suit sets,men fashions,men sets,tracksuit men set,mens fashion,track suit men,mens pants fashions men,men clothing ,men two piece set,
shirts,2 piece tracksuit,mens tracksuits,mens outfit,tracksuit,gym clothing,men fashion,mens romper,sweat pants ,running clothing,bike outfit men,linen outfit for men full,men white outfit cycling,biking outfit men all,white linen outfit for men red, outfit men shorts,tennis outfit for men,men outfit sets camo,hawaiian outfit for men july,men linen outfit joggers,jogging outfit men,white linen outfit for men two piece,men outfit sets hunting,american outfit mens ,shorts outfit for men new,
Sport set for men,summer suit for men,men suit,sweatpants set,hip hop plus size sweatsuit,shorts and shirts for men,men sweat suit set,two piece set men,summer clothes for men,men 2 piece set,sweat suits women,track suits,backwoods,men summer clothes,ropa de hombre moda,clothing,mens sets of clothing,men set,men track suits ,tracksuit,mens tracksuit,mens sports suits,pants men,men outfits,men outfit setsweatsuits men,men short sets,men sweatsuit,romper,tracksuits,", '13');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('58', 'Wrangler Authentics Men\'s Hooded Flannel Lined Twill Shirt', '8', '17', '1.jpg', '400.000', "54% Cotton, 46% Polyester
Imported
Button closure
Machine Wash
RELAXED FIT. Perfect for layering in the winter or during cool fall evenings, this relaxed fit hooded shirt jacket doesn't restrict movement and leaves room for layering on colder days.
BUILT FOR COMFORT. Made with comfort and function in mind, this midweight lined twill shirt will keep you warm all season long. Your new wardrobe favorite.
FUNCTIONAL STYLE. Designed with a cotton shell, this fleece-lined shirt jacket is designed with style and function in mind. Wear it to work or out to lunch with friends, this essential staple can be worn for many occasions.
DURABLE FINISHINGS. Finished with heavy-duty plastic buttons, this hooded shirt is built to last. Button cuff closure designed to keep the warmth in, and the cold air out.
ADDED STORAGE. Constructed with (2) button front pockets, this blanket-lined shirt has easy-access storage for all your basic necessities.", "54% Cotton, 46% Polyester
Imported
Button closure
Machine Wash
RELAXED FIT. Perfect for layering in the winter or during cool fall evenings, this relaxed fit hooded shirt jacket doesn't restrict movement and leaves room for layering on colder days.
BUILT FOR COMFORT. Made with comfort and function in mind, this midweight lined twill shirt will keep you warm all season long. Your new wardrobe favorite.
FUNCTIONAL STYLE. Designed with a cotton shell, this fleece-lined shirt jacket is designed with style and function in mind. Wear it to work or out to lunch with friends, this essential staple can be worn for many occasions.
DURABLE FINISHINGS. Finished with heavy-duty plastic buttons, this hooded shirt is built to last. Button cuff closure designed to keep the warmth in, and the cold air out.
ADDED STORAGE. Constructed with (2) button front pockets, this blanket-lined shirt has easy-access storage for all your basic necessities.", '11');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('59', 'Goodthreads Men\'s Slim-Fit Short-Sleeve Printed Poplin Shirt', '8', '26', '1.jpg', '700.000', "54% Cotton, 46% Polyester
Imported
Button closure
Machine Wash
RELAXED FIT. Perfect for layering in the winter or during cool fall evenings, this relaxed fit hooded shirt jacket doesn't restrict movement and leaves room for layering on colder days.
BUILT FOR COMFORT. Made with comfort and function in mind, this midweight lined twill shirt will keep you warm all season long. Your new wardrobe favorite.
FUNCTIONAL STYLE. Designed with a cotton shell, this fleece-lined shirt jacket is designed with style and function in mind. Wear it to work or out to lunch with friends, this essential staple can be worn for many occasions.
DURABLE FINISHINGS. Finished with heavy-duty plastic buttons, this hooded shirt is built to last. Button cuff closure designed to keep the warmth in, and the cold air out.
ADDED STORAGE. Constructed with (2) button front pockets, this blanket-lined shirt has easy-access storage for all your basic necessities.", "54% Cotton, 46% Polyester
Imported
Button closure
Machine Wash
RELAXED FIT. Perfect for layering in the winter or during cool fall evenings, this relaxed fit hooded shirt jacket doesn't restrict movement and leaves room for layering on colder days.
BUILT FOR COMFORT. Made with comfort and function in mind, this midweight lined twill shirt will keep you warm all season long. Your new wardrobe favorite.
FUNCTIONAL STYLE. Designed with a cotton shell, this fleece-lined shirt jacket is designed with style and function in mind. Wear it to work or out to lunch with friends, this essential staple can be worn for many occasions.
DURABLE FINISHINGS. Finished with heavy-duty plastic buttons, this hooded shirt is built to last. Button cuff closure designed to keep the warmth in, and the cold air out.
ADDED STORAGE. Constructed with (2) button front pockets, this blanket-lined shirt has easy-access storage for all your basic necessities.", '19');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('70', 'Essentials Men\'s Performance', '4', '13', '1.jpg', '450.000', 'We listen to customer feedback and fine-tune every detail to ensure our clothes are more comfortable, higher quality, and longer lasting—at affordable prices for the whole family.', "Package Dimensions ‏ : ‎ 12.48 x 9.37 x 2.13 inches; 10.93 Ounces
Item model number ‏ : ‎ 13215
Department ‏ : ‎ Mens
Date First Available ‏ : ‎ March 23, 2022
Manufacturer ‏ : ‎ AMAZON ESSENTIALS
ASIN ‏ : ‎ B09GYKSTK3
Best Sellers Rank: #192 in Our Brands (See Top 100 in Our Brands)
#5 in Men's Athletic Shorts", '18');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('71', 'Mens Sport Flip Flops Comfort Casual', '4', '13', '1.jpg', '600.000', 'Amazon Basics Rubber Encased Hex Dumbbell Hand Weight', '15 pound individual dumbbell weight with a solid cast iron core for exercise and strength training
Ideal for use in fitness classes, home gym or workout area
Hexagonal rubber-encased ends help prevent rolling and promote stay-in-place storage
Non-slip textural grip for reliable, comfortable use
Dimensions: 12 x 4.5 x 4 inches (LxWxH) with 1.38-inch grip diameter; weighs 15 pounds (sold individually)', '20');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('72', 'UNDER ARMOUR 32oz Sideline', '4', '13', '1.jpg', '300.000', 'Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', "QUICK SHOT LID – The patented Quick-shot lid with one-way valve so you can hydrate quickly, even on-the-go
ONE HAND USE - When you're running or training, you don't always have a spare hand when you need to hydrate, this is the bottle for those times when you don't have two hands free
PRACTICAL – have a quick drink on the go, marked with ounces & milliliters for easy measuring, dishwasher safe with self-draining cap helps prevent dishwasher puddle
TOP QUALITY – Made for kids and adults, BPA and Lead Free, perfect for all sports, the gym, around the house, for travel, camping, and more, fits on bike holder
Dimensions: 10\"H x 3.25\"W x 3.25\"D", '21');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('73', 'Fruit of the Loom Women', '4', '4', '1.jpg', '200.000', 'With wide, comfy straps in a classic racerback design, the Nike Swoosh Sports Bra feels snug and secure while you move. Smooth, lightweight fabric wicks sweat to keep you dry, comfortable and focused. For every rep, step and jump—know that you’re supported. This product is made with at least 75% recycled polyester fibers. Dri-FIT technology pulls sweat away from your skin to help you stay dry and comfortable.', 'Package Dimensions ‏ : ‎ 11.42 x 5.91 x 1.18 inches; 2.08 Ounces
Item model number ‏ : ‎ BV3630
Department ‏ : ‎ Womens
Date First Available ‏ : ‎ April 13, 2020
Manufacturer ‏ : ‎ Nike Apparel (Sporting Goods)
ASIN ‏ : ‎ B07RQMRXWG
Best Sellers Rank: #4,942 in Clothing, Shoes & Jewelry (See Top 100 in Clothing, Shoes & Jewelry)
#56 in Women\'s Sports Bras', '13');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('74', 'Men\'s Cotton Performance Short', '4', '31', '1.jpg', '200.000', 'The Russell Athletic Men’s Essential Tee delivers the comfort, style, and performance to fit your active lifestyle. This t-shirt features our signature Dri-Power moisture wicking technology, odor protection to keep the fabric fresh, and a UPF 30+ rating to protect you from harmful UV rays. This tee is a wardrobe essential, offering both the style and comfort of cotton with the benefits of performance.', 'Package Dimensions ‏ : ‎ 10.94 x 9.45 x 1.02 inches; 5.93 Ounces
Item model number ‏ : ‎ 64STTM0
Department ‏ : ‎ Mens
Date First Available ‏ : ‎ May 25, 2022
ASIN ‏ : ‎ B085V1CN6H
Best Sellers Rank: #231 in Clothing, Shoes & Jewelry (See Top 100 in Clothing, Shoes & Jewelry)
#4 in Men\'s Activewear T-Shirts', '24');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('75', 'adidas Men\'s Performance Boxer Brief', '4', '13', '1.jpg', '400.000', 'Step up your training today with a set of GoSports training cones. The set includes 20 training cones which are Great for individuals or team drills. Their low profile design and flexible construction means they are durable and extremely safe if anyone falls on one. Their high visibility orange color is Great for low light conditions. We also include a mesh tote bag so you can keep the cones organized and transport them with ease.', '$40.33 Shipping & Import Fees Deposit to Vietnam Details 
Available at a lower price from other sellers that may not offer free Prime shipping.
AGILITY TRAINING: Includes 20 high visibility orange training cones - essential for any training regimen to support player development in a variety of sports
COACH FAVORITE: Low profile design keeps the field safe while still serving as flexible and durable markers for boundary lines, training courses, and drills
STORAGE TOTE: Includes sturdy mesh tote bag with drawstring to keep cones organized and easy to take anywhere
RETAINS SHAPE: Holds up against the demands of training and made from durable flexible plastic so they do not lose shape from being stepped on unlike other low quality sets
', '23');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('76', 'Men\'s Designed 2 Move Feelready T-Shirt', '4', '22', '1.jpg', '500.000', 'Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Is Discontinued By Manufacturer ‏ : ‎ No
Product Dimensions ‏ : ‎ 2.13 x 2.6 x 2.2 inches; 0.01 Ounces
Item model number ‏ : ‎ SP_01138
Date First Available ‏ : ‎ February 28, 2014
Manufacturer ‏ : ‎ Sports Research
ASIN ‏ : ‎ B00IOZWC2M
Best Sellers Rank: #466 in Health & Household (See Top 100 in Health & Household)
#3 in Vitamin B7 (Biotin) Supplements', '21');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('77', 'GoSports Sports Training Cone', '4', '31', '1.jpg', '300.000', 'Degree Men Sport Antiperspirant Deodorant delivers 48-hour sweat and odor protection to keep you feeling dry and fresh. This antiperspirant deodorant for men works as hard as you do and offers 48-hour protection, so you can start moving and take on the day. Our Sport Antiperspirant Deodorant features a zesty lemon and bergamot orange scent with a hint of musk. The powerful antiperspirant deodorant responds when you need it most, so you can stay confident without having to worry about slowing down. You can be confident you’ll be protected from sweat and odor by this antiperspirant for men. Stay fresh and feel clean from morning to night. Simply twist, glide and get moving. The dynamic, energizing scent helps to keep you as fresh as when you started your day. Stay dry, cool, and confident thanks to Degree Men Sport Antiperspirant Deodorant. At Degree, we want to inspire the confidence in everyone to move more and go further. We’re here to support your journey through an antiperspirant that moves with you and helps you go beyond your limits. As well as increasing our use of reusable materials, we’re making it easier for you to recycle our antiperspirant and dry spray packaging. Degree. It won’t let you down.', '48-HOUR PROTECTION: Active lives need Degree Men Sport Antiperspirant Deodorant. This antiperspirant for men delivers confidence with 48-hour sweat and odor protection.
FEEL SHOWER-FRESH ALL DAY: This antiperspirant deodorant keeps you feeling dry with a refreshing, dynamic scent. You\'ll feel as fresh as when you started your day
READY FOR WHAT’S NEXT: Take on the day with Degree Men Sport Antiperspirant Deodorant stick. Simply twist, glide, and move
ENERGIZING SCENT: Stay fresh longer with this antiperspirant for men. Degree Men Sport Antiperspirant Deodorant features a dynamic, zesty lemon and bergamot orange scent
RECYCLE WITH DEGREE: As well as increasing our use of reusable materials, we’re making it easier for you to recycle our antiperspirant and dry spray packaging
GO BEYOND YOUR LIMITS: At Degree, we want to inspire the confidence in everyone to move more and go further. We’re here to support your journey through an antiperspirant for men that moves with you', '15');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('78', 'Sports Research Biotin Supplement', '4', '31', '1.jpg', '500.000', 'Our 608v5 classic trainer features super-soft cushioning and a durable rubber outsole to deliver the support and comfort your feet need on a daily basis. This shoe was designed with comfort perks like an oversized ABZORB heel crash pad, a durable molded PU insert and relaxed fit last. Plus, a suede and mesh upper delivers a snug fit and breathable comfort.', 'Product Dimensions ‏ : ‎ 13.27 x 7.22 x 4.88 inches; 10.8 Ounces
Item model number ‏ : ‎ WX608AB5
Department ‏ : ‎ Womens
Date First Available ‏ : ‎ June 28, 2018
Manufacturer ‏ : ‎ New Balance
ASIN ‏ : ‎ B07B417MT7
Best Sellers Rank: #532 in Clothing, Shoes & Jewelry (See Top 100 in Clothing, Shoes & Jewelry)', '25');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('79', 'Degree Men Original Protection', '4', '4', '1.jpg', '400.000', 'Equal parts durable, comfortable and stylish, the Gildan Adult Fleece Hooded Sweatshirt belongs in every collection. Whether you’re hanging out with friends or relaxing at home, this must-have delivers everything you want in a hoodie, including the perfect surface for making decorations pop.', 'Product details
Package Dimensions ‏ : ‎ 12.76 x 11.57 x 3.43 inches; 8 Ounces
Item model number ‏ : ‎ G18500
Department ‏ : ‎ Mens
Date First Available ‏ : ‎ October 5, 2022
ASIN ‏ : ‎ B0BHF5HBP7
Best Sellers Rank: #26 in Clothing, Shoes & Jewelry (See Top 100 in Clothing, Shoes & Jewelry)', '9');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('80', 'New Balance Women\'s', '4', '13', '1.jpg', '2.000.000', 'Move from the street to the gym with a modern look. this newly updated duffel bag features a water-resistant base for all-day durability while you\'re on the go. zip end pockets and a small front pocket give you easy access to your personal essentials.', 'Item model number ‏ : ‎ 979175
Department ‏ : ‎ Unisex
Date First Available ‏ : ‎ April 23, 2020
Manufacturer ‏ : ‎ adidas
ASIN ‏ : ‎ B087LR92KJ
Best Sellers Rank: #1,072 in Clothing, Shoes & Jewelry (See Top 100 in Clothing, Shoes & Jewelry)
#2 in Sports Duffel Bags', '16');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('81', 'Gildan Adult Fleece Hooded', '4', '4', '1.jpg', '1.500.000', 'This all-in-one gym equipment features a variety of fitness exercises to tone and strengthens the core, thighs, arms, and legs. It’s a combination of a Smith machine, pull-up bar, cable crossovers, and a leg developer.
Power-up your upper body muscles with the Smithstyle press bar and cable crossovers, and strengthen the lower body muscles with the leg developer.', 'Item Weight        131 Kilograms
Brand        Marcy
Color        Gray, Brown
Material        Steel
Item Dimensions LxWxH        98 x 59 inches', '19');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('82', 'Defender 4 Medium Duffel Bag', '4', '13', '1.jpg', '2.500.000', 'THE BUNDLE PACK to maximize your exercise routine with a full body workout for your home anytime you want for all levels to create gains
PORTABLE GYM BAR that can be used as a doorway pull up bar or turned over to perform sit-ups, pushups, and dips; 300-pound weight capacity', '
Brand        Perfect Fitness
Maximum Weight Recommendation        300 Pounds
Mounting Type        Door Mount
Material        Alloy Steel
Special Feature        Portable', '4');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('83', 'Marcy Smith Cage Machine', '4', '22', '1.jpg', '5.000.000', '95% Cotton, 5% Spandex
Imported
Drawstring closure
Machine Wash
High-Class Material: Our Men\'s Lounge Jogger made of premium fleece(machine wash), provides you a soft and comfortable feel in a stylish fit. With the season changing, you can choose the plus fleece type or without fleece.
Pockets & Adjustable Draw Cord Design: Feature with open side deep pockets offer convenient storage. The elastic waistband of Joggers Sweatpants can perfect suit your waist, which makes you can do the exercises without anxiety
Perfect Style: The Lounge Jogging Pants have tapered Sweatpants with a ribbed elastic waistband and an adjustable drawstring, promise a comfortable secure fit to have a perfect feeling while doing your training. Athletic fit for maximum comfort.', 'Package Dimensions ‏ : ‎ 13.75 x 10.5 x 1.75 inches; 1.3 Pounds
Department ‏ : ‎ Mens
Date First Available ‏ : ‎ September 27, 2019
ASIN ‏ : ‎ B07YHJLHC4
Best Sellers Rank: #2,102 in Clothing, Shoes & Jewelry (See Top 100 in Clothing, Shoes & Jewelry)
#19 in Men\'s Sweatpants', '25');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('84', 'Perfect Fitness Perfect Pushup', '4', '31', '1.jpg', '5.500.000', 'THE BUNDLE PACK to maximize your exercise routine with a full body workout for your home anytime you want for all levels to create gains
PORTABLE GYM BAR that can be used as a doorway pull up bar or turned over to perform sit-ups, pushups, and dips; 300-pound weight capacity', 'Brand        Perfect Fitness
Maximum Weight Recommendation        300 Pounds
Mounting Type        Door Mount
Material        Alloy Steel
Special Feature        Portable', '6');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('85', 'THE GYM PEOPLE Men\'s Fleece Joggers Pants', '4', '31', '1.jpg', '8.000.000', '95% Cotton, 5% Spandex
Imported
Drawstring closure
Machine Wash
High-Class Material: Our Men\'s Lounge Jogger made of premium fleece(machine wash), provides you a soft and comfortable feel in a stylish fit. With the season changing, you can choose the plus fleece type or without fleece.
Pockets & Adjustable Draw Cord Design: Feature with open side deep pockets offer convenient storage. The elastic waistband of Joggers Sweatpants can perfect suit your waist, which makes you can do the exercises without anxiety
Perfect Style: The Lounge Jogging Pants have tapered Sweatpants with a ribbed elastic waistband and an adjustable drawstring, promise a comfortable secure fit to have a perfect feeling while doing your training. Athletic fit for maximum comfort.', 'Package Dimensions ‏ : ‎ 13.75 x 10.5 x 1.75 inches; 1.3 Pounds
Department ‏ : ‎ Mens
Date First Available ‏ : ‎ September 27, 2019
ASIN ‏ : ‎ B07YHJLHC4
Best Sellers Rank: #2,102 in Clothing, Shoes & Jewelry (See Top 100 in Clothing, Shoes & Jewelry)
#19 in Men\'s Sweatpants',"16");
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('86', 'BalanceFrom Tricep Press Down Cable Attachment', '4', '31', '1.jpg', '2.000.000', 'Full combo includes: 1x Tricep Rope, 1x V-Handle, 1x V-Shaped Bar and 1x Straight Rotating Bar. Universal design fits most cable systems
V Handle (Double D Handle) - Constructed of solid steel with a textured finish for better grip and safety during workouts. Weight Capacity: Up to 800 lbs', 'Full combo includes: 1x Tricep Rope, 1x V-Handle, 1x V-Shaped Bar and 1x Straight Rotating Bar. Universal design fits most cable systems
V Handle (Double D Handle) - Constructed of solid steel with a textured finish for better grip and safety during workouts. Weight Capacity: Up to 800 lbs', '23');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('87', 'DMoose Weight Lifting Belt', '4', '13', '1.jpg', '1.200.000', '✅ Please Double Check Your Size In Images Before Placing The Order!
✅ MAINTAIN IDEAL BODY POSTURE - The DMoose Weight belt helps you stay in the perfect form for intense workouts. Whether you are a beginner or an advanced lifter, these Weight lifting belts will help you lift more comfortably and reduce risk of injury to your lower back while working out. Built to last so you can keep lifting even longer. Add this to your workout gear so you\'re ready to lift harder than ever!', 'Size        Small
Material        Neoprene
Brand        DMoose Fitness
Color        American
Closure Type        Hook and Loop', '25');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('88', '1/2-Inch Extra Thick Exercise Yoga Mat', '4', '31', '1.jpg', '3.000.000', '100% NBR foam
Imported
Extra thick mat for yoga, gym, and everyday exercise
Textured foam construction provides traction and stability
1/2 inch thick mat provides extra support, shock-absorption, and comfort
Elastic straps secure rolled-up mat; includes shoulder strap for easy carrying
Please check the mat will not slip on the floor before using
Dimensions: 74 x 24 x .5 inches
', 'Color        Black
Brand        Amazon Basics
Material        Foam
Product Care Instructions        Hand Wash Only
Product Dimensions        73.2"L x 24.3"W x 0.5"Th
Item Weight        2.45 Pounds', '3');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('89', 'MAXPRO Fitness: Cable Home Gym', '4', '22', '1.jpg', '4.000.000', 'WHAT\'S INCLUDED: MAXPRO Raw Metal SmartConnect, MAXPRO 3-piece Quick Connect Long Bar, 2x MAXPRO Workout Handles, 2x MAXPRO Ankle/Wrist Straps, 2x MAXPRO Door Mount Brackets, USB Charger
SMARTCONNECT: Bluetooth connected model, with on-board sensors that along with the MAXPRO App track your workout, monitor your progress, provides valuable data and analytics, and coaches you to help you reach your fitness goals.', 'Brand        MAXPRO
Color        Raw Metal (SmartConnect)
Maximum Weight Recommendation        300 Pounds
Controls Type        Push Button
Handle Type        Strap', '11');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('90', 'Philips Sonicare 4100 Power Toothbrush', '5', '14', '1.jpg', '2.000.000', 'Removes up to 5x-7x more plaque vs. a manual toothbrush
Pressure sensor and two intensity settings protect sensitive gums from overbrushing
2 minute SmarTimer with QuadPacer ensure Dentist-recommended brushing time
Brush head replacement reminder ensures your brush head is always effective
Long battery life with battery light indicator: One charge last for 2 weeks
Includes: 1 Philips Sonicare 4100 handle, 1 Optimal Plaque Control (C2) brush head, and 1 USB charger (wall adaptor not included)', 'Brand        Philips Sonicare
Age Range (Description)        Adult
Special Feature        Brushing Timer, Pressure Sensor
Power Source        Corded Electric
Item Firmness Description        Soft', '27');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('91', 'Cuisinart CCO-50BKN Deluxe Electric', '5', '32', '1.jpg', '10.000.000', 'FUNCTIONAL: Cuisinart quality-engineered motor system makes it easy to open any size can with the Power Cut blade
STURDY: Base prevents any sliding or tipping
EASY CLEAN UP: Removable activation lever for easy cleaning
EASY TO USE: Single-touch operation for easy use
LIMITED 3-YEAR WARRANTY: Refer to user manual for troubleshooting steps and questions surrounding warranty policies – this product is BPA free', 'Color        Black
Material        Plastic
Brand        Cuisinart
Size        Black
Blade Material        Stainless Steel', '23');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('92', 'COSORI Electric Kettle with Stainless', '5', '14', '1.jpg', '5.000.000', 'THE PUREST WATER FOR YOU--Your kettle is made with superior-quality 304 stainless steel and borosilicate glass to keep your water safe and tasting pure for years to come
COMPLETELY SAFE--No need to watch your kettle while it’s boiling. It automatically shuts off 30 seconds after it finishes boiling, and boil-dry protection prevents the kettle from turning on when there is no water. Specifications: The kettle features a rated power of 1500W and is made for use only in the US and Canada', 'Brand        COSORI
Capacity        1.7 Liters
Material        BPA-Free, Stainless Steel, Borosilicate Glass
Color        Black
Special Feature        Manual', '6');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('93', 'Basics Electric Can Opener, Black', '5', '32', '1.jpg', '2.500.000', 'Electric can opener for opening standard-sized cans
Powerful stainless steel blade smoothly and safely opens cans with no snagging
Automatic stop, on/off, and release/locking mechanisms
Wide, non-slip base keeps the opener in place on your countertop
Magnetic lid holder prevents lid from dropping into the can
Modern, compact design with durable plastic housing', 'Color        Black
Material        Stainless Steel, Plastic
Brand        Amazon Basics
Blade Material        Stainless Steel
Item Dimensions LxWxH        4.4 x 4.35 x 8.04 inches', '15');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('94', 'Philips Norelco Shaver 2300', '5', '14', '1.jpg', '3.500.000', 'ComfortCut Blades, get a clean shave that\'s comfortable on your skin. Rounded blade caps shield 27 self-sharpening blades to gently cut hair just above skin level and help the shaver glide smoothly over your skin
Experience a convenient, clean shave with heads that flex and float in 4 directions. The head adjusts to the curves of your face, ensuring smooth contact with your skin without a lot of pressure. 4D Flex Heads follow your face\'s contours for a clean shave', 'Brand        Philips Norelco
Recommended Uses For Product        Face
Special Feature        Not-Applicable
Power Source        Corded Electric
Included Components        Charger', '3');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('95', 'Philips Sonicare 1100 Electric Rechargeable', '5', '23', '1.jpg', '5.000.000', '2 minute SmarTimer with QuadPacer ensure Dentist-recommended brushing time. Battery life up to 14 days
Slim ergonomic design makes brushing easier and more comfortable
Easy-start gently eases you into the electric brushing experience by gradually increasing power
Long battery life with battery light indicator: One charge last for 2 weeks
Includes: 1 Philips Sonicare 1100 electric toothbrush, 1 SimplyClean (C1) brush head, and 1 USB charger (wall adaptor not included)', 'Brand        Philips Sonicare
Age Range (Description)        Adult
Special Feature        Brushing Timer
Power Source        Corded Electric
Color        White Grey', '19');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('96', 'Elite Gourmet EDB-302BF Countertop', '5', '5', '1.jpg', '12.000.000', 'Easy to Clean: 6.5-inch and 5-inch Cast Iron flat cooking plates are nonstick and easy to clean with a damp cloth or non abrasive sponge
Adjustable Temperature: Quickly reach and sustain the desired LOW, MEDIUM or HIGH heat settings with the variable temperature knob to keep food warm or boil hot water.
Built in Safety: Dual power indicator lights on the front of the burner remind users when the item is powered ON; non skid feet ensure the burner remains stable during use.', 'Color        Black
Material        Aluminum
Special Feature        Manual
Brand        Elite Gourmet
Heating Elements        2', '18');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('97', 'Bostitch Personal Electric Pencil Sharpener', '5', '14', '1.jpg', '34.000.000', 'HHC cutter technology for longer life
Powerful motor for stall-free operation (under normal use)
Space-saver compact design
Safety switch prevents operation when shavings tray is removed
High capacity easy clean shavings tray. HEIGHT: 4. 25 inches', 'Brand        Bostitch Office
Color        Blue
Power Source        Electric
Material        Plastic
Item Dimensions LxWxH        8.38 x 4 x 4.25 inches', '29');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('98', 'Braun Electric Series 3 Razor', '5', '32', '1.jpg', '3.000.000', 'CLOSE, CLEAN SHAVE: 3 blade free floating system follows facial contours for a flawless finish and includes a middle trimmer to cut difficult hairs along with 2x SensoFoil shaving elements for ultimate closeness and skin comfort
CAPTURES MORE HAIR: Precision trimmer for accurate moustache and sideburn trimming, includes a specialized MicroComb designed to capture more hair in each stroke *compared to Braun series 3, tested on 3 day beards
BUILT TO LAST: Durable cordless electric shaver, lasting up to 7 years and designed for hair removal with water, foam or gel', 'Brand        Braun
Recommended Uses For Product        Contour
Special Feature        Triple action cutting system, No Docking Station, Wet & Dry
Power Source        Battery Powered
Included Components        Charger', '4');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('99', 'Bodum 11870-01US Bistro Electric Milk', '5', '23', '1.jpg', '4.000.000', 'Milk frother Bistro milk frother was designed to make you a professional Barista without leaving your doorstep
Compact small electric milk frother has convenient cord storage in the removable base perfect if you plan to leave out on the kitchen counter
Sleek design auto shut off when finished Transparent lid allows the frothing to be observed', 'Brand        Bodum
Special Feature        Manual
Color        Black
Material        Glass
Item Dimensions LxWxH        4.38 x 5.63 x 7.88 inches', '27');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('100', 'BELLA XL Electric Ceramic Titanium Griddle', '5', '5', '1.jpg', '5.000.000', 'XL ELECTRIC GRIDDLE: This hardworking extra-large griddle features a 1500 watt heating system, cool touch handles & a base with a built in ledge with backstop for easy pancake flipping. The removable probe with easy-to-use dial allows for precise temperature control
DURABLE & EFFICIENT: The unique ceramic non-stick coating is 8 times more durable & cooks up to 30% faster than standard non-stick coatings. It\'s reinforced with titanium for outstanding strength & scratch resistance
NONSTICK COOKING: This griddle\'s Healthy-Eco coating contains no harmful chemicals like lead & cadmium. Its titanium ceramic coating offers superior food release making this a true non-stick surface', 'Material        Titanium, Ceramic
Brand        BELLA
Color        Copper/Black
Item Weight        3.96 Pounds
Shape        Rectangular', '26');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('101', 'LEM Products 1219 20-Pound Motorized Sausage', '5', '23', '1.jpg', '11.000.000', 'The variable speed control of the Motorized Sausage Stuffer lowers and raises the piston with 8 different speeds from slow to fast, letting you stuff at your own pace, plus the included electric foot switch allows you to stuff your sausage hands free. The sturdy stainless steel body, base and removable cylinder make filling and clean up easy. Includes four stainless steel stuffing tubes: 1/2", 5/8", 1", 1-1/4" OD. 
Handle included. Motor is exclusive to this stuffer only. LEM Products makes home meat processing easy! We deliver high quality meat processing equipment: meat grinders, jerky making equipment, 
and vacuum sealers along with the needed supplies for the hunter and home meat processor. Our products allow everyone from butchers, restaurants, and the at-home meat processor to make delicious sausage, jerky and other meat products, all while controlling 
the healthy content of the foods they provide for their family and friends. LEM is the leader in game processing.', 'Easy, one-person sausage stuffing in half the time! With the power, precision, and smart features of our Big Bite Motorized Stuffers, making sausage is a rewarding, hassle-free, one-person job. The powerful motor pushes with more than a TON of force, while precision controls allow you to determine the flow and set the pace.
Speed control knob: Adjusts how fast the piston lowers so you can control the rate of flow into the casing -- especially important when making small sausages and snack sticks.
Foot switch: Frees up your hands for easy, one-person operation.', '14');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('102', 'Smooth Touch Electric Automatic Can Opener', '5', '5', '1.jpg', '9.000.000', 'ELIMINATES SHARP LID EDGES — This electric can opener cuts cans along the side for smooth, touchable lids;The lid can be re-used to store leftover canned food in the refrigerator
OPENS POP-TOP AND REGULAR CANS: No need to struggle with or handle sharp and messy pop-top lids any longer; You get smooth lids when opening pop-top and regular cans with this automatic can opener', 'Color        Black and Chrome
Material        Plastic, Metal
Brand        Hamilton Beach
Size        Extra Tall
Blade Material        Stainless Steel
', '4');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('103', 'Water Boiler & Heater Auto-Shutoff', '5', '14', '1.jpg', '10.000.000', 'CONVENIENT SERVING WITH DETACHABLE CORD: The cord detaches from the electric kettle for easy serving. Boil and carry hot water to the table or anywhere you\'re serving hot beverages or need hot water. Perfect for adding boiling water to soups or recipes.
PEACE OF MIND: The electric water kettle automatically turns off when it reaches a boil. Boil-dry protection keeps the kettle from scorching if it runs out of water.
EASY TO FILL: With convenient dual water windows, you can view the water level from either side of the hot water kettle. And the pull-up handle makes it easy to lift the lid to add water.', 'Brand        Proctor Silex
Capacity        1 Liters
Color        Black
Special Feature        Manual
Product Dimensions        10.2"L x 6.51"W x 6.51"H', '19');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('104', 'Elite Gourmet EC812 Electric Coffee', '5', '14', '1.jpg', '3.000.000', 'Note: 1)Too coarse a grind, too little coffee, or insufficiently tamping the grounds before brewing can all lead to inadequate pressure for a proper brew. 2)It is important to note that the amount of espresso extracted will vary depending on the grind size and amount and reprogramming may be needed when the size and amount are adjusted.Please refer to user guide or user manual or user guide (provided below in PDF) before first use
READY TO SERVE LIGHT indicates when Coffee Is Ready to serve. Transparent Brew Progress Knob allows you to view brewing cycle and includes Dish-washer safe Stainless Steel permanent filter basket', 'Brand        Elite Gourmet
Capacity        4 Cups
Color        Stainless Steel
Product Dimensions        10"D x 6"W x 13.25"H
Special Feature        Manual', '11');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('105', 'Electric Single Burner 1100-Watts', '5', '23', '1.jpg', '4.500.000', 'Can Be Used for Cooking Outdoors or in the Office
Features a Temperature Regulating Knob with Heat Distribution Coils
Power Indicator Light. Non-slip rubber feet prevents product from sliding
Slim Space Saving Design
This item shouldn’t be use for more than 60 minutes in a 2-hour period as indicated in the manual', 'Color        Black
Material        Aluminum
Special Feature        Adjustable TemperatureTimerPower Light Indicator
Brand        Imusa
Heating Elements        1
Product Dimensions        8.7"D x 8.1"W x 3.3"H', '21');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('106', 'Ecosmart POU 3.5 Point of Use Electric', '5', '5', '1.jpg', '4.800.000', 'Can provide hot water for one sink at 0.5 GPM in warmer climates
Requires 1 x 30 amp breaker and 10 AWG wire
For one sink at 0.5 GPM in colder climates the POU 6 is recommended
Amperage Draw 29 amp. kW - 3.5 kW
Connection Fittings 1/2" NPT
Max temperature rise @ .5 GMP is 47.8°F Max temperature rise @ 1GPM is 23.9°F Max temperature rise @ 1.5 GPM is 15.9°F', 'Brand        EcoSmart
Capacity        0.5 Gallons
Power Source        30 AMP
Item Dimensions LxWxH        6 x 11 x 3 inches
Wattage        3500 watts', '22');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('107', 'Braun Electric Razor for Men,', '5', '23', '1.jpg', '3.200.000', 'Great Christmas, birthday & anniversary gifts for him. Perfect gift for husband, boyfriend, dad, and all the men in your life
3 pressure-sensitive shaving elements for efficiency and skin comfort
Rechargeable long-life NiMH batteries
Wet&Dry shaver for use with water, foam or gel
Designed and engineered in Germany by Braun
Durable cordless electric shaver, waterproof to -5 meters
Contents: Braun Series 3 electric razor, protective cap, smart plug for automatic 100-240 voltage adjustment', 'Brand        Braun
Recommended Uses For Product        Beard, Face
Special Feature        Rechargeable
Power Source        Battery Powered
Model Name        54067', '3');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('108', 'Instant Pot Duo 7-in-1 Electric Pressure Cooker', '5', '32', '1.jpg', '2.400.000', '7-IN-1 FUNCTIONALITY: Pressure cook, slow cook, rice cooker, yogurt maker, steamer, sauté pan and food warmer.
QUICK ONE-TOUCH COOKING: 13 customizable Smart Programs for pressure cooking ribs, soups, beans, rice, poultry, yogurt, desserts and more.
COOK FAST OR SLOW: Pressure cook delicious one-pot meals up to 70% faster than traditional cooking methods or slow cook your favorite traditional recipes – just like grandma used to make.
QUICK AND EASY CLEAN UP: Finger-print resistant, stainless-steel sides and dishwasher-safe lid, inner pot, and accessories.', 'Brand        Instant Pot
Capacity        5.68 Liters
Material        Stainless steel
Closure Type        Outer Lid, Inner Lid
Color        Stainless Steel/Black
Finish Type        Stainless Steel
Product Dimensions        12.2"D x 13.38"W x 12.48"H
Special Feature        Programmable
Wattage        1000 watts
Voltage        120 Volts
', '26');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('109', 'Ovente Electric Indoor Griddle', '5', '5', '1.jpg', '5.300.000', 'Efficient – Cook breakfast, lunch, or dinner for you and the whole family in minutes! This 1200W electric griddle heats quickly and evenly making sure all of your food is cooked inside-out!
Non-Stick Plate – Cleaning is quick and easier with its non-stick cooking surface that prevents food from sticking. Completely PFOA-Free for your savoury meal.
Adjustable Knob – Equipped with a 5-level temperature dial so you can adjust to your desired temperature ranging from 200-400°F.', 'Special Feature        5 Level Temperature Dial
Color        Black - 16x10 Griddle
Material        Non-Stick
Brand        OVENTE
Product Dimensions        12"D x 18"W x 2.75"H
Wattage        1200 watts', '7');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('110', 'Hisense 55-Inch Class R6 Series Dolby Vision HDR 4K UHD Roku Smart TV with Alexa Compatibility', '7', '16', '1.jpg', '42.000.000', '4K UltraHD delivers more than four times the resolution of a regular 1080p highdefinition screen. Along with over 8.3 million pixels, inside you\'ll find a powerful full array LED backlight at work creating a sharper, more colorful picture.
Kick back and enjoy streaming movies and TV episodes, plus live-streaming news, TV, sports and more, across thousands of free and paid channels with the Roku TV Operating System.
Quickly access entertainment and control your TV with a Google Assistant or Alexa device (sold separately). With the touch of your remote or Roku mobile app, or a simple voice command, you can take control of your smart home, turn on and off the TV, change channels, and much more.
Dolby Vision HDR and HDR10 transforms your TV into an entertainment powerhouse. The image technology from cinemas, now brought together in the home, provide amazing realism that you\'ll see, hear, and feel like never before.
Motion Rate 120 image processing technology allows you to enjoy fast-paced sports, movies, and 4K gaming without the lag.
Dimensions (with the stand): 48.5 by 30.4 by 8.9 inches, 25.4 pounds.
Ports: 3 HDMI, HDMI CED/HDMI ARC, Ethernet, 1 USB 2.0, 1 RF Antenna, 1 RCA Composite Video Input, 1 L/R Audio Input for Composite, 1 Optical Digital Ausio Output, 1 Earphone/Audio Output.', 'Screen Size        55 Inches
Brand        Hisense
Supported Internet Services        Apple TV, Disney Plus, Google Assistant, Netflix, Prim Video, Hulu
Display Technology        LED
Product Dimensions        28"D x 48.5"W x 2.9"H
Resolution        3840 x 2160p
Refresh Rate        60 Hz
Special Feature        Flat
Model Name        55R6G
Included Components        Stand, TV, Remote Control, Power Cable', '4');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('111', 'SAMSUNG 32-inch Class LED Smart FHD TV 1080P (UN32N5300AFXZA, 2018 Model)', '7', '34', '1.jpg', '37.000.000', 'Full HD 1080p Resolution - Enjoy a viewing experience that is 2x the clarity of standard HD TVs..Power Supply (V) AC110-120V 50/60Hz
Smart TV - Get to your entertainment the faster, easier, and more intelligent way. Easily access your streaming services all in one place using the Samsung Remote Control.
Micro Dimming Pro - Reveal a more true-to-life picture with enhanced contrast.
Quad Core Processor: enjoy a Fluid browsing experience and faster control switching between apps, streaming content and other media effortlessly.
Dimensions: Without Stand 28.9" W x 17.3" H x 3.1" D | With Stand 28.9" W x 18.2" H x 6.4" D. Stand Size (WxHxD)-5.4 x 6.5 x 1.8 inches
Inputs Outputs: Two HDMI Input, One Component Video Input, One RF In (Satellite Input), One RF In (Terrestrial Cable Input), One USB Input, One Composite In (AV), One Ethernet (LAN) and One Digital Audio Out (Optical)', 'Screen Size        32 Inches
Brand        SAMSUNG
Supported Internet Services        Netflix,Prime Video, YouTube, HULU, HBO Now
Display Technology        LCD
Product Dimensions        6.4"D x 28.9"W x 18.2"H
Resolution        1080p
Refresh Rate        60 Hz
Special Feature        Quad-Core Processor; High-Dynamic Range; Digital Clean View; Eco Sensor
Model Name        Class N5300
Included Components        User Manual, E - Manual, Power Cable, Standard Remote Control with Batteries', '17');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('112', 'LG B2 Series 65-Inch Class OLED Smart TV OLED65B2PUA, 2022 - AI-Powered 4K', '7', '34', '1.jpg', '53.000.000', 'With LG\'s 8 million self-lit OLED pixels, you\'ll get a vivid viewing experience with infinite contrast, deep black, and over a billion colors that add depth and bring out the best in whatever you\'re watching
Engineered especially for LG, the advanced α7 Gen5 AI Processor 4K algorithmically adapts and adjusts picture and sound quality for a lifelike viewing experience with depth and rich color
Get in the action with an impressive 120Hz refresh rate that keeps up with the fast movement in sports, video games, and movies for a sharp picture with smooth motion from start to finish
LG Game Optimizer mode with NVIDIA G-SYNC, FreeSync Premium, and Variable Refresh Rate (VRR) improve your gaming experience with fluid on-screen motion. Game Optimizer manages your game settings all in one place
Mount it on the wall with a 300 x 200 VESA mount (sold separately). Magic Remote, remote control batteries (AA), power cable, and quick start guide are included. TV stand sold separately
Find your favorite shows and movies fast with built-in access to Netflix, Prime Video, Apple TV app, Disney+, HBO Max* and instant access to over 300+ free LG Channels** with everything from comedy to movies to sports
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Screen Size        65 Inches
Brand        LG
Supported Internet Services        Netflix, HBO Max, Prime Video, Disney+, Apple TV
Display Technology        OLED
Product Dimensions        9.7"D x 57"W x 34.2"H
Resolution        4K
Refresh Rate        120
Special Feature        Pixel Level Dimming; Intense Color; Billion Rich Colors; Cinema HDR; NVIDIA GEFORCE NOW; Wide Viewing Angle; Dynamic Tone MappingPixel Level Dimming; Intense Color; Billion Rich Colors; Cinema HDR; NVIDIA GEFORCE NOW; Wide Viewing Angle; Dynamic Tone Mapping
Model Name        FBALGOLED65B2PUA
Included Components        Stand, Power Cable, Remote Control Battery (AA), Magic Remote, Quick Start Guide', '9');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('113', 'SAMSUNG 43-Inch Class Crystal 4K UHD AU8000 Series HDR, 3 HDMI Ports', '7', '34', '1.jpg', '62.000.000', 'HANDPICKED BY AMAZON: They did the research so you don’t have to.
CRYSTAL PROCESSOR 4K: See every detail with stunning clarity; The powerful processor, specifically tuned for Crystal Displays, converts what you\'re watching to 4K
BUILT-IN VOICE ASSISTANTS: Access a world of content beyond streaming; Schedule recordings, search, auto-adjust gaming settings, seamlessly connect with a host of compatible devices, and control your smart TV with your voice, all with one remote
HDR: Enjoy a whole new world of vivid color and detail found in newer films and streaming service content with HDR, also known as High Dynamic Range
MOTION XCELERATOR: With minimized blur and enhanced motion clarity, Motion Xcelerator catches all the fast-moving action, whether you\'re watching sports or taking advantage of new gaming capabilities
SLEEK and SLIM DESIGN: The ultra thin, AirSlim profile lets your television blend in effortlessly
4K UHD UPSCALING: See what you’ve been missing on a crisp, clear picture that’s 4x the resolution of Full HD', 'Screen Size        43 Inches
Brand        SAMSUNG
Supported Internet Services        disney_plus,apple_tv,youtube,netflix
Display Technology        LED
Product Dimensions        7.7"D x 38"W x 23.6"H
Resolution        4K
Refresh Rate        60 Hz
Special Feature        Dynamic Crystal Color; Crystal Processor 4K; Smart TV with Multiple Voice Assistants; HDR
Model Name        LED UHD 8 Series
Included Components        User Manual, E - Manual, OneRemote TM2180E with batteries, Power Cable', '23');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('114', 'SAMSUNG 32-Inch Class QLED Q60A Series - 4K UHD Dual LED Quantum HDR Smart TV with Alexa', '7', '7', '1.jpg', '23.000.000', '100% COLOR VOLUME WITH QUANTUM DOT: A billion stay-true shades of breathtaking color.
DUAL LED BACKLIGHT: Dedicated warm and cool LED backlights provide enhanced contrast.
QUANTUM HDR: Go beyond HDTV with an expanded range of color.
AIR SLIM DESIGN: Sleek and slim design.
QUANTUM PROCESSOR 4K LITE: Transform what you\'re watching to stunning 4K.
¹QLED televisions can produce 100% Color Volume in the DCI-P3 color space, the format for most cinema screens and HDR movies for television. ²32" Dual LED not available.
SMART TV WITH MULTIPLE VOICE ASSISTANTS: This TV comes with your favorite voice assistants built-in and ready to help. Choose from Bixby, Amazon Alexa or Google Assistant', 'Screen Size        32 Inches
Brand        SAMSUNG
Supported Internet Services        Netflix, Hulu, YouTube, and More
Display Technology        QLED
Product Dimensions        6.1"D x 28.5"W x 18.8"H
Resolution        4K
Refresh Rate        60 Hz
Special Feature        100% Color Volume with Quantum Dot; Dual LED; Quantum HDR; Quantum Processor 4K Lite
Model Name        QLED Q60 Series
Included Components        User Manual, E - Manual, Power Cable, SolarCell Remote™ TM-2180E', '15');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('115', 'SAMSUNG 85-Inch Class QLED Q80B Series - 4K UHD Direct Full Array Quantum HDR', '7', '25', '1.jpg', '52.000.000', 'DIRECT FULL ARRAY: Watch the deep blacks and bright whites pop from LED lights directly behind your screen.
QUANTUM PROCESSOR WITH 4K UPSCALING: Enjoy your picture automatically converted to stunning 4K by the intelligent processor.
QUANTUM HDR 12X | 8X: Watch how your picture deepens with an amazing range of immersive color.
DOLBY ATMOS AND OBJECT TRACKING SOUND: Sound that moves with the on-screen action.
REAL DEPTH ENHANCER: Experience depth and dimension on screen just like you do in real life.
100% COLOR VOLUME WITH QUANTUM DOT*:Bask in a billion shades of brilliant color at 100% Color Volume. Quantum Dot technology brings you a gorgeous picture by transforming light into lifelike color that always stays true. That means even as the scene gets brighter, the details stay bold. **QLED televisions can produce 100% Color Volume in the DCI-P3 color space, the format for most cinema screens and HDR movies for television.
SMART TV WITH MULTIPLE VOICE ASSISTANTS: This TV comes with your favorite voice assistants built-in and ready to help. Choose from Bixby, Amazon Alexa or Google Assistant', 'Screen Size        85 Inches
Brand        SAMSUNG
Supported Internet Services        Hulu
Display Technology        QLED
Product Dimensions        13.3"D x 74.5"W x 45.8"H
Resolution        4K
Refresh Rate        120 Hz
Special Feature        100% Color Volume with Quantum Dot; Real Depth Enhancer; HDR10+; Works with Google Assistant and Alexa, Direct Full Array; Quantum Processor with 4K Upscaling; Quantum HDR 12x100% Color Volume with Quantum Dot; Real Depth Enhancer; HDR10+; Works with Google Assistant and Alexa, Direct Full Array; Quantum Processor with 4K Upscaling; Quantum HDR 12x
Model Name        QN85Q80BAFXZA
Included Components        User Manual / E-Manual, SolarCell Remote™ TM-2280E, Power Cable', '28');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('116', 'LG 27LP600B-P 27 Inch Full HD (1920 x 1080) IPS TV Monitor with 5W x 2 Built-in Speakers, HDMI Input and Dolby Audio', '7', '34', '1.jpg', '22.000.000', '27” Full HD (1920 x 1080) IPS Display
5W x 2 Built-in Speakers
HDMI Input
Dolby Audio
Wall Mountable', '
Screen Size        27 Inches
Display Resolution Maximum        1920 x 1080
Brand        LG
Special Feature        Flat
Refresh Rate        75 Hz', '30');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('117', 'SAMSUNG NT678U HG55NT678UF 55" Smart LED-LCD TV - 4K UHDTV - Black', '7', '16', '1.jpg', '16.000.000', 'The 55" screen size is suitable for a large bedroom
16:9 aspect ratio to display content on full screen
Experience the ultimate home theater experience with Dolby Digital Plus sound system
DVB-T2 digital tuner to receive DTV channels
3840 x 2160 resolution and 2160p scan format for producing sharp and bright images
Direct LED backlight technology for a consistent picture quality from corner to corner
Features 3 x HDMI ports for delivering and transferring high-quality pictures and 3D sound effects simultaneously at a high-speed', '
Screen Size        55 Inches
Brand        SAMSUNG
Supported Internet Services        Netflix, Hulu, Browser
Display Technology        LED
Product Dimensions        54"D x 31"W x 5.05"H
Resolution        4K
Refresh Rate        60 Hz
Special Feature        Hybrid Log Gamma, Film Mode, UHD Mastering Engine, Closed Caption, Clock Backup Supply, Subtitle, LYNK REACH 4.0, Screwed Battery Cover, PurColor, Auto Channel Search, Auto Motion Plus, Audio Return Channel (ARC), Wake-up Timer, Energy Saving Mode, Parental Control, Auto Power Off, Connect Share, Mega Contrast, Game Mode, LYNK DRM, Hospitality Home Menu, Welcome Message, Soundbar Compatible, Progressive Scan, Hotel Channel List, On/Off Timer, High Dynamic Range (HDR), My Channel, Digital Clean View, On Screen Display, USB Cloning, Smoovie Compatible, Auto Source Mode, Security ModeHybrid Log Gamma, Film Mode, UHD Mastering Engine, Closed Caption, Clock Backup Supply, Subtitle, LYNK REACH 4.0, Screwed Battery Cover, PurColor, Auto Channel Search, Auto Motion Plus, Audio Return ChanModel Name        NT678U', '7');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('118', 'Westinghouse 24" HD Small TV with Built-in DVD and V-Chip, Slim, Compact 720p LED Flat Screen TV', '7', '25', '1.jpg', '22.000.000', 'High Definition Entertainment - Enjoy a range of vivid colors and crisp visual details with our 24-inch DVD combo Westinghouse TV. This TV LED backlit screen has reduced motion blur with 720p HD resolution for an immersive viewing experience.
Built-in DVD Player - Our 24 in TV comes with its very own DVD player. The built-in DVD feature of this 24” TV lets you play movies or shows with true HD images and sounds without the need for extra devices or cords.
HDMI & USB Compatible - This flat screen HD TV is equipped with all the connectivities required to use your favorite streaming device. It easily supports HDMI, USB, VGA, Digital TV Tuner connectivity, and HD video game consoles for quick, convenient playing.
Parental Control Features - Monitor what your kids are watching with our TV with DVD player. The built-in V-chip of this TV for bedroom allows parents/guardians to block content based on program ratings and check on the parental guidelines of unfamiliar shows.
Excellent, Space-Saving Design - The compact, flexible design of this small flat screen TV will fit in any small space from your office, kids’ room, garage, kitchen, or RV (12V inverter required).', '
Screen Size        23.6 Inches
Brand        Westinghouse
Supported Internet Services        Browser
Display Technology        LED
Product Dimensions        6.3"D x 21.6"W x 14.5"H
Resolution        720p
Refresh Rate        60 Hz
Special Feature        parental controls V-chip, TV, dvd player, portable, lightweight, LED
Model Name        D2
Connectivity Technology        USB', '27');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('119', 'SAMSUNG 55-Inch Class QLED Q60B Series - 4K UHD Dual LED Quantum HDR Smart TV with Alexa Built-in (QN55Q60BAFXZA, 2022 Model)', '7', '25', '1.jpg', '27.000.000', '100% COLOR VOLUME WITH QUANTUM DOT: Bask in a billion shades of brilliant color at 100% Color Volume, that stay true even in bright scenes.
QUANTUM PROCESSOR LITE WITH 4K UPSCALING: Everything on your screen is upgraded to 4K resolution by a smart, powerful processor.
DUAL LED: Enjoy natural, real-life colors with dedicated warm and cool Dual LED backlights.
QUANTUM HDR: Go beyond HDTV with Quantum HDR that delivers an expanded range of color and contrast.
SMART TV WITH MULTIPLE VOICE ASSISTANTS: Just speak up—your favorite Voice Assistant is built in and ready to help.', '
Screen Size        55 Inches
Brand        SAMSUNG
Supported Internet Services        Netflix
Display Technology        QLED
Product Dimensions        8.8"D x 48.5"W x 29.4"H
Resolution        4K
Refresh Rate        60 Hz
Special Feature        Object Tracking Sound Lite; 100% Color Volume with Quantum Dot; Filmmaker Mode, Quantum Processor Lite with 4K Upscaling; Quantum HDR; Smart TV with Multiple Voice Assistants; Motion XceleratorObject Tracking Sound Lite; 100% Color Volume with Quantum Dot; Filmmaker Mode, Quantum Processor Lite with 4K Upscaling; Quantum HDR; Smart TV with Multiple Voice Assistants; Motion Xcelerator
Model Name        QN55Q60BAFXZA
Included Components        Samsung Smart Control, User Manual, Power Cable, E-Manual, Remote Controller', '6');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('120', 'Amazon Fire TV 75" Omni QLED Series 4K UHD smart TV + 4-Year Protection Plan', '7', '34', '1.jpg', '23.000.000', 'This bundle includes an Amazon Fire TV 75" Omni QLED Series and 4-year Protection Plan.
Protection Plan covers product breakdowns during normal use, plus mechanical and electrical failures. Includes 24/7 support and 2-day replacements.
Your Protection Plan has no deductibles or shipping fees. Cancel anytime, full refund in the first 90 days.
Your Protection Plan will be delivered via e-mail within 24 hours.
Stunning 4K Quantum Dot Display (QLED) - Makes movies, shows, and live sports pop in brighter, richer, and more lifelike colors.
Advanced HDR - Scenes leap off the screen in deep, realistic color with Dolby Vision IQ and HDR10+ Adaptive. HDR10 and HLG are also supported.
Adaptive Brightness - Fire TV automatically optimizes the brightness of movies and shows through a built-in sensor that detects the lighting in your room.
Bolder contrast - Experience deeper darks and brighter whites with full array local dimming in 96 individual zones enhancing contrast.
Fire TV Ambient Experience - Turns your TV screen into a canvas for displaying over a thousand pieces of free artwork, personal photos, helpful Alexa widgets, and more.', 'This bundle includes an Amazon Fire TV 75" Omni QLED Series and 4-year Protection Plan.
Protection Plan covers product breakdowns during normal use, plus mechanical and electrical failures. Includes 24/7 support and 2-day replacements.
Your Protection Plan has no deductibles or shipping fees. Cancel anytime, full refund in the first 90 days.
Your Protection Plan will be delivered via e-mail within 24 hours.
Stunning 4K Quantum Dot Display (QLED) - Makes movies, shows, and live sports pop in brighter, richer, and more lifelike colors.
Advanced HDR - Scenes leap off the screen in deep, realistic color with Dolby Vision IQ and HDR10+ Adaptive. HDR10 and HLG are also supported.
Adaptive Brightness - Fire TV automatically optimizes the brightness of movies and shows through a built-in sensor that detects the lighting in your room.
Bolder contrast - Experience deeper darks and brighter whites with full array local dimming in 96 individual zones enhancing contrast.
Fire TV Ambient Experience - Turns your TV screen into a canvas for displaying over a thousand pieces of free artwork, personal photos, helpful Alexa widgets, and more.', '28');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('121', 'SAMSUNG 85-Inch Class Neo QLED 8K QN900A Series UHD Quantum HDR', '7', '34', '1.jpg', '17.000.000', 'EXTRAORDINARY CONTRAST: See how deep blacks and bright whites make the difference with Mini LEDS & Quantum Matrix Technology Pro
8K UPSCALING: Whatever you watch, the Neo Quantum Processor 8K automatically converts your content to stunning 8K*
INFINITY SCREEN: Immerse yourself in the stunning sharpness and depth of 8K on an expansive, nearly edge-to-edge screen
SOUND THAT MOVES YOU: Discover TV audio that follows the action on screen with Object Tracking Sound Pro
LIFELIKE BRILLIANCE: Experience a truly jaw-dropping spectrum of vibrant colors with Quantum HDR 64X
FOUR TIMES MORE PIXELS: More pixels allow more details and with Real 8K Resolution you get 4X more pixels than a 4K UHD TV*
ALEXA BUILT-IN: Just ask Alexa, Google Assistant or Bixby to open your apps, change channels, control your smart home and more', '
Screen Size        85 Inches
Brand        SAMSUNG
Supported Internet Services        Netflix, Prime Video and Google TV
Display Technology        Neo QLED
Product Dimensions        13.5"D x 73.9"W x 45.1"H
Resolution        8K
Refresh Rate        120 Hz
Special Feature        Quantum Matrix Technology Pro; Neo Quantum Processor 8K; Infinity Screen; Quantum HDR 64X; Real 8K ResolutionQuantum Matrix Technology Pro; Neo Quantum Processor 8K; Infinity Screen; Quantum HDR 64X; Real 8K Resolution
Model Name        Q900A Neo QLED 8K
Included Components        Power Cable, User Manual, Solar Cell Remote controller, Samsung smart control,Attachable Slim One ConnectPower Cable, User Manual, Solar Cell Remote controller, Samsung smart control,Attachable Slim One Connect', '5');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('122', 'SAMSUNG 32" M80B UHD HDR Smart Computer Monitor Screen with Streaming TV, Slimfit Camera Included', '7', '34', '1.jpg', '21.000.000', 'SMART TV EXPERIENCE: Enjoy Netflix, YouTube and other streaming services by simply connecting the monitor to WiFi; Samsung TV Plus also offers free live and on-demand content with no downloads or sign-up needed, while Universal Guide provides personalized content recommendations
ICONIC SLIM DESIGN: The Smart Monitor is built with your lifestyle in mind, delivering a more cutting-edge design than ever; With an ultra-slim flat back, neat camera design and beautiful colors, the monitor offers a minimalist look that suits any environment and enhances your setup with super style
PC-LESS PRODUCTIVITY: Browse the web, edit documents and work on projects, all without the need for a separate PC; With new Workmode, you can also remotely access another PC, use Microsoft Office 365 programs and even connect to Samsung mobile devices with Samsung DeX for seamless working
SLIMFIT CAMERA: The SlimFit camera with tilt functionality allows you to create the perfect angle while using your favorite video call apps like Google Duo, which can be accessed directly through the monitor; Plus, the camera cover and option to fully detach always protect your privacy
IoT HUB: Turn your Smart Monitor into a control center for the home by connecting it to your IoT home products with SmartThings; Relax by turning off the lights, pulling down the blinds and setting the thermostat to the perfect temperature all with the Smart Monitor for a perfectly relaxed evening
MULTIPLE VOICE ASSISTANTS: With the Far Field Voice feature, activate your voice assistant just by speaking; Directly command the monitor – even at a distance – and tell it what you need; The Smart Monitor supports both Bixby and Amazon Alexa
MOBILE CONNECTIVITY: With AirPlay integration, you can wirelessly connect Apple devices to the Smart Monitor and view on a bigger screen; Enjoy your favorite content from an iPhone, iPad, and Mac on the Smart Monitor and even mirror apps, documents, and websites
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Screen Size        32 Inches
Brand        SAMSUNG
Special Feature        Built-In Webcam, Height Adjustment, USB Hub, High Dynamic Range, Built-In Speakers
Refresh Rate        60 Hz
Connectivity Technology        US', '17');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('123', 'LG 86QNED90UPA Alexa Built-in QNED MiniLED 90 Series 86" 4K Smart UHD NanoCell TV (2021)', '7', '7', '1.jpg', '33.000.000', 'QNED MINI LED DISPLAY: The LG Quantum Dot NanoCell display combines NanoCell and miniLED technology for brilliantly bright colors and a higher contrast ratio for deeper blacks.
QUANTUM DOT NANOCELL COLOR TECHNOLOGY: A color innovation that needs to be seen. Two color technologies – Quantum Dot and NanoCell Plus – combine to deliver a more stunning picture with richer, more accurate colors.
MINI LED BACKLIGHT: New MiniLED technology is a giant leap forward in LCD TV. Tiny LEDs offer a more detailed control, a brighter picture and an ultra-high contrast ratio for smooth, life-like images that seem to jump out of the screen and into your room.
120HZ REFRESH RATE: LG TVs are great for watching your favorite sports or playing your favorite games thanks to a 120Hz native refresh rate – the highest native rate for 4K.
FULL ARRAY DIMMING PRO: Catch every detail. Full Array Dimming Pro\'s unique dimming zones deliver precise backlight control and an ultra-high contrast ratio for deeper blacks and more vivid colors for an impeccable picture.', '
Screen Size        85.6 Inches
Brand        LG
Supported Internet Services        Netflix, Prime Video, Hulu, Vudu, YouTube
Display Technology        LED
Product Dimensions        1.2"D x 75.5"W x 43.2"H
Resolution        4K
Refresh Rate        120 Hz
Special Feature        App Store, Film Mode, Alexa, HDR Gaming Interest Group (HGiG), Sound Sync, IP Control, Audio Return Channel (ARC), 4K Cinema HDR, Gallery Mode, FreeSync Premium, Game Mode, Quantum Dot Technology, Full Array Dimming Pro, Google Assistant, Sport Mode, Progressive Scan, HomeKit, 4K AI Upscaling, High Dynamic Range (HDR), Auto Low Latency Mode (ALLM), In-plane Switching (IPS) Technology, Dolby Vision IQ, ThinQ AI, Web Browser, RF Antenna InputApp Store, Film Mode, Alexa, HDR Gaming Interest Group (HGiG), Sound Sync, IP Control, Audio Return Channel (ARC), 4K Cinema HDR, Gallery Mode, FreeSync Premium, Game Mode, Quantum Dot Technology
Model Name        90
Included Components        Power Cable, Remote Control, Stand', '16');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('124', 'Sony 75 inch TV Bundle with Sound Bar: 75 inch 4K Ultra HD', '7', '16', '1.jpg', '22.500.000', 'HANDPICKED BY AMAZON: They did the research so you don’t have to.
FULL ARRAY LED CONTRAST – Precisely controlled backlighting delivers deep black, high peak brightness and is further enhanced by XR Contrast Booster 10 for real-life depth and detail.
INTELLIGENT TV PROCESSING – The Cognitive Processor XR understands how humans see to deliver intense contrast with deep blacks, high peak brightness, and natural colors.
PERFECT FOR PLAYSTATION 5 – Take your gaming to the next level with input lag as low as 8.5ms and BRAVIA XR exclusive features for the PlayStation 5 – Auto HDR Tone Mapping & Auto Genre Picture Switch.
FEATURES SPECIFIED IN HDMI 2.1– Get the advantage in high-performance gaming on BRAVIA XR Smart TVs with HDMI 2.1 features such as 4K/120, VRR, and ALLM.
WIDE SPECTRUM OF COLORS – Rediscover everything you watch with billions of accurate colors and see impressive picture quality that is natural and beautiful, enhanced by XR Triluminos Pro.
PREMIUM SMART TV– Google TV with Google Assistant organizes your favorite content all in one place. Stream from Prime Video, Netflix, Disney+, Apple TV, HBO Max, Peacock and many more. Also, stream from your Apple device with AirPlay 2 support.
MOVIES INCLUDED WITH BRAVIA CORE – Bring the cinematic experience home. Enjoy streaming high-quality 4K UHD quality movies included with the BRAVIA CORE app, exclusively on select Sony Smart TVs.
WORKS WITH ALEXA – Through an Alexa enabled device, ask Alexa to change channels, adjust volume, and turn your TV on/off.
ENHANCED ENTERTAINMENT – Experience immersive and engaging cinematic content as the creator intended with support for Dolby Vision, IMAX Enhanced, and Netflix Adaptive Calibrated Mode.', '
Screen Size        75 Inches
Brand        Sony
Supported Internet Services        YouTube, Browser
Display Technology        LED
Resolution        4K
Special Feature        Flat
Model Name        BRAVIA XR
Mounting Type        Table Mount
Year        2022', '1');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('125', 'GTUOXIES 100 Inches 4K Ultra HD LED TV Super Screen Stunning Display High Dynamic Range Full Array LED', '7', '34', '1.jpg', '150.000.000', 'Captivating Ultra HD: The TS100’s brilliant ultra HD display goes beyond 4 times the resolution of Full HD, delivering astonishingly vivid images, depth, true-to-life colours and an incredibly GTUOXIES 3840x 2160 resolution that you’ve never seen before. Pixel by pixel.
Not just designed a breathtakingly large display: It’ve brought to you visionary design that allows you to capture nuances that escape the naked eye, colours and clarity that awaken all your senses, picture quality that’s the best in its class and a future-ready Ultra HD world that delivers an overwhelming immersive experience.
Fan-less Design: The fan-less architecture is also great for maintenance as the TS100 comes with zero mechanical air-ventilation fans.
Active Contrast: Experience exceptional levels of colour variety, precision, depth and contrast. GTUOXIES delivers a world of brilliant UHD picture quality with incredibly GTUOXIES definition and clarity down to the tiniest detail.
24/7 Use: With high brightness and superior durability, GTUOXIES’s LED displays are id', '
Screen Size        100 Inches
Brand        GTUOXIES
Supported Internet Services        Netflix, YouTube, Browser
Display Technology        LCD
Product Dimensions        3.66"D x 88.81"W x 52.71"H
Resolution        4K
Refresh Rate        120 Hz
Special Feature        平顶
Included Components        Blu-ray
Connectivity Technology        Bluetooth, Wi-Fi, Ethernet, HDMI', '23');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('126', 'VIZIO 65-Inch M-Series 4K QLED HDR Smart TV with Voice Remote, Dolby Vision, HDR10+', '7', '16', '1.jpg', '24.000.000', '4K Ultra HD - Over 8 million pixels for breathtaking detail. 4 times the resolution of 1080p!
Dolby Vision Bright Mode You’ll see even more lifelike accuracy, color saturation, black detail, and brightness in Dolby Vision Bright picture mode, thanks to color pixel tuning that ramps up depth and detail to new heights. M-Series also supports HDR10/+ and HLG formats.
Quantum Color - Next-generation QLED delivers cinematic color with over a billion hues of vibrant color.
Full Array Backlight - Evenly distributed LEDs across the screen\'s backlight deliver superior light uniformity and picture performance.
IQ Active Processor - Delivers superior picture processing, and a powerful and intelligent 4K upscaling engine that makes your favorite HD entertainment look spectacular in 4K.', 'Screen Size        65 Inches
Brand        VIZIO
Supported Internet Services        Apple TV+, Crackle, Discovery+, Disney+, Fandango, fuboTV, HBO Max, Hulu, iHeartRadio, Netflix, Pandora, Paramount+, Peacock, Prime Video, Redbox, Sling TV, STARZ, TikTok, Tubi, Vudu, XUMO, YouTube, YouTube TVApple TV+, Crackle, Discovery+, Disney+, Fandango, fuboTV, HBO Max, Hulu, iHeartRadio, Netflix, Pandora, Paramount+, Peacock, Prime Video, Redbox, Sling TV, STARZ, TikTok, Tubi, Vudu, XUMO, YouTube, YouTube… See more
Display Technology        QLED
Product Dimensions        11.8"D x 56.84"W x 35.38"H
Resolution        4K
Refresh Rate        60 Hz
Special Feature        Hundreds of Free Channels with WatchFree+, Quantum Color, Dolby Vision HDR, IQ Active Display Processor, Spatial Scaling EngineHundreds of Free Channels with WatchFree+, Quantum Color, Dolby Vision HDR, IQ Active Display Processor, Spatial Scaling Engine
Model Name        M65Q6-J09
Included Components        Power Cable, Voice Remote, Stand', '9');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('127', 'Sony A90J 83 Inch TV: BRAVIA XR OLED 4K Ultra HD Smart Google TV with Dolby Vision HDR', '7', '16', '1.jpg', '32.500.000', 'COGNITIVE PROCESSOR XR – Revolutionary TV processing technology that understands how humans see and hear to deliver intense contrast with pure blacks, high peak brightness, and natural colors.
XR TRILUMINOS PRO - Rediscover everything you watch with billions of accurate colors and see pictures that are natural and beautiful to the human eye.
Enjoy wireless personalized home theater audio
Surround yourself in audio with Sony’s 360 Spatial Sound Personalizer technology (* Firmware update available by Jan 2022 and is required to enjoy 360 Spatial Sound on BRAVIA XR. Network connection required for firmware update of BRAVIA XR)', 'Screen Size        83 Inches
Brand        Sony
Supported Internet Services        Google TV;Amazon Instant Video;Hulu;Netflix;YouTube
Display Technology        OLED
Resolution        4K
Refresh Rate        120 hertz
Special Feature        Flat
Included Components        Power Cable;Remote Control;Stand
Connectivity Technology        Bluetooth
Year        2021', '27');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('128', 'SAMSUNG 65-Inch Class QLED Q80A Series - 4K UHD Direct Full Array Quantum HDR 12x Smart TV with Alexa', '7', '7', '1.jpg', '27.000.000', 'HANDPICKED BY AMAZON: They did the research so you don’t have to.
DIRECT FULL ARRAY BACKLIGHTING: Experience deep blacks and pure whites with an in-screen LED array.
OBJECT TRACKING SOUND (OTS): Sound that moves with the action. 50" has OTS Lite"
QUANTUM PROCESSOR 4K: Elevate your picture to 4K with machine based AI.
100% COLOR VOLUME WITH QUANTUM DOT: A billion stay-true shades of breathtaking color. QLED televisions can produce 100% Color Volume in the DCI-P3 color space, the format for most cinema screens and HDR movies for television.
QUANTUM HDR 12X: Cinematic detail with wider range of cinematic colors. The range of Quantum HDR claims luminance based on internal testing standards and is subject to change according to viewing environment or specific conditions.
ALEXA BUILT-IN: Ask more from your TV. Just ask Alexa to open apps, change the channel, search for movies and shows, play music, control your smart home devices and more. To talk to Alexa, press and hold the mic button on your remote. If you have hands-free enabled just say, "Alexa" and ask a question.
TV without stand : 56.9 x 32.7 x 2.2TV with stand : 56.9 x 35.7 x 11.4Stand footprint : 15.4 x 9.2 x 11.4', 'Screen Size        65 Inches
Brand        SAMSUNG
Supported Internet Services        Streaming Services
Display Technology        QLED
Product Dimensions        11.4"D x 56.9"W x 35.7"H
Resolution        4K
Refresh Rate        120 Hz
Special Feature        Direct Full Array; Object Tracking Sound; Quantum Processor 4K, 100% Color Volume with Quantum Dot; Quantum HDR 12X; Adaptive PictureDirect Full Array; Object Tracking Sound; Quantum Processor 4K, 100% Color Volume with Quantum Dot; Quantum HDR 12X; Adaptive Picture
Model Name        QLED Q80 Series
Included Components        User Manual, E - Manual, Power Cable, SolarCell Remote™ TM-2180E', '10');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('129', 'LG 75QNED99UPA Alexa Built-in QNED MiniLED 99 Series 75" 8K Smart', '7', '25', '1.jpg', '180.000.000', 'REAL 8K QUANTUM DOT NANOCELL DISPLAY: See brighter depth and detail. Thanks to Real 8K, the best in resolution, combined with our best in backlighting. Over 33 million pixels bring your content to life with unbelievable detail. Games, movies and shows pop like never before with Full Array Dimming Pro, our most advanced LED technology.
MINI LED: New MiniLED technology is a giant leap forward in LCD TV. MiniLED technology uses smaller LEDs to maximize precise luminance, a higher level of contrast and deeper blacks due to increased dimming zones.
a9 GEN 4 AI PROCESSOR 8K: The a9 Gen 4 AI Processor 8K is specifically engineered to power 8K performance, detecting and enhancing every detail you see on screen. Your non-8K content looks like near 8K with AI 8K Upscaling. Plus, AI Picture Pro and AI Sound Pro give you clearer, smoother images and maximum sound quality.
HOME CINEMA EXPERIENCE: Get breathtaking picture and audio that makes you feel like you\'re in the action with Cinema HDR, Dolby Vision IQ & Dolby Atmos. See movies exactly how directors intended with Filmmaker Mode.And with built-in access to Netflix, Prime Video, Apple TV+, Disney+ and LG channels, your favorite content is at your fingertips.
ULTIMATE GAMEPLAY: Experience gaming like never before with features that help you beat the competition. Game Optimizer gives you easier access to all your game settings, the latest HDMI allows for fast gaming speeds and you\'ll get low input lag and fast response times with Auto Low-Latency Mode and HGiG.', 'Screen Size        75 Inches
Brand        LG
Supported Internet Services        YouTube, Browser
Resolution        8K
Special Feature        Flat
Year        2018
Speaker Type        Soundbar
Wattage        520 watts', '8');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('130', 'Pamapic Outdoor Sectional Furniture for 6,Wicker Patio Furniture,All-Weather Gray PE Rattan Sectional Sofa', '6', '15', '1.jpg', '12.000.000', 'STABLE & FIRM: Corner sofa of patio sectional set with four reclining levels to lie down. Feel free to enjoy leisure time at your desired angle. Clips connect the sections and fastening strips prevent cushions from sliding.
SECTIONAL & L SHAPED OUTDOOR SOFA:This 7 piece couch can be assembled in nearly unlimited configurations to fit your space and your needs. You get to choose the perfect combination for this outdoor furniture set and then change it as many times as you like.
COMFORT & MACHINE WASHABLE: Cushions of wicker conversation set can relax you. They have removable, machine-washable covers that are easy to clean.
EASY TO INSTALL & FREE COMBINATION:This patio set is easy to assemble by following the included instructions and comes with everything that you need to put it together and start using it immediately. Not to mention there are plenty of different configurations that you can use to make this outdoor sofa work for you and your family.
PACKAGE DETAILS: Our product is delivered with 3 boxes. You may not get all boxes at the same time. We recommend assembling the set after receiving all boxes. Package 1 size: 29.13"×28.74"×14.96", Package 2 size: 31.49"×29.13"×16.53", Package 3 size: 31.89"×27.75"×17.72"', 'Color        Silver Gray
Brand        Pamapic
Size        7 PCS
Item Weight        49 Pounds
Assembly Required        Yes', '6');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('131', 'Acanva Luxury Modern Style Living Room Upholstery Curved Sofa with Chaise 2-Piece Set', '6', '15', '1.jpg', '8.300.000', 'AXF320-RCG Dimensions: 2-Seater One Arm: W56.3 x D40.2 x H27.6 | Chaise: W90.2 x D68.9 x H27.6 | Overall: W146.5 x D68.9 x H27.6
ENJOY YOUR LIFE - With a streamlined yet one-piece silhouette, the living room sofa attracts guests to sit down and relax. Bring luxurious comfort and modern fresh style to your home office with this Acanva dark gray sofa couch.
PEARL BOUCLE SOFA - Its pearl boucle fabric upholstery brings you the soft feeling of being on the back of a lamb and its curved retro design allows for a timeless look for years.
FIRM AND COMFORTABLE - Complete with a larch wood frame and soft pocket spring support structure, this modular sofa 2 piece set provides a premium seating experience thanks to its high-resilience padding, wide deep, and four throw pillows.
NO ASSEMBLY - The sofa for living room, bedroom which easy to care for and maintenance, spot clean with a damp cloth. Ships in several boxes, may ship separately.', '
Product Dimensions        49.6"D x 135.8"W x 27.6"H
Color        Dark Grey
Brand        Acanva
Style        Retro
Type        Sectional
Room Type        Living Room, Bedroom, Home Office
Seating Capacity        3
Shape        L-Shape
Arm Style        Curved
Frame Material        Wood', '27');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('132', 'HomePop Swoop Arm Living-Room-Chairs, Velvet Navy', '6', '33', '1.jpg', '730.000', '100% Polyester
ACCENT CHAIRS: The perfect seating solution for any room of your home, our stylish built to last Swoop Arm Accent Chair seamlessly compliments any existing living room furniture or even bedroom furniture
ACCENT CHAIRS FOR BEDROOM AND LIVING ROOM: Created with a soft and durable fabric, our Classic Accent Chair is perfectly completed with wood legs to offer a timeless style | When paired together our accent chairs set of 2 provide extra seating for your home
ACCENT CHAIR LIVING ROOM: Weighing at 30.8 lbs our Accent Chairs with Arms supports a capacity of up to 250 lbs
ACCENT FURNITURE CARE & CLEANING: Super easy to assemble and maintain | Spot clean only
ACCENT CHAIR DIMENSIONS: 33.25 Inches High x 25 Inches Wide x 27.75 Inches Deep
Note : To ensure proper assembly, please follow all steps provided in assembly video and the installation manual (provided in pdf below)', 'Color        Velvet Navy
Brand        HomePop
Product Dimensions        27.75"D x 25"W x 33.25"H
Style        Nautical, Transitional
Special Feature        Arm Rest, Cushion Availability', '12');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('133', 'Natural Walnut Coated Coffee Table, Custom Designed Coffee Table, Wooden Rustic Coffee Table', '6', '24', '1.jpg', '1.700.000', 'When you order the coffee table in the picture, we will send you the disassembled version of the stand, the screws you will use for assembly, the screwdriver to tighten the screws and a video explaining how it is set up.

Our aim is to make you feel special by bringing a stylish touch to your furniture used in daily life. You can be sure that you will use your coffee tables produced by our talented craftsmen for many years.

✔It is a special design.

✔It will add comfort and aesthetics to your home.

✔It is made of old and unproductive trees without harming the nature.

✔Four sides have extra protection, strong packaging covered with styrofoam.

✔With its robust and high quality packaging, it is delivered to all parts of the world without any problems.

✔Small touches will reflect the difference to your home.

✔It will be shipped within 1-2 business days.

✔4mm tempered smoked glass is used.

✔Resistant to water, shock and humidity

✔Natural walnut coated', 'Dimensions

Height : 16.53 Inches

Width: 35.43 Inches

Depth 35.43 Inches

Weight: 28.8 Kilograms', '18');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('134', 'XWWDP Mobilya Mesillas Noche para El Chevet Meuble Nachtkastje Bedroom Furniture', '6', '6', '1.jpg', '5.700.000', 'Material: artificial board
Style: simple and modern
Size: 33*28*42cm
Whether to assemble: assembly
Applicable object: Adult', '
Color        Onecolor
Shape        Rectangular
Table design        Nightstand
Special Feature        Portable
Style        Modern', '2');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('135', 'Meridian Furniture Luna Collection Modern | Contemporary Clear Acrylic Accent Swing Chair with Gold Metal Base and Durable Fabric Seat', '6', '24', '1.jpg', '13.900.000', 'Velvet
Overall Dimensions: 41.5" W x 29.5" D x 64" H
Clear Acrylic Swing
Gold Metal Base and Frame
White Durable Fabric Seat
Contemporary Design', 'Color        White, Gold Finish
Brand        Meridian Furniture
Product Dimensions        29.5"D x 41.5"W x 64"H
Style        Contemporary
Material        Stainless Steel', '20');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('136', 'Meridian Furniture Vector Collection Modern | Contemporary Upholstered Bed with Custom Base', '6', '6', '1.jpg', '27.000.000', 'Overall Dimensions: 81.5" W x 85.5" D x 68" H
Headboard Height: 68" / Footboard Height: 16" / Sideboard Height: 16"
Leg Height: 4"
Full Slats (Box Spring Not Required)
Height From Floor to Top of Slats: 12.6" H', 'detail', '25');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('137', 'ORIENTAL Furniture Red Lacquer Half-Round Landscape Cabinet', '6', '15', '1.jpg', '14.500.000', 'Each piece is hand finished, so variations in design are expected
No two are exactly alike
Finished in a traditional Chinese lacquer
Hand-crafted by artisans in Guangdong', '
Brand        ORIENTAL Furniture
Color        Red
Material        Wood
Product Dimensions        14"D x 36"W x 36"H
Mounting Type        Floor Mount', '6');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('138', 'South Shore Versa 2-Door Armoire with Drawers, Gray Maple', '6', '33', '1.jpg', '15.000.000', 'Laminated Particleboard
Note : To ensure proper assembly, please follow all steps provided in the installation manual (provided in pdf below)
Home storage: featuring 2 large drawers and 4 storage spaces with 3 adjustable shelves, The Wardrobe provides extra concealed storage space in your Bedroom or any room around your home.
Contemporary style: this robust Armoire modern color and shaping are finished off with contrasting metal handles making it a stylish addition to any home decor.
Maximum capacity: make the most of the Armoire generous storage by adding South Shore felt baskets. Each shelf can support up to 25lb of clothing, bed linen, books and more.
: made in North American with non-toxic laminated particleboard, this piece of Furniture meets or exceeds all North American safety standards.
5-Year limited : shop with confidence knowing that We proudly stand behind this piece of Furniture with a full 5-year limited . Assembly is required.
Ships in several boxes, may ship separately
', 'Brand        South Shore
Color        Gray Maple
Material        Engineered Wood
Recommended Uses For Product        Tools
Product Dimensions        19.38"D x 33.75"W x 63.5"H', '26');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('139', '"South Shore Versa 2-Door Armoire with Drawers, Weathered Oak"','6', '15', '1.jpg', '16.000.000', 'Laminated Particleboard
HOME STORAGE: Featuring 2 large drawers and 4 storage spaces with 3 adjustable shelves, the wardrobe provides extra concealed storage space in your bedroom or any room around your home.
CONTEMPORARY STYLE: This robust armoire’s modern color and shaping are finished off with contrasting metal handles making it a stylish addition to any home decor.
MAXIMUM CAPACITY: Make the most of the armoire’s generous storage by adding South Shore felt baskets. Each shelf can support up to 25lb of clothing, bed linen, books and more.
ECO-FRIENDLY: Made in North America with non-toxic laminated particleboard, this piece of furniture meets or exceeds all North American safety standards.
5-YEAR LIMITED WARRANTY: Shop with confidence knowing that we proudly stand behind this piece of furniture with a full 5-year limited warranty. Assembly is required.
Ships in several boxes, may ship separately', '
Brand        South Shore
Color        Weathered Oak
Material        Engineered Wood
Product Dimensions        19.5"D x 33.75"W x 63.5"H
Mounting Type        Wall Mount', '25');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('140', 'South Shore Acapella Wardrobe Armoire, Pure Black', '6', '33', '1.jpg', '14.500.000', 'Laminated Particleboard
VERSATILE DESIGN: Framed door and drawers with streamlined edges give this wardrobe a transitional style, making it suitable for kids or adults bedrooms, or any other room in your home.
GENEROUS STORAGE: Combining adjustable storage shelves and large drawers with metal slides, the wardrobe is ideal for storing clothing, sweaters, linen, toys and more.
FULL LENGTH HANGING: Behind the wardrobe door is a metal rod supplying a convenient full length hanging space ideal for longer clothing items, and 2 hooks for scarves, ties and neckwear.
ECO-FRIENDLY: Made in North America with non-toxic laminated particleboard, this piece of furniture meets or exceeds all North American safety standards.
5-YEAR LIMITED WARRANTY: Shop with confidence knowing that we proudly stand behind this piece of furniture with a full 5-year limited warranty. Assembly is required.
Ships in several boxes, may ship separately', '
Brand        South Shore
Color        Pure Black
Material        Engineered Wood
Recommended Uses For Product        Tools
Product Dimensions        ', '8');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('141', 'SOFTTOUCH 4728595N Heavy Duty Self Stick Felt Furniture Pads to Protect Hardwood Floors from Scratches, 3/4 Inch, Brown, 20 Count', '6', '6', '1.jpg', '900.000', 'PROTECT YOUR HARD SURFACES - Everyday use and movement of furniture can be damaging your hard floor surfaces. These SoftTouch Felt Pads to protect your beautiful floors from scratches
REDUCE SCRATCHING AND NOISE - Use these round felt pads to reduce friction and noise while moving furniture and protect your hardwood, ceramic, tile, linoleum floors and all other hard surfaces from unsightly scratches and damage
ELIMINATE NOISE FROM EVERYDAY USE - Never again hear the annoying scraping sound of a chair being pushed against a hard surface – round felt pads help reduce noise from everyday use
HEAVY DUTY, PERFECT FOR ALL FURNITURE - The long-lasting, heavy-duty furniture round felt pads are super durable with a self-stick adhesive and can be used on tables, cedar chests, chairs, curio cabinets, desks and much more
VALUE PACK WITH 20 PIECES - Each value pack includes 20, 3/4" diameter round, brown color furniture felt pieces', 'Brand        SOFTTOUCH
Material        Felt, Plastic
Color        Brown
Shape        Round
Product Dimensions        1.4"L x 13.41"W x 11.51"Th', '1');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('142', 'Gorilla Grip Soft Faux Fur Area Rug, Washable, Shed and Fade Resistant, Grip Dots Underside', '6', '15', '1.jpg', '890.000', 'Ultra Soft and Thick High Pile Shag: premium shag yarns and thick high pile are extra soft and plush; cozy under bare feet and comfortable for the whole family to enjoy
Grip Dots on Underside: rug features a strong backing with thousands of tiny, durable dots; perfect for homes with kids and pets; built tough for daily use even in the busiest areas of your home
Plush High Density Foam Inner Layer: designed with an additional layer of high density foam for superior comfort; new and improved inner foam layer is now twice as thick as our previous area rug adding even more cushioning under foot
Machine Washable: no need to worry over life\'s spills and messes with this rug; simply machine wash or vacuum as often as needed; do not overstuff your machine
Fade Resistant: durable for everyday use, rug resists fading with lasting color even after multiple washes', '
Color        Red
Pattern        Solid
Shape        Rectangular
Special Feature        Washable
Material        Faux Fur', '7');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('143', 'Gray Round Rug for Bedroom,Fluffy Circle Rug 4\'X4\' for Kids Room,Furry Carpet for Teen\'s Room', '6', '6', '1.jpg', '360.000', 'Microfiber
⭐Fluffy Rug with Rubber Backing--The biggest feature of this material is its amazingly soft touch especially when you walk on it. This softness comes from a thousands of 1.7" plush fibers. Besides,we also features a rubber backing to keep it stay in place.
⭐Perfect for Kid\'s Room: Do you have a little one who is fond of playing on the floor? If so, This is a "must buy" for your kids! Its vivid color and furry appearance are perfect to enhance a kid\'s room. Meanwhile, our plush rug also offers warmth and comfort between kids and the cold floor during their happy time!
⭐How to Clean: We suggest you vacuum or wipe it. When cleaning is required,please hand wash and air-dry to make rug fluffy and a long service life. After the rug is air-dried, it’s better if you fluff it. Not machine washable.
⭐Attention: Since this rug comes with a vacuum Packaging bag, it’s normal to see the fibers on the rug is not fluffy enough and there will be some creases. Please lay it flat for 2 to 3 days and wait patiently for its recovery. We are sorry for any inconvenience.
⭐Service: We promise to return and exchange the products due to quality problems within 30 days. If you have any questions, Please email us and we will reply within 24 hours.', '
Color        Grey
Pattern        Solid
Shape        Round
Special Feature        Fluffy, Soft, Comfortable
Material        Rubber', '17');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('144', 'SAFAVIEH Adirondack Collection 6\' x 9\' Light Blue / Dark Blue ADR114F Floral Glam Damask Distressed', '6', '33', '1.jpg', '240.000', 'Polypropylene Pile
[STAIN RESISTANT & NON-SHEDDING]: Expertly machine-woven from enhanced synthetic durable fibers that are stain resistant and have a virtually non-shedding 0.45-inch thick pile
[KID AND PET-FRIENDLY]: Safe for everyday indoor high foot traffic and areas more prone to life’s unpredictable messes from kid or pet activity
[TRENDY STYLE]: Floral damask design beautifully enhances any room of the home, from the living room, dining room, bedroom, entryway, nursery, dorm room, study, home office, or eat-in kitchen
[EASY MAINTENANCE & DURABLE]: Stress-free cleaning includes regular vacuuming and gently blotting out minor stains with a mild detergent or carpet cleaner
[TRUSTED BRAND]: SAFAVIEH has been a trusted brand and leader in home furnishings for over 100 years, using their expertise in crafting trendy high-quality designs; Begin your rug search with Safavieh and explore over 100,000 products today', '
Color        Light Blue/Dark Blue
Pattern        Floral
Shape        Rectangular
Special Feature        Stain Resistant
Material        Polypropylene', '23');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('145', 'NICETOWN Nursery Essential Thermal Insulated Solid Grommet Top Blackout Curtains/Drapes', '6', '24', '1.jpg', '170.000', 'READY MADE: Set includes 2 BLACKOUT CURTAINS PANELS of 42" wide x 63" length with 6 grommets top each. Quality fabric without liner feels soft and heavy.
SERVE WELL: Curtains impede 85%-99% light and UV rays(Dark color curtains work well). Noise-reducing, better TV viewing thanks to the innovative triple weave technology.
ENERGY SMART: Triple weave blackout fabric balances room temperature by insulating against summer heat and winter chill. Protect your furniture, floors, and artwork from the ravages of the sun, the drapes will pay for themselves off over time.
GOOD TO GO: Thread trimmed and wrinkle-free, ring (1.6-inch inner diameter) fits easily with standard curtain rods. All sets for you to put them up right away.
EASY TO MAINTAIN: NICETOWN blackout curtains are made to last. Machine washable in cold water, tumble dry. Quick ironing or steam clean when needed. Visiting the NICETOWN store, find out your favorite curtains.', '
Brand        NICETOWN
Color        Baby Pink
Material        Fabric
Product Dimensions        63"L x 42"W
Opacity        Blackout', '3');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('146', 'Exclusive Home Catarina Layered Solid Room Darkening Blackout and Sheer Grommet Top Curtain Panel Pair', '6', '6', '1.jpg', '340.000', '100% Polyester
Imported
ELEGANT: The Catarina curtain panels offer both the function of a sateen woven blackout curtain paired with the fashion of a sewn in sheer panel for layered sophistication
ROOM DARKENING OPACITY: room darkening opacity is designed for light control and privacy.
GROMMET TOP FOR HANGING: These two curtain panels feature eight (8) matte silver grommets per curtain panel and fits a curtain rod up to 1.25" in diameter. Each panel is sewn with a 3.5" heading, 1" side hem, and 3" bottom hem.
SET OF TWO CURTAIN PANELS: Includes two (2) curtain panels, each measuring 52"x 84".
MULTIPLE STYLING OPTIONS: The Catarina curtain panels has a sophisicated layered look that offers multiple styling methods that will enhance your décor.
Minimizing sunlight exposure opacity', '
Brand        Exclusive Home Curtains
Color        Aqua
Material        Polyester
Product Dimensions        84"L x 51.97"W
Opacity        Blackout,Sheer', '23');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('147', 'Deco 79 Aluminum Drip Accent Table with Melting Designed Legs and Shaded Glass Top, 16" x 16" x 24", Silver', '6', '33', '1.jpg', '560.000', 'CONTEMPORARY THEME: A contemporary style offers neutral elements and basic forms with a bold design
MADE OF ALUMINUM: Contemporary round table is made of tempered glass and raw unfinished aluminum that features natural pock marks in the material for a slightly textured design
SILVER POLISHED FINISH: Round accent table showcases a textured aluminum body with pock marks in a glossy metallic gold finish, with an opaque black glass table top
FEATURES ROUND ACCENT TABLE: Silver end table carries a beautiful sculptural base that features dripping metal silhouette that serves as a striking embellishment and a solid structure with dark glass top
LARGE SIZE: Round side table measures 15.5"L x 15.5"W x 24.5"H and weighs 14.3 lbs', '
Product Dimensions        16"D x 16"W x 24.5"H
Color        Silver
Shape        Round
Brand        Deco 79
Table design        End Table', '1');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('148', 'Modern Day Accents Recodo, Silver, Aluminum, Side, Home or Office, Curved Foot Leg, Table, Round Tabletop', '6', '33', '1.jpg', '3.400.000', 'Dimensions: 19” H x 36” D x 36” L
Top surface supports up to 100 Ibs.
Tabletop made with tempered safety glass
Rubber capped feet help prevent scratched floors
Ships ready-to-assemble with step-by-step instructions', '
Product Dimensions        36"D x 36"W x 19"H
Color        Glass/Chrome
Shape        Round
Brand        Walker Edison
Table design        Coffee Table', '13');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('149', 'Deco 79 Wood Geometric Mirrored Accent Table with Crystal Embellishments, 19" x 19" x 23", Silver', '6', '24', '1.jpg', '3.250.000', 'GLAM THEME: Elevate your space and add a touch of luxury with this glam inspired piece
MADE OF MDF: A glam-inspired side table crafted of solid and polished wood and glass materials
SILVER AND CLEAR MIRRORED FINISH: This silver geometric mirrored side table comes in a sophisticated silver finish that suits any glam-inspired interior design
FEATURES SQUARE ACCENT TABLE: A wood and glass accent table featuring a geometric shape with reflective glass panels, round bead details, and rubber stoppers at the base
CONVENIENTLY SIZED: This item measures 18.63L x 18.63W x 23.38H inches, and weighs 51.50 lbs', '
Product Dimensions        18.63"D x 18.63"W x 23.38"H
Color        Silver
Shape        Square
Brand        Deco 79
Table design        Coffee Table
', '18');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('150', 'Beats Solo3 Wireless On-Ear Headphones - Apple W1 Headphone Chip, Class 1 Bluetooth, 40 Hours of Listening Time, Built-in Microphone - Black', '3', '3', '1.jpg', '2.300.000', 'High-performance wireless Bluetooth headphones
Features the Apple W1 chip and Class 1 wireless Bluetooth connectivity
With up to 40 hours of battery life, Beats Solo3 wireless is your perfect everyday headphone
Compatible with iOS and Android devices
With Fast Fuel, 5 minutes of charging gives you 3 hours of playback when battery is low
Adjustable fit with comfort-cushioned ear cups made for everyday use
Sleek, streamlined design that’s durable and foldable to go everywhere you do
Take calls, control your music, and activate Siri with the multifunction on-ear controls
The award-winning sound and design you’ve come to love from Beats, with premium playback with fine-tuned acoustics that maximize clarity, breadth, and balance
What\'s in the box - Beats Solo3 Wireless headphones, Carrying case, 3.5mm RemoteTalk cable, Universal USB charging cable (USB-A to USB Micro-B), Quick Start Guide, Warranty Card (USB power adapter sold separately)', 'Brand        Beats
Model Name        Beats Solo3
Color        Black
Form Factor        On Ear
Connectivity Technology        Bluetooth, USB', '3');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('151', 'Beats Solo3 Wireless On-Ear Headphones - Apple W1 Headphone Chip, Class 1 Bluetooth, 40 Hours of Listening Time, Built-in Microphone - Red', '3', '3', '1.jpg', '2.300.000', 'High-performance wireless Bluetooth headphones
Features the Apple W1 chip and Class 1 wireless Bluetooth connectivity
With up to 40 hours of battery life, Beats Solo3 wireless is your perfect everyday headphone
Compatible with iOS and Android devices
With Fast Fuel, 5 minutes of charging gives you 3 hours of playback when battery is low
Adjustable fit with comfort-cushioned ear cups made for everyday use
Sleek, streamlined design that’s durable and foldable to go everywhere you do
Take calls, control your music, and activate Siri with the multifunction on-ear controls
The award-winning sound and design you’ve come to love from Beats, with premium playback with fine-tuned acoustics that maximize clarity, breadth, and balance
What\'s in the box - Beats Solo3 Wireless headphones, Carrying case, 3.5mm RemoteTalk cable, Universal USB charging cable (USB-A to USB Micro-B), Quick Start Guide, Warranty Card (USB power adapter sold separately)', 'Brand        Beats
Model Name        Beats Solo3
Color        Citrus Red
Form Factor        On Ear
Connectivity Technology        Bluetooth, NFC', '19');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('152', 'Beats Studio Buds - True Wireless Noise Cancelling Earbuds - Compatible with Apple & Android', '3', '3', '1.jpg', '1.700.000', 'Custom acoustic platform delivers powerful, balanced sound
Control your sound with two distinct listening modes: Active Noise Cancelling (ANC) and Transparency mode
Three soft ear tip sizes for a stable and comfortable fit while ensuring an optimum acoustic seal
Up to 8 hours of listening time (up to 24 hours combined with pocket-sized charging case)
Industry-leading Class 1 Bluetooth for extended range and fewer dropouts
High-quality call performance and voice assistant interaction via built-in microphones
IPX4-rated sweat- and water-resistant wireless earbuds
Beats wireless headphones and earphones are compatible with Apple and Android devices
What’s in the box – Beats Studio Buds true wireless noise cancelling earphones, charging case, ear tips with three size options, USB-C to USB-C charging cable, Quick Start Guide, warranty card (USB-C power adapter sold separately)', 'Brand        Beats
Model Name        Studio Buds
Color        Red
Form Factor        In Ear
Connectivity Technology        Wireless, Apple H1 Chip, AirPlay, HDMI', '9');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('153', 'Philips H4205 On-Ear Wireless Headphones with 32mm Drivers and BASS Boost on-Demand, Blue ', '3', '12', '1.jpg', '2.225.000', 'HERE COMES THE BASS: Pronounced beats. Stronger vibes. These wireless on-ear headphones boast a BASS boost button for deeper bass at a touch. Powerful 32mm drivers bring the best out of your favorite soundtracks.
ANYTIME, ANYWHERE: You get up to 29 hours playtime from a 2-hour charge via USB-C, and if you need a little extra juice, a 15-minute boost will give you another 4 hours.
DESIGNED FOR LONG-WEARING COMFORT: These on-ear headphones boast a cushioned headband so light you can barely feel it. The soft ear cups are clearly marked for left/right ears, and can be angled until they feel just right. The matte color is smart yet understated - the perfect finishing touch to your everyday look.
AT YOUR FINGERTIPS: You can take calls, pause music, and wake your voice assistant with a press of the multifunction button. These headphones are ready to pair as soon as you turn them on.
STAY ON-THE-MOVE: The ear cups on these headphones fold flat and swivel inward, so they can easily fit in your pocket or handbag.
INCLUDED ACCESSORIES: USB-C cable, quick start guide.
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', '
Brand        Philips Audio
Model Name        H4205
Color        Blue
Form Factor        On Ear
Connectivity Technology        Wireless, Bluetooth', '11');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('154', 'Sony WH-CH520 Wireless Headphones Bluetooth On-Ear Headset with Microphone', '3', '12', '1.jpg', '1.350.00', 'With up to 50-hour battery life and quick charging, you’ll have enough power for multi-day road trips and long festival weekends.
Great sound quality customizable to your music preference with EQ Custom on the Sony | Headphones Connect App.
Boost the quality of compressed music files and enjoy streaming music with high quality sound through DSEE.
Designed to be lightweight and comfortable for all-day use.
Crystal clear hands-free calling with built-in mic.
Multipoint connection allows you to quickly switch between two devices at once.
Find your headphones easily with Fast Pair.
Connect to your PC easily with Swift Pair.
360 Reality Audio compatible so you can fully immerse yourself in sound all around you.
Swivel design for compact and easy carrying.', '
Brand        Sony
Model Name        WHCH520/L
Color        Blue
Form Factor        On Ear
Connectivity Technology        Wireless', '2');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('155', 'Logitech G305 LIGHTSPEED Wireless Gaming Mouse, Hero 12K Sensor, 12,000 DPI', '3', '12', '1.jpg', '1.150.000', 'HERO Gaming Sensor: Next-gen HERO mouse sensor delivers up to 10x the power efficiency over other gaming mice with exceptional accuracy and responsiveness thanks to 400 IPS precision and up to 12000 DPI sensitivity
LIGHTSPEED Wireless: Ultra-fast LIGHTSPEED Wireless technology gives you a lag-free gaming experience. The G305 wireless gaming mouse delivers incredible responsiveness and reliability with a super-fast 1ms report rate for competition-level performance
Ultra-Long Battery Life: The G305 wireless Logitech mouse boasts an incredible 250 hours of continuous gameplay on a single AA battery so you can play at peak performance without worrying about running out of power
Lightweight design: Thanks to an efficient mechanical design, the G305 gaming mouse weighs in at only 99 grams for high manoeuvrability
Portable Convenience: The durable, compact design with built-in USB receiver storage makes the G305 means you can take it with you.
Note : In case of Wireless mouse, the USB receiver will be provided inside or along with the mouse
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', '
Brand        Logitech G
Color        White
Connectivity Technology        Bluetooth
Special Feature        Wireless
Movement Detection Technology        Opti', '10');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('156', 'Logitech G703 Lightspeed Wireless Gaming Mouse W/Hero 25K Sensor, PowerPlay Compatible, Lightsync RGB', '3', '21', '1.jpg', '1.300.000', 'Selling Wireless Gaming Gear Brand - Based on independent aggregated sales data (FEB ‘19 - FEB’20) of Wireless Gaming Keyboard, Mice, and PC Headset in units from: US, CA, CN, JP, KR, TW, TH, ID, DE, FR, RU, UK, SE, TR
Power play wireless charging: never worry about your battery life again. Add the power play wireless charging system to keep G703 and other compatible g mice charged while at rest and at play. Power play wireless charging system sold separately
Hero 25K sensor through a software update from G HUB, this upgrade is free to all players: our most advanced, with 1:1 tracking, 400-plus IPS, and 100-25, 600 max DPI sensitivity — Plus zero smoothing, filtering, or acceleration, and 10x power efficiency of previous Gen
Light speed wireless: Pro-level responsiveness and connectivity for long lasting, high performance game play - with a weight of 95 g and battery life for up to 35 hours of continuous play with default light Sync RGB lighting.
Supreme comfort and quality: Brings together comfort, durability, and performance with comfortable design, rubber side grips, 10 g optional weight, and 6 programmable buttons for a customizable gaming experience.
Advanced button technology: Metal-spring button Tensioning keeps primary left and right buttons poised to trigger with less force, for exceptional button feel, response, and consistency every time
Light sync RGB: Full-spectrum lighting responds to in-game action, Audio, and screen color; Customize lighting effects from 16.8M colors with G hub gaming software, and sync across g gear
Note: In case of wireless mouse, the USB receiver will be provided inside or along with the mouse
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', '
Brand        Logitech G
Color        Black
Connectivity Technology        Bluetooth
Movement Detection Technology        Optical
Number of Buttons        6', '28');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('157', 'Corsair Scimitar RGB Elite, MOBA/MMO Gaming Mouse, Black, Backlit RGB LED, 18000 DPI, Optical', '3', '3', '1.jpg', '', 'Loaded with 17 fully programmable buttons, ideal for performing frequent actions and executing complex macros in MMOs and MOBAs.
Patented Key Slider control system lets you reposition the 12 side buttons to comfortably fit your grip. hardware macro playback: three predefined profiles include actions common for MMO gaming as well as General purpose keyboard shortcuts. Custom, gaming Grade 16000 DPI Optical sensor: ultra-accurate and high-speed tracking Engine. Surface calibration tuning Utility: optimizes sensor precision and responsiveness for your playing surface.
Equipped with a custom PixArt PMW3391 native 18, 000 DPI optical sensor, adjustable in 1 DPI resolution steps, for highly accurate and customizable tracking.
The SCIMITAR RGB ELITE’s 50 million click-rated Omron switches, durably constructed scroll wheel, and braided cable ensure that it stands up to the wear-and-tear of extended gaming.
Sculpted to comfortably fit the contours of your palm, regardless of hand size or grip style, with a right-side finger rest for added support.
Compatible Devices: A Pc With A Usb Port', '
Brand        Corsair
Color        Black
Connectivity Technology        Bluetooth
Special Feature        便携式
Movement Detection Technology        Optical', '2');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('158', 'Logitech G203 Wired Gaming Mouse, 8,000 DPI, Rainbow Optical Effect LIGHTSYNC RGB', '3', '12', '1.jpg', '850', 'Selling Gaming Gear Brand - Based on independent aggregated sales data (FEB ‘19 - FEB’20) of Gaming Keyboard, Mice, and PC Headset in units from: US, CA, CN, JP, KR, TW, TH, ID, DE, FR, RU, UK, SE, TR
8,000 DPI gaming-grade sensor responds precisely to movements. Customize your sensitivity settings to suit the sensitivity you like with Logitech G HUB gaming software and cycle easily through up to 5 DPI settings.
Play in color with our most vibrant Lightsync RGB featuring color wave effects customizable across -16.8 million colors. Install Logitech G HUB software to choose from preset colors and animations or make your own. Game-driven, audio visualization and screen mapping options are also available.
Play comfortably and with total control. The classic and simple 6-button layout and classic gaming shape is a comfortable time-tested and loved design. Each button can be customized using Logitech G HUB software to simplify tasks.
Primary buttons are mechanical and tensioned with durable metal springs for reliability, performance and excellent feel. The crisp clicks and precise feedback delivers a great precision feel to maximize your fun in game.
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', '
Brand        Logitech G
Color        Black
Connectivity Technology        USB
Special Feature        Lightsync RGB Lighting
Movement Detection Technology        Optical', '1');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('159', 'Corsair K100 RGB Optical-Mechanical Gaming Keyboard - Corsair OPX RGB Optical-Mechanical Keyswitches - AXON Hyper', '3', '12', '1.jpg', '5.200.000', 'The CORSAIR K100 RGB is the pinnacle of CORSAIR keyboards, offering the cutting-edge performance, style, durability, and customization that gamers need to stand above the rest..Keyboard Cable Material: Braided
The centerpiece of your gaming setup, the CORSAIR K100 RGB boasts a refined design bolstered by a durable aluminum frame, dynamic per-key RGB backlighting, and a 44-zone three-sided LightEdge.
Powered by CORSAIR AXON Hyper-Processing Technology, enabling CORSAIR’s most advanced gaming keyboard experience by delivering up to 4x faster throughput with native 4,000Hz hyper-polling and 4,000Hz key scanning, while simultaneously driving up to 20-layer lighting effects.
A programmable iCUE control wheel gives you command over backlighting, media jogging, and more through CORSAIR iCUE software, customizable to perform actions in games and applications.
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', '
Brand        Corsair
Compatible Devices        Gaming Console
Connectivity Technology        Wired
Keyboard Description        Gaming
Special Feature        Lighting
Color        Black
Operating System        Mac OS X 10.15 or newer, Windows 10
Number of Keys        110
Keyboard backlighting color support        RGB
Style        K100', '16');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('160', 'Logitech G713 Wired Mechanical Gaming Keyboard with LIGHTSYNC RGB Lighting, Linear Switches (GX Red), and Keyboard Palm Rest, PC and Mac Compatible', '3', '21', '1.jpg', '1.900.000', 'Cloud-soft Comfort: Float away with G713’s dreamy white design and comfy, cloud-shaped palm rest; compact mechanical TKL keyboard layout and adjustable height give that good game feeling, all-day long
Lovely Lighting: Per key and perimeter Logitech LIGHTSYNC RGB with preloaded Play Mood animations, the Aurora Collection signature lighting; customize your RGB gaming keyboard’s lighting on G HUB
Always On: You’re always ready to play, simple and worry-free, with wired USB-C keyboard connectivity
Gaming-Grade Tech: Let the good games begin on this Logitech mechanical keyboard with your choice of GX switches, ultra-responsive, USB-wired play, and full media controls at your fingertips
Make It Yours: Complete your custom mechanical keyboard’s look with keycaps and top plates in multiple colorways, including Pink Dawn and Green Flash; sold separately
From The Aurora Collection: Gaming gear plays best together, G713 Logitech keyboard, G735 headset, G705 mouse share the same inclusive design and dreamy aesthetic; gaming accessories sold separately
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand        Logitech G
Compatible Devices        PC
Connectivity Technology        USB
Keyboard Description        Logitech G Topaz
Recommended Uses For Product        Gaming
Special Feature        Adjustable Height, LIGHTSYNC, Compact Keyboard, Palm Rest, Removable Cable, Customizable Backlighting, Low-profile KeysAdjustable Height, LIGHTSYNC, Compact Keyboard, Palm Rest, Removable Cable, Customizable Backlighting, Low-profile Keys
Color        White Mist
Operating System        iPadOS 13.4, macOS 10.15, Chrome OS, iOS 14, Windows 10
Number of Keys        87
Keyboard backlighting color support        RGB', '2');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('161', 'ASUS ROG Strix Scope NX TKL Moonlight White Wired Mechanical RGB Gaming Keyboard', '3', '12', '1.jpg', '2.300.400', 'READY FOR ACTION, COMPACTLY CRAFTED - The ROG Strix Scope NX TKL Moonlight White is a compact, tenkeyless mechanical keyboard, featuring Xccurate Design – an extra-wide Ctrl key that\'s easier to feel and find in a frenzied FPS session.
TKL FORM FACTOR FOR FPS - A high-performance mechanical gaming keyboard with a small footprint, freeing up space on your worktop for broader mouse movements – perfect for lower-sensitivity settings that slow the reticle for leveled-up aiming accuracy. The keyboard is topped with an aluminum faceplate for everyday resilience and it’s finished with a striking slash aesthetic to add a touch of style.
ROG NX MECHANICAL SWITCH - Exclusive ROG NX mechanical switches offer fast actuation and specially tuned force curves for great keystroke feel & feedback. ROG NX Red mechanical switches provide a 1.8 mm actuation point for fast input. An initial actuation of 40 gram-force (gf) helps prevent accidental keystrokes, and it extends to 55 gf for perfect rebound feedback. As a result, keystrokes are instantaneous and have a smooth and linear feel.
DYNAMIC RGB LIGHTING - Enjoy vibrant RGB illumination with the ROG Strix Scope NX TKL Moonlight White. Featuring individually illuminated keys, lock indictors and ROG logo, plus an arresting RGB underglow effect that extends the lighting beyond the keyboard. Powered by Aura Sync, the entire color spectrum and a range of dynamic lighting effects at your command is uniquely yours.
MINIMALIST LOOK, MAXIMUM IMPACT - The new Moonlight White product series offers a range of new devices with a clean aesthetic. Arm yourself with the Moonlight White editions of the ROG Strix Scope NX TKL keyboard, Strix Impact II optical-sensor mouse, Strix Go Core headset, Cetra II Core in-ear headphones, and the Zephyrus G14 and G15 gaming laptops.
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', '
Brand        ASUS
Compatible Devices        Gaming Console
Connectivity Technology        wired
Keyboard Description        Gaming
Recommended Uses For Product        Gaming
Special Feature        Lighting, Multimedia Keyboard
Color        Moonlight
Operating System        Windows 10
Number of Keys        84
Keyboard backlighting color support        RGB', '16');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('162', 'Logitech G560 PC Gaming Speaker System with 7.1 DTS:X Ultra Surround Sound, Game based LIGHTSYNC RGB', '3', '3', '1.jpg', '4.200.000', 'Built-in LIGHTSYNC RGB lighting blasts game driven lighting colors and effects activated by the audio in many popular games
Explosive 240 Watts Peak power and unique driver design deliver a huge soundscape for a heightened gaming experience
Integrated DTS:X Ultra surround sound renders 3D positional audio so you hear your gaming environment from every angle
Easily customize four speaker lighting zones with Logitech Family Software for both front and rear light projection in your choice of 16.8 million colors
Works with Windows based PCs and Bluetooth enabled devices including computers, smartphones and tablets (DTS:X not supported on Mac OS X)
Sound Pressure Level (SPL Max) - 97decibel @426B
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand        Logitech G
Series        G560
Speaker Type        Subwoofer
Connectivity Technology        Bluetooth, USB
Special Feature        USB Port
', '27');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('163', 'Razer Leviathan V2 X: PC Soundbar with Full-Range Drivers - Compact Design - Chroma RGB - USB Type C Power and Audio Delivery', '3', '30', '1.jpg', '1.800.000', 'PC Soundbar with Full-Range Drivers: Armed with two full-range drivers and two passive radiators, the Leviathan V2 X delivers a riveting audio experience across all your entertainment
Compact Desktop Form Factor: The most compact soundbar in our Leviathan V2 range fits perfectly beneath your monitor for a clutter-free desktop
USB Type C Power and Audio Delivery: Powered by a single USB Type C cable to deliver dynamic audio with a volume output of up to 90Db and enables for an easy setup
Bluetooth 5.0: Enjoy smooth, stutter-free sound with a low-latency Bluetooth connection, as you switch seamlessly between your PC and your preferred mobile device that’s conveniently paired via the Razer Audio App
Powered by Razer Chroma RGB: With 14 lighting zones, countless patterns, dynamic in-game lighting effects—experience full RGB customization and deeper immersion with the world’s largest lighting ecosystem for gaming devices
Razer Audio App and Razer Synapse: From customizing RGB lighting to toggling between audio devices, tweak the soundbar to best suit your needs with software designed to give you more control
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand        Razer
Model Name        Leviathan V2 X
Speaker Type        Soundbar
Connectivity Technology        Bluetooth
Special Feature        Compact Design - Chroma RGB, Bluetooth 5.0 - for PC, Laptop, Smartphones, Tablets & Nintendo Switch, PC Soundbar with Full-Range Drivers, USB Type C Power and Audio DeliveryCompact Design - Chroma RGB, Bluetooth 5.0 - for PC, Laptop, Smartphones, Tablets & Nintendo Switch, PC Soundbar with Full-Range Drivers, USB Type C Power and Audio Delivery', '24');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('164', 'Edifier R1280T Powered Bookshelf Speakers - 2.0 Stereo Active Near Field Monitors', '3', '30', '1.jpg', '2.300.000', '2 x AUX INPUT - Convenient connection to any device that has a 3.5mm headphone output or dual RCA output. Connect to two devices via AUX at the same time, no plugging and switching needed. (None Bluetooth version)
STUDIO SOUND QUALITY - Natural sound reproduction from 13mm silk dome tweeter and 4 inch full range unit
REMOTE CONTROL - Adjust volume at your figure tips. Bass and treble control located on the side of main speaker.
CLASSIC WOOD FINISH - High quality MDF wood build finished with wood effect vinyl serves as a great compliment to any home decor.
2 YEAR WARRANTY - Guaranteed high quality and reliability with hassle-free parts and labor warranty for two years in USA and Canada.
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'rand        Edifier
Speaker Type        Bookshelf, Monitor, Tweeter, Computer
Connectivity Technology        RCA, Auxiliary
Special Feature        On-speaker adjustable volume, bass, and treble. RCA, PC audio inputs.
Recommended Uses For Product        For Computers, For Televisions, For Smartphones, For Tablets', '3');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('165', 'Razer Gigantus v2 Cloth Gaming Mouse Pad (Medium): Thick, High-Density Foam - Non-Slip Base', '3', '21', '1.jpg', '180', 'Ultra-Large Area for Low-Sensitivity Playstyles: Designed to never run out of mouse space during high-leverage gaming, reducing the need to lift and reposition mice
Optimized Gaming Surface: Features a micro-textured surface for precise pixel-tracking—calibrated for all mouse sensors—with a surface coating for both fast and controlled playstyles
Non-Slip Rubber Base: Made of natural-foam rubber for keeping the Gigantus mouse mat in place
Size: Medium
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand        Razer
Color        Classic Black
Special Feature        Non-slip
Recommended Uses For Product        Gaming
Material        Rubber
', '7');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('166', 'Corsair MM300 - Anti-Fray Cloth Gaming - High-Performance Mouse Pad Optimized for Gaming Sensors', '3', '30', '1.jpg', '270', 'Superior control: Textile weave surface designed for pixel precise targeting and low friction tracking
No fray, No fuss: Surrounded stitched edges guard against surface peeling for maximum durability
Accurate plus Precise: Optimized for both laser and optical gaming mice
Zero slip: Anti-skid rubber base helps it stay securely in place
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', 'Brand        Corsair
Color        Multicolor
Special Feature        Non-slip
Recommended Uses For Product        Gaming
Material        Cloth||natural Rubber - Base,Cloth,Rubber - Base', '16');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('167', '156pcs Funny Meme Vinyl Stickers Pack, Vine Stickers for Laptop', '3', '21', '1.jpg', '30', '📏 Sticker Size: Large 3-4" Decorative Vinyl Stickers
☔Comes with 156pcs of unique stickers, includes all shown in picture, great for classroom, party
🏙 Designed in Boston, MA
💻 Perfect for personalizing Laptops, Macbooks, Skateboards, Luggage, Cars, Bumpers, Bikes, Bicycles, Bedroom, Travel Case, Motorcycle, Snowboard, PS4, XBOX ONE
☔ Premium cute quality vinyl stickers protect against wear/tear and built to last
Note: Products with electrical plugs are designed for use in the US. Outlets and voltage differ internationally and this product may require an adapter or converter for use in your destination. Please check compatibility before purchasing.', '
Brand        Debinolo
Color        Multicolor
Item Dimensions LxWxH        5 x 4 x 0.3 inches
Surface Recommendation        Wall
Room Type        Bedroom, Classroom
Material        Vinyl
Theme        Meme
Special Feature        Self Adhesive
Style        meme
Age Range (Description)        Adult,Youth', '22');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('168', 'Dixie PerfecTouch 12 Oz Insulated Paper Hot Coffee Cup by GP PRO', '3', '3', '1.jpg', '25', 'Paper
INSULATED HOT PAPER CUPS keep drinks hot and fingers cool
MORE HYGIENIC because they are one-time use compared to permanent ware cups
A COST EFFICIENT OPTION because there’s no need for cardboard cup sleeves or double-cupping
DUAL-PURPOSE paper cups help with storage constraints and simplify ordering
PRODUCT MAY BE RECYCLED if you have access to a recycler that accepts paper or plastic products containing food residue. Such facilities may not exist in your area', 'Brand        Georgia-Pacific
Material        Paper
Color        Multicolor
Capacity        12 Ounces
Special Feature        Non-Slip,Insulated,Sturdy', '24');
INSERT INTO product (id, Name, category_id, shop_id, image, price, description, details, quantity) VALUES ('169', 'Comfy Package [300 Pack] 12 oz. Kraft Paper Hot Coffee Cups', '3', '21', '1.jpg', '20', 'Comfy Package 12 oz. Kraft Paper Hot Coffee Cups for serving hot coffee, tea, hot chocolate, and other hot or cold beverages [300 Pack]
Rolled rim for rigidity and strength and fits all standard 90 mm lids (3 1/2 inches).
Its thick paper wall makes it great as everyday hot coffee cups, hot cocoa cups and hot tea cups. Can withstand temperatures up to 205 degrees Fahrenheit, making it suitable for a wide range of beverages.
Unbleached and Eco Friendly, 100% safe and healthy.
Kraft Brown Color adds an authentic and natural feel.', 'Brand        Comfy Package
Material        Paper
Color        Kraft
Capacity        12 Ounces
Special Feature        hot-beverage, cold-beverage', '30');

insert into review(id,user_review,email_review,product_id,content,rating,post_date) values
(1,"John","John@gmail.com",3,"Good Product","4","2023-08-20 23:59:59"),
(2,"David","David@gmail.com",3,"Good Product_A","4","2022-08-20 23:59:59"),
(3,"Jason","Jason@gmail.com",4,"Good Product_B","4","2021-08-20 23:59:59"),
(4,"Beckham","Beck@gmail.com",5,"Good Product_C","4","2020-08-20 23:59:59"),
(5,"John Dang","John@gmail.com",6,"Good Product_D","5","2018-08-20 23:59:59");

-- select shop.id, id_users, shop_name, shop.address, username from shop 
-- inner join users
-- on shop.id_users = users.id;

-- select product.id , name, category_id, shop_id, image, price, description, details , shop_name , category_name
-- from product 
-- inner join category
-- on product.category_id = category.id
-- 					inner join shop
--                             on product.shop_id = shop.id;

--                          
-- select shop.id, id_users, shop_name, shop.address, username, shopper_details_id, shopper_details.email, shopper_details.phonenumber, shopper_details.address, category, quantity, date_created, avatar from shop
-- inner join users
-- on shop.id_users = users.id
-- inner join shopper_details
-- on shopper_details.id = shop.shopper_details_id
-- where users.id = 3;


-- select product.id , name, category_id, shop_id, image, price, description, details , shop_name , category_name
-- from product 
-- inner join category
-- on product.category_id = category.id
-- inner join shop
-- on product.shop_id = shop.id 
-- where shop.id = 3;

-- select * from shopper_details order by id desc limit 0,1;
-- select * from users;
-- select * from product order by id desc limit 0,1;


-- select shop.id, id_users, shop_name, shop.address, username, shopper_details_id, avatar, category  from shop 
-- inner join users
-- on shop.id_users = users.id
-- inner join shopper_details
-- on shopper_details.id = shop.shopper_details_id;