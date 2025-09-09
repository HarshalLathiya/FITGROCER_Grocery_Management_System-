-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 09, 2025 at 04:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fitgrocer`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nutritions`
--

CREATE TABLE `nutritions` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `vitamins` varchar(100) DEFAULT NULL,
  `carbohydrates` float DEFAULT NULL,
  `fiber` float DEFAULT NULL,
  `protien` float DEFAULT NULL,
  `fat` float DEFAULT NULL,
  `calories` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nutritions`
--

INSERT INTO `nutritions` (`id`, `product_id`, `vitamins`, `carbohydrates`, `fiber`, `protien`, `fat`, `calories`) VALUES
(1, 1, '26', 34, 8, 2, 4, 0.15),
(2, 2, '20', 6.5, 6.24, 2.8, 0.4, 34),
(3, 3, '50', 6.9, 2.5, 1.5, 0.22, 31),
(4, 4, '20', 9.5, 3.2, 2, 0.41, 40),
(5, 5, '19', 10, 2.8, 1, 0.2, 41),
(6, 6, '30', 9.3, 1.7, 1.1, 0.25, 40),
(7, 7, '23', 11.8, 2.4, 0.9, 0.2, 47),
(8, 8, '21', 17, 0.9, 0.6, 0.2, 69),
(9, 9, '95', 7.7, 2, 0.8, 0.3, 32),
(10, 10, '85', 7.6, 0.4, 0.6, 0.2, 30),
(11, 11, '155', 14, 3, 1.1, 0.5, 61),
(12, 12, '105', 13.1, 1.4, 0.5, 0.1, 50),
(13, 13, '90', 4.8, 0.2, 3.2, 4, 67),
(14, 15, '70', 1.2, 0.1, 18.3, 20.8, 265),
(15, 14, '70', 0.1, 0.2, 0.9, 81, 100),
(16, 16, '75', 3.4, 0.22, 3.1, 4, 60),
(17, 17, '60', 4, 0.22, 1, 1, 27),
(18, 18, '65', 24, 2, 7, 5, 186);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `quantity` float DEFAULT NULL,
  `shipping_address` varchar(100) DEFAULT NULL,
  `total_amount` int(11) NOT NULL,
  `orderDateTime` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `product_id`, `user_id`, `quantity`, `shipping_address`, `total_amount`, `orderDateTime`) VALUES
(1, 2, 2, 2, 'kamani science college', 120, '2025-09-08 04:39:54');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `type` enum('FRUIT','VEGETABLE','dairy','weightGain','weightLoss') DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `image_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `type`, `quantity`, `image_name`, `created_at`) VALUES
(1, 'Broccoli ', 'Broccoli is a nutritious green vegetable rich in vitamins and fiber.', 90, 'VEGETABLE', 0, 'product-6.jpg', '2025-04-14 14:18:56'),
(2, 'Bell Pepper', 'Bell pepper is a colorful, crunchy vegetable rich in vitamins and antioxidants.', 60, 'VEGETABLE', 97, 'product-1.jpg', '2025-04-14 14:33:47'),
(3, 'Red Cabbage', 'Red cabbage is a vibrant, crunchy vegetable packed with antioxidants and vitamins.', 100, 'VEGETABLE', 100, 'product-4.jpg', '2025-04-14 14:39:28'),
(4, 'Red Chili', 'Red chili is a fiery spice rich in vitamin C and capsaicin, adding heat and health to dishes.', 30, 'VEGETABLE', 100, 'product-12.jpg', '2025-04-14 14:42:01'),
(5, 'Carrot', 'Carrots are sweet, crunchy root vegetables rich in beta-carotene and great for vision.', 35, 'VEGETABLE', 100, 'product-7.jpg', '2025-04-14 14:44:30'),
(6, 'Onion', 'Onion is a flavorful bulb vegetable packed with antioxidants and natural compounds that support hear', 25, 'VEGETABLE', 100, 'product-9.jpg', '2025-04-14 14:52:18'),
(7, 'Orange', 'Orange is a juicy, tangy fruit packed with vitamin C and immune-boosting antioxidants.', 60, 'FRUIT', 99, 'orange.jpg', '2025-04-14 14:54:51'),
(8, 'Grapes', 'Grapes are juicy, sweet fruits loaded with antioxidants and natural sugars for quick energy.', 60, 'FRUIT', 1, 'grapes.webp', '2025-04-14 14:56:49'),
(9, 'Strawberry', 'Strawberry is a sweet, juicy berry packed with vitamin C, antioxidants, and natural goodness.', 120, 'FRUIT', 100, 'category-2.jpg', '2025-04-14 15:07:56'),
(10, 'Watermelon', 'Watermelon is a hydrating summer fruit loaded with water, antioxidants, and natural sweetness.', 100, 'FRUIT', 100, 'images.jpeg', '2025-04-14 15:10:13'),
(11, 'Kiwi', 'Kiwi is a tangy-sweet fruit rich in vitamin C, fiber, and powerful antioxidants.', 90, 'FRUIT', 100, 'th.jpeg', '2025-04-14 15:50:37'),
(12, 'Pineapple', 'Pineapple is a tropical fruit bursting with vitamin C, enzymes, and sweet-tangy flavor.', 75, 'FRUIT', 100, 'pineapples.jpg', '2025-04-14 15:52:45'),
(13, 'Amul Cow Milk', 'Amul Cow Milk is pure, nutritious, and easy to digest with 4% fat content.', 32, 'dairy', 98, 'Milk.png', '2025-04-14 15:59:37'),
(14, 'Butter', 'Butter is a rich dairy product made from cream, known for its high fat content and creamy texture.', 50, 'dairy', 100, 'butter.jpeg', '2025-04-14 16:02:18'),
(15, 'Paneer ', 'Paneer is a soft, fresh cheese rich in protein and calcium, widely used in Indian cuisine.', 70, 'dairy', 100, 'paneer.jpg', '2025-04-14 16:34:18'),
(16, 'Curd', 'Curd is a probiotic-rich dairy product that aids digestion and boosts gut health.', 55, 'dairy', 1, 'curd.jpeg', '2025-04-14 16:45:58'),
(17, 'Amul Buttermilk', 'Buttermilk is a light, refreshing dairy drink known for aiding digestion and cooling the body.', 20, 'dairy', 100, 'buttermilk.webp', '2025-04-14 16:50:43'),
(18, 'Amul Shrikhand (Mango)', 'Amul Shrikhand Mango is a sweet, creamy dessert made from hung curd and flavored with real mango pul', 150, 'dairy', 100, 'shrikhand.webp', '2025-04-14 16:54:19');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `phone_number` varchar(60) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` varchar(45) NOT NULL DEFAULT 'CUSTOMER',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `phone_number`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Lathiya Harshal', '9737612352', 'harshalplathiya@gmail.com ', '$2b$10$zPVA7b5iD3XTfPn8e4wfOOeOndE0FBzoI58eeba7GAprVg0UHJduS', 'ADMIN', '2025-08-29 13:23:45'),
(2, 'mihir Lathiya', '9737609594', 'mihirlathiya@gmail.com', '$2b$10$EsiUIQXXs3FvQBiZ1.ga8eCCdYzKcglrFqEPWuQNcOPk4PsEGHJ.O', 'CUSTOMER', '2025-08-29 13:29:12'),
(3, 'varshil Lathiya', '9484871696', 'varshillathiya@gmail.com', '$2b$10$EDEo3iJ56AMQ8Mt3Et9QpOwO4LZo4LPoH6NySLqTzfxGQjjCW78ti', 'CUSTOMER', '2025-08-30 13:21:23'),
(5, 'Nikhil Lathiya', '7046473969', 'nikhilLathiya@gmail.com', '$2b$10$hhtVAEElcyVtUL1ioG6wxuFyRv5xqLuwDolYAR3K28E.qbXlFjsXq', 'CUSTOMER', '2025-08-30 13:50:47'),
(6, 'navdeep Bhalu', '7878513482', 'navdeepb@gamil.com', '$2b$10$/HxxbGH7qzxwhN.nlP343u9.MFep5/Dh7BFcBuq/GwhF8g9kDLNCu', 'CUSTOMER', '2025-08-30 15:39:49'),
(7, 'Sarvaiya Dharmik', '6354339281', 'dharmiks@gmail.com', '$2b$10$VI4WuSuuT9WwowbLPFjWTujRvuY1ZTQqTiM9lkHV3ri.nTmbqC/5S', 'CUSTOMER', '2025-09-08 04:34:39'),
(8, 'Kureshi Sufiyan', '8401953920', 'sufiyank@gmail.com', '$2b$10$3drXAv/tZrA1azE1ELypGeBtlEcYB2XGHkHg00yiz7kFtBs.gyUG2', 'CUSTOMER', '2025-09-08 04:45:30');

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `id` int(11) NOT NULL,
  `shipping_address` varchar(45) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`id`, `shipping_address`, `user_id`) VALUES
(1, '426,Near Dhareswar Temple Chital', 2),
(2, '426,Near Market', 6),
(3, 'kamani science college', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_cart_user_idx` (`user_id`),
  ADD KEY `FK_cart_product_idx` (`product_id`);

--
-- Indexes for table `nutritions`
--
ALTER TABLE `nutritions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_nutrition_idx` (`product_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_order_user_idx1` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_user_details_userId_idx` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `nutritions`
--
ALTER TABLE `nutritions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `FK_cart_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `FK_cart_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `nutritions`
--
ALTER TABLE `nutritions`
  ADD CONSTRAINT `FK_nutrition` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_details`
--
ALTER TABLE `user_details`
  ADD CONSTRAINT `FK_user_details_userId` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
