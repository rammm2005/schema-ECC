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
CREATE TABLE provinsi (
  id_provinsi INT(11) AUTO_INCREMENT NOT NULL,
  nama_provinsi VARCHAR(50) NOT NULL,
  PRIMARY KEY(id_provinsi)
);
CREATE TABLE kabupaten (
  id_kabupaten INT(11) AUTO_INCREMENT NOT NULL,
  nama_kabupaten VARCHAR(50) NOT NULL,
  id_provinsi INT(11) NOT NULL,
  PRIMARY KEY(id_kabupaten),
  FOREIGN KEY(id_provinsi) REFERENCES provinsi(id_provinsi) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE kecamatan (
  id_kecamatan INT(11) AUTO_INCREMENT NOT NULL,
  nama_kecamatan VARCHAR(50) NOT NULL,
  id_kabupaten INT(11) NOT NULL,
  PRIMARY KEY(id_kecamatan),
  FOREIGN KEY(id_kabupaten) REFERENCES kabupaten(id_kabupaten) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE desa_kelurahan (
  id_desa_kelurahan INT(11) AUTO_INCREMENT NOT NULL,
  nama_desa_kelurahan VARCHAR(50) NOT NULL,
  id_kecamatan INT(11) NOT NULL,
  PRIMARY KEY(id_desa_kelurahan),
  FOREIGN KEY(id_kecamatan) REFERENCES kecamatan(id_kecamatan) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE kode_pos (
  id_kode_pos INT(11) AUTO_INCREMENT NOT NULL,
  kode_pos INT(10) NOT NULL,
  id_desa_kelurahan INT(11) NOT NULL,
  PRIMARY KEY(id_kode_pos),
  FOREIGN KEY(id_desa_kelurahan) REFERENCES desa_kelurahan(id_desa_kelurahan) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE penjual (
  id_penjual CHAR(5) NOT NULL,
  nama_penjual VARCHAR(50) NOT NULL,
  jalan VARCHAR(150),
  id_kode_pos INT(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  no_tlp VARCHAR(15) NOT NULL,
  created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  jenis_kelamin ENUM('cowok', 'cewek'),
  status_penjual BOOLEAN DEFAULT(1),
  PRIMARY KEY(id_penjual),
  FOREIGN KEY(id_kode_pos) REFERENCES kode_pos(id_kode_pos) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE produk (
  id_produk CHAR(5) NOT NULL,
  merk VARCHAR(50) NOT NULL,
  harga DECIMAL(11) NOT NULL,
  deskripsi TEXT NOT NULL,
  id_kategori CHAR(5) NOT NULL,
  id_penjual CHAR(5) NOT NULL,
  created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  PRIMARY KEY(id_produk),
  FOREIGN KEY(id_kategori) REFERENCES kategori(id_kategori) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(id_penjual) REFERENCES penjual(id_penjual) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE pelanggan(
  id_pelanggan CHAR(5) NOT NULL,
  nama_pelanggan VARCHAR(50) NOT NULL,
  jalan VARCHAR(150),
  tgl_lahir DATE NOT NULL,
  jenis_kelamin ENUM('cowok', 'cewek', 'kustom'),
  id_kode_pos INT(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  no_tlp VARCHAR(50) NOT NULL,
  PRIMARY KEY(id_pelanggan),
  FOREIGN KEY(id_kode_pos) REFERENCES kode_pos(id_kode_pos) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE rating(
  id_rating INT(11) NOT NULL AUTO_INCREMENT,
  id_produk CHAR(5) NOT NULL,
  ulasan TEXT NOT NULL,
  bintang INT(5) NOT NULL,
  id_pelanggan CHAR(5) NOT NULL,
  created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  PRIMARY KEY(id_rating),
  FOREIGN KEY(id_produk) REFERENCES produk(id_produk) ON DELETE CASCADE ON UPDATE CASCADE,
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
  id_produk CHAR(5) NOT NULL,
  id_kurir CHAR(5) NOT NULL,
  id_penjual CHAR(5) NOT NULL,
  id_pelanggan CHAR(5) NOT NULL,
  created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  PRIMARY KEY(id_order),
  FOREIGN KEY(id_produk) REFERENCES produk(id_produk) ON DELETE CASCADE ON UPDATE CASCADE,
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
  update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  PRIMARY KEY(kode_pengiriman)
);
-- Alter Table Command
ALTER TABLE produk
ADD stok INT(11) NOT NULL;
-- Insert Command
INSERT INTO kategori(id_kategori, nama_kategori)
VALUES ('J0001', 'HandPhone'),
  ('J0002', 'Laptop'),
  ('J0003', 'Tablet'),
  ('J0004', 'Aksesoris Handphone'),
  ('J0005', 'Personal Computer');
-- Insert into provinsi
INSERT INTO provinsi (nama_provinsi)
VALUES ('Bali');
-- Insert into kabupaten
INSERT INTO kabupaten (nama_kabupaten, id_provinsi)
VALUES ('Badung', 1),
  ('Bangli', 1),
  ('Buleleng', 1),
  ('Gianyar', 1),
  ('Jembrana', 1),
  ('Karangasem', 1),
  ('Klungkung', 1),
  ('Tabanan', 1);
-- Insert into kecamatan
INSERT INTO kecamatan (nama_kecamatan, id_kabupaten)
VALUES ('Kuta', 1),
  ('Petang', 1);
-- Insert into desa_kelurahan
INSERT INTO desa_kelurahan (nama_desa_kelurahan, id_kecamatan)
VALUES ('Kuta', 1),
  ('Legian', 1);
-- Insert into kode_pos
INSERT INTO kode_pos (kode_pos, id_desa_kelurahan)
VALUES (80361, 1),
  -- Kuta
  (80361, 2);
-- Legian
-- Insert into penjual
INSERT INTO penjual (
    id_penjual,
    nama_penjual,
    jalan,
    id_kode_pos,
    email,
    no_tlp,
    jenis_kelamin,
    status_penjual
  )
VALUES (
    'P1000',
    'Toko ABC',
    'Jalan Raya No. 123',
    1,
    'tokoabc@email.com',
    '08123456789',
    'cowok',
    1
  ),
  (
    'P2000',
    'Toko XYZ',
    'Jalan Utama No. 456',
    2,
    'tokoxyx@email.com',
    '08234567890',
    'cewek',
    1
  );
-- Insert into produk
INSERT INTO produk (
    id_produk,
    merk,
    harga,
    deskripsi,
    id_kategori,
    id_penjual
  )
VALUES (
    'PR1',
    'Produk A',
    100000,
    'Deskripsi Produk A',
    'J0002',
    'P1000'
  ),
  (
    'PR2',
    'Produk B',
    150000,
    'Deskripsi Produk B',
    'J0001',
    'P2000'
  );
-- Insert into pelanggan
INSERT INTO pelanggan (
    id_pelanggan,
    nama_pelanggan,
    jalan,
    tgl_lahir,
    jenis_kelamin,
    id_kode_pos,
    email,
    no_tlp
  )
VALUES (
    'C1000',
    'Pelanggan 1',
    'Jalan Pelanggan 1',
    '2000-01-01',
    'cowok',
    1,
    'pelanggan1@email.com',
    '08345678901'
  ),
  (
    'C2000',
    'Pelanggan 2',
    'Jalan Pelanggan 2',
    '1995-05-15',
    'cewek',
    2,
    'pelanggan2@email.com',
    '08456789012'
  );
-- Insert into rating
INSERT INTO rating (id_produk, ulasan, bintang, id_pelanggan)
VALUES ('PR1', 'Produk A bagus', 5, 'C1000'),
  ('PR2', 'Produk B kurang memuaskan', 3, 'C2000');
-- Insert into kurir
INSERT INTO kurir (id_kurir, nama_kurir, alamat, status_kurir)
VALUES ('K1000', 'JNE Express', 'Jalan Ekspres No. 1', 1),
  ('K2000', 'Pos Indonesia', 'Jalan Pos No. 2', 1);
-- Insert into jenis_pembayaran
INSERT INTO jenis_pembayaran (
    id_pembayaran,
    tipe_pembayaran,
    status_pembayaran
  )
VALUES ('P0001', 'Transfer Bank', 1),
  ('P0002', 'Kartu Kredit', 1);
-- Insert into orders
INSERT INTO orders (
    id_order,
    jumlah_order,
    total_harga,
    alamat_tujuan,
    tgl_order,
    id_pembayaran,
    id_produk,
    id_kurir,
    id_penjual,
    id_pelanggan
  )
VALUES (
    'OR001',
    2,
    200000,
    'Jalan Raya No. 123',
    '2023-01-15',
    'P0001',
    'PR1',
    'K1000',
    'P1000',
    'C1000'
  ),
  (
    'OR002',
    1,
    150000,
    'Jalan Utama No. 456',
    '2023-01-16',
    'P0002',
    'PR2',
    'K2000',
    'P2000',
    'C2000'
  );
-- Insert into jasa_pengiriman
INSERT INTO jasa_pengiriman (kode_pengiriman, nama_pengiriman, STATUS)
VALUES ('JP001', 'Reguler', 1),
  ('JP002', 'Express', 1);



-- Study Case AVG
-- 1. Average Rating for Each Product
SELECT id_produk, AVG(bintang) AS avg_rating
FROM rating
GROUP BY id_produk;

-- 2. Average Price of Products by Category
SELECT K.nama_kategori, AVG(P.harga) AS avg_price
FROM produk P
JOIN kategori K ON P.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 3. Average Order Quantity
SELECT AVG(jumlah_order) AS avg_order_quantity
FROM orders;

-- 4. Average Order Total Price
SELECT AVG(total_harga) AS avg_order_total_price
FROM orders;

-- 5. Average Price of Products Sold by Each Seller
SELECT P.nama_penjual, AVG(B.harga) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
GROUP BY P.nama_penjual;

-- 6. Average Number of Orders per Customer
SELECT id_pelanggan, AVG(jumlah_order) AS avg_orders_per_customer
FROM orders
GROUP BY id_pelanggan;

-- 7. Average Rating for Each Category
SELECT K.nama_kategori, AVG(R.bintang) AS avg_rating
FROM kategori K
LEFT JOIN produk B ON K.id_kategori = B.id_kategori
LEFT JOIN rating R ON B.id_produk = R.id_produk
GROUP BY K.nama_kategori;

-- 8. Average Price of Products Sold by Each Seller in Each Category
SELECT P.nama_penjual, K.nama_kategori, AVG(B.harga) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY P.nama_penjual, K.nama_kategori;

-- 9. Average Rating by Gender for Each Product
SELECT R.id_produk, P.jenis_kelamin, AVG(R.bintang) AS avg_rating
FROM rating R
JOIN pelanggan P ON R.id_pelanggan = P.id_pelanggan
GROUP BY R.id_produk, P.jenis_kelamin;

-- 10. Average Order Quantity by Product
SELECT id_produk, AVG(jumlah_order) AS avg_order_quantity
FROM orders
GROUP BY id_produk;

-- 11. Average Price of Products Sold by Each Seller by Gender
SELECT P.nama_penjual, Pel.jenis_kelamin, AVG(B.harga) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN pelanggan Pel ON P.id_penjual = Pel.id_alamat
GROUP BY P.nama_penjual, Pel.jenis_kelamin;

-- 12. Average Order Quantity by Seller
SELECT id_penjual, AVG(jumlah_order) AS avg_order_quantity
FROM orders
GROUP BY id_penjual;

-- 13. Average Price of Products Sold in Each Province
SELECT A.provinsi, AVG(B.harga) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN alamat A ON P.id_alamat = A.id_alamat
GROUP BY A.provinsi;

-- 14. Average Order Total Price by Seller
SELECT id_penjual, AVG(total_harga) AS avg_order_total_price
FROM orders
GROUP BY id_penjual;

-- 15. Average Price of Products Sold in Each City
SELECT A.kabupaten, AVG(B.harga) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN alamat A ON P.id_alamat = A.id_alamat
GROUP BY A.kabupaten;

-- 16. Average Rating for Each Product by Gender
SELECT R.id_produk, Pel.jenis_kelamin, AVG(R.bintang) AS avg_rating
FROM rating R
JOIN pelanggan Pel ON R.id_pelanggan = Pel.id_pelanggan
GROUP BY R.id_produk, Pel.jenis_kelamin;

-- 17. Average Price of Products Sold by Each Seller in Each City
SELECT P.nama_penjual, A.kabupaten, AVG(B.harga) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN alamat A ON P.id_alamat = A.id_alamat
GROUP BY P.nama_penjual, A.kabupaten;

-- 18. Average Rating by Age Group for Each Product
SELECT R.id_produk, 
    CASE 
        WHEN YEAR(CURRENT_DATE) - YEAR(Pel.tgl_lahir) BETWEEN 18 AND 30 THEN '18-30'
        WHEN YEAR(CURRENT_DATE) - YEAR(Pel.tgl_lahir) BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS age_group,
    AVG(R.bintang) AS avg_rating
FROM rating R
JOIN pelanggan Pel ON R.id_pelanggan = Pel.id_pelanggan
GROUP BY R.id_produk, age_group;

-- 19. Average Order Quantity by Category
SELECT K.nama_kategori, AVG(jumlah_order) AS avg_order_quantity
FROM orders O
JOIN produk B ON O.id_produk = B.id_produk
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 20. Average Rating by Payment Type for Each Product
SELECT R.id_produk, JP.tipe_pembayaran, AVG(R.bintang) AS avg_rating
FROM rating R
JOIN jenis_pembayaran JP ON R.id_pembayaran = JP.id_pembayaran
GROUP BY R.id_produk, JP.tipe_pembayaran;
