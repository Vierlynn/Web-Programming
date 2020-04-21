-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 13, 2020 at 09:19 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apotek-ku`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `nama`, `username`, `password`) VALUES
(2, 'gear24', 'gear', '$2y$10$S0XcIKPCer5r6al6WhAPCO8YwKBd.ATd.q.y05hnHE7pmicIhqZ4W'),
(3, 'we', 'wejoy', '$2y$10$IpzRtfmuMjwGsH2aft7SNeW2Y/m8TsWGg2DRJ0ub4Beh6SVp6c8IK');

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id` int(11) NOT NULL,
  `transaksi_id` int(11) NOT NULL,
  `kode_obat` varchar(100) NOT NULL,
  `jumlah` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`id`, `transaksi_id`, `kode_obat`, `jumlah`) VALUES
(8, 17, 'INST', 1),
(9, 18, 'xxx', 1),
(10, 18, 'BTDN', 1),
(11, 18, 'INST', 1),
(12, 19, 'ENTR01', 1),
(13, 19, 'SLDX', 1);

--
-- Triggers `detail_transaksi`
--
DELIMITER $$
CREATE TRIGGER `kurangi_stok_obat` BEFORE INSERT ON `detail_transaksi` FOR EACH ROW BEGIN
	DECLARE stok_sisa INT;
    SELECT stok INTO stok_sisa FROM obat WHERE kode = NEW.kode_obat;
    IF stok_sisa < NEW.jumlah THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stok tidak mencukupi';
    END IF;
	UPDATE obat SET stok = stok - NEW.jumlah WHERE kode = NEW.kode_obat;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `kode` varchar(100) NOT NULL,
  `supplier_id` int(11) NOT NULL,
  `nama_obat` varchar(255) NOT NULL,
  `produsen` varchar(100) NOT NULL,
  `stok` int(11) UNSIGNED NOT NULL,
  `foto` varchar(255) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`kode`, `supplier_id`, `nama_obat`, `produsen`, `stok`, `foto`, `harga`) VALUES
('BTDN', 1, 'Bethadine', 'Ovo', 1, '2019-07-04-11-23-20_5d1e27f85dc0b.jpg', 10000),
('ENTR01', 3, 'Entro Stop', 'Elevina', 14, '2019-07-04-11-22-33_5d1e27c92eb50.jpg', 5000),
('INST', 1, 'Insto', 'Limo', 10, '2019-07-04-11-27-04_5d1e28d83a4df.jpg', 15000),
('SLDX', 1, 'Siladex', 'Limo', 19, '2019-07-04-11-26-06_5d1e289e36909.jpg', 15000),
('xxx', 1, 'ELAKANA', 'SANBE', 59, '2020-04-14-02-01-32_5e94b70c2fb38.jpg', 15000);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `alamat` text NOT NULL,
  `kota` varchar(100) NOT NULL,
  `telp` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`id`, `nama`, `alamat`, `kota`, `telp`) VALUES
(1, 'gg', 'Padang Bulan', 'Medan', '021123123'),
(2, 'cc', 'Kemunciran', 'Jakarta', '021123123'),
(3, 'winterwood', 'Sei Borin', 'Medan', '0213123123'),
(4, 'gear', 'ahmad yahnis', 'PEKANBARU', '124557877');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `tgl` datetime NOT NULL,
  `nama_pembeli` varchar(255) NOT NULL,
  `admin_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id`, `tgl`, `nama_pembeli`, `admin_id`) VALUES
(17, '2020-04-14 02:05:03', 'winterwood', 3),
(18, '2020-04-14 02:06:13', 'OTOKO DAAAAA', 2),
(19, '2020-04-14 02:07:17', 'Kazuma dessu', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_id` (`transaksi_id`),
  ADD KEY `kode_obat` (`kode_obat`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`kode`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`kode_obat`) REFERENCES `obat` (`kode`),
  ADD CONSTRAINT `detail_transaksi_ibfk_3` FOREIGN KEY (`kode_obat`) REFERENCES `obat` (`kode`) ON DELETE NO ACTION;

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
