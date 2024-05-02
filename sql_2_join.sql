# SQL Join exercise
#

#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * 
FROM City
WHERE Name LIKE 'Ping%'
ORDER BY Population ASC;
#
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT *
FROM City
WHERE Name like 'Ran%' 
ORDER BY Population DESC;
#
#
# 3: Count all cities
SELECT COUNT(*) AS Number_Of_Citys 
FROM City;
#
#
# 4: Get the average population of all cities
SELECT AVG(Population) 
FROM City;
#
#
# 5: Get the biggest population found in any of the cities
SELECT MAX(Population) 
FROM City;
#
#
# 6: Get the smallest population found in any of the cities
SELECT MIN(Population) 
FROM City;
#
#
# 7: Sum the population of all cities with a population below 10000
SELECT SUM(Population) 
FROM City 
WHERE Population < 10000;
#
#
# 8: Count the cities with the countrycodes MOZ and VNM
SELECT COUNT(CountryCode) 
FROM City 
WHERE CountryCode = 'MOZ' OR CountryCode = 'VNM';
#
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
SELECT COUNT(CountryCode) 
FROM City 
WHERE CountryCode = 'MOZ';
SELECT COUNT(CountryCode) 
FROM City 
WHERE CountryCode = 'VNM';
#
#
# 10: Get average population of cities in MOZ and VNM
SELECT AVG(Population) 
FROM City 
WHERE CountryCode = 'MOZ' OR CountryCode = 'VNM';
#
#
# 11: Get the countrycodes with more than 200 cities
SELECT Country.Name 
FROM Country
INNER JOIN City ON Country.Code = City.CountryCode
GROUP BY Country.Name
HAVING COUNT(DISTINCT City.Name) > 200;
#
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
SELECT Country.Name 
FROM Country
INNER JOIN City ON Country.Code = City.CountryCode
GROUP BY Country.Name
HAVING COUNT(DISTINCT City.Name) > 200
ORDER BY COUNT(City.Name) DESC;
#
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
SELECT CountryLanguage.Language, City.Name 
FROM CountryLanguage
JOIN City ON CountryLanguage.CountryCode = City.CountryCode
WHERE City.Population BETWEEN 400 AND 500;
#
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT City.Name AS City_Name, CountryLanguage.Language AS Spoken_Language
FROM CountryLanguage 
JOIN City ON CountryLanguage.CountryCode = City.CountryCode
WHERE City.Population BETWEEN 500 AND 600;
#
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
SELECT Name, Population
FROM City
WHERE CountryCode = (
	SELECT CountryCode 
    FROM City
    WHERE Population = 122199
);
#
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT Name, Population
FROM City
WHERE CountryCode = (
	SELECT CountryCode 
    FROM City
    WHERE Population = 122199
) 
AND Population != 122199
ORDER BY Population DESC;
#
#
# 17: What are the city names in the country where Luanda is capital?
SELECT Name 
FROM City 
WHERE CountryCode = (
	SELECT CountryCode 
    FROM City
	WHERE Name = 'Luanda'
);

SELECT City.Name 
FROM City 
JOIN Country ON Country.Code = City.CountryCode
WHERE Country.Capital = (
	SELECT City.Id 
    FROM City
	WHERE Name = 'Luanda'
);
#
#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT Capitals.Name AS Capital_Names
FROM Country AS Country_Capital
JOIN City AS Capitals ON Country_Capital.Capital = Capitals.ID
JOIN Country AS Country_Region ON Country_Capital.Region = Country_Region.Region
JOIN City AS Capital ON Country_Region.Code = Capital.CountryCode
WHERE Capital.Name = 'Yaren';
#
#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT CountryLanguage.Language AS Spoken
FROM City
JOIN Country AS Country_Riga ON City.CountryCode = Country_Riga.Code
JOIN Country AS Country_Region ON  Country_Riga.Region = Country_Region.Region
JOIN CountryLanguage ON Country_Region.Code = CountryLanguage.CountryCode
WHERE City.Name = 'Riga'
ORDER BY Spoken ASC;
#
#
# 20: Get the name of the most populous city
SELECT Name, Population 
FROM City
WHERE Population = (
	SELECT MAX(Population)
	FROM City
    );
#