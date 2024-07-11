<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$status = isset($_GET['status']) ? $_GET['status'] : '';
$kategori = isset($_GET['kategori']) ? $_GET['kategori'] : '';

$sql = "SELECT * FROM tb_pengaduan WHERE status = ? AND kategori = ?";
$stmt = $koneksi->prepare($sql);
$stmt->bind_param("ss", $status, $kategori);
$stmt->execute();
$result = $stmt->get_result();

$response = array();
if ($result->num_rows > 0) {
	$response['isSuccess'] = true;
	$response['message'] = "Berhasil Menampilkan Data Pengaduan";
	$response['data'] = array();
	while ($row = $result->fetch_assoc()) {
		$response['data'][] = $row;
	}
} else {
	$response['isSuccess'] = false;
	$response['message'] = "Gagal menampilkan Data Pengaduan";
	$response['data'] = null;
}

echo json_encode($response);
