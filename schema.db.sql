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
  PRIMARY KEY(id_kabupaten)
);
CREATE TABLE kecamatan (
  id_kecamatan INT(11) AUTO_INCREMENT NOT NULL,
  nama_kecamatan VARCHAR(50) NOT NULL,
  PRIMARY KEY(id_kecamatan)
);
CREATE TABLE desa_kelurahan (
  id_desa_kelurahan INT(11) AUTO_INCREMENT NOT NULL,
  nama_desa_kelurahan VARCHAR(50) NOT NULL,
  PRIMARY KEY(id_desa_kelurahan)
);

CREATE TABLE kode_pos (
  id_kode_pos INT(11) AUTO_INCREMENT NOT NULL,
  kode_pos INT(10) NOT NULL,
  PRIMARY KEY(id_kode_pos)
);

CREATE TABLE alamat (
  id_alamat INT(11) AUTO_INCREMENT NOT NULL,
  id_provinsi INT(11) NOT NULL,
  id_kabupaten INT(11)  NOT NULL,
  id_kode_pos INT(11) NOT NULL,
  id_kecamatan INT(11) NOT NULL,
  id_desa_kelurahan INT(11) NOT NULL,
  PRIMARY KEY(id_alamat),
  FOREIGN KEY(id_provinsi) REFERENCES provinsi(id_provinsi) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(id_kabupaten) REFERENCES kabupaten(id_kabupaten) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(id_kecamatan) REFERENCES kecamatan(id_kecamatan) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(id_desa_kelurahan) REFERENCES desa_kelurahan(id_desa_kelurahan) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(id_kode_pos) REFERENCES kode_pos(id_kode_pos) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE penjual (
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
CREATE TABLE produk (
  id_produk CHAR(6) NOT NULL,
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
  id_alamat INT(11)  NOT NULL, 
  email VARCHAR(50) NOT NULL,
  created_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  update_at DATETIME(4) DEFAULT CURRENT_TIMESTAMP(4) NOT NULL,
  no_tlp VARCHAR(50) NOT NULL,
  PRIMARY KEY(id_pelanggan),
  FOREIGN KEY(id_alamat) REFERENCES alamat(id_alamat) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE rating(
  id_rating INT(11) NOT NULL AUTO_INCREMENT,
  id_produk CHAR(6) NOT NULL,
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
  id_produk CHAR(6) NOT NULL,
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

ALTER TABLE rating
MODIFY COLUMN bintang DECIMAL(3,2) NOT NULL;






-- Insert Command
INSERT INTO kategori(id_kategori, nama_kategori)
VALUES 
 ('J0003','Mother Board'),
  ('J0004', 'Apple Phone'),
  ('J0005','Air Pods'),
  ('J0006', 'Smartwatch'),
  ('J0007', 'Printer'),
  ('J0008', 'Gaming Laptop'),
  ('J0009', 'Power Bank'),
  ('J0010', 'Camera'),
  ('J0011', 'Headphones'),
  ('J0012', 'Fitness Tracker'),
  ('J0013', 'External Hard Drive'),
  ('J0014', 'Wireless Charger'),
  ('J0015', 'Computer Accessories');

-- Insert additional data into provinsi
INSERT INTO provinsi (nama_provinsi)
VALUES 
  ('Aceh'),
  ('Sumatera Utara'),
  ('Sumatera Barat'),
  ('Riau'),
  ('Jambi'),
  ('Sumatera Selatan'),
  ('Bengkulu'),
  ('Lampung'),
  ('Bangka Belitung'),
  ('Kalimantan Barat');

-- Insert additional data into kabupaten
INSERT INTO kabupaten (nama_kabupaten)
VALUES 
  ('Aceh Barat'),
  ('Tapanuli Selatan'),
  ('Pasaman'),
  ('Kampar'),
  ('Muaro Jambi'),
  ('Ogan Komering Ilir'),
  ('Bengkulu Tengah'),
  ('Lampung Selatan'),
  ('Bangka'),
  ('Pontianak');

-- Insert additional data into kecamatan
INSERT INTO kecamatan (nama_kecamatan)
VALUES 
  ('Meulaboh'),
  ('Balige'),
  ('Lubuk Sikaping'),
  ('Bukit Batu'),
  ('Jambi Timur'),
  ('Palembang Utara'),
  ('Curup'),
  ('Metro'),
  ('Manggar'),
  ('Singkawang');

-- Insert additional data into desa_kelurahan
INSERT INTO desa_kelurahan (nama_desa_kelurahan)
VALUES 
  ('Gampong Baro'),
  ('Huta Bulu'),
  ('Sungai Liput'),
  ('Pulau Muda'),
  ('Tanjungkarang'),
  ('Ilir Barat I'),
  ('Batu Tanam'),
  ('Gedong Tataan'),
  ('Manggar Baru'),
  ('Dompak');

-- Insert additional data into kode_pos
INSERT INTO kode_pos (kode_pos)
VALUES 
  (23456),
  (56789),
  (12345),
  (67890),
  (34567),
  (89012),
  (45678),
  (90123),
  (98765),
  (32109);

-- Insert additional data into alamat
INSERT INTO alamat(
  id_provinsi ,
  id_kabupaten ,
  id_kode_pos ,
  id_kecamatan ,
  id_desa_kelurahan) VALUES 
  (3, 4, 3, 4, 4),
  (1, 9, 8, 2, 1),
  (6, 3, 5, 5, 6),
  (7, 1, 2, 8, 7),
  (2, 10, 7, 3, 2),
  (5, 6, 1, 6, 5),
  (8, 2, 4, 9, 8),
  (4, 5, 6, 1, 10),
  (9, 7, 9, 7, 3),
  (10, 8, 10, 10, 9);

-- Insert additional data into penjual
INSERT INTO penjual (
    id_penjual,
    nama_penjual,
    jalan,
    id_alamat,
    email,
    no_tlp,
    jenis_kelamin,
    status_penjual
  )
VALUES 
  ('P3000', 'Toko EFG', 'Jalan Maju No. 789', 3, 'tokoeft@email.com', '08765432109', 'cowok', 1),
  ('P4000', 'Toko LMN', 'Jalan Sejahtera No. 1011', 4, 'tokolmn@email.com', '08901234567', 'cewek', 1),
  ('P5000', 'Toko OPQ', 'Jalan Harmoni No. 1213', 5, 'tokoopq@email.com', '08123456789', 'cowok', 1),
  ('P6000', 'Toko RST', 'Jalan Indah No. 1415', 6, 'tokorst@email.com', '08234567890', 'cewek', 1),
  ('P7000', 'Toko UVW', 'Jalan Damai No. 1617', 7, 'tokouvw@email.com', '08345678901', 'cowok', 1),
  ('P8000', 'Toko XYZ', 'Jalan Sentosa No. 1819', 8, 'tokowxy@email.com', '08456789012', 'cewek', 1),
  ('P9000', 'Toko ABC', 'Jalan Bersama No. 2021', 9, 'tokoabc@email.com', '08567890123', 'cowok', 1),
  ('P1000', 'Toko DEF', 'Jalan Kencana No. 2223', 10, 'tokodef@email.com', '08678901234', 'cewek', 1),
  ('P1100', 'Toko GHI', 'Jalan Sejati No. 2425', 1, 'tokoghi@email.com', '08789012345', 'cowok', 1),
  ('P1200', 'Toko JKL', 'Jalan Bahagia No. 2627', 2, 'tokojkl@email.com', '08890123456', 'cewek', 1);


-- Insert additional data into produk
INSERT INTO produk (
    id_produk,
    merk,
    harga,
    stok,
    deskripsi,
    id_kategori,
    id_penjual
  )
VALUES 
  ('PR0003', 'ROG mother Board', 1200000,100, 'mother board ini sangatlah keren dan kualitas kerja tenga kuda', 'J0003', 'P3000'),
  ('PR0004', 'Iphone 15 +', 8000000,140, 'Design stylish dengan tampilan elegan dan juga luxury dan royal', 'J0004', 'P4000'),
  ('PR0005', 'Air Pods Pro Gen 2', 2500000,50 ,'memiliki ke luaran suara yang lebih jernih dan mengagumkan ketika mendengar', 'J0005', 'P5000'),
  ('PR0006', 'Smart Watch Gen 3', 3000000,25 ,'Memiliki design yang elegan dan multi fungsi baru', 'J0006', 'P6000'),
  ('PR0007', 'Printer LG', 1800000,30 ,'Memiliki tampilan yang lebih keren dan kinerja dan hasil tinta yang memukau', 'J0007', 'P7000'),
  ('PR0008', 'ROG Strik', 50000000,170 ,'Laptop Gaming yang memiliki design yang elegan dan performa yang stabil ketika gaming', 'J0008', 'P8000'),
  ('PR0009', 'Robots', 2000000,200, 'Memiliki kapasitas batery yang ebih kuat dan daya charge yang lebih tinggi', 'J0009', 'P9000'),
  ('PR0010', 'Sony 3', 1500000,36, 'Memiliki tampilan gambar yang keren dan jernih', 'J0010', 'P1000'),
  ('PR0011', 'POCO X 4', 6500000,11, 'Performa gaming yang bagus dengan harga yang murah untuk itu worth it', 'J0011', 'P1100'),
  ('PR0012', 'Fitness Pro', 120000,35, 'Tracking performa anda untuk sesuatu yang memukau', 'J0012', 'P1200');

-- Insert additional data into pelanggan
INSERT INTO pelanggan (
    id_pelanggan,
    nama_pelanggan,
    jalan,
    tgl_lahir,
    jenis_kelamin,
    id_alamat,
    email,
    no_tlp
  )
VALUES 
  ('C3000', 'Pelanggan 3', 'Jalan Pelanggan 3', '1998-08-25', 'cewek', 3, 'pelanggan3@email.com', '08901234567'),
  ('C4000', 'Pelanggan 4', 'Jalan Pelanggan 4', '2001-03-10', 'cowok', 4, 'pelanggan4@email.com', '08123456789'),
  ('C5000', 'Pelanggan 5', 'Jalan Pelanggan 5', '1990-12-01', 'cewek', 5, 'pelanggan5@email.com', '08234567890'),
  ('C6000', 'Pelanggan 6', 'Jalan Pelanggan 6', '1985-05-20', 'cowok', 6, 'pelanggan6@email.com', '08345678901'),
  ('C7000', 'Pelanggan 7', 'Jalan Pelanggan 7', '1999-11-15', 'cewek', 7, 'pelanggan7@email.com', '08456789012'),
  ('C8000', 'Pelanggan 8', 'Jalan Pelanggan 8', '1993-02-28', 'cowok', 8, 'pelanggan8@email.com', '08567890123'),
  ('C9000', 'Pelanggan 9', 'Jalan Pelanggan 9', '1988-09-05', 'cewek', 9, 'pelanggan9@email.com', '08678901234'),
  ('C1000', 'Pelanggan 10', 'Jalan Pelanggan 10', '2002-07-18', 'cowok', 10, 'pelanggan10@email.com', '08789012345'),
  ('C1100', 'Pelanggan 11', 'Jalan Pelanggan 11', '1997-04-03', 'cewek', 1, 'pelanggan11@email.com', '08890123456'),
  ('C1200', 'Pelanggan 12', 'Jalan Pelanggan 12', '1980-10-12', 'cowok', 2, 'pelanggan12@email.com', '08901234567');

-- Insert additional data into rating
INSERT INTO rating (id_produk, ulasan, bintang, id_pelanggan)
VALUES 
  ('PR0003', 'Produk C luar biasa', 5, 'C3000'),
  ('PR0004', 'Produk D sangat baik', 4.5, 'C4000'),
  ('PR0005', 'Produk E bagus', 5, 'C5000'),
  ('PR0006', 'Produk F kurang memuaskan', 3, 'C6000'),
  ('PR0007', 'Produk G oke banget', 5, 'C7000'),
  ('PR0008', 'Produk H lumayan', 4.3, 'C8000'),
  ('PR0009', 'Produk I biasa saja', 3.7, 'C9000'),
  ('PR0010', 'Produk J puas', 5, 'C1000'),
  ('PR0011', 'Produk K tidak sesuai ekspektasi', 2.7, 'C1100'),
  ('PR0012', 'Produk L mengecewakan', 1.2, 'C1200');

-- Insert additional data into kurir
INSERT INTO kurir (id_kurir, nama_kurir, alamat, status_kurir)
VALUES 
  ('K3000', 'Tiki Express', 'Jalan Cepat No. 3', 1),
  ('K4000', 'Lion Parcel', 'Jalan Singa No. 4', 1),
  ('K5000', 'J&T Logistics', 'Jalan Tuntas No. 5', 1),
  ('K6000', 'Sicepat Express', 'Jalan Cepat No. 6', 1),
  ('K7000', 'Wahana Ekspres', 'Jalan Wahana No. 7', 1),
  ('K8000', 'Ninja Xpress', 'Jalan Ninja No. 8', 1),
  ('K9000', 'AnterAja', 'Jalan Antar No. 9', 1),
  ('K1000', 'SiCepat Ekspres', 'Jalan Cepat No. 10', 1),
  ('K1100', 'JNE Logistics', 'Jalan Ekspres No. 11', 1),
  ('K1200', 'Pos Express', 'Jalan Pos No. 12', 1);



-- Insert additional data into jenis_pembayaran
INSERT INTO jenis_pembayaran (
    id_pembayaran,
    tipe_pembayaran,
    status_pembayaran
  )
VALUES 
  ('P0003', 'OVO', 1),
  ('P0004', 'Dana', 1),
  ('P0005', 'GoPay', 1),
  ('P0006', 'LinkAja', 1),
  ('P0007', 'ShopeePay', 1),
  ('P0008', 'Cash On Delivery', 1),
  ('P0009', 'Transfer BRI', 1),
  ('P0010', 'Transfer BNI', 1),
  ('P0011', 'Transfer Mandiri', 1),
  ('P0012', 'Credit Card', 1);

-- Insert additional data into orders
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
VALUES 
  ('OR003', 3, 300000, 'Jalan Maju No. 789', '2023-02-20', 'P0003', 'PR0003', 'K3000', 'P3000', 'C3000'),
  ('OR004', 1, 80000, 'Jalan Sejahtera No. 1011', '2023-02-21', 'P0004', 'PR0004', 'K4000', 'P4000', 'C4000'),
  ('OR005', 2, 500000, 'Jalan Harmoni No. 1213', '2023-02-22', 'P0005', 'PR0005', 'K5000', 'P5000', 'C5000'),
('OR006', 1, 300000, 'Jalan Indah No. 1415', '2023-02-23', 'P0006', 'PR0006', 'K6000', 'P6000', 'C6000'),
('OR007', 4, 720000, 'Jalan Damai No. 1617', '2023-02-24', 'P0007', 'PR0007', 'K7000', 'P7000', 'C7000'),
('OR008', 2, 360000, 'Jalan Sentosa No. 1819', '2023-02-25', 'P0008', 'PR0008', 'K8000', 'P8000', 'C8000'),
('OR009', 3, 600000, 'Jalan Bersama No. 2021', '2023-02-26', 'P0009', 'PR0009', 'K9000', 'P9000', 'C9000'),
('OR010', 1, 150000, 'Jalan Kencana No. 2223', '2023-02-27', 'P0010', 'PR0010', 'K1000', 'P1000', 'C1000'),
('OR011', 2, 700000, 'Jalan Sejati No. 2425', '2023-02-28', 'P0011', 'PR0011', 'K1100', 'P1100', 'C1100'),
('OR012', 1, 120000, 'Jalan Bahagia No. 2627', '2023-03-01', 'P0012', 'PR0012', 'K1200', 'P1200', 'C1200');
-- Insert into jasa_pengiriman
INSERT INTO jasa_pengiriman (kode_pengiriman, nama_pengiriman, STATUS)
VALUES ('JP001', 'Reguler', 1),
  ('JP002', 'Express', 1),
  ('JP003', 'JNE', 0),
  ('JP005', 'Tik Tok Express' , 0),
  ('JP004', 'Gojek', 1);




-- Study Case AVG
-- 1. Average Rating for Each Product
SELECT id_produk, ROUND(AVG(bintang), 1) AS Avgg_Rating
FROM rating
GROUP BY id_produk;

-- 2. Average Price of Products by Category
SELECT K.nama_kategori, CONCAT('Rp ', FORMAT(AVG(P.harga), 0)) AS avg_price
FROM produk P
JOIN kategori K ON P.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 3. Average Order Quantity by order date
SELECT tgl_order, ROUND(AVG(jumlah_order)) AS avg_order_quantity
FROM orders ORDER BY tgl_order;

-- 4. Average Order Total Price
SELECT CONCAT('Rp ', FORMAT(AVG(total_harga), 0)) AS avg_order_total_price
FROM orders;

-- 5. Average Price of Products Sold by Each Seller
SELECT P.nama_penjual, CONCAT('Rp ', FORMAT(AVG(B.harga), 0)) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
GROUP BY P.nama_penjual;

-- 6. Average Number of Orders per Customer
SELECT id_pelanggan, ROUND(AVG(jumlah_order)) AS avg_orders_per_customer
FROM orders
GROUP BY id_pelanggan;

-- 7. Average Rating for Each Category
SELECT
  K.nama_kategori,
  CASE
    WHEN AVG(R.bintang) IS NULL THEN 'belum ada rating'
    ELSE ROUND(AVG(R.bintang), 2)
  END AS avg_rating
FROM
  kategori K
  LEFT JOIN produk B ON K.id_kategori = B.id_kategori
  LEFT JOIN rating R ON B.id_produk = R.id_produk
GROUP BY
  K.nama_kategori;

-- 8. Average Price of Products Sold by Each Seller in Each Category
SELECT P.nama_penjual, K.nama_kategori, CONCAT('Rp ', FORMAT(AVG(B.harga), 0)) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY P.nama_penjual, K.nama_kategori;

-- 9. Average Rating by Gender for Each Product
SELECT R.id_produk, P.jenis_kelamin, ROUND(AVG(R.bintang), 2) AS avg_rating
FROM rating R
JOIN pelanggan P ON R.id_pelanggan = P.id_pelanggan
GROUP BY R.id_produk, P.jenis_kelamin;

-- 10. Average Order Quantity by Product
SELECT id_produk, ROUND(AVG(jumlah_order), 2) AS avg_order_quantity
FROM orders
GROUP BY id_produk;

-- 11. Average Price of Products Sold by Each Seller by Gender
SELECT P.nama_penjual, Pel.jenis_kelamin,Pel.`id_alamat`, AVG(B.harga) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN pelanggan Pel ON P.id_alamat = Pel.id_alamat
GROUP BY P.nama_penjual, Pel.jenis_kelamin, Pel.id_alamat;

-- 12. Average Order Quantity by Seller
SELECT id_penjual, ROUND(AVG(jumlah_order), 1) AS avg_order_quantity
FROM orders
GROUP BY id_penjual;

-- 13. Average Price of Products Sold in Each Province
SELECT PR.nama_provinsi, PRO.merk, CONCAT('Rp ', FORMAT(AVG(O.total_harga), 0)) AS avg_price_province
FROM orders O
JOIN penjual P ON O.id_penjual = P.id_penjual
JOIN produk PRO ON O.`id_produk` = PRO.`id_produk`
JOIN alamat A ON P.id_alamat = A.id_alamat
JOIN provinsi PR ON A.id_provinsi = PR.id_provinsi
GROUP BY PR.nama_provinsi;

-- 14. Average Order Total Price by Seller
SELECT id_penjual, CONCAT('Rp ', FORMAT(AVG(total_harga), 0)) AS avg_order_total_price
FROM orders
GROUP BY id_penjual;

-- 15. Average Price of Products Sold in Each City
SELECT K.nama_kabupaten, CONCAT('Rp ', FORMAT(AVG(B.harga), 0)) AS avg_price
FROM produk B
JOIN penjual P ON B.id_penjual = P.id_penjual
JOIN alamat A ON P.id_alamat = A.id_alamat
JOIN kabupaten K ON A.id_kabupaten = K.id_kabupaten
GROUP BY K.nama_kabupaten;


-- 17 AVG price by payments
SELECT JP.tipe_pembayaran, CONCAT('Rp ', FORMAT(AVG(O.`total_harga`), 0)) AS AVG_Price
FROM orders O
JOIN jenis_pembayaran JP ON O.id_pembayaran = JP.id_pembayaran
GROUP BY JP.tipe_pembayaran;


-- 18. Average Rating by Age Group for Each Product
SELECT R.id_produk, 
    CASE 
        WHEN YEAR(CURRENT_DATE) - YEAR(Pel.tgl_lahir) BETWEEN 18 AND 30 THEN '18-30'
        WHEN YEAR(CURRENT_DATE) - YEAR(Pel.tgl_lahir) BETWEEN 31 AND 45 THEN '31-45'
        ELSE '46+'
    END AS cos_age_group,
    ROUND(AVG(R.bintang), 2) AS avg_rating
FROM rating R
JOIN pelanggan Pel ON R.id_pelanggan = Pel.id_pelanggan
GROUP BY R.id_produk, cos_age_group;

-- 19. Average Order Quantity by Category
SELECT K.nama_kategori, ROUND(AVG(jumlah_order), 1) AS avg_order_quantity
FROM orders O
JOIN produk B ON O.id_produk = B.id_produk
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 20. Average Rating by Payment Type for Each Product 
SELECT O.id_produk, JP.tipe_pembayaran, ROUND(AVG(R.bintang), 1) AS avg_rating
FROM rating R
JOIN orders O ON R.id_produk = O.id_produk 
JOIN jenis_pembayaran JP ON O.id_pembayaran = JP.id_pembayaran
GROUP BY O.id_produk, JP.tipe_pembayaran;


-- SUM AND COUNT STUDY CASE
-- 16. Count of Ratings by Product
SELECT id_produk, COUNT(id_rating) AS rating_count
FROM rating
GROUP BY id_produk;

-- 21. Sum of Order Quantity by Category
SELECT K.nama_kategori, SUM(jumlah_order) AS total_order_quantity
FROM orders O
JOIN produk B ON O.id_produk = B.id_produk
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 22. Sum of Order Total Price by Seller
SELECT id_penjual, CONCAT('Rp ', FORMAT(SUM(total_harga), 0)) AS total_order_price
FROM orders
GROUP BY id_penjual;

-- 23. Sum of Order Total Price by Payment Type
SELECT JP.tipe_pembayaran, CONCAT('Rp ', FORMAT(SUM(O.total_harga), 0)) AS total_order_price
FROM orders O
JOIN jenis_pembayaran JP ON O.id_pembayaran = JP.id_pembayaran
GROUP BY JP.tipe_pembayaran;

-- 24. Count of Orders by Seller
SELECT id_penjual, COUNT(id_order) AS order_count
FROM orders
GROUP BY id_penjual;

-- 25. Count of Orders by Payment Type
SELECT JP.tipe_pembayaran, COUNT(id_order) AS order_count
FROM orders O
JOIN jenis_pembayaran JP ON O.id_pembayaran = JP.id_pembayaran
GROUP BY JP.tipe_pembayaran;

-- 26. Sum of Order Quantity by Product
SELECT id_produk, SUM(jumlah_order) AS total_order_quantity
FROM orders
GROUP BY id_produk;

-- 27. Count of Orders by Product
SELECT id_produk, COUNT(id_order) AS order_count
FROM orders
GROUP BY id_produk;

-- 28. Count of Orders by Category
SELECT K.nama_kategori, COUNT(id_order) AS order_count
FROM orders O
JOIN produk B ON O.id_produk = B.id_produk
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 29. Sum of Order Total Price by Category
SELECT K.nama_kategori, CONCAT('Rp ', FORMAT(SUM(total_harga), 0)) AS total_order_price
FROM orders O
JOIN produk B ON O.id_produk = B.id_produk
JOIN kategori K ON B.id_kategori = K.id_kategori
GROUP BY K.nama_kategori;

-- 30. Sum of Order Total Price by Product
SELECT id_produk,CONCAT('Rp ', FORMAT(SUM(total_harga), 0)) AS total_order_price
FROM orders
GROUP BY id_produk;


-- SELECT Case
-- Select total penjualan, rata-rata rating, dan harga produk dari tabel produk, orders, dan rating.
SELECT 
    P.id_produk,
    P.merk,
    K.nama_kategori,
    CONCAT('Rp ', FORMAT(AVG(O.total_harga * jumlah_order), 0)) AS avg_order_total_price,
    COUNT(O.id_order) AS total_penjualan,
    CONCAT('Rating ', FORMAT(AVG(R.bintang), 1)) AS avg_rating
FROM produk P
JOIN kategori K ON P.id_kategori = K.id_kategori
LEFT JOIN orders O ON P.id_produk = O.id_produk
LEFT JOIN rating R ON P.id_produk = R.id_produk
GROUP BY P.id_produk, P.merk, K.nama_kategori;


-- 1. Produk yang terjual pada tanggal tertentu
SELECT *
FROM orders
WHERE tgl_order = '2023-01-16'; -- Ganti tanggal sesuai kebutuhan

-- 2. Pelanggan yang Paling Banyak Berbelanja
SELECT
    O.id_pelanggan,
    P.nama_pelanggan,
    CONCAT('Rp ', FORMAT(SUM(O.jumlah_order * O.total_harga), 0)) AS total_orders,
    J.tipe_pembayaran
FROM orders O
JOIN pelanggan P ON O.id_pelanggan = P.id_pelanggan
JOIN jenis_pembayaran J ON O.id_pembayaran = J.id_pembayaran
GROUP BY O.id_pelanggan
ORDER BY total_orders DESC
LIMIT 1;

-- 3. Metode Pembayaran Pelanggan Tertentu
SELECT
    O.id_pelanggan,
    O.id_kurir,
    O.id_pembayaran,
    JP.tipe_pembayaran
FROM orders O
JOIN jenis_pembayaran JP ON O.id_pembayaran = JP.id_pembayaran
WHERE O.id_pelanggan = 'C1000';

-- 4. Pelanggan di alamat tertentu
SELECT P.*
FROM pelanggan P
JOIN alamat A ON P.id_alamat = A.id_alamat
WHERE A.id_kode_pos = '1'

UNION ALL

-- 5. Penjual di alamat tertentu
SELECT Pe.*
FROM penjual Pe
JOIN alamat A ON Pe.id_alamat = A.id_alamat
WHERE A.id_kode_pos = '3'

-- Mengambil jumlah order pada tanggal terbaru
SELECT id_penjual, COUNT(*) AS total_order, MAX(tgl_order) AS latest_date
FROM orders
WHERE DATE(tgl_order) = (SELECT MAX(DATE(tgl_order)) FROM orders)
GROUP BY id_penjual
ORDER BY total_order DESC;

-- Mengambil order penjual yang tanggalnya sudah lewat atau terlama
SELECT id_penjual, COUNT(*) AS total_order, MIN(tgl_order) AS low_date
FROM orders
WHERE DATE(tgl_order) = (SELECT MIN(DATE(tgl_order)) FROM orders)
GROUP BY id_penjual, DATE(tgl_order)
ORDER BY total_order DESC, low_date;

-- 6. Penjual dengan penjualan terbanyak
SELECT id_penjual, SUM(jumlah_order) AS total_penjualan
FROM orders
GROUP BY id_penjual
ORDER BY total_penjualan DESC
LIMIT 10


-- 7. Penjual dengan tahun join paling lama
SELECT P.id_penjual, MIN(YEAR(P.created_at)) AS tahun_join
FROM penjual P
GROUP BY P.id_penjual
ORDER BY tahun_join ASC
LIMIT 1

-- Tahun join pembeli dengan tahun baru join
SELECT P.id_pelanggan, DATE(MAX(P.created_at)) AS latest_date
FROM pelanggan P
GROUP BY P.id_pelanggan
ORDER BY latest_date ASC
LIMIT 4;



-- 8. Pelanggan dengan rating terbaik
SELECT R.id_pelanggan, ROUND(AVG(R.bintang), 2) AS avg_rating
FROM rating R
GROUP BY R.id_pelanggan
ORDER BY avg_rating DESC
LIMIT 1



-- 9. Pelanggan dengan rating terburuk
SELECT R.id_pelanggan, ROUND(AVG(R.bintang), 2) AS avg_rating
FROM rating R
GROUP BY R.id_pelanggan
ORDER BY avg_rating ASC
LIMIT 2;



