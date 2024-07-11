<?php

header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $required_params = ['id', 'nama', 'no_hp', 'nik', 'laporan_pengaduan'];
    $missing_params = array_diff($required_params, array_keys($_POST));
    if (!empty($missing_params)) {
        $response['isSuccess'] = false;
        $response['message'] = "Parameter tidak lengkap: " . implode(", ", $missing_params);
        echo json_encode($response);
        exit;
    }

    $id = $_POST['id'];
    $nama = $_POST['nama'];
    $no_hp = $_POST['no_hp'];
    $nik = $_POST['nik'];
    $laporan_pengaduan = $_POST['laporan_pengaduan'];

    $uploads = ['foto_ktp', 'foto_laporan'];
    $uploaded_files = [];

    foreach ($uploads as $upload) {
        if (isset($_FILES[$upload]) && $_FILES[$upload]['error'] == UPLOAD_ERR_OK) {
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

    $sql = "UPDATE tb_pengaduan SET 
                nama = '$nama', 
                no_hp = '$no_hp', 
                nik = '$nik', 
                laporan_pengaduan = '$laporan_pengaduan'";

    if ($uploaded_files['foto_ktp'] !== null) {
        $foto_ktp = $uploaded_files['foto_ktp'];
        $sql .= ", foto_ktp = '$foto_ktp'";
    }

    if ($uploaded_files['foto_laporan'] !== null) {
        $foto_laporan = $uploaded_files['foto_laporan'];
        $sql .= ", foto_laporan = '$foto_laporan'";
    }

    $sql .= " WHERE id = '$id'";

    if ($koneksi->query($sql) === TRUE) {
        $response['isSuccess'] = true;
        $response['message'] = "Berhasil mengedit data pengaduan";

        // Retrieve the updated data
        $updated_data_query = "SELECT * FROM tb_pengaduan WHERE id = '$id'";
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
