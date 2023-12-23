-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2023 at 03:10 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mysticgrills`
--

-- --------------------------------------------------------

--
-- Table structure for table `menuitems`
--

CREATE TABLE `menuitems` (
  `menuItemId` int(11) NOT NULL,
  `menuItemName` varchar(30) NOT NULL,
  `menuItemDescription` varchar(30) NOT NULL,
  `menuItemPrice` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `menuitems`
--

INSERT INTO `menuitems` (`menuItemId`, `menuItemName`, `menuItemDescription`, `menuItemPrice`) VALUES
(1, 'Grilled Chicken', 'Juicy grilled chicken served w', 15.99),
(2, 'Vegetarian Pasta', 'Pasta with a mix of fresh vege', 12.99),
(3, 'BBQ Ribs', 'Tender BBQ ribs with a side of', 18.99),
(4, 'Salmon Steak', 'Grilled salmon steak with lemo', 22.99),
(5, 'Margherita Pizza', 'Classic pizza with tomato, moz', 14.99),
(6, 'Shrimp Scampi', 'Garlic butter shrimp served ov', 19.99),
(7, 'Steakhouse Burger', 'Juicy beef patty with cheese a', 16.99),
(8, 'Chicken Caesar Salad', 'Fresh salad with grilled chick', 13.99),
(9, 'Vegetable Stir-Fry', 'Assorted vegetables stir-fried', 11.99),
(10, 'Tiramisu', 'Classic Italian dessert with c', 8.99),
(11, 'Fish Tacos', 'Tacos filled with grilled fish', 17.99),
(12, 'Mango Sorbet', 'Refreshing mango-flavored sorb', 6.99);

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `orderId` int(11) NOT NULL,
  `menuItemId` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`orderId`, `menuItemId`, `quantity`) VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 1),
(2, 1, 1),
(2, 2, 2),
(3, 1, 1),
(3, 2, 2),
(3, 3, 3),
(4, 1, 2),
(4, 4, 2),
(5, 2, 1),
(5, 5, 3),
(6, 3, 2),
(6, 6, 1),
(7, 1, 1),
(7, 2, 2),
(8, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `orderStatus` varchar(30) NOT NULL,
  `orderDate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderId`, `userId`, `orderStatus`, `orderDate`) VALUES
(1, 2, 'Pending', '2023-12-01'),
(2, 3, 'Pending', '2023-12-02'),
(3, 2, 'Pending', '2023-12-03'),
(4, 4, 'Pending', '2023-12-04'),
(5, 5, 'Pending', '2023-12-05'),
(6, 4, 'Pending', '2023-12-06'),
(7, 6, 'Served', '2023-12-07'),
(8, 7, 'Served', '2023-12-08'),
(9, 8, 'Served', '2023-12-09');

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `receiptId` int(11) NOT NULL,
  `orderId` int(11) NOT NULL,
  `receiptPaymentAmount` double NOT NULL,
  `receiptPaymentDate` date NOT NULL,
  `receiptPaymentType` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`receiptId`, `orderId`, `receiptPaymentAmount`, `receiptPaymentDate`, `receiptPaymentType`) VALUES
(1, 1, 43.97, '2023-12-01', 'Credit Card'),
(2, 2, 56.97, '2023-12-02', 'PayPal'),
(3, 3, 74.97, '2023-12-03', 'Cash'),
(4, 4, 45.98, '2023-12-04', 'Debit Card'),
(5, 5, 29.99, '2023-12-05', 'Cash'),
(6, 6, 78.96, '2023-12-06', 'Credit Card'),
(7, 7, 33.98, '2023-12-07', 'Credit Card'),
(8, 8, 45.97, '2023-12-08', 'Cash'),
(9, 9, 26.99, '2023-12-09', 'Debit Card');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userId` int(11) NOT NULL,
  `userRole` varchar(20) NOT NULL,
  `userName` varchar(30) NOT NULL,
  `userEmail` varchar(30) NOT NULL,
  `userPassword` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userId`, `userRole`, `userName`, `userEmail`, `userPassword`) VALUES
(1, 'Admin', 'Admin User', 'admin@example.com', 'adminpassword'),
(2, 'Customer', 'John Doe', 'john.doe@example.com', 'johnpassword'),
(3, 'Customer', 'Jane Doe', 'jane.doe@example.com', 'janepassword'),
(4, 'Customer', 'Alice Smith', 'alice.smith@example.com', 'alicepassword'),
(5, 'Customer', 'Bob Johnson', 'bob.johnson@example.com', 'bobpassword'),
(6, 'Admin', 'Super Admin', 'superadmin@example.com', 'superadminpassword'),
(7, 'Chef', 'Gandi', 'chef@gmail.com', 'chef'),
(8, 'Waiter', 'Makro', 'waiter@gmail.com', 'waiter'),
(9, 'Customer', 'Joni', 'customer@gmail.com', 'customer'),
(10, 'Admin', 'Kevin', 'admin@gmail.com', 'admin'),
(11, 'Cashier', 'Salsha', 'cashier@gmail.com', 'cashier');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `menuitems`
--
ALTER TABLE `menuitems`
  ADD PRIMARY KEY (`menuItemId`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`orderId`,`menuItemId`),
  ADD KEY `fk_menu_item_ids` (`menuItemId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderId`),
  ADD KEY `fk_user_id` (`userId`);

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`receiptId`),
  ADD KEY `fk_order_ids` (`orderId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menuitems`
--
ALTER TABLE `menuitems`
  MODIFY `menuItemId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `receipts`
--
ALTER TABLE `receipts`
  MODIFY `receiptId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `fk_menu_item_ids` FOREIGN KEY (`menuItemId`) REFERENCES `menuitems` (`menuItemId`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_order_id` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE;

--
-- Constraints for table `receipts`
--
ALTER TABLE `receipts`
  ADD CONSTRAINT `fk_order_ids` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
