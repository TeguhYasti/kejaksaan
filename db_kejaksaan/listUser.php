<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

// Periksa apakah parameter ID telah diberikan dan tidak kosong
if (isset($_GET['id']) && !empty($_GET['id'])) {
	$id = $_GET['id'];

	$sql = "SELECT * FROM users WHERE id = $id";
	$result = $koneksi->query($sql);

	if ($result->num_rows > 0) {
		$response['isSuccess'] = true;
		$response['message'] = "Berhasil Menampilkan Data User dengan ID $id";
		$response['data'] = $result->fetch_assoc(); // Hanya satu baris data yang diambil
	} else {
		$response['isSuccess'] = false;
		$response['message'] = "Gagal menampilkan Data User dengan ID $id";
		$response['data'] = null;
	}
} else {
	$response['isSuccess'] = false;
	$response['message'] = "Parameter ID tidak diberikan atau kosong";
	$response['data'] = null;
}

echo json_encode($response);
