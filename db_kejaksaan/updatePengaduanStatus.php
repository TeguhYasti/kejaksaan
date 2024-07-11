<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

// Include the database connection file
include 'koneksi.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Check if all required parameters are available
    if (isset($_POST['id'])) {
        $id = $_POST['id'];
        $status = $_POST['status'];
        $sql = "UPDATE tb_pengaduan SET status='$status' WHERE id=$id";

        // Execute the SQL statement
        if ($koneksi->query($sql) === TRUE) {
            $response['isSuccess'] = true;
            $response['message'] = "Berhasil mengubah status data pengaduan";
        } else {
            $response['isSuccess'] = false;
            $response['message'] = "Gagal mengubah status data pengaduan: " . $koneksi->error;
        }
        // Move uploaded files to their respective folders

    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap";
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);