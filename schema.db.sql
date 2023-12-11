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
    jalan VARCHAR(150),
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
    jalan VARCHAR(150),
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
);


-- Alter Table Command
ALTER TABLE barang
ADD stok INT(11) NOT NULL;


-- Insert Command
INSERT INTO kategori(id_kategori, nama_kategori)
VALUES ('J0001', 'HandPhone'),
    ('J0002', 'Laptop'),
    ('J0003', 'Tablet'),
    ('J0004', 'Aksesoris Handphone'),
    ('J0005', 'Personal Computer');

-- Insert data into the "alamat" table
INSERT INTO alamat (kode_pos, kabupaten, kecamatan, provinsi) VALUES
  (12345, 'Kabupaten A', 'Kecamatan A1', 'Provinsi A'),
  (23456, 'Kabupaten B', 'Kecamatan B1', 'Provinsi B'),
  (23456, 'Kabupaten C', 'Kecamatan C1', 'Provinsi C');


-- Insert data into the "penjual" table
INSERT INTO penjual (id_penjual, nama_penjual, id_alamat, email, no_tlp, jenis_kelamin, status_penjual, jalan) VALUES
  ('P001', 'Penjual 1', 1, 'penjual1@example.com', '1234567890', 'cowok', 1, 'Jalan A 1'),
  ('P002', 'Penjual 2', 2, 'penjual2@example.com', '9876543210', 'cewek', 1, 'Jalan B 1');

-- Insert data into the "barang" table
INSERT INTO barang (id_barang, merk, harga, deskripsi, id_kategori, id_penjual) VALUES
  ('B001', 'Merk A', 100.0, 'Deskripsi Barang A', 'K001', 'P001'),
  ('B002', 'Merk B', 150.0, 'Deskripsi Barang B', 'K002', 'P002');

-- Insert data into the "pelanggan" table
INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, tgl_lahir, jenis_kelamin, id_alamat, email, no_tlp) VALUES
  ('PL001', 'Pelanggan A', '1990-01-01', 'cowok', 3, 'pelangganA@example.com', '111222333', 'Jalan X 1'),
  ('PL002', 'Pelanggan B', '1985-05-15', 'cewek', 4, 'pelangganB@example.com', '444555666', 'Jalan Z 1');

-- Insert data into the "rating" table
INSERT INTO rating (id_barang, ulasan, bintang, id_pelanggan) VALUES
  ('B001', 'Ulasan Produk A', 4, 'PL001'),
  ('B002', 'Ulasan Produk B', 5, 'PL002');

-- Insert data into the "kurir" table
INSERT INTO kurir (id_kurir, nama_kurir, alamat, status_kurir) VALUES
  ('K001', 'Kurir A', 'Alamat Kurir A', 1),
  ('K002', 'Kurir B', 'Alamat Kurir B', 1);

-- Insert data into the "jenis_pembayaran" table
INSERT INTO jenis_pembayaran (id_pembayaran, tipe_pembayaran, status_pembayaran) VALUES
  ('JP001', 'Pembayaran A', 1),
  ('JP002', 'Pembayaran B', 1);

-- Insert data into the "orders" table
INSERT INTO orders (id_order, jumlah_order, total_harga, alamat_tujuan, tgl_order, id_pembayaran, id_barang, id_kurir, id_penjual, id_pelanggan) VALUES
  ('O001', 2, 200, 'Alamat Tujuan 1', '2023-01-01', 'JP001', 'B001', 'K001', 'P001', 'PL001'),
  ('O002', 3, 300, 'Alamat Tujuan 2', '2023-01-02', 'JP002', 'B002', 'K002', 'P002', 'PL002');

-- Insert data into the "jasa_pengiriman" table
INSERT INTO jasa_pengiriman (kode_pengiriman, nama_pengiriman, status) VALUES
  ('JP001', 'Jasa Pengiriman A', 1),
  ('JP002', 'Jasa Pengiriman B', 1);
