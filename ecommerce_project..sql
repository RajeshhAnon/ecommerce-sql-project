-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 09, 2025 at 06:32 PM
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
-- Database: `ecommerce_project`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `orderdetails`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `orderdetails`;
CREATE TABLE `orderdetails` (
`OrderID` int(11)
,`UserName` varchar(100)
,`Product` varchar(100)
,`Quantity` int(11)
,`Price` decimal(10,2)
,`Total` decimal(20,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
CREATE TABLE `orderitems` (
  `OrderItemID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`OrderItemID`, `OrderID`, `ProductID`, `Quantity`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 4, 2),
(5, 3, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `UserID`, `OrderDate`) VALUES
(1, 1, '2025-07-01'),
(2, 2, '2025-07-02'),
(3, 1, '2025-07-03');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `PaymentDate` date DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`PaymentID`, `OrderID`, `PaymentDate`, `Amount`, `PaymentMethod`) VALUES
(1, 1, '2025-07-01', 56400.00, 'UPI'),
(2, 2, '2025-07-02', 1200.00, 'Credit Card'),
(3, 3, '2025-07-03', 42000.00, 'Net Banking');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `ProductID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductID`, `Name`, `Price`) VALUES
(1, 'Laptop', 55000.00),
(2, 'Mouse', 700.00),
(3, 'Keyboard', 1200.00),
(4, 'Monitor', 8500.00),
(5, 'Tablet', 25000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `productsales`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `productsales`;
CREATE TABLE `productsales` (
`Name` varchar(100)
,`QuantitySold` decimal(32,0)
,`Revenue` decimal(42,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `userordersummary`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `userordersummary`;
CREATE TABLE `userordersummary` (
`UserName` varchar(100)
,`TotalOrders` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `UserName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `UserName`, `Email`, `Password`) VALUES
(1, 'Rajeshh', 'rajesh@example.com', 'pass123'),
(2, 'Asha', 'asha@example.com', 'asha456'),
(3, 'Kiran', 'kiran@example.com', 'kiran789');

-- --------------------------------------------------------

--
-- Structure for view `orderdetails`
--
DROP TABLE IF EXISTS `orderdetails`;

DROP VIEW IF EXISTS `orderdetails`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `orderdetails`  AS SELECT `o`.`OrderID` AS `OrderID`, `u`.`UserName` AS `UserName`, `p`.`Name` AS `Product`, `oi`.`Quantity` AS `Quantity`, `p`.`Price` AS `Price`, `oi`.`Quantity`* `p`.`Price` AS `Total` FROM (((`orders` `o` join `users` `u` on(`o`.`UserID` = `u`.`UserID`)) join `orderitems` `oi` on(`o`.`OrderID` = `oi`.`OrderID`)) join `products` `p` on(`oi`.`ProductID` = `p`.`ProductID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `productsales`
--
DROP TABLE IF EXISTS `productsales`;

DROP VIEW IF EXISTS `productsales`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `productsales`  AS SELECT `p`.`Name` AS `Name`, sum(`oi`.`Quantity`) AS `QuantitySold`, sum(`oi`.`Quantity` * `p`.`Price`) AS `Revenue` FROM (`products` `p` join `orderitems` `oi` on(`p`.`ProductID` = `oi`.`ProductID`)) GROUP BY `p`.`ProductID` ;

-- --------------------------------------------------------

--
-- Structure for view `userordersummary`
--
DROP TABLE IF EXISTS `userordersummary`;

DROP VIEW IF EXISTS `userordersummary`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `userordersummary`  AS SELECT `u`.`UserName` AS `UserName`, count(`o`.`OrderID`) AS `TotalOrders` FROM (`users` `u` left join `orders` `o` on(`u`.`UserID` = `o`.`UserID`)) GROUP BY `u`.`UserID` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`OrderItemID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `OrderID` (`OrderID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `OrderItemID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
