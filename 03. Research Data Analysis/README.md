# Проект «Исследование объявлений о продаже квартир»

**Цель:**

Нужно научиться определять рыночную стоимость объектов недвижимости. Ваша задача — установить параметры. Это позволит построить автоматизированную систему: она отследит аномалии и мошенническую деятельность.

**Исходные данные:**
По каждой квартире на продажу доступны два вида данных. Первые вписаны пользователем, вторые получены автоматически на основе картографических данных. Например, расстояние до центра, аэропорта, ближайшего парка и водоёма.

**Ход исследования:**

Шаг 1. Откройте файл с данными и изучите общую информацию  
Путь к файлу: `/datasets/real_estate_data.csv`.

Шаг 2. Предобработка данных  
Определите и изучите пропущенные значения:  
Для некоторых пропущенных значений можно предположить логичную замену. Например, если человек не указал число балконов — скорее всего, их нет. Такие пропуски правильно заменить на 0. Для других типов данных нет подходящего значения на замену. В этом случае правильно оставить эти значения пустыми. Отсутствие значения — тоже важный сигнал, который не нужно прятать.  
Заполните пропуски, где это уместно. Опишите, почему вы решили заполнить пропуски именно в этих столбцах и как выбрали значения.  
Укажите причины, которые могли привести к пропускам в данных.  
Приведите данные к нужным типам:  
Поясните, в каких столбцах нужно изменить тип данных и почему.  

Шаг 3. Посчитайте и добавьте в таблицу  
цену квадратного метра;  
день недели, месяц и год публикации объявления;  
этаж квартиры; варианты — первый, последний, другой;  
соотношение жилой и общей площади, а также отношение площади кухни к общей.  

Шаг 4. Проведите исследовательский анализ данных и выполните инструкции  
Изучите следующие параметры: площадь, цена, число комнат, высота потолков. Постройте гистограммы для каждого параметра.  
Изучите время продажи квартиры. Постройте гистограмму. Посчитайте среднее и медиану. Опишите, сколько обычно занимает продажа. Когда можно считать, что продажи прошли очень быстро, а когда необычно долго?  
Уберите редкие и выбивающиеся значения. Опишите, какие особенности обнаружили.  
Какие факторы больше всего влияют на стоимость квартиры? Изучите, зависит ли цена от площади, числа комнат, удалённости от центра. Изучите зависимость цены от того, на каком этаже расположена квартира: первом, последнем или другом. Также изучите зависимость от даты размещения: дня недели, месяца и года.  
Выберите 10 населённых пунктов с наибольшим числом объявлений. Посчитайте среднюю цену квадратного метра в этих населённых пунктах. Выделите населённые пункты с самой высокой и низкой стоимостью жилья. Эти данные можно найти по имени в столбце locality_name.  
Изучите предложения квартир: для каждой квартиры есть информация о расстоянии до центра. Выделите квартиры в Санкт-Петербурге (locality_name). Ваша задача — выяснить, какая область входит в центр. Создайте столбец с расстоянием до центра в километрах: округлите до целых значений. После этого посчитайте среднюю цену для каждого километра. Постройте график: он должен показывать, как цена зависит от удалённости от центра. Определите границу, где график сильно меняется, — это и будет центральная зона.  
Выделите сегмент квартир в центре. Проанализируйте эту территорию и изучите следующие параметры: площадь, цена, число комнат, высота потолков. Также выделите факторы, которые влияют на стоимость квартиры (число комнат, этаж, удалённость от центра, дата размещения объявления). Сделайте выводы. Отличаются ли они от общих выводов по всей базе?  

Шаг 5. Напишите общий вывод  
Оформление: Выполните задание в Jupyter Notebook. Заполните программный код в ячейках типа code, текстовые пояснения — в ячейках типа markdown. Примените форматирование и заголовки.  

**Используемые библиотеки:** pandas, pyplot, numpy.

**Итоговые выводы:**

В отчете был проанализирован архив объявлений о продаже квартир в Санкт-Петербурге и соседних населённых пунктах за несколько лет. Были обнаружены и обработаны пропущенные значения и заполнены пропуски. Данные были привежены к нужному типу.  
Посчитали и добавили в таблицу цену квадратного метра, день недели, месяц и год публикации объявления, категории по этажам квартиры, соотношение жилой и общей площади, а также отношение площади кухни к общей.  
Провели исследовательский анализ данных. Изучили следующие параметры: площадь, цена, число комнат, высота потолков и построили гистограммы для каждого параметра. Аномальных значений не обнаружено.  

