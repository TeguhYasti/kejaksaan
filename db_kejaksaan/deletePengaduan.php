<?php
include 'koneksi.php';

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

$id = $_POST['id'];

$query = "DELETE FROM tb_pengaduan WHERE id='$id'";
$result = mysqli_query($koneksi, $query);

if ($result) {
    $response = array(
        'status' => 'success',
        'message' => 'Data berhasil dihapus'
    );
} else {
    $response = array(
        'status' => 'failed',
        'message' => 'Gagal hapus data'
    );
}

header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($koneksi);
