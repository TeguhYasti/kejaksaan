<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Pastikan bahwa semua parameter yang diperlukan tersedia
    $required_params = ['id', 'nama', 'sekolah'];
    $missing_params = array_diff($required_params, array_keys($_POST));
    if (!empty($missing_params)) {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap: " . implode(", ", $missing_params);
        echo json_encode($response);
        exit;
    }

    $id = $_POST['id'];
    $nama = $_POST['nama'];
    $sekolah = $_POST['sekolah'];



    $sql = "UPDATE tb_jaksa SET sekolah='$sekolah',  nama='$nama'";
    $sql .= " WHERE id = '$id'";

    if ($koneksi->query($sql) === TRUE) {
        $response['isSuccess'] = true;
        $response['message'] = "Berhasil mengedit data pengaduan";

        // Retrieve the updated data
        $updated_data_query = "SELECT * FROM tb_jaksa WHERE id = '$id'";
        $result = $koneksi->query($updated_data_query);
        if ($result->num_rows > 0) {
            $response['data'] = $result->fetch_assoc();
        } else {
            $response['data'] = null;
        }
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Gagal mengedit data pengaduan: " . $koneksi->error;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
