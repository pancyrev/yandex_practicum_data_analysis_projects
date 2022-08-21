/* 1. Посчитайте, сколько компаний закрылось. */
SELECT COUNT(*)
FROM company
WHERE status = 'closed'

/* 2. Отобразите количество привлечённых средств для новостных компаний США. Используйте данные из таблицы company. Отсортируйте таблицу по убыванию значений в поле funding_total .*/
SELECT funding_total
FROM company
WHERE category_code IN ('news') AND country_code IN ('USA')
ORDER BY funding_total DESC

/* 3. Найдите общую сумму сделок по покупке одних компаний другими в долларах. Отберите сделки, которые осуществлялись только за наличные с 2011 по 2013 год включительно.*/
SELECT SUM(price_amount)
FROM acquisition
WHERE term_code = 'cash' 
    AND acquired_at BETWEEN '2011-01-01' AND '2013-12-31'
    
/* 4. Отобразите имя, фамилию и названия аккаунтов людей в твиттере, у которых названия аккаунтов начинаются на 'Silver'. */
SELECT first_name,
        last_name,
        twitter_username
FROM people
WHERE twitter_username LIKE 'Silver%'

/* 5. Выведите на экран всю информацию о людях, у которых названия аккаунтов в твиттере содержат подстроку 'money', а фамилия начинается на 'K'.*/
SELECT *
FROM people
WHERE twitter_username LIKE '%money%' AND last_name LIKE 'K%'

/* 6. Для каждой страны отобразите общую сумму привлечённых инвестиций, которые получили компании, зарегистрированные в этой стране. Страну, в которой зарегистрирована компания, можно определить по коду страны. Отсортируйте данные по убыванию суммы.*/
SELECT country_code,
        SUM(funding_total)
FROM company
GROUP BY country_code
ORDER BY sum DESC

/* 7. Составьте таблицу, в которую войдёт дата проведения раунда, а также минимальное и максимальное значения суммы инвестиций, привлечённых в эту дату.
Оставьте в итоговой таблице только те записи, в которых минимальное значение суммы инвестиций не равно нулю и не равно максимальному значению.*/
SELECT funded_at,
        MIN(raised_amount),
        MAX(raised_amount)
FROM funding_round
GROUP BY funded_at
HAVING MIN(raised_amount) != 0 AND MIN(raised_amount) !=MAX(raised_amount)

/* 8. Создайте поле с категориями:
Для фондов, которые инвестируют в 100 и более компаний, назначьте категорию high_activity.
Для фондов, которые инвестируют в 20 и более компаний до 100, назначьте категорию middle_activity.
Если количество инвестируемых компаний фонда не достигает 20, назначьте категорию low_activity.
Отобразите все поля таблицы fund и новое поле с категориями.*/
SELECT *,
        CASE
            WHEN invested_companies >= 100 THEN 'high_activity'
            WHEN invested_companies >= 20 AND invested_companies < 100 THEN 'middle_activity'
            WHEN invested_companies < 20 THEN 'low_activity'
         END
FROM fund

/* 9. Для каждой из категорий, назначенных в предыдущем задании, посчитайте округлённое до ближайшего целого числа среднее количество инвестиционных раундов, в которых фонд принимал участие. Выведите на экран категории и среднее число инвестиционных раундов. Отсортируйте таблицу по возрастанию среднего.*/
SELECT 
       CASE
           WHEN invested_companies>=100 THEN 'high_activity'
           WHEN invested_companies>=20 THEN 'middle_activity'
           ELSE 'low_activity'
       END AS activity,
       ROUND(AVG(investment_rounds))
FROM fund
GROUP BY activity
ORDER BY round

/* 10. Выгрузите таблицу с десятью самыми активными инвестирующими странами. Активность страны определите по среднему количеству компаний, в которые инвестируют фонды этой страны.
Для каждой страны посчитайте минимальное, максимальное и среднее число компаний, в которые инвестировали фонды, основанные с 2010 по 2012 год включительно.
Исключите из таблицы страны с фондами, у которых минимальное число компаний, получивших инвестиции, равно нулю. Отсортируйте таблицу по среднему количеству компаний от большего к меньшему, а затем по коду страны в лексикографическом порядке.
Для фильтрации диапазона по годам используйте оператор BETWEEN.*/
SELECT country_code,
       MIN(invested_companies),
       MAX(invested_companies),
       AVG(invested_companies)
FROM fund
WHERE EXTRACT(YEAR FROM CAST(founded_at AS date)) BETWEEN '2010' AND '2012'
GROUP BY country_code
HAVING MIN(invested_companies) > 0
ORDER BY avg DESC
LIMIT 10

