<?php

header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {

    $response = array();
    $username = $_POST['username'];
    $no_tlp = $_POST['no_tlp'];
    $email = $_POST['email'];
    $alamat = $_POST['alamat'];
    $nik = $_POST['nik'];
    $password = md5($_POST['password']);

    $cek = "SELECT * FROM users WHERE username = '$username' OR email = '$email'";
    $result = mysqli_query($koneksi, $cek);

    if (mysqli_num_rows($result) > 0) {
        $response['value'] = 2;
        $response['message'] = "Username atau email telah digunakan";
        echo json_encode($response);
    } else {
        $insert = "INSERT INTO users (username, no_tlp, email, password, alamat, nik, is_admin) 
                   VALUES ('$username', '$no_tlp', '$email', '$password', '$alamat', '$nik', 0)";

        if (mysqli_query($koneksi, $insert)) {
            $response['value'] = 1;
            $response['message'] = "Registrasi Berhasil";
            echo json_encode($response);
        } else {
            $response['value'] = 0;
            $response['message'] = "Gagal Registrasi";
            echo json_encode($response);
        }
    }
}
