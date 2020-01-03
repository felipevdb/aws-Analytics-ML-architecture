import csv
import mysql.connector
from mysql.connector import Error

#insertVariblesIntoTable('fd3348decc9f430e0ac4fe8f6e295b2c','7d84470691342ca6eeef041506aa4422','18047','sorocaba','SP')

connection = mysql.connector.connect(
                    host="dbecommercce.cwrhgv0yu1je.us-east-1.rds.amazonaws.com",
                    user="admin",
                    passwd="7hXV51XqkHBDURU6GcNH",
                    database="ecommerce")
cursor = connection.cursor()
mySql_insert_query = """INSERT INTO order_payments(order_id, payment_sequential, payment_type, payment_installments, payment_value)
                                VALUES (%s, %s, %s, %s, %s) """


lista = []

with open('/Users/felbrito/WorkDocs/DataSets/ECommerce-Transactions/brazilian-ecommerce/olist_order_payments_dataset.csv') as csvfile:
    readCSV = csv.reader(csvfile, delimiter=',')
    next(readCSV)
    i = 0

    for row in readCSV:
        lista.append((
        row[0],
        row[1],
        row[2],
        row[3],
        row[4],
        ))

    start = 0
    end = 0

    while (end < 103886):
        end = end + 500
        cursor.executemany(mySql_insert_query, lista[start:end])
        connection.commit()
        print('start:', start,' ending:', end,'\n')
        start = end
     
    
    print('Rows inserted')
    if (connection.is_connected()):
            cursor.close()
            connection.close()
            print("MySQL connection is closed")