/* 11. Отобразите имя и фамилию всех сотрудников стартапов. Добавьте поле с названием учебного заведения, которое окончил сотрудник, если эта информация известна.*/
SELECT p.first_name,
        p.last_name,
        e.instituition
FROM people AS p
LEFT OUTER JOIN education AS e ON p.id = e.person_id

/* 12. Для каждой компании найдите количество учебных заведений, которые окончили её сотрудники. Выведите название компании и число уникальных названий учебных заведений. Составьте топ-5 компаний по количеству университетов.*/
SELECT c.name,
        COUNT(DISTINCT instituition)
FROM people AS p
LEFT OUTER JOIN education AS e ON p.id = e.person_id
LEFT OUTER JOIN company AS c ON p.company_id = c.id
GROUP BY name
ORDER BY count DESC
LIMIT 5 OFFSET 1

/* 13. Составьте список с уникальными названиями закрытых компаний, для которых первый раунд финансирования оказался последним.*/
SELECT name
FROM company
WHERE id IN
    (SELECT company_id
    FROM funding_round
    WHERE is_first_round = is_last_round AND is_first_round != 0)
    AND status = 'closed'
    
/* 14. Составьте список уникальных номеров сотрудников, которые работают в компаниях, отобранных в предыдущем задании.*/
SELECT id
FROM people
WHERE company_id IN
    (SELECT id
    FROM company
    WHERE id IN
        (SELECT company_id
        FROM funding_round
        WHERE is_first_round = 1 AND is_last_round = 1)
        AND status = 'closed')

/* 15. Составьте таблицу, куда войдут уникальные пары с номерами сотрудников из предыдущей задачи и учебным заведением, которое окончил сотрудник.*/
        SELECT DISTINCT person_id,
        instituition
FROM education
WHERE person_id IN
    (SELECT id
    FROM people
    WHERE company_id IN
        (SELECT id
        FROM company
        WHERE id IN
            (SELECT company_id
            FROM funding_round
            WHERE is_first_round = 1 AND is_last_round = 1)
            AND status = 'closed'))

            
/* 16. Посчитайте количество учебных заведений для каждого сотрудника из предыдущего задания.*/
SELECT person_id,
        COUNT(instituition)
FROM education
WHERE person_id IN
    (SELECT id
    FROM people
    WHERE company_id IN
        (SELECT id
        FROM company
        WHERE id IN
            (SELECT company_id
            FROM funding_round
            WHERE is_first_round = 1 AND is_last_round = 1)
            AND status = 'closed'))
GROUP BY (person_id)

/* 17. Дополните предыдущий запрос и выведите среднее число учебных заведений (всех, не только уникальных), которые окончили сотрудники разных компаний. Нужно вывести только одну запись, группировка здесь не понадобится.*/
WITH
i AS (SELECT person_id,
        COUNT(instituition)
FROM education
WHERE person_id IN
    (SELECT id
    FROM people
    WHERE company_id IN
        (SELECT id
        FROM company
        WHERE id IN
            (SELECT company_id
            FROM funding_round
            WHERE is_first_round = 1 AND is_last_round = 1)
            AND status = 'closed'))
GROUP BY (person_id))

SELECT AVG(count)
FROM i

/* 18. Напишите похожий запрос: выведите среднее число учебных заведений (всех, не только уникальных), которые окончили сотрудники Facebook*.
*(сервис, запрещённый на территории РФ)*/
WITH
i AS (SELECT person_id,
        COUNT(instituition)
FROM education
WHERE person_id IN
    (SELECT id
        FROM people
        WHERE company_id IN
            (SELECT id
            FROM company
            WHERE name = 'Facebook'))
GROUP BY (person_id))

SELECT AVG(count)
FROM i

/* 19. Составьте таблицу из полей:
name_of_fund — название фонда;
name_of_company — название компании;
amount — сумма инвестиций, которую привлекла компания в раунде.
В таблицу войдут данные о компаниях, в истории которых было больше шести важных этапов, а раунды финансирования проходили с 2012 по 2013 год включительно.*/
SELECT f.name AS name_of_fund, 
       c.name AS name_of_company, 
	   fr.raised_amount AS amount
FROM investment AS i 
LEFT JOIN company AS c ON c.id = i.company_id
LEFT JOIN fund AS f ON f.id = i.fund_id
INNER JOIN (SELECT * 
           FROM funding_round
           WHERE EXTRACT(YEAR FROM funded_at) BETWEEN 2012 AND 2013) AS fr ON fr.id = i.funding_round_id
