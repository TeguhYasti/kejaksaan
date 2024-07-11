<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $required_params = ['nama', 'no_hp', 'nik', 'id_user']; // Remove 'status' from required params
    $missing_params = array_diff($required_params, array_keys($_POST));
    if (!empty($missing_params)) {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap: " . implode(", ", $missing_params);
        echo json_encode($response);
        exit;
    }

    $uploads = ['foto_ktp', 'foto_laporan'];
    $uploaded_files = [];
    foreach ($uploads as $upload) {
        if (isset($_FILES[$upload])) {
            $filename = $_FILES[$upload]["name"];
            $tempname = $_FILES[$upload]["tmp_name"];
            $ext = pathinfo($filename, PATHINFO_EXTENSION);
            $filename_without_ext = pathinfo($filename, PATHINFO_FILENAME);
            $angka_acak = rand(1, 999);
            $final_filename = $filename_without_ext . '-' . $angka_acak . '.' . $ext;
            $folder = "C:\\xampp\\htdocs\\db_kejaksaan\\upload\\" . $final_filename;

            if (move_uploaded_file($tempname, $folder)) {
                $uploaded_files[$upload] = $final_filename;
            } else {
                $response['isSuccess'] = false;
                $response['message'] = "Gagal memindahkan file $upload. Pastikan folder tujuan ada dan writable.";
                echo json_encode($response);
                exit;
            }
        } else {
            $uploaded_files[$upload] = null;
        }
    }

    $nama = $_POST['nama'];
    $no_hp = $_POST['no_hp'];
    $nik = $_POST['nik'];
    $id_user = $_POST['id_user'];
    $foto_ktp = $uploaded_files['foto_ktp'];
    $uraian_laporan = $_POST['uraian_laporan'];
    $laporan_pengaduan = $_POST['laporan_pengaduan']; // assuming this is a text field in your form
    $foto_laporan = $uploaded_files['foto_laporan'];

    $sql = "INSERT INTO tb_korupsi (nama, no_hp, nik, foto_ktp, uraian_laporan,  laporan_pengaduan, foto_laporan,  id_user";
    $values = "('$nama', '$no_hp', '$nik', '$foto_ktp', '$uraian_laporan', '$laporan_pengaduan','$foto_laporan',  '$id_user'";

    if (isset($_POST['status'])) {
        $status = $_POST['status'];
        $sql .= ", status";
        $values .= ", '$status'";
    }

    $sql .= ") VALUES $values)";

    if ($koneksi->query($sql) === TRUE) {
        $response['isSuccess'] = true;
        $response['message'] = "Berhasil menambahkan data korupsi";
    } else {
        $response['isSuccess'] = false;
        $response['message'] = "Gagal menambahkan data korupsi: " . $koneksi->error;
    }
} else {
    $response['isSuccess'] = false;
    $response['message'] = "Metode yang diperbolehkan hanya POST";
}

echo json_encode($response);
