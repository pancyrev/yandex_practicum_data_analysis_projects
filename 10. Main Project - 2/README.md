# Проект «Анализ поведения пользователей мобильного приложения»

**Описание проекта**  
Вы работаете в стартапе, который продаёт продукты питания. Нужно разобраться, как ведут себя пользователи вашего мобильного приложения.
Изучите воронку продаж. Узнайте, как пользователи доходят до покупки. Сколько пользователей доходит до покупки, а сколько — «застревает» на предыдущих шагах? На каких именно?

**Входные данные**  
Файл `/datasets/logs_exp.csv` с действиями пользователей

**Цель:** провести анализ поведения пользователей по результатам ААВ-эксперимента по замене шрифтов в интерфейсе мобильного приложения для заказа продуктов питания.

**Задачи**  
Шаг 1. Загрузите данные и подготовьте их к анализу  
Шаг 2. Подготовьте данные  
- Замените названия столбцов на удобные для вас;  
- Проверьте пропуски и типы данных. Откорректируйте, если нужно;  
- Добавьте столбец даты и времени, а также отдельный столбец дат;

Шаг 3. Изучите и проверьте данные  
- Сколько всего событий в логе?  
- Сколько всего пользователей в логе?  
- Сколько в среднем событий приходится на пользователя?  
- Данными за какой период вы располагаете? Найдите максимальную и минимальную дату. Постройте гистограмму по дате и времени. Можно ли быть уверенным, что у вас одинаково полные данные за весь период? Технически в логи новых дней по некоторым пользователям могут «доезжать» события из прошлого — это может «перекашивать данные». Определите, с какого момента данные полные и отбросьте более старые. Данными за какой период времени вы располагаете на самом деле?  
- Много ли событий и пользователей вы потеряли, отбросив старые данные?  
- Проверьте, что у вас есть пользователи из всех трёх экспериментальных групп.  

Шаг 4. Изучите воронку событий  
- Посмотрите, какие события есть в логах, как часто они встречаются. Отсортируйте события по частоте.  
- Посчитайте, сколько пользователей совершали каждое из этих событий. Отсортируйте события по числу пользователей. Посчитайте долю пользователей, которые хоть раз совершали событие.  
- Предположите, в каком порядке происходят события. Все ли они выстраиваются в последовательную цепочку? Их не нужно учитывать при расчёте воронки.  
- По воронке событий посчитайте, какая доля пользователей проходит на следующий шаг воронки (от числа пользователей на предыдущем). То есть для последовательности событий A → B → C посчитайте отношение числа пользователей с событием B к количеству пользователей с событием A, а также отношение числа пользователей с событием C к количеству пользователей с событием B.  
- На каком шаге теряете больше всего пользователей?  
- Какая доля пользователей доходит от первого события до оплаты?  

Шаг 5. Изучите результаты эксперимента  
- Сколько пользователей в каждой экспериментальной группе?  
- Есть 2 контрольные группы для А/А-эксперимента, чтобы проверить корректность всех механизмов и расчётов. Проверьте, находят ли статистические критерии разницу между выборками 246 и 247.  
- Выберите самое популярное событие. Посчитайте число пользователей, совершивших это событие в каждой из контрольных групп.    Посчитайте долю пользователей, совершивших это событие. Проверьте, будет ли отличие между группами статистически достоверным.   Проделайте то же самое для всех других событий (удобно обернуть проверку в отдельную функцию). Можно ли сказать, что разбиение на группы работает корректно?  
- Аналогично поступите с группой с изменённым шрифтом. Сравните результаты с каждой из контрольных групп в отдельности по каждому событию. Сравните результаты с объединённой контрольной группой. Какие выводы из эксперимента можно сделать?  
- Какой уровень значимости вы выбрали при проверке статистических гипотез выше? Посчитайте, сколько проверок статистических гипотез вы сделали. При уровне значимости 0.1 каждый десятый раз можно получать ложный результат. Какой уровень значимости стоит применить? Если вы хотите изменить его, проделайте предыдущие пункты и проверьте свои выводы.

**Используемые библиотеки:** pandas, numpy, datetime, scipy, math, plotly.

**Итоговые выводы:**

