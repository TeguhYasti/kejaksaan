<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    if (isset($_POST['rating']) && isset($_POST['pesan'])) {
        $rating = $_POST['rating'];

        $pesan = $_POST['pesan'];
        $id_user = $_POST['id_user'];

        $sql = "INSERT INTO tb_penilaian (pesan,rating, id_user) VALUES ('$pesan', '$rating', '$id_user')";
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil menambahkan Data Jaksa Masuk pesan";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal menambahkan Data Jaksa Masuk pesan: " . $koneksi->error;
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