Изучили время продажи квартиры. Построили гистограммы. Посчитали среднюю и медиану. Определили аномально короткие значения равные нулю и выбросы в значениях 45, 60 и 90. Среднее значение времени продажи квартиры равно 200 дней, медианное равно 112 дней. Межквартильнй диапазон равен от 43 до 263 дней. Диаграмма размаха охватывает диапазон от 1 до 593 дней. Значит продажи более 593 дней являются аномально долгими.  

Изучили факторы, которые больше всего влияют на стоимость квартиры.  
Цена зависит от площади квартиры. Чем выше площадь, тем выше стоимость.  
Цена не зависит от количества комнат.  
Чем ближе квартира к центру, тем выше разброс цен. На расстоянии более 10000 м цена квартиры слабо зависит от удаленности от центра.  
Цена квартиры зависит от этажа. На первом и последнем этажах квартиры дешевле.  
Во вторник публикуют объявления с наибольшей ценой. К выходным цена снижается и в воскресенье достигает минимума.  
Наибольшая цена на квартиры устанавливается в апреле, наименьшая - в июне. Обычно летом покупательная активность снижается.  
С 2014 года медианная цена квартир снижается. В 2017 году стоимость достигла минимума и затем начала повышаться.  

Были выбранны десять населенных пунктов с наибольшим числом объявлений и была посчитана средняя стоимость квадранго метра. Наибольшую среднюю стоимость квадратного метра имеет Санкт-Петербург, а наименьшую - Выборг.  

Изучили предложения квартир и информацию о расстоянии до центра. Анализ диаграммы рассеяния и графика зависимости цены от расстояния до центра показывает, что центральная зона ограничена радиусом 8км. На диаграмме рассеяния видно, что в центральной зоне большой разброс цены. На удалении от центра разброс уменьшается и цена меньше зависит от удаления от центра.  

Изучен сегмент квартир в центре и проанализирована эта территория.  
Цена зависит от площади квартиры. Чем больше площадь, тем выше цена. Количество комнат и высота потолков слабо влияет на цену.  
Цена квартиры зависит от этажа. На первом этаже квартиры дешевле. На последнем этаже цена выше.  
В центральной части города наблюдается большой разброс по ценам. При это по медианныным значениям можно заметить зависимость цены от удаленности от центра: чем дальше от центра, тем дешевле.  
По субботам публикуют самые дешевые квартиры. По понедельникам наиболее дорогие.  
В декабре публикуют объявления с самыми дешевыми ценами. В январе самые дорогие.  
Цена упала с 2014 до 2015 почти в два раза. В течение 2015-2019 гг. изменялась незначительно.  

Сравнивая данные по всей базе и объявлениям, выделенным в центральной зоне, можно сделать следующие выводы:  
Цена квартиры зависит от её площади. Чем выше площадь, тем выше стоимость. Количество комнат и высота потолков не влияет на цену. Цена квартиры зависит от этажа. На первом и последнем этажах квартиры дешевле. Чем ближе квартира к центру, тем выше разброс цен. Чем дальше квартира от центра, тем дешевле. На расстоянии более 10000 м цена квартиры слабо зависит от удаленности от центра.  
По данным всей базы во вторник публикуют самые дешевые квартиры, а в воскресенье - дорогие. Для центральной зоны Санкт-Петербурга в субботу - самые дешевые, в понедельник - дорогие. Также наблюдаются различия по месяцам публикации. Для всей базы самые дорогие - в апреле, дешевые - в июне. Для Санкт-Петербурга: дешевые - в декабре, дорогие - в январе. Цена квартир по рынку росла с 2017 года. При этом в Санкт-Петербурге в период с 2015-2019 гг. стоимость менялась незначительно.  

Таким образом, есть параметры, которые едины для всего рынка, не зависят от локального сегмента, но влияют на стоимость, такие как площадь, этажность и удаление от центра. И есть параметры которые необходимо учитывать в зависимости от региона: день и месяц публикации и особенности регионального изменения стоимости квартиры.