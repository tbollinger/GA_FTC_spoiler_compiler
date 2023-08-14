import re, requests, json, pprint as pprint
import time
from bs4 import BeautifulSoup

site = "https://www.gatcg.com/article/fractured-crown-design-notes"

response = requests.get(site)

soup = BeautifulSoup(response.text, 'html.parser')
img_tags = soup.find_all('img')

urls = [img['src'] for img in img_tags]

for url in urls:
    filename = re.search(r'/([\w_-]+[.](jpg|gif|png|webp))$', url)
    print(filename)
    time.sleep(0.2)
    try:
        if not filename:
             # print("Regex didn't match with the url: {}".format(url))
             continue
        with open(filename.group(1), 'wb') as f:
            if 'http' not in url:
                url = '{}{}'.format(site, url)
            print('trying to get file from: {}'.format(url))
            response = requests.get(url)
            f.write(response.content)
    except:
        print('could not get file: {}'.format(filename))

