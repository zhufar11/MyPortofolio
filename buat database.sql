-- 0. Create Database
CREATE DATABASE universitas;

-- 1.1 Add Table with Primary Key 
CREATE TABLE universitas_dosen(
    id_dosen varchar(50) NOT NULL,
    nama_dosen varchar(100),
    prog_studi varchar(100),
    PRIMARY KEY (id_dosen)
);

select * from universitas_dosen

-- 1.2 Create Table with Primary Key 
CREATE TABLE universitas_mahasiswa (
    id_mahasiswa varchar(50) NOT NULL PRIMARY KEY,
    nama_mahasiswa varchar(100),
    id_dosen_wali varchar(100)
);

SELECT * FROM universitas_mahasiswa

-- 2 CREATE Table FOREIGN KEY
DROP TABLE universitas.mahasiswa;

CREATE TABLE universitas.mahasiswa (
    id_mahasiswa varchar(50) NOT NULL PRIMARY KEY,
    nama_mahasiswa varchar(100),
    id_dosen_wali varchar(100),
    FOREIGN KEY (id_dosen_wali) REFERENCES universitas.dosen(id_dosen)
);

EXPLAIN universitas.mahasiswa;

-- Melihat ER Diagram
-- 3. Memasukkan data ###
-- 3.1
DROP TABLE universitas.mahasiswa;

DROP TABLE universitas.dosen;

CREATE TABLE universitas.dosen (
    id_dosen varchar(50) NOT NULL,
    nama_dosen varchar(100),
    prog_studi varchar(100)
);

INSERT INTO
    universitas.dosen (id_dosen, nama_dosen, prog_studi)
VALUES
    ('A1001', 'Mali, Ph.D', 'Teknik Industri'),
    ('A1003', 'Dr. Margareta', 'Matematika'),
    ('A1004', 'Adi, S.E., MBA', 'Manajemen'),
    ('A1005', 'Mali, Ph.D', 'Manajemen');

SELECT
    *
FROM
    universitas.dosen;

-- 3.2
CREATE TABLE universitas.mahasiswa (
    id_mahasiswa varchar(50) NOT NULL,
    nama_mahasiswa varchar(100),
    id_dosen_wali varchar(100)
);

INSERT INTO
    universitas.mahasiswa(id_mahasiswa, nama_mahasiswa, id_dosen_wali)
VALUES
    ('13217073', 'Aruman', 'A1004');

SELECT
    *
FROM
    universitas.mahasiswa;

-- 4. 
SELECT
    *
FROM
    universitas.mahasiswa;

EXPLAIN universitas.mahasiswa;

ALTER TABLE
    universitas.mahasiswa
ADD
    nilai_ujian FLOAT;

ALTER TABLE
    universitas.mahasiswa DROP COLUMN nilai_ujian;

ALTER TABLE
    universitas.mahasiswa
MODIFY
    COLUMN id_mahasiswa INTEGER;

EXPLAIN universitas.mahasiswa;

ALTER TABLE
    universitas.mahasiswa CHANGE COLUMN id_mahasiswa nomor_induk_mahasiswa varchar(50);-- 0. Create Database
DROP DATABASE universitas;

CREATE DATABASE universitas;

-- 1.1 Add Table with Primary Key 
CREATE TABLE universitas.dosen (
    id_dosen varchar(50) NOT NULL,
    nama_dosen varchar(100),
    prog_studi varchar(100),
    PRIMARY KEY (id_dosen)
);

EXPLAIN universitas.dosen;

-- 1.2 Create Table with Primary Key 
CREATE TABLE universitas.mahasiswa (
    id_mahasiswa varchar(50) NOT NULL PRIMARY KEY,
    nama_mahasiswa varchar(100),
    id_dosen_wali varchar(100)
);

EXPLAIN universitas.mahasiswa;

-- 2 CREATE Table FOREIGN KEY
DROP TABLE universitas.mahasiswa;

CREATE TABLE universitas.mahasiswa (
    id_mahasiswa varchar(50) NOT NULL PRIMARY KEY,
    nama_mahasiswa varchar(100),
    id_dosen_wali varchar(100),
    FOREIGN KEY (id_dosen_wali) REFERENCES universitas.dosen(id_dosen)
);

EXPLAIN universitas.mahasiswa;

-- Melihat ER Diagram
-- 3. Memasukkan data ###
-- 3.1
DROP TABLE universitas.mahasiswa;

DROP TABLE universitas.dosen;

CREATE TABLE universitas.dosen (
    id_dosen varchar(50) NOT NULL,
    nama_dosen varchar(100),
    prog_studi varchar(100)
);

INSERT INTO
    universitas.dosen (id_dosen, nama_dosen, prog_studi)
VALUES
    ('A1001', 'Mali, Ph.D', 'Teknik Industri'),
    ('A1003', 'Dr. Margareta', 'Matematika'),
    ('A1004', 'Adi, S.E., MBA', 'Manajemen'),
    ('A1005', 'Mali, Ph.D', 'Manajemen');

SELECT
    *
FROM
    universitas.dosen;

-- 3.2
CREATE TABLE universitas.mahasiswa (
    id_mahasiswa varchar(50) NOT NULL,
    nama_mahasiswa varchar(100),
    id_dosen_wali varchar(100)
);

INSERT INTO
    universitas.mahasiswa(id_mahasiswa, nama_mahasiswa, id_dosen_wali)
VALUES
    ('13217073', 'Aruman', 'A1004');

SELECT
    *
FROM
    universitas.mahasiswa;

-- 4. 
SELECT
    *
FROM
    universitas.mahasiswa;

EXPLAIN universitas.mahasiswa;

ALTER TABLE
    universitas.mahasiswa
ADD
    nilai_ujian FLOAT;

ALTER TABLE
    universitas.mahasiswa DROP COLUMN nilai_ujian;

ALTER TABLE
    universitas.mahasiswa
MODIFY
    COLUMN id_mahasiswa INTEGER;

EXPLAIN universitas.mahasiswa;

ALTER TABLE
    universitas.mahasiswa CHANGE COLUMN id_mahasiswa nomor_induk_mahasiswa varchar(50);