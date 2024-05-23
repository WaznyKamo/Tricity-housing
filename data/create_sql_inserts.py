# -*- coding: utf-8 -*-
"""
Created on Mon May 20 19:51:25 2024

@author: Kamil
"""

import pandas as pd


data = pd.read_csv("data_cleaned.csv")

sell_data = data[data['Sprzedaż'] == 1]

sell_data['inserts'] = 'INSERT INTO HOUSING_DATA.SELL_DATA VALUES (' + sell_data['Cena'].astype(str) + ", '" + sell_data['Miasto'] + "','" + sell_data['Dzielnica'] + \
"'," + sell_data['Pokoje'].astype(str) + "," + sell_data['Pow. całkowita'].astype(str) + "," + sell_data['Rok budowy'].astype(str) + "," + \
sell_data['Piętro'].astype(str) + "," + sell_data['Liczba pięter'].astype(str) + "," + sell_data['Balkon'].astype(str) + "," + sell_data['Cena/m2'].astype(str) + \
"," + sell_data['Rynek pierwotny'].astype(str) + ");"

rent_data = data[data['Najem'] == 1]


rent_data['inserts'] = 'INSERT INTO HOUSING_DATA.RENT_DATA VALUES (' + rent_data['Cena'].astype(str) + ", '" + rent_data['Miasto'] + "','" + rent_data['Dzielnica'] + \
"'," + rent_data['Pokoje'].astype(str) + "," + rent_data['Pow. całkowita'].astype(str) + "," + rent_data['Rok budowy'].astype(str) + "," + \
rent_data['Piętro'].astype(str) + "," + rent_data['Liczba pięter'].astype(str) + "," + rent_data['Balkon'].astype(str) + "," + rent_data['Cena/m2'].astype(str) + \
"," + rent_data['Rynek pierwotny'].astype(str) + ");"


sell_data.to_csv('db/sell_data.sql', columns = ['inserts'], index=False, header=False, sep='|')
rent_data.to_csv('db/rent_data.sql', columns = ['inserts'], index=False, header=False, sep='|')
