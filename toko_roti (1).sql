-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2023 at 04:23 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `toko_roti`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_status_pembayaran` (IN `transaksi_id` INT(100), IN `status_pembayaran` VARCHAR(100))   BEGIN
  UPDATE transaksi SET status_pembayaran = status_pembayaran WHERE id_transaksi = transaksi_id;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calculate_total_harga` (`jumlah` INT, `harga` INT) RETURNS INT(11)  BEGIN
  DECLARE total INT;
  UPDATE keranjang SET total = jumlah * harga;
  RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `avg_harga_produk`
-- (See below for the actual view)
--
CREATE TABLE `avg_harga_produk` (
`id_produk` int(100)
,`name` varchar(100)
,`category` varchar(199)
,`harga` int(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `join_keranjang_produk`
-- (See below for the actual view)
--
CREATE TABLE `join_keranjang_produk` (
`id_keranjang` int(100)
,`name` varchar(100)
,`harga` int(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id_keranjang` int(100) NOT NULL,
  `id_konsumen` int(100) NOT NULL,
  `pid` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `harga` int(100) NOT NULL,
  `jumlah` int(100) NOT NULL,
  `total` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keranjang`
--

INSERT INTO `keranjang` (`id_keranjang`, `id_konsumen`, `pid`, `name`, `harga`, `jumlah`, `total`) VALUES
(1, 5, 1, 'Lemper', 5000, 10, 50000),
(2, 6, 2, 'Wajik', 5000, 10, 50000),
(3, 7, 3, 'Japanese Cheesecake', 40000, 2, 80000),
(4, 6, 4, 'Tiramisu', 100000, 1, 100000),
(5, 5, 5, 'Garlic Bread', 12000, 4, 48000),
(6, 7, 6, 'Roti Tawar', 20000, 2, 40000),
(7, 6, 7, 'Choocolate Donut', 10000, 6, 60000),
(8, 7, 8, 'Cheese Donut', 10000, 6, 60000),
(9, 8, 1, 'Lemper', 5000, 6, 30000),
(10, 9, 3, 'Japanese Cheesecake', 40000, 10, 400000),
(11, 5, 5, 'Garlic Bread', 12000, 10, 120000);

--
-- Triggers `keranjang`
--
DELIMITER $$
CREATE TRIGGER `calculate_total` BEFORE INSERT ON `keranjang` FOR EACH ROW BEGIN
  DECLARE total INT;
  SET total = NEW.jumlah * NEW.harga;
  SET NEW.total = total;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `konsumen`
--

CREATE TABLE `konsumen` (
  `id_konsumen` int(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `alamat` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `konsumen`
--

INSERT INTO `konsumen` (`id_konsumen`, `nama`, `email`, `password`, `alamat`) VALUES
(5, 'harits', 'harits@gmail.com', '81dc9bdb52d04dc20036dbd8313ed055', 'Nadn'),
(6, 'Agung', 'agung@gmail.com', '1234', 'Sleman'),
(7, 'Miti', 'miti@gmail.com', '1234', 'Jogja'),
(8, 'Jenifer', 'jenifer@gmail.com', '1234', 'Klaten'),
(9, 'Micheal', 'micheal@gmail.com', '1234', 'Magelang');

-- --------------------------------------------------------

--
-- Table structure for table `pekerja`
--

CREATE TABLE `pekerja` (
  `id_pekerja` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pekerja`
--

INSERT INTO `pekerja` (`id_pekerja`, `name`, `password`) VALUES
(10, 'harits', '1234'),
(11, 'Kei', '1234'),
(12, 'Kayana', '1234');

-- --------------------------------------------------------

--
-- Table structure for table `pesan`
--

CREATE TABLE `pesan` (
  `id_pesan` int(100) NOT NULL,
  `id_konsumen` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `message` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesan`
--

INSERT INTO `pesan` (`id_pesan`, `id_konsumen`, `name`, `email`, `message`) VALUES
(1, 5, 'harits', 'harits@gmail.com', 'Selamat Pagi');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(199) NOT NULL,
  `harga` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `name`, `category`, `harga`) VALUES
(1, 'Lemper', 'Tradisional Food', 5000),
(2, 'Wajik', 'Tradisional Food', 5000),
(3, 'Japanese Cheesecake', 'Cakes', 40000),
(4, 'Tiramisu', 'Cakes', 100000),
(5, 'Garlic Bread', 'Breads', 12000),
(6, 'Roti Tawar', 'Breads', 20000),
(7, 'Choocolate Donut', 'Donuts', 10000),
(8, 'Cheese Donut', 'Donuts', 10000);

--
-- Triggers `produk`
--
DELIMITER $$
CREATE TRIGGER `after_delete_produk` AFTER DELETE ON `produk` FOR EACH ROW BEGIN
  DELETE FROM keranjang WHERE pid = OLD.id_produk;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(100) NOT NULL,
  `id_konsumen` int(100) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `method` varchar(100) NOT NULL,
  `alamat` varchar(500) NOT NULL,
  `total_produk` varchar(1000) NOT NULL,
  `total_harga` varchar(100) NOT NULL,
  `tanggal` date NOT NULL DEFAULT current_timestamp(),
  `status_pembayaran` varchar(100) NOT NULL DEFAULT '''pending'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_konsumen`, `nama`, `email`, `method`, `alamat`, `total_produk`, `total_harga`, `tanggal`, `status_pembayaran`) VALUES
(1, 5, 'harits', 'harits@gmail.com', 'cash', 'Nadn', '14', '98000', '2023-06-20', '\'pending\''),
(2, 6, 'Agung', 'agung@gmail.com', 'credit card', 'Sleman', '17', '210000', '2023-06-12', '\'pending\''),
(3, 7, 'Miti', 'miti@gmail.com', 'cash', 'Jogja', '10', '180000', '2023-06-01', 'completed'),
(4, 8, 'Jenifer', 'jenifer@gmail.com', 'credit card', 'Klaten', '6', '30000', '2023-05-30', 'completed'),
(5, 9, 'Micheal', 'micheal@gmail.com', 'cash', 'Magelang', '10', '400000', '2023-05-28', '\'pending\'');

-- --------------------------------------------------------

--
-- Stand-in structure for view `transaksicompleted`
-- (See below for the actual view)
--
CREATE TABLE `transaksicompleted` (
`nama` varchar(100)
,`alamat` varchar(500)
,`tanggal` date
,`status_pembayaran` varchar(100)
,`total_produk` varchar(1000)
,`total_harga` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `union_konsumen_pekerja`
-- (See below for the actual view)
--
CREATE TABLE `union_konsumen_pekerja` (
`id_konsumen` int(100)
,`nama` varchar(100)
,`type` varchar(8)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_konsumen`
-- (See below for the actual view)
--
CREATE TABLE `view_konsumen` (
`id_konsumen` int(100)
,`nama` varchar(100)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_produk`
-- (See below for the actual view)
--
CREATE TABLE `view_produk` (
`id_produk` int(100)
,`name` varchar(100)
,`harga` int(100)
);

-- --------------------------------------------------------

--
-- Structure for view `avg_harga_produk`
--
DROP TABLE IF EXISTS `avg_harga_produk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `avg_harga_produk`  AS SELECT `produk`.`id_produk` AS `id_produk`, `produk`.`name` AS `name`, `produk`.`category` AS `category`, `produk`.`harga` AS `harga` FROM `produk` WHERE `produk`.`harga` > (select avg(`produk`.`harga`) from `produk`) ;

-- --------------------------------------------------------

--
-- Structure for view `join_keranjang_produk`
--
DROP TABLE IF EXISTS `join_keranjang_produk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `join_keranjang_produk`  AS SELECT `keranjang`.`id_keranjang` AS `id_keranjang`, `keranjang`.`name` AS `name`, `produk`.`harga` AS `harga` FROM (`keranjang` join `produk` on(`keranjang`.`pid` = `produk`.`id_produk`)) ;

-- --------------------------------------------------------

--
-- Structure for view `transaksicompleted`
--
DROP TABLE IF EXISTS `transaksicompleted`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `transaksicompleted`  AS SELECT `k`.`nama` AS `nama`, `k`.`alamat` AS `alamat`, `t`.`tanggal` AS `tanggal`, `t`.`status_pembayaran` AS `status_pembayaran`, `t`.`total_produk` AS `total_produk`, `t`.`total_harga` AS `total_harga` FROM (`transaksi` `t` join `konsumen` `k` on(`t`.`id_konsumen` = `k`.`id_konsumen`)) WHERE `t`.`status_pembayaran` = 'completed' ;

-- --------------------------------------------------------

--
-- Structure for view `union_konsumen_pekerja`
--
DROP TABLE IF EXISTS `union_konsumen_pekerja`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `union_konsumen_pekerja`  AS SELECT `konsumen`.`id_konsumen` AS `id_konsumen`, `konsumen`.`nama` AS `nama`, 'konsumen' AS `type` FROM `konsumen`union select `pekerja`.`id_pekerja` AS `id_pekerja`,`pekerja`.`name` AS `name`,'pekerja' AS `type` from `pekerja`  ;

-- --------------------------------------------------------

--
-- Structure for view `view_konsumen`
--
DROP TABLE IF EXISTS `view_konsumen`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_konsumen`  AS SELECT `konsumen`.`id_konsumen` AS `id_konsumen`, `konsumen`.`nama` AS `nama`, `konsumen`.`email` AS `email` FROM `konsumen` ;

-- --------------------------------------------------------

--
-- Structure for view `view_produk`
--
DROP TABLE IF EXISTS `view_produk`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_produk`  AS SELECT `produk`.`id_produk` AS `id_produk`, `produk`.`name` AS `name`, `produk`.`harga` AS `harga` FROM `produk` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id_keranjang`),
  ADD KEY `keranjang_id_konsumen` (`id_konsumen`);

--
-- Indexes for table `konsumen`
--
ALTER TABLE `konsumen`
  ADD PRIMARY KEY (`id_konsumen`);

--
-- Indexes for table `pekerja`
--
ALTER TABLE `pekerja`
  ADD PRIMARY KEY (`id_pekerja`);

--
-- Indexes for table `pesan`
--
ALTER TABLE `pesan`
  ADD PRIMARY KEY (`id_pesan`),
  ADD KEY `pesan_id_konsumen` (`id_konsumen`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`),
  ADD KEY `transaksi_id_konsumen` (`id_konsumen`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id_keranjang` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `konsumen`
--
ALTER TABLE `konsumen`
  MODIFY `id_konsumen` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pekerja`
--
ALTER TABLE `pekerja`
  MODIFY `id_pekerja` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pesan`
--
ALTER TABLE `pesan`
  MODIFY `id_pesan` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `keranjang_id_konsumen` FOREIGN KEY (`id_konsumen`) REFERENCES `konsumen` (`id_konsumen`);

--
-- Constraints for table `pesan`
--
ALTER TABLE `pesan`
  ADD CONSTRAINT `pesan_id_konsumen` FOREIGN KEY (`id_konsumen`) REFERENCES `konsumen` (`id_konsumen`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_id_konsumen` FOREIGN KEY (`id_konsumen`) REFERENCES `konsumen` (`id_konsumen`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
