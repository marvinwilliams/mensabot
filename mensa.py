from bs4 import BeautifulSoup
import requests
import sys

url = sys.argv[1]
meals = {}
r = requests.get(url)
soup = BeautifulSoup(r.text, 'html.parser')
adenauer = soup.find(id='canteen_place_1')
cantine = adenauer.find(id='fragment-c1-1')#.find_all('tr', recursive=False)
line = ''
meal_name = ''
for row in cantine.find_all('tr', recursive=False):
    for column in row.find_all('td'):
        if not 'class' in column.attrs:
            continue
        if 'mensatype' in column['class']:
            line = column.div.text
            meals[line] = {}
        for entry in column.find_all('span'):
            if 'class' in entry.attrs:
                if 'bg' in entry['class']:
                    if not entry.text:
                        continue
                    meal_name = entry.text
                    meals[line][meal_name] = ''
                    print(line, meal_name)
                elif 'price_3' in entry['class']:
                    if not entry.text:
                        continue
                    price = entry.text 
                    meals[line][meal_name] = price


print("| Linie | Essen | Preis |\\n")
print("|-------|-------|-------|\\n")
for line, items in meals.items():
    if items:
        meals = list(items.items())
        print(f"| {line} | {meals[0][0]} | {meals[0][1]} |\\n")
        for meal in meals[1:]:
            if "zu jedem Gericht ein Dessert oder Obst" in meal[0]:
                continue
            print(f"| | {meal[0]} | {meal[1]} |\\n")
