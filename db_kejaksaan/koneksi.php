<?php

$koneksi = mysqli_connect("localhost", "root", "", "db_informasikejaksaan");

if ($koneksi) {

	// echo "Database berhasil Connect";

} else {
	echo "gagal Connect";
}
