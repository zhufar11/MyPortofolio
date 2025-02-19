DELIMITER //

CREATE PROCEDURE hitung_luas_bangun_datar (
    IN jenis_bangun_datar VARCHAR(50),
    IN x FLOAT,
    IN y FLOAT,
    OUT luas FLOAT,
    OUT keterangan VARCHAR(100)
)
BEGIN
    IF jenis_bangun_datar = 'segitiga' THEN
        IF x > 0 AND y > 0 THEN
            SET luas = 0.5 * x * y;
            SET keterangan = 'Perhitungan luas segitiga berhasil dilakukan';
        ELSE
            SET luas = NULL;
            SET keterangan = 'Alas dan tinggi segitiga harus lebih dari 0';
        END IF;
    ELSEIF jenis_bangun_datar = 'persegi_panjang' THEN
        IF x > 0 AND y > 0 THEN
            SET luas = x * y;
            SET keterangan = 'Perhitungan luas persegi panjang berhasil dilakukan';
        ELSE
            SET luas = NULL;
            SET keterangan = 'Panjang dan lebar persegi panjang harus lebih dari 0';
        END IF;
    ELSE
        SET luas = NULL;
        SET keterangan = 'Jenis bangun datar tidak valid';
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS hitung_luas_bangun_datar;

CALL hitung_luas_bangun_datar('persegi_panjang', 4, 8, @luas, @keterangan);
SELECT @luas AS luas, @keterangan AS keterangan;


