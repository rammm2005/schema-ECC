-- untuk membuat database
CREATE DATABASE online_shop;
USE online_shop;

CREATE TABLE kategori (
    id_kategori CHAR(5) NOT NULL,
    nama_kategori VARCHAR(50) NOT NULL,
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    PRIMARY KEY(id_kategori)
);

CREATE TABLE penjual(
    id_penjual CHAR(5) NOT NULL,
    nama_penjual VARCHAR(50) NOT NULL,
    -- alamat_penjual VARCHAR(50) NOT NULL,
    id_alamat INT(11) NOT NULL,
    email VARCHAR(50) NOT NULL,
    no_tlp VARCHAR(15) NOT NULL,
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    jenis_kelamin ENUM('cowok', 'cewek'),
    status_penjual BOOLEAN DEFAULT(1),
    PRIMARY KEY(id_penjual),
    FOREIGN KEY(id_alamat) REFERENCES alamat(id_alamat) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE barang (
    id_barang CHAR(5) NOT NULL,
    merk VARCHAR(50) NOT NULL,
    harga FLOAT(11) NOT NULL,
    deskripsi TEXT NOT NULL,
    id_kategori CHAR(5) NOT NULL,
    id_penjual CHAR(5) NOT NULL,
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    PRIMARY KEY(id_barang),
    FOREIGN KEY(id_kategori) REFERENCES kategori(id_kategori) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_penjual) REFERENCES penjual(id_penjual) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE pelanggan(
    id_pelanggan CHAR(5) NOT NULL,
    nama_pelanggan VARCHAR(50) NOT NULL,
    tgl_lahir DATE NOT NULL,
    jenis_kelamin ENUM('cowok', 'cewek', 'kustom'),
    id_alamat INT(11) NOT NULL,
    email VARCHAR(50) NOT NULL,
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    no_tlp VARCHAR(50) NOT NULL,
    PRIMARY KEY(id_pelanggan),
    FOREIGN KEY(id_alamat) REFERENCES alamat(id_alamat) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE alamat(
    id_alamat INT(11) AUTO_INCREMENTS NOT NULL,
    kode_pos INT(10) NOT NULL,
    kabupaten VARCHAR(50),
    kecamatan VARCHAR(50),
    provinsi VARCHAR(50) NOT NULL,
    jalan VARCHAR(100) NOT NULL,
    PRIMARY KEY(id_alamat)
);

CREATE TABLE rating(
    id_rating INT(11) NOT NULL AUTO_INCREMENT,
    id_barang CHAR(5) NOT NULL,
    ulasan TEXT NOT NULL,
    bintang INT(5) NOT NULL,
    id_pelanggan CHAR(5) NOT NULL,
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
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
CREATE TABLE jenis_pembayaran(
    id_pembayaran CHAR(5) NOT NULL,
    tipe_pembayaran VARCHAR(50) NOT NULL,
    status_pembayaran BOOLEAN DEFAULT(1),
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    PRIMARY KEY(id_pembayaran)
);
CREATE TABLE orders(
    id_order CHAR(5) NOT NULL,
    jumlah_order INT(10) NOT NULL,
    total_harga INT(17) NOT NULL,
    alamat_tujuan VARCHAR(100) NOT NULL,
    tgl_order DATE NOT NULL,
    id_pembayaran CHAR(5) NOT NULL,
    id_barang CHAR(5) NOT NULL,
    id_kurir CHAR(5) NOT NULL,
    id_penjual CHAR(5) NOT NULL,
    id_pelanggan CHAR(5) NOT NULL,
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    PRIMARY KEY(id_order),
    FOREIGN KEY(id_barang) REFERENCES barang(id_barang) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_kurir) REFERENCES kurir(id_kurir) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_penjual) REFERENCES penjual(id_penjual) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_pelanggan) REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_pembayaran) REFERENCES jenis_pembayaran(id_pembayaran) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE jasa_pengiriman(
    kode_pengiriman CHAR(5) NOT NULL,
    nama_pengiriman VARCHAR(255) NOT NULL,
    STATUS BOOLEAN DEFAULT(1),
    created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
    update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4)NOT NULL,
     PRIMARY KEY(kode_pengiriman)
);-- Alter Table Command
ALTER TABLE barang
ADD stok INT(11) NOT NULL;


-- Insert Command
INSERT INTO kategori(id_kategori, nama_kategori)
VALUES ('J0001', 'HandPhone'),
    ('J0002', 'Laptop'),
    ('J0003', 'Tablet'),
    ('J0004', 'Aksesoris Handphone'),
    ('J0005', 'Personal Computer');