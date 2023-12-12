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
INSERT INTO barang (id_barang, merk, harga,stok, deskripsi, id_kategori, id_penjual) VALUES
  ('B001', 'Merk A', 100.0,100, 'Deskripsi Barang A', 'K001', 'P001'),
  ('B002', 'Merk B', 150.0,150, 'Deskripsi Barang B', 'K002', 'P002');

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


-- 1. Average Rating for Each Product
SELECT id_barang, AVG(bintang) AS avg_rating
FROM rating
GROUP BY id_barang;

-- 2. Average Price of Products by Category
SELECT K.nama_kategori, AVG(B.harga) AS avg_price
FROM barang B
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 3. Average Order Quantity
SELECT AVG(jumlah_order) AS avg_order_quantity
FROM orders;

-- 4. Average Order Total Price
SELECT AVG(total_harga) AS avg_order_total_price
FROM orders;

-- 5. Average Price of Products Sold by Each Seller
SELECT P.nama_penjual, AVG(B.harga) AS avg_price
FROM barang B
JOIN penjual P ON B.id_penjual = P.id_penjual
GROUP BY P.nama_penjual;

-- 6. Average Number of Orders per Customer
SELECT id_pelanggan, AVG(jumlah_order) AS avg_orders_per_customer
FROM orders
GROUP BY id_pelanggan;

-- 7. Average Rating for Each Category
SELECT K.nama_kategori, AVG(R.bintang) AS avg_rating
FROM kategori K
LEFT JOIN barang B ON K.id_kategori = B.id_kategori
LEFT JOIN rating R ON B.id_barang = R.id_barang
GROUP BY K.nama_kategori;

-- 8. Average Price of Products Sold by Each Seller in Each Category
SELECT P.nama_penjual, K.nama_kategori, AVG(B.harga) AS avg_price
FROM barang B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY P.nama_penjual, K.nama_kategori;

-- 9. Average Rating by Gender for Each Product
SELECT R.id_barang, P.jenis_kelamin, AVG(R.bintang) AS avg_rating
FROM rating R
JOIN pelanggan P ON R.id_pelanggan = P.id_pelanggan
GROUP BY R.id_barang, P.jenis_kelamin;

-- 10. Average Order Quantity by Product
SELECT id_barang, AVG(jumlah_order) AS avg_order_quantity
FROM orders
GROUP BY id_barang;

-- 11. Average Price of Products Sold by Each Seller by Gender
SELECT P.nama_penjual, Pel.jenis_kelamin, AVG(B.harga) AS avg_price
FROM barang B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN pelanggan Pel ON P.id_penjual = Pel.id_alamat
GROUP BY P.nama_penjual, Pel.jenis_kelamin;

-- 12. Average Order Quantity by Seller
SELECT id_penjual, AVG(jumlah_order) AS avg_order_quantity
FROM orders
GROUP BY id_penjual;

-- 13. Average Price of Products Sold in Each Province
SELECT A.provinsi, AVG(B.harga) AS avg_price
FROM barang B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN alamat A ON P.id_alamat = A.id_alamat
GROUP BY A.provinsi;

-- 14. Average Order Total Price by Seller
SELECT id_penjual, AVG(total_harga) AS avg_order_total_price
FROM orders
GROUP BY id_penjual;

-- 15. Average Price of Products Sold in Each City
SELECT A.kabupaten, AVG(B.harga) AS avg_price
FROM barang B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN alamat A ON P.id_alamat = A.id_alamat
GROUP BY A.kabupaten;

-- 16. Average Rating for Each Product by Gender
SELECT R.id_barang, Pel.jenis_kelamin, AVG(R.bintang) AS avg_rating
FROM rating R
JOIN pelanggan Pel ON R.id_pelanggan = Pel.id_pelanggan
GROUP BY R.id_barang, Pel.jenis_kelamin;

-- 17. Average Price of Products Sold by Each Seller in Each City
SELECT P.nama_penjual, A.kabupaten, AVG(B.harga) AS avg_price
FROM barang B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN alamat A ON P.id_alamat = A.id_alamat
GROUP BY P.nama_penjual, A.kabupaten;

-- 18. Average Rating by Age Group for Each Product
SELECT R.id_barang, 
    CASE 
        WHEN YEAR(CURRENT_DATE) - YEAR(Pel.tgl_lahir) BETWEEN 18 AND 30 THEN '18-30'
        WHEN YEAR(CURRENT_DATE) - YEAR(Pel.tgl_lahir) BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS age_group,
    AVG(R.bintang) AS avg_rating
FROM rating R
JOIN pelanggan Pel ON R.id_pelanggan = Pel.id_pelanggan
GROUP BY R.id_barang, age_group;

-- 19. Average Order Quantity by Category
SELECT K.nama_kategori, AVG(jumlah_order) AS avg_order_quantity
FROM orders O
JOIN barang B ON O.id_barang = B.id_barang
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 20. Average Rating by Payment Type for Each Product
SELECT R.id_barang, JP.tipe_pembayaran, AVG(R.bintang) AS avg_rating
FROM rating R
JOIN jenis_pembayaran JP ON R.id_pembayaran = JP.id_pembayaran
GROUP BY R.id_barang, JP.tipe_pembayaran;


