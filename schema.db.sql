CREATE DATABASE online_shop;


USE online_shop 


CREATE TABLE kategori (
    id_kategori CHAR(5) NOT NULL,
    nama_kategori VARCHAR(50) NOT NULL,
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    PRIMARY KEY(id_kategori)
);

INSERT INTO kategori(id_kategori, nama_kategori)
VALUES ('J0001', 'HandPhone'),
    ('J0002', 'Laptop'),
('J0003', 'Tablet'),
('J0004', 'Aksesoris Handphone'),
('J0005', 'Personal Computer');

SELECT * FROM kategori;


CREATE TABLE penjual(
        id_penjual CHAR(5) NOT NULL,
        nama_penjual VARCHAR(50) NOT NULL,
        alamat_penjual VARCHAR(50) NOT NULL,
        email VARCHAR(50) NOT NULL,
        no_tlp VARCHAR(15) NOT NULL,
        jenis_kelamin ENUM('cowok', 'cewek'),
        status_penjual BOOLEAN DEFAULT(1),
        PRIMARY KEY(id_penjual)
    );

CREATE TABLE barang (
    id_barang CHAR(5) NOT NULL,
    merk VARCHAR(50) NOT NULL,
    harga FLOAT(11) NOT NULL,
    deskripsi TEXT NOT NULL,
    id_kategori CHAR(5) NOT NULL,
    id_penjual CHAR(5) NOT NULL,
    PRIMARY KEY(id_barang),
    FOREIGN KEY(id_kategori) REFERENCES kategori(id_kategori) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_penjual) REFERENCES penjual(id_penjual) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE pelanggan(
    id_pelanggan CHAR(5) NOT NULL,
    nama_pembeli VARCHAR(50) NOT NULL,
    tgl_lahir DATE NOT NULL,
    jenis_kelamin ENUM('cowok', 'cewek', 'kustom'),
    alamat_pembeli VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    no_tlp VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_pelanggan)
);

CREATE TABLE rating(
    id_rating INT(11) NOT NULL AUTO_INCREMENT,
    id_barang CHAR(5) NOT NULL,
    ulasan TEXT NOT NULL,
    bintang INT(5) NOT NULL,
    id_pelanggan CHAR(5) NOT NULL,
    PRIMARY KEY(id_rating),
    FOREIGN KEY(id_barang) REFERENCES barang(id_barang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_pelanggan) REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE kurir(
    id_kurir CHAR(5) NOT NULL,
    nama_kurir VARCHAR(50) NOT NULL,
    alamat VARCHAR(100),
    status_kurir BOOLEAN DEFAULT(1),
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    PRIMARY KEY(id_kurir)
);