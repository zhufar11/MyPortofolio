select *
from PortofolioProject..House

-- benerin tanggal
alter table house drop column if exists saledates
SELECT SaleDate, CONVERT(date, SaleDate) AS saledates
from PortofolioProject..House;

UPDATE house
SET saledate = CONVERT(date, SaleDate);

ALTER TABLE house
ADD saledates date;

UPDATE house
SET saledates = CONVERT(date, SaleDate);


-- memperbaiki alamat rumah yg null
-- mencocoki data dengan parcel ID dan Property ID
select *
from PortofolioProject..House

select a.parcelid, a.propertyaddress, b.parcelid, b.propertyaddress, isnull(a.propertyaddress,b.propertyaddress)
from PortofolioProject..house a
join PortofolioProject..house b
	on a.parcelid = b.parcelid
	and a.[uniqueid] <> b.[uniqueid]
where a.propertyaddress is null

-- update table biar lebih baik
update a
set propertyaddress = isnull(a.propertyaddress,b.propertyaddress)
from PortofolioProject..house a
join PortofolioProject..house b
	on a.parcelid = b.parcelid
	and a.[uniqueid] <> b.[uniqueid]
where a.propertyaddress is null

select *
from PortofolioProject..House

select distinct(soldasvacant), count(soldasvacant)
from PortofolioProject..House
group by SoldAsVacant
order by 2

select soldasvacant,
	case when soldasvacant = 'Y' then 'SOLD'
	when soldasvacant = 'N' then 'NOT SOLD'
	when SoldAsVacant = 'Yes' then 'SOLD'
	when SoldAsVacant = 'No' then 'NOT SOLD'
	else soldasvacant
	end as Penjualanrumah
from PortofolioProject..House

update PortofolioProject..House
set soldasvacant = case when soldasvacant = 'Y' then 'SOLD'
	when soldasvacant = 'N' then 'NOT SOLD'
	when SoldAsVacant = 'Yes' then 'SOLD'
	when SoldAsVacant = 'No' then 'NOT SOLD'
	else soldasvacant
	end


-- cari yang duplikat dan hapus
with RowNumCTE as(
select *,
	ROW_NUMBER() OVER (
	PARTITION BY parcelid,
	propertyaddress,
	saleprice,
	saledate,
	legalreference
	order by
	uniqueid
	) row_num
from PortofolioProject..House
)
select *
from RowNumCTE
where row_num > 1
order by PropertyAddress

select *
from PortofolioProject..House

--hapus kolom g penting
alter table PortofolioProject..House
drop column SaleDate, TaxDistrict

SELECT * 
FROM PortofolioProject..House
WHERE OwnerName IS NULL and OwnerAddress IS NULL and Acreage is null and LandValue is null and BuildingValue is null and 
TotalValue is null and YearBuilt is null and Bedrooms is null and FullBath is null and HalfBath is null;

SELECT * 
FROM PortofolioProject..House
order by PropertyAddress asc