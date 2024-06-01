select 1 from dual;

truncate HOUSING_DATA.SELL_DATA;

select * from HOUSING_DATA.RENT_DATA;

select * from HOUSING_DATA.SELL_DATA;

select cena, miasto from HOUSING_DATA.SELL_DATA;

select round(avg(cena), 2) from HOUSING_DATA.SELL_DATA;

select miasto, avg(cena) from HOUSING_DATA.SELL_DATA group by miasto;

select miasto, avg(cena_m2) from HOUSING_DATA.SELL_DATA group by miasto;

select miasto, dzielnica, avg(cena) from HOUSING_DATA.SELL_DATA group by miasto, dzielnica order by miasto, dzielnica;

select * from  HOUSING_DATA.SELL_DATA where miasto='Sopot' order by cena_m2 desc;



select balkon, avg(cena_m2), count(*) as liczba_ofert from HOUSING_DATA.SELL_DATA group by balkon;

select miasto, dzielnica, avg(cena), avg(Pokoje), avg(rok_budowy), avg(pow_całkowita), avg(cena_m2), avg(balkon), avg(liczba_pieter), count(*) as l_ofert from HOUSING_DATA.SELL_DATA group by miasto, dzielnica order by avg(pow_całkowita) desc

select miasto, rok_budowy, avg(pow_całkowita), count(*) as l_ofert from HOUSING_DATA.SELL_DATA group by miasto, rok_budowy order by miasto, rok_budowy desc

select * from HOUSING_DATA.SELL_DATA where rok_budowy=1972

select Miasto, round(avg(cena),2) as 'Cena [zł]', avg(Pokoje) as 'Liczba pokoi', round(avg(rok_budowy),2) as 'Rok budowy', 
round(avg(pow_całkowita),2) as 'Powierzchnia całkowita [m2]', round(avg(cena_m2),2) as 'Cena za m2 [zł/m2]', 
round(avg(balkon)*100,2) 'Obecność balkonu [%]', round(avg(liczba_pieter),2) as 'Liczba pięter', count(*) as 'Liczba ofert' 
from HOUSING_DATA.SELL_DATA group by miasto order by miasto

select Miasto, Dzielnica, round(avg(cena),2) as 'Cena [zł]', avg(Pokoje) as 'Liczba pokoi', round(avg(rok_budowy),2) as 'Rok budowy', 
round(avg(pow_całkowita),2) as 'Powierzchnia całkowita [m2]', round(avg(cena_m2),2) as 'Cena za m2 [zł/m2]', 
round(avg(balkon)*100,2) 'Obecność balkonu [%]', round(avg(liczba_pieter),2) as 'Liczba pięter', count(*) as 'Liczba ofert' 
from HOUSING_DATA.SELL_DATA group by miasto, dzielnica order by miasto, dzielnica


select Miasto,(rok_budowy-mod(rok_budowy, 10)) as Lata, round(avg(pow_całkowita), 2) as 'Powierzchnia całkowita [m2]', 
round(avg(pokoje), 2) as 'Liczba pokoi', round(avg(cena_m2), 2) as 'Cena za m2 [zł/m2]', round(avg(pietro),2) as Piętro, 
round(avg(Liczba_pieter),2) as 'Liczba pięter', count(*) as 'Liczba ofert' 
from HOUSING_DATA.SELL_DATA group by miasto, lata order by miasto, lata desc



select a.Miasto, a.Dzielnica, round(a.Srednia_cena_sprzedazy_za_m2, 2) as 'Średnia cena sprzedaży za m2 [zł/m2]', 
round(b.Srednia_cena_najmu_za_m2, 2) as 'Średnia cena najmu za m2 [zł/m2]', 
round(b.Srednia_cena_najmu_za_m2/a.srednia_cena_sprzedazy_za_m2*12*100*0.915, 2) as ROI,
a.Liczba_ofert_sprzedazy as 'Liczba ofert sprzedaży', b.Liczba_ofert_najmu as 'Liczba ofert najmu' from 
(select miasto, dzielnica, avg(cena_m2) as srednia_cena_sprzedazy_za_m2, count(*) as liczba_ofert_sprzedazy from HOUSING_DATA.SELL_DATA group by miasto, dzielnica order by miasto, dzielnica) a
left join
(select miasto, dzielnica, avg(cena_m2) as srednia_cena_najmu_za_m2, count(*) as liczba_ofert_najmu from HOUSING_DATA.RENT_DATA group by miasto, dzielnica order by miasto, dzielnica) b
on a.miasto=b.miasto and a.dzielnica=b.dzielnica
order by ROI desc;