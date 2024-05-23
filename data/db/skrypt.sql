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

select a.miasto, a.dzielnica, a.srednia_cena_sprzedazy_za_m2, b.srednia_cena_najmu_za_m2, b.srednia_cena_najmu_za_m2/a.srednia_cena_sprzedazy_za_m2*12*100*0.915 as ROI,
a.liczba_ofert_sprzedazy, b.liczba_ofert_najmu from 
(select miasto, dzielnica, avg(cena_m2) as srednia_cena_sprzedazy_za_m2, count(*) as liczba_ofert_sprzedazy from HOUSING_DATA.SELL_DATA group by miasto, dzielnica order by miasto, dzielnica) a
left join
(select miasto, dzielnica, avg(cena_m2) as srednia_cena_najmu_za_m2, count(*) as liczba_ofert_najmu from HOUSING_DATA.RENT_DATA group by miasto, dzielnica order by miasto, dzielnica) b
on a.miasto=b.miasto and a.dzielnica=b.dzielnica
order by ROI desc;

select balkon, avg(cena_m2), count(*) as liczba_ofert from HOUSING_DATA.SELL_DATA group by balkon;

select miasto, dzielnica, avg(pow_całkowita), avg(cena_m2), avg(balkon), avg(liczba_pieter), count(*) as l_ofert from HOUSING_DATA.SELL_DATA group by miasto, dzielnica order by avg(pow_całkowita) desc

select miasto, rok_budowy, avg(pow_całkowita), count(*) as l_ofert from HOUSING_DATA.SELL_DATA group by miasto, rok_budowy order by miasto, rok_budowy desc

select * from HOUSING_DATA.SELL_DATA where rok_budowy=1972


select miasto,(rok_budowy-mod(rok_budowy, 10)) as lata, avg(pow_całkowita), avg(cena_m2), count(*) as l_ofert from HOUSING_DATA.SELL_DATA group by miasto, lata order by miasto, lata desc