WHERE c.milestones > 6;

/* 20. Выгрузите таблицу, в которой будут такие поля:
название компании-покупателя;
сумма сделки;
название компании, которую купили;
сумма инвестиций, вложенных в купленную компанию;
доля, которая отображает, во сколько раз сумма покупки превысила сумму вложенных в компанию инвестиций, округлённая до ближайшего целого числа.
Не учитывайте те сделки, в которых сумма покупки равна нулю. Если сумма инвестиций в компанию равна нулю, исключите такую компанию из таблицы.
Отсортируйте таблицу по сумме сделки от большей к меньшей, а затем по названию купленной компании в лексикографическом порядке. Ограничьте таблицу первыми десятью записями.*/
WITH
i AS (SELECT a.id,
       c.name AS acquiring_company
FROM acquisition AS a
LEFT OUTER JOIN company AS c ON a.acquiring_company_id = c.id),

d AS (SELECT a.id,
               c.name AS acquired_company,
              c.funding_total 
FROM acquisition AS a
LEFT OUTER JOIN company AS c ON a.acquired_company_id = c.id)

SELECT acquiring_company,
        price_amount,
        acquired_company,
        funding_total,
        ROUND((price_amount/funding_total))
FROM acquisition AS a
LEFT OUTER JOIN i ON a.id = i.id
LEFT OUTER JOIN d ON a.id = d.id
WHERE price_amount != 0 AND funding_total != 0
ORDER BY price_amount DESC, acquired_company
LIMIT 10

/* 21. Выгрузите таблицу, в которую войдут названия компаний из категории social, получившие финансирование с 2010 по 2013 год включительно. Выведите также номер месяца, в котором проходил раунд финансирования.*/
SELECT c.name,
       EXTRACT(month FROM cast(fr.funded_at AS date))
FROM company AS c
LEFT JOIN funding_round AS fr ON c.id=fr.company_id
WHERE c.category_code='social'
  AND EXTRACT(year FROM cast(fr.funded_at AS date)) BETWEEN 2010 AND 2013
  
/* 22. Отберите данные по месяцам с 2010 по 2013 год, когда проходили инвестиционные раунды. Сгруппируйте данные по номеру месяца и получите таблицу, в которой будут поля:
номер месяца, в котором проходили раунды;
количество уникальных названий фондов из США, которые инвестировали в этом месяце;
количество компаний, купленных за этот месяц;
общая сумма сделок по покупкам в этом месяце.*/
WITH
i AS (SELECT COUNT(DISTINCT f.name),
        EXTRACT(MONTH FROM fr.funded_at) AS month
FROM funding_round AS fr
LEFT OUTER JOIN investment AS i ON fr.id = i.funding_round_id
LEFT OUTER JOIN fund AS f ON i.fund_id = f.id
WHERE fr.funded_at BETWEEN '2010-01-01' AND '2013-12-31'
        AND f.country_code = 'USA'
GROUP BY month),

b AS (SELECT COUNT( acquired_company_id),
        SUM(price_amount),
        EXTRACT(MONTH FROM acquired_at) AS month
FROM acquisition
WHERE acquired_at BETWEEN '2010-01-01' AND '2013-12-31'
GROUP BY month)

SELECT i.month,
        i.count,
        b.count,
        b.sum
FROM i
LEFT OUTER JOIN b ON i.month = b.MONTH

/* 23. Составьте сводную таблицу и выведите среднюю сумму инвестиций для стран, в которых есть стартапы, зарегистрированные в 2011, 2012 и 2013 годах. Данные за каждый год должны быть в отдельном поле. Отсортируйте таблицу по среднему значению инвестиций за 2011 год от большего к меньшему.*/
WITH
i1 AS (SELECT AVG(funding_total),
        country_code
FROM company
WHERE EXTRACT(YEAR FROM founded_at) = 2011 
    GROUP BY country_code),

i2 AS (SELECT AVG(funding_total),
        country_code
FROM company
WHERE EXTRACT(YEAR FROM founded_at) = 2012
    GROUP BY country_code),
    
i3 AS (SELECT AVG(funding_total),
        country_code
FROM company
WHERE EXTRACT(YEAR FROM founded_at) = 2013
    GROUP BY country_code)
    
SELECT i1.country_code,
        i1.avg,
        i2.avg,
        i3.avg
FROM i1
INNER JOIN i2 ON i1.country_code = i2.country_code
INNER JOIN i3 ON i1.country_code = i3.country_code
ORDER BY i1.avg DESC