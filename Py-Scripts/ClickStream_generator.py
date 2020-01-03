import csv
import random
import datetime
import boto3
import json
from time import sleep


def csv_to_list(filepath, filename, columnName):
    colunas = []
    lista = []
    with open(filepath +'/'+ filename) as csvfile:
        readCSV = csv.reader(csvfile, delimiter=',')
        colunas = next(readCSV)
        
        columnIndex = colunas.index(columnName)

        for row in readCSV:
            lista.append(row[columnIndex])
    
    return lista

def generate_ClickStream(customers, products, locations):
    data = {}
    data['customer_id'] = random.choice(customers)
    data['device_id'] = random.choice(['mobile','computer', 'tablet', 'mobile','computer'])
    data['product_category_name'] = random.choice(products)
    data['location'] = random.choice(locations)
    now = datetime.datetime.now()
    str_now = now.isoformat()
    data['timestamp'] = str_now
    return data

def sendData_Stream(data):
    response = kinesis_client.put_record(
        DeliveryStreamName = stream_name,
        Record={
            "Data": json.dumps(data).encode('ascii')
        }
    )
    #print(response)


filepath = '/PATH/Dataset'
#Customers Id
customers_file = 'olist_customers_dataset.csv'
customers_column = 'customer_id'
#Product
product_file = 'olist_products_dataset.csv'
product_column = 'product_category_name'
#Location of customer
location_file = 'olist_geolocation_dataset.csv'
location_column = 'geolocation_city'
#Kinesis Configuration
kinesis_client = boto3.client('firehose', region_name='us-east-1')
stream_name = 'clickStream'

customers = csv_to_list(filepath, customers_file, customers_column)
products = csv_to_list(filepath, product_file, product_column)
locations = csv_to_list(filepath, location_file, location_column)

while(True):
    data = generate_ClickStream(customers, products, locations)
    sendData_Stream(data) 