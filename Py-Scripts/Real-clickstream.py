import csv
import random
import datetime
import boto3
import json
import numpy as np
from time import sleep

def csv_to_list (filepath, filename):
    array = []
    with open(filepath +'/'+ filename) as csvfile:
        reader = csv.reader(csvfile,  delimiter=',') # change contents to floats
        colunas = next(reader)
        for row in reader: # each row is a list
            array.append(row)
    
    return array

def generate_arrays(orders, order_items, products):
    date_array = []
    customers_array = []
    products_category_array = []

    for i in range( 0, len(orders)):
        #indices = [j for j, x in enumerate(j[0] for j in order_items) if x == orders[i][0]]
        for j, x in enumerate(j[0] for j in order_items):
            if x == orders[i][0]:
                for u, y in enumerate(u[0] for u in products):
                    if y == order_items[j][2]:
                        #customers_array.append(orders[i][1]) #Customer_Id
                        #products_category_array.append(products[u][1]) #product_category_name
                        #date_array.append( orders[i][3]) #date
                        data = generate_ClickStream(orders[i][1], products[u][1], orders[i][3], products[u][0])
                        sendData_Stream(data) 


    return date_array, customers_array, products_category_array

def sendData_Stream(data):
    print('sending data:', data)
    response = kinesis_client.put_record(
        DeliveryStreamName = stream_name,
        Record={
            "Data": json.dumps(data).encode('ascii')
        }
    )
    #print(response)

def generate_ClickStream(customer, product_category, date, product_id):
    data = {}
    data['customer_id'] = customer
    data['device_id'] = random.choice(['mobile','computer', 'tablet', 'mobile','computer', 'computer'])
    data['product_id'] = product_id
    data['product_category_name'] = product_category
    data['campanha'] = random.choice(['facebook','twitter', 'e-mail', 'google ads','Null'])
    data['timestamp'] = date
    return data

filepath = '/Users/felbrito/Documents/Projects/aws-Analytics-ML-architecture/Dataset'
#Orders
orders_file = 'olist_orders_dataset.csv'
#Items
order_items_file = 'olist_order_items_dataset.csv'
#products
products_file = 'olist_products_dataset.csv'
#Kinesis Configuration
kinesis_client = boto3.client('firehose', region_name='us-east-1')
stream_name = 'clickStream'

orders = csv_to_list(filepath, orders_file)
order_items = csv_to_list(filepath, order_items_file)
products = csv_to_list(filepath, products_file)

date_array,customers_array,products_category_array = generate_arrays(orders, order_items, products)

#for i in range( 0, len(customers_array)):
#    data = generate_ClickStream(customers_array[i], products_category_array[i], date_array[i])
#    sendData_Stream(data) 