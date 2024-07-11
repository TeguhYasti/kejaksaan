<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array();
    $email = $_POST['email'];
    $password = md5($_POST['password']);

    $cek = "SELECT * FROM users WHERE email = '$email' AND password = '$password'";
    $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));

    if (isset($result)) {
        $response['value'] = 1;
        $response['message'] = "berhasil login";
        $response['username'] = $result['username'];
        $response['email'] = $result['email'];
        $response['no_tlp'] = $result['no_tlp'];
        $response['alamat'] = $result['alamat'];
        $response['nik'] = $result['nik'];
        $response['is_admin'] = $result['is_admin'];
        $response['id'] = $result['id'];

        // Set session ID
        session_start();
        $_SESSION['id_user'] = $result['id'];

        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal login";
        echo json_encode($response);
    }
}
