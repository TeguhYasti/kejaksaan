<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$status = isset($_GET['status']) ? $_GET['status'] : '';


$sql = "SELECT * FROM tb_jaksa WHERE status = ?";
$stmt = $koneksi->prepare($sql);
$stmt->bind_param("s", $status);
$stmt->execute();
$result = $stmt->get_result();

$response = array();
if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Data Jaksa";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal menampilkan Data Jaksa";
    $response['data'] = null;
}

echo json_encode($response);
