-- Исследование корреляции между ростом населения и нормой калорий на человека в день
-- 1. Скачиваем датасеты из открытого источника
-- 2. Преобразуем в формат Excel
-- 3. Импортируем в Microsoft SQL Server Management Studio
-- 4. Смотрим данные из таблиц
SELECT *
FROM daily_supply

SELECT *
FROM population

-- 5. Объединяем таблицы по коду страны и годам, убираем континенты, сортируем по коду страны

SELECT d.entity, d.code, d.year, d.Daily_caloric_supply, 
p.Population
FROM daily_supply d
JOIN population p
ON d.code = p.code AND d.year = p.year
ORDER BY code

-- 6. Переносим данные в Power BI