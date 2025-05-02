select *
from data_penjualan;

select *
from data_kustomer;

--Total pendapatan selama setahun dalam USD
SELECT 
    year, 
    ROUND(SUM(net_usd), 2) AS total_usd
FROM data_penjualan
GROUP BY year
ORDER BY year;

--sumber pendapatan dalam usd
SELECT 
    countryfull, 
    ROUND(SUM(net_usd), 2) AS total_usd
FROM data_penjualan
GROUP BY countryfull
ORDER BY total_usd DESC;

--data gender pelanggan
SELECT 
    gender, 
    COUNT(*) AS total_transaksi,
    ROUND(SUM(net_usd), 2) AS total_usd
FROM data_penjualan
GROUP BY gender;

--rentang umur dalam kategori barang
SELECT 
    range_age, 
    categoryname, 
    COUNT(*) AS total_transaksi, 
    ROUND(SUM(net_usd), 2) AS total_usd
FROM data_penjualan
GROUP BY range_age, categoryname
ORDER BY range_age, total_usd DESC;


--barang2 high end
SELECT 
    gender, 
    COUNT(*) AS total_transaksi_high_end,
    ROUND(SUM(net_usd), 2) AS total_usd_high_end
FROM data_penjualan
WHERE high_low = 'High'
GROUP BY gender
ORDER BY total_usd_high_end DESC;

--produk top 10
SELECT TOP 10
    productname, 
    ROUND(SUM(net_usd), 2) AS total_penjualan
FROM data_penjualan
GROUP BY productname
ORDER BY total_penjualan DESC;

--berdarakan kategori dan sub kategori
SELECT 
    categoryname, 
    subcategoryname, 
    ROUND(SUM(net_usd), 2) AS total_penjualan
FROM data_penjualan
GROUP BY categoryname, subcategoryname
ORDER BY categoryname, total_penjualan DESC;

--jumlah barang terjual berdasarkan product name
SELECT 
    productname,
    categoryname, 
    subcategoryname, 
    ROUND(SUM(productkey), 2) AS total_penjualan
FROM data_penjualan
GROUP BY productname, categoryname, subcategoryname
ORDER BY productname, total_penjualan DESC;

select
	productkey,
	orderdate,
	categoryname, 
    subcategoryname,
	productname,
	count(*) as jumlah_brg_trjwl
from data_penjualan
group by orderdate, productkey, productname, categoryname, subcategoryname
ORDER BY jumlah_brg_trjwl desc;

--buat table segmentasi kostumer
ALTER TABLE data_penjualan
ADD customername VARCHAR(255);

UPDATE data_penjualan
SET customername = CONCAT(givenname, ' ', surname);


SELECT 
    customername,
    COUNT(orderdate) AS frekuensi_beli,
    SUM(net_usd) AS total_belanja,
    MAX(orderdate) AS terakhir_beli
FROM data_penjualan
GROUP BY customername;

--Segmentasi Berdasarkan Produk yang Dibeli (Behavior)
SELECT 
    customername,
    categoryname,
    COUNT(*) AS jumlah_pembelian
FROM data_penjualan
GROUP BY customername, categoryname
ORDER BY customername, jumlah_pembelian DESC;

select categoryname,
	COUNT(*) AS jumlah_pembelian
from data_penjualan
group by categoryname
order by jumlah_pembelian desc;