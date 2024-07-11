<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';


$id = $_POST['id'];
$username = $_POST['username'];
$email = $_POST['email'];
$no_tlp = $_POST['no_tlp'];
$alamat = $_POST['alamat'];
$nik = $_POST['nik'];


$sql = "UPDATE users SET username='$username', email='$email', no_tlp='$no_tlp', alamat='$alamat', nik='$nik' WHERE id='$id'";
$isSuccess = $koneksi->query($sql);

if ($isSuccess) {
    $cek = "SELECT * FROM users WHERE id =$id";
    $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
    $response['is_success'] = true;
    $response['value'] = 1;
    $response['message'] = "User Berhasil di Edit";
    $response['username'] = $result['username'];
    $response['email'] = $result['email'];
    $response['no_tlp'] = $result['no_tlp'];
    $response['alamat'] = $result['alamat'];
    $response['nik'] = $result['nik'];
    $response['id'] = $result['id'];
} else {
    $response['is_success'] = false;
    $response['value'] = 0;
    $response['message'] = "Gagal Edit User";
}

echo json_encode($response);
