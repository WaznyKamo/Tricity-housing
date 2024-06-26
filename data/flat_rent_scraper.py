# -*- coding: utf-8 -*-
"""
Created on Fri Apr 12 17:37:31 2024

@author: Kamil
"""

from bs4 import BeautifulSoup
import requests
import pandas as pd
# import re


file_path = r"C:\Users\Kamil\OneDrive\Inżynieria danych i Data Science\Tricity-housing\data\flat-rent_Gdynia.csv"

# included filter in link in order to get only offers with known prices
url_site = "https://www.morizon.pl/do-wynajecia/mieszkania/gdynia/?ps%5Blocation%5D%5Bmap%5D=1with_price%5D=1&page="
flats = pd.DataFrame()

def get_flat_info(flat_url):
    response_flat = requests.get(flat_url)
    soup_flat = BeautifulSoup(response_flat.text, features='html.parser')
    
    # if not soup_flat.find("h3", attrs={"class": "offer-title big-text ezl3qpx2 ooa-ebtemw er34gjf0"}):
    #     return pd.DataFrame()
    try:
        price = soup_flat.find("span", attrs={"class": "hUo19C"}).text
    except:
        return pd.DataFrame()
    title = soup_flat.find("h1", attrs={"class": "reQkSH"}).text
    city = soup_flat.find("span", attrs={"class": "pB4Lzt"}).text
    try:
        area = soup_flat.find_all("span", attrs={"class": "pB4Lzt"})[1].text
    except:
        area = ''
    rooms = soup_flat.find("span", attrs={"class": "pFD0ZW"}).text
    
    # attribute_table = soup_flat.find('div', attrs={"class": "ooa-1gtr7l5 e18eslyg2"})
    
    flat_dict = {}
    flat_dict['Nazwa'] = title
    flat_dict['Cena'] = price
    flat_dict['Miasto'] = city
    flat_dict['Dzielnica'] = area
    flat_dict['Pokoje'] = rooms
    
    
    for section in soup_flat.find_all('div', attrs={"class": "Yrhe-z"}):
        for attribute in section.find_all('div', attrs={"class": "oH0nKI"}):
            attribute_name = attribute.find('div', attrs={"class": "OlSncH cBsAOs"}).text
            attribute_value = attribute.find('div', attrs={"class": "OlSncH i1S7Na"}).text
            
            flat_dict[attribute_name] = attribute_value
            flat = pd.DataFrame(flat_dict, index=[0])
    return flat

data = pd.DataFrame()
response = requests.get(url_site + '1')
soup = BeautifulSoup(response.text, features='html.parser')
     
pages = int(soup.find_all("div", attrs={"class": "FrQWdq"})[-2].text)
print(pages)


for i in range(1, pages+1):
    url = url_site + str(i)
    response = requests.get(url)
    soup = BeautifulSoup(response.text, features='html.parser')
    
    flat_list = soup.find_all('div', attrs={"class": "card__outer"})
    
    for flat in flat_list:
        link = flat.find('a').get("href")
        # name = flat.find('span', attrs={"class": "_9Y9BTQ"}).text
        link = "https://www.morizon.pl" + link
        flat_info = get_flat_info(link)
        flats = pd.concat([flats, flat_info]) 
    print(i)

flats.to_csv(file_path, index=False, sep='|')
print('File created')
    
    
