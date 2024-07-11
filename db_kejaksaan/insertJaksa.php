<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    if (isset($_POST['nama']) && isset($_POST['sekolah'])) {
        $nama = $_POST['nama'];

        $sekolah = $_POST['sekolah'];
        $id_user = $_POST['id_user'];

        $sql = "INSERT INTO tb_jaksa (sekolah,nama, id_user) VALUES ('$sekolah', '$nama', '$id_user')";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menambahkan Data Jaksa Masuk sekolah";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan Data Jaksa Masuk sekolah: " . $koneksi->error;
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
