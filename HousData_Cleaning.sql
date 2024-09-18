SET SQL_SAFE_UPDATES = 0;

SELECT * FROM house_data.rockymount_house_data;

/** Removing '$' sign and ',' from Price column so that the data type can be converted to INTEGERS **/
UPDATE rockymount_house_data
SET Price = REPLACE(REPLACE(Price, '$', ''), ',', '')
WHERE Price is NOT NULL;

ALTER TABLE rockymount_house_data
MODIFY COLUMN `Price` INTEGER;

DELETE FROM rockymount_house_data
WHERE `Sellers Details` IS NULL OR `Sellers Details` = '';

-- Add new columns to store extracted information
ALTER TABLE rockymount_house_data
ADD COLUMN Beds INT,
ADD COLUMN Baths INT,
ADD COLUMN SquareFeet INT,
ADD COLUMN PropertyType VARCHAR(50);

UPDATE rockymount_house_data
SET Beds = SUBSTRING(`Property Details`, 1, 1);

UPDATE rockymount_house_data
SET Baths = SUBSTRING(`Property Details`, 5, 1);

UPDATE rockymount_house_data
SET `Property Details` = REPLACE(`Property Details`, ',', '');

UPDATE rockymount_house_data
SET SquareFeet = SUBSTRING(`Property Details`, 8, 4)
WHERE TRIM(SUBSTRING(`Property Details`, 8, 4)) != 'qft';

DELETE FROM rockymount_house_data
WHERE SquareFeet IS NULL;

UPDATE rockymount_house_data
SET PropertyType = SUBSTRING(`Property Details`, 17, length(`Property Details`));

ALTER TABLE rockymount_house_data
DROP COLUMN `Property Details`;


