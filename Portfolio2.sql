-- ������������ ���������� ����� ������ ��������� � ������ ������� �� �������� � ����
-- 1. ��������� �������� �� ��������� ���������
-- 2. ����������� � ������ Excel
-- 3. ����������� � Microsoft SQL Server Management Studio
-- 4. ������� ������ �� ������
SELECT *
FROM daily_supply

SELECT *
FROM population

-- 5. ���������� ������� �� ���� ������ � �����, ������� ����������, ��������� �� ���� ������

SELECT d.entity, d.code, d.year, d.Daily_caloric_supply, 
p.Population
FROM daily_supply d
JOIN population p
ON d.code = p.code AND d.year = p.year
ORDER BY code

-- 6. ��������� ������ � Power BI