С целью анализа поведения пользователей по результатам ААВ-эксперимента по замене шрифтов в интерфейсе мобильного приложения для заказа продуктов питания были сделаны следующие задачи:
- Подготовлены исходные данные: заменены названия столбцов, проверены пропуски и типы данных, добавлены столбцы даты и времени
- Изучены и проверены данные: посчитано количество событий в логе, посчитано количество пользователей в логе, посчитано среднее количество событий на пользователя. Построены гистограммы событий по дате и времени. Определено, с какого момента данные полные и отброшены старые данные. Оценен период анализа, найдены максимальная и минимальная дата эксперимента. Посчитано, сколько событий и пользователей потеряли, отбросив старые данные. Проверено, что пользователи есть во всех трёх экспериментальных группах.
- Изучена воронка событий: изучены события в логах и посчитано как часто они встречаются. Посчитано, сколько пользователей совершали каждое из этих событий. Посчитана доля пользователей, которые хоть раз совершали событие. Предположено, в каком порядке происходят события. По воронке событий посчитано, какая доля пользователей проходит на следующий шаг воронки (от числа пользователей на предыдущем). Посчитано на каком шаге теряется больше всего пользователей. Посчитано какая доля пользователей доходит от первого события до оплаты.
- Изучены результаты эксперимента: посчитано количество пользователей в каждой экспериментальной группе. Проверены статистические критерии между выборками 246 и 247. Посчитаны доли пользователей, совершивших каждое событие. Проверено, будет ли отличие между группами статистически достоверным.
- Проверены статистические критерии с группой с изменённым шрифтом. Проведено сравните результатов с каждой из контрольных групп в отдельности по каждому событию. Проведено сравнение результатов с объединённой контрольной группой. Выбран уровень значимости при проверке статистических гипотез. Посчитано количество проверок статистических гипотез.
- Сделаны выводы.

Из исходного датафрейма были удалены события с неполными данными и низкой активностью пользователей. В окончательную таблицу попали данные в период с 2019-08-01 по 2019-08-07. Также были удалены пользователи с аномально высокой активностью: пользователи, которые совершили более двухсот событий за весь период исследования. Из исходной таблицы было удалено 15,2% данных.
Всего записей 206615, уникальных событий: 5.
Всего уникальных пользователей 7458. В среденем на каждого пользователя приходится 19 событий.
Пользователи разделены на три группы: две экспериментальных и одну контрольную. В каждой группе находится 2456, 2491 и 2511 пользователей соответственно.

Чаще всего происходило событие загрузки главной страницы приложения MainScreenAppear(54.8%) - 113264 раз.
40956 (19.8%) - OffersScreenAppear.
29250 (14.2%) - CartScreenAppear.
22164 (10.7%) - PaymentScreenSuccessful.
Реже всего клиенты пользовались Tutorial (0.5%) - 981.

7344 пользователей хотя бы раз запускали главный экран приложения. Это составляет 98,5% всех пользователей. Активность остальных 1,5% пользователей не была зарегестрирована, что, возможно, связано с ошибками подключения или регистрации пользователей в логах.
4517 пользователей (60,6%) открывали каталог товаров.
3658 пользователей (49%) переходили в корзину.
3463 пользователя (46,6%) упешно оплатили заказ.
824 пользователя (11%) хотя бы раз открывали руководство пользователя.

Возможная последовательность действий пользователей для оформления заказа:
- открывает главный экран приложения;
- изучает каталог товаров, добавляет их в корзину;
- переходит в корзину для оформления и оплаты заказа;
- переходит на экран успешной оплаты заказа.  
Руководство пользователя не учитывается при расчете воронки.

Анализ воронки показал следующие результаты:

На первом шаге теряется 38% пользователей. Пользователи не переходят с главного экрана в каталог. Возможно, это связано с проблемами интерфейса стартовой страницы.
81% пользователей, изучивших каталог, переходят к оформлению товара.
95% пользователей успешно оплачивает заказ.
От запуска стратовой страницы до офрмления заказа доходит 47% пользователей.

Без учета события Tutorial в каждой группе количество пользователей равно:
- в группе 246: 2455
- в группе 247: 2490
- в группе 248: 2509  
Каждый пользователь находится в одной группе и не входит в другие группы.

Проверка критериев А/А-теста показала следующее:

Количество пользователей в различных группах достигает 3,1%;
Для всех групп фиксируют и отправляют в системы аналитики данные об одном и том же;
Различие ключевых метрик по группам не превышает 5% и не имеет статистической значимости;
Попавший в одну из групп посетитель остаётся в этой группе до конца теста.
Ни для одного из событий разница не оказалось значимой и обе группы 246 и 247 можно считать контрольными. А/А эксперимент прошел успешно.

В рамках анализа А/В-теста сравнение результатов с каждой из контрольных групп в отдельности и результатов с объединённой контрольной группой по каждому событию не показало статистически занчимых различий. Из чего следует, что введение новых шрифтов в интерфейс программы не повлияло на конверсию.

При проверке статистических гипотез был принят уровень значимости 0,05. Всего было сделано 17 проверок:
- одна проверка событий А/А эксперимента
- четыре проверки долей пользователей по событиям контрольных групп
- 12 проверок долей пользователей по событиям контрольных, кобинированных и экспериментальных групп. 

Минимальное р-значение при проверке гипотез было 0,086 > 0,05, поэтому оставим уровень значимости равен 0,05, т.к. внедрение поправок на множественную проверку не приведет к увеличению значения уровня статистической значимости.

Из результатов анализа A/A/B-эксперимента следует, что изменение шрифта в приложении не повлияло на поведение пользователей.
