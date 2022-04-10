-- Èññëåäîâàíèå êîððåëÿöèè ìåæäó ðîñòîì íàñåëåíèÿ è íîðìîé êàëîðèé íà ÷åëîâåêà â äåíü
-- 1. Ñêà÷èâàåì äàòàñåòû èç îòêðûòîãî èñòî÷íèêà
-- 2. Ïðåîáðàçóåì â ôîðìàò Excel
-- 3. Èìïîðòèðóåì â Microsoft SQL Server Management Studio
-- 4. Ñìîòðèì äàííûå èç òàáëèö

SELECT *
FROM daily_supply

SELECT *
FROM population

-- 5. Îáúåäèíÿåì òàáëèöû ïî êîäó ñòðàíû è ãîäàì, óáèðàåì êîíòèíåíòû, ñîðòèðóåì ïî êîäó ñòðàíû

SELECT d.entity, d.code, d.year, d.Daily_caloric_supply, 
p.Population
FROM daily_supply d
JOIN population p
ON d.code = p.code AND d.year = p.year
ORDER BY code

-- 6. Ïåðåíîñèì äàííûå â Power BI
-finput-charset=utf-8 -fexec-charset=cp866
