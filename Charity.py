import mysql.connector
from tabulate import tabulate


def showQueryA(mydb, query, h, args):
    mycursor = mydb.cursor()
    mycursor.execute(query, args)
    myresult = mycursor.fetchall()

    if mycursor.rowcount != 0:
        print(tabulate(myresult, headers=h, tablefmt='psql'))
    else:
        print("No Result")


def justExec(mydb, query, args):
    mycursor = mydb.cursor()
    mycursor.execute(query, args)


def showQuery(mydb, query, h):
    mycursor = mydb.cursor()
    mycursor.execute(query)
    myresult = mycursor.fetchall()

    if mycursor.rowcount != 0:
        print(tabulate(myresult, headers=h, tablefmt='psql'))
    else:
        print("No Result")


def run(ID, MyDB):
    print('-------------------------------')
    print('Hello ' + str(ID))
    while(True):
        print('-------------------------------')
        print("Choose One Of Below Options To Continue: ")
        print("""
        1.Show Driver Should Be Rated
        2.Rate Driver
        3.Set Daily Usage
        4.Edit Charity Name
        5.Update Password
        6.Delete Account
        """)

        ans = input("Your Answer: ")
        if ans == '1':
            showQueryA(MyDB,
                       """
            SELECT DeliveryID, CharityID, CONCAT(FirstName, ' ', LastName) AS Name
            FROM delivery
            INNER JOIN driver d on delivery.DriverID = d.ID
            WHERE CharityID = %s AND Rate = 0;
            """,
                       ['Delivery ID', 'Charity ID', 'Driver Name'], (ID, ))
        elif ans == '2':
            deliveryID = input('Enter Delivery ID: ')
            rate = input('Enter Rate: ')
            justExec(MyDB,
                     """
            UPDATE delivery
            SET Rate = %s
            WHERE DeliveryID = %s;
            """, (rate, deliveryID, ))
        elif ans == '3':
            usage = input('Enter Daily Usage: ')
            justExec(MyDB,
                     """
            UPDATE charity
            SET DailyUsage = %s
            WHERE ID = %s;
            """, (usage, ID, ))
        elif ans == '4':
            name = input('Enter New Name: ')
            justExec(MyDB,
                     """
            UPDATE charity
            SET Name = %s
            where ID = %s;
            """, (name, ID, ))
        elif ans == '5':
            passwd = input('Enter New Password: ')
            justExec(MyDB,
                     """
            UPDATE user
            SET Password = %s
            where Username = %s;
            """, (passwd, ID, ))
        elif ans == '6':
            justExec(MyDB,
                     """
            DELETE FROM user
            WHERE Username = %s;   

            """, (ID, ))
            break
        else:
            print("Wrong Choice!")

        ans = input("Do You Want To Continue? (y/N): ")
        if ans == "Y" or ans == "y":
            continue
        break
