-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 30 Bulan Mei 2024 pada 04.05
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_informasikejaksaan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_jaksa`
--

CREATE TABLE `tb_jaksa` (
  `id` int(11) NOT NULL,
  `sekolah` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `status` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_jaksa`
--

INSERT INTO `tb_jaksa` (`id`, `sekolah`, `nama`, `status`, `id_user`) VALUES
(1, 'SMA 3 Jakarta', 'githani', 0, 7),
(4, 'SMA 2 Padang', 'sasa', 1, 8),
(5, 'SMA 10 Padang', 'biba', 2, 8),
(6, 'SMA 1 Padang', 'fika', 1, 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_korupsi`
--

CREATE TABLE `tb_korupsi` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_hp` varchar(16) NOT NULL,
  `nik` varchar(255) NOT NULL,
  `foto_ktp` varchar(255) NOT NULL,
  `uraian_laporan` text NOT NULL,
  `laporan_pengaduan` varchar(255) NOT NULL,
  `foto_laporan` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_korupsi`
--

INSERT INTO `tb_korupsi` (`id`, `nama`, `no_hp`, `nik`, `foto_ktp`, `uraian_laporan`, `laporan_pengaduan`, `foto_laporan`, `status`, `id_user`) VALUES
(1, 'kiki', '08676567456', '', 'ktp5.pdf', 'ada salah satu pegawai yang melakukan korupsi', 'korupsi di kantor', 'bukti1.pdf', 0, 7),
(3, 'jeje', '6876987698', '12312312', '1279879', 'korupsi yang dilakukan oleh 2 orang dikantor.', 'korupsi', 'foto3.pdf', 0, 7),
(4, 'kekey', '08966678', '124323467', 'CIPTA INOVASI_GITHANI RIZKYKA PASYA-404.pdf', 'jhvbmn', 'iuybbmnb', 'KTM-422.pdf', 0, 7),
(6, 'dika', '798798', '11120000', 'ktp1-653.pdf', 'pidana korupsi yang dilakukan manager perusahaan', 'korupsi oleh manager', 'foto2-116.pdf', 1, 8),
(7, 'didi', '0936345', '124323467', 'ktp2-295.pdf', 'foto2-605.pdf', 'iuybbmnb', 'jhvbmn', 1, 8),
(8, 'jina', '76575', '98678', 'KTM-122.pdf', 'gfghf', 'hghjg', 'KTM-813.pdf', 1, 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pengaduan`
--

CREATE TABLE `tb_pengaduan` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_hp` varchar(16) NOT NULL,
  `nik` varchar(255) NOT NULL,
  `foto_ktp` varchar(255) NOT NULL,
  `laporan_pengaduan` varchar(255) NOT NULL,
  `foto_laporan` varchar(255) NOT NULL,
  `kategori` varchar(255) NOT NULL,
  `status` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_pengaduan`
--

INSERT INTO `tb_pengaduan` (`id`, `nama`, `no_hp`, `nik`, `foto_ktp`, `laporan_pengaduan`, `foto_laporan`, `kategori`, `status`, `id_user`) VALUES
(4, 'toniiii', '081934', '1111', 'ktp2.pdf', 'ada beberapa pegawai yang melakukan tindak pidana korupsi', 'foto2.pdf', 'korupsi', 1, 5),
(6, 'fifi', '90890834', '134235', 'ktp3.pdf', 'pegawai tidak bekerja', 'foto1.pdf', 'pegawai', 0, 7),
(7, 'ffila', '90890834', '134235', 'ktp3.pdf', 'pegawai tidak bekerja', 'foto1.pdf', 'pegawai', 0, 7),
(9, 'dila', '90890834', '134235', 'ktp3.pdf', 'pegawai malas', 'foto1.pdf', 'pegawai', 0, 8),
(10, 'kila', '7868796', '980978', 'ktp1-975.pdf', 'jhflkdhasdf', 'ktp1-975.pdf', 'pegawai', 0, 8),
(11, 'fifa', '7868796', '980978', 'ktp1-449.pdf', 'jhflkdhasdf', 'ktp1-320.pdf', 'pegawai', 2, 8),
(12, 'fisa', '0000', '1111', 'foto2-786.pdf', 'ada beberapa pegawai yang melakukan tindak pidana korupsi', 'ktp2-812.pdf', 'Korupsi', 0, 8),
(13, 'fahri', '0872345672', '4412312', 'foto2-500.pdf', 'Ingin melaksanakan penyuluhan hukum', 'ktp2-481.pdf', 'hukum', 1, 7),
(14, 'mirna', '08456333', '990000', 'ktp2-408.pdf', 'adanya pengawasan aliran hukum', 'foto2-302.pdf', 'agama', 1, 7),
(15, 'toni', '0878676', '1231111', 'ktp2-112.pdf', 'posko pilkada tahun 2024', 'foto2-909.pdf', 'pilkada', 2, 7),
(16, 'rere', '0878676', '1231111', 'ktp2-788.pdf', 'posko pilkada tahun 2024', 'foto2-671.pdf', 'pilkada', 1, 7),
(17, 'kuya', '08576567', '1344', 'KTM-830.pdf', 'sdsd', 'KTM-68.pdf', 'pegawai', 1, 7),
(18, 'biba', '0866456', '124124', 'Githani Rizkyka Pasya - Mendali Perunggu-863.pdf', 'dfasfsfs', 'Githani Rizkyka Pasya - Sertifikat-632.pdf', 'hukum', 1, 7),
(19, 'lika', '0865645', '423423', 'KTM-226.pdf', 'gsdfg', 'KTM-793.pdf', 'agama', 1, 7),
(20, 'santoso', '08243267', '534345', 'KTM-733.pdf', 'bsdfsd', 'KTM-981.pdf', 'pilkada', 1, 7),
(21, 'bima', '86876', '54564', 'KTM-71.pdf', 'werwrsf', 'KTM-794.pdf', 'pegawai', 1, 7),
(24, 'putra', '01111', '97777777', 'KTM-915.pdf', 'gjhfggf', 'KTM-619.pdf', 'pegawai', 1, 7);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_penilaian`
--

CREATE TABLE `tb_penilaian` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `pesan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb_penilaian`
--

INSERT INTO `tb_penilaian` (`id`, `id_user`, `rating`, `pesan`) VALUES
(1, 7, 5, 'pelayanan cepat'),
(2, 8, 5, 'pelayanan ramah');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `no_tlp` varchar(50) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `is_admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `no_tlp`, `alamat`, `nik`, `is_admin`) VALUES
(5, 'gigi', '0c0b3da4ac402bd86191d959be081114', 'gigi@gmail.com', '067783423', 'padang', '123213', 0),
(6, 'githa', '202cb962ac59075b964b07152d234b70', 'githa@gmail.com', '0812342356', 'jakarta', '123687678', 1),
(7, 'budi', '202cb962ac59075b964b07152d234b70', 'budi@gmail.com', '0956756751', 'bogor', '00812314234', 0),
(8, 'tita', '202cb962ac59075b964b07152d234b70', 'tita@gmail.com', '087812434', 'solok', '001342432', 0),
(9, 'tina', '202cb962ac59075b964b07152d234b70', 'tina@gmail.com', '90789', 'padang', '907987', 0),
(10, 'lola', '202cb962ac59075b964b07152d234b70', 'lola@gmail.com', '9686', 'padang', '8979869', 0),
(11, 'yana', '202cb962ac59075b964b07152d234b70', 'yana@gmail.com', '987876', 'padang', '76875', 0);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb_jaksa`
--
ALTER TABLE `tb_jaksa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `tb_korupsi`
--
ALTER TABLE `tb_korupsi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `tb_pengaduan`
--
ALTER TABLE `tb_pengaduan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `tb_penilaian`
--
ALTER TABLE `tb_penilaian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tb_jaksa`
--
ALTER TABLE `tb_jaksa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tb_korupsi`
--
ALTER TABLE `tb_korupsi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `tb_pengaduan`
--
ALTER TABLE `tb_pengaduan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT untuk tabel `tb_penilaian`
--
ALTER TABLE `tb_penilaian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tb_jaksa`
--
ALTER TABLE `tb_jaksa`
  ADD CONSTRAINT `tb_jaksa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `tb_korupsi`
--
ALTER TABLE `tb_korupsi`
  ADD CONSTRAINT `tb_korupsi_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `tb_pengaduan`
--
ALTER TABLE `tb_pengaduan`
  ADD CONSTRAINT `tb_pengaduan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `tb_penilaian`
--
ALTER TABLE `tb_penilaian`
  ADD CONSTRAINT `tb_penilaian_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
