<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$id_user = isset($_GET['id_user']) ? $_GET['id_user'] : '';


$sql = "SELECT * FROM tb_jaksa WHERE id_user = ?";
$stmt = $koneksi->prepare($sql);
$stmt->bind_param("s", $id_user);
$stmt->execute();
$result = $stmt->get_result();

$response = array();
if ($result->num_rows > 0) {
    $response['isSuccess'] = true;
    $response['message'] = "Berhasil Menampilkan Data Korupsi";
    $response['data'] = array();
    while ($row = $result->fetch_assoc()) {
        $response['data'][] = $row;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Gagal menampilkan Data Korupsi";
    $response['data'] = null;
}

echo json_encode($response);
