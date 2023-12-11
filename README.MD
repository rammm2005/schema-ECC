# Database Schema Online ECC

## Run This First 
```
CREATE DATABASE online_shop;
USE online_shop;
```
For make the Database and Using the Database

## Table: kategori

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_kategori    | CHAR(5) NOT NULL          | Primary Key                         |
| nama_kategori  | VARCHAR(50) NOT NULL      | Category Name                       |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |

---

## Table: penjual

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_penjual     | CHAR(5) NOT NULL          | Primary Key                         |
| nama_penjual   | VARCHAR(50) NOT NULL      | Seller's Name                       |
| jalan          | VARCHAR(150)              | Seller's Address                    |
| id_alamat      | INT(11) NOT NULL          | Foreign Key to alamat.id_alamat     |
| email          | VARCHAR(50) NOT NULL      | Email Address of the Seller         |
| no_tlp         | VARCHAR(15) NOT NULL      | Phone Number of the Seller          |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |
| jenis_kelamin  | ENUM('cowok', 'cewek')    | Gender of the Seller                |
| status_penjual | BOOLEAN DEFAULT(1)        | Status of the Seller                |
| FOREIGN KEY(id_alamat) REFERENCES alamat(id_alamat) ON DELETE CASCADE ON UPDATE CASCADE |

---

## Table: barang

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_barang      | CHAR(5) NOT NULL          | Primary Key                         |
| merk           | VARCHAR(50) NOT NULL      | Brand of the Product                |
| harga          | FLOAT(11) NOT NULL         | Price of the Product                |
| deskripsi      | TEXT NOT NULL             | Description of the Product          |
| id_kategori    | CHAR(5) NOT NULL          | Foreign Key to kategori.id_kategori |
| id_penjual     | CHAR(5) NOT NULL          | Foreign Key to penjual.id_penjual   |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |
| FOREIGN KEY(id_kategori) REFERENCES kategori(id_kategori) ON DELETE CASCADE ON UPDATE CASCADE |
| FOREIGN KEY(id_penjual) REFERENCES penjual(id_penjual) ON DELETE CASCADE ON UPDATE CASCADE |

---

## Table: pelanggan

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_pelanggan   | CHAR(5) NOT NULL          | Primary Key                         |
| nama_pelanggan | VARCHAR(50) NOT NULL      | Customer's Name                     |
| jalan          | VARCHAR(150)              | Customer's Address                  |
| tgl_lahir      | DATE NOT NULL             | Date of Birth of the Customer       |
| jenis_kelamin  | ENUM('cowok', 'cewek', 'kustom') | Gender of the Customer         |
| id_alamat      | INT(11) NOT NULL          | Foreign Key to alamat.id_alamat     |
| email          | VARCHAR(50) NOT NULL      | Email Address of the Customer       |
| no_tlp         | VARCHAR(50) NOT NULL      | Phone Number of the Customer        |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |
| FOREIGN KEY(id_alamat) REFERENCES alamat(id_alamat) ON DELETE CASCADE ON UPDATE CASCADE |

---

## Table: alamat

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_alamat      | INT(11) AUTO_INCREMENT NOT NULL | Primary Key                   |
| kode_pos       | INT(10) NOT NULL          | Postal Code                         |
| kabupaten      | VARCHAR(50)               | District                            |
| kecamatan      | VARCHAR(50)               | Sub-district                        |
| provinsi       | VARCHAR(50) NOT NULL      | Province                            |
| jalan          | VARCHAR(100) NOT NULL     | Street Address                      |

---

## Table: rating

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_rating      | INT(11) NOT NULL AUTO_INCREMENT | Primary Key                   |
| id_barang      | CHAR(5) NOT NULL          | Foreign Key to barang.id_barang     |
| ulasan         | TEXT NOT NULL             | Customer's Review                   |
| bintang        | INT(5) NOT NULL           | Rating in Stars (1-5)               |
| id_pelanggan   | CHAR(5) NOT NULL          | Foreign Key to pelanggan.id_pelanggan |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |
| FOREIGN KEY(id_barang) REFERENCES barang(id_barang) ON DELETE CASCADE ON UPDATE CASCADE |
| FOREIGN KEY(id_pelanggan) REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE ON UPDATE CASCADE |

---

## Table: kurir

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_kurir       | CHAR(5) NOT NULL          | Primary Key                         |
| nama_kurir     | VARCHAR(50) NOT NULL      | Courier's Name                      |
| alamat         | VARCHAR(100)              | Courier's Address                   |
| status_kurir   | BOOLEAN DEFAULT(1)        | Status of the Courier               |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |

---

## Table: jenis_pembayaran

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_pembayaran  | CHAR(5) NOT NULL          | Primary Key                         |
| tipe_pembayaran| VARCHAR(50) NOT NULL      | Type of Payment                     |
| status_pembayaran| BOOLEAN DEFAULT(1)      | Status of the Payment               |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |

---

## Table: orders

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| id_order       | CHAR(5) NOT NULL          | Primary Key                         |
| jumlah_order   | INT(10) NOT NULL          | Quantity of Products in the Order   |
| total_harga    | INT(17) NOT NULL          | Total Price of the Order            |
| alamat_tujuan  | VARCHAR(100) NOT NULL     | Delivery Address                    |
| tgl_order      | DATE NOT NULL             | Order Date                          |
| id_pembayaran  | CHAR(5) NOT NULL          | Foreign Key to jenis_pembayaran.id_pembayaran |
| id_barang      | CHAR(5) NOT NULL          | Foreign Key to barang.id_barang     |
| id_kurir       | CHAR(5) NOT NULL          | Foreign Key to kurir.id_kurir       |
| id_penjual     | CHAR(5) NOT NULL          | Foreign Key to penjual.id_penjual   |
| id_pelanggan   | CHAR(5) NOT NULL          | Foreign Key to pelanggan.id_pelanggan |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |
| FOREIGN KEY(id_barang) REFERENCES barang(id_barang) ON DELETE CASCADE ON UPDATE CASCADE |
| FOREIGN KEY(id_kurir) REFERENCES kurir(id_kurir) ON DELETE CASCADE ON UPDATE CASCADE |
| FOREIGN KEY(id_penjual) REFERENCES penjual(id_penjual) ON DELETE CASCADE ON UPDATE CASCADE |
| FOREIGN KEY(id_pelanggan) REFERENCES pelanggan(id_pelanggan) ON DELETE CASCADE ON UPDATE CASCADE |
| FOREIGN KEY(id_pembayaran) REFERENCES jenis_pembayaran(id_pembayaran) ON DELETE CASCADE ON UPDATE CASCADE |

---

## Table: jasa_pengiriman

| Column         | Data Type                 | Description                         |
| -------------- | ------------------------- | ----------------------------------- |
| kode_pengiriman| CHAR(5) NOT NULL          | Primary Key                         |
| nama_pengiriman| VARCHAR(255) NOT NULL     | Name of the Delivery Service        |
| STATUS         | BOOLEAN DEFAULT(1)        | Status of the Delivery Service      |
| created_at     | DATETIME(4) NOT NULL      | Timestamp of Creation               |
| update_at      | DATETIME(4) NOT NULL      | Timestamp of Last Update            |


# get showing the PDM Right Here