import mysql.connector
from tabulate import tabulate


def showQuery(mydb, query, h, args):
    try:
        mycursor = mydb.cursor()
        mycursor.execute(query, args)
        myresult = mycursor.fetchall()

        if mycursor.rowcount != 0:
            print(tabulate(myresult, headers=h, tablefmt='psql'))
        else:
            print("No Result")
    except:
        print("Error")


def justExec(mydb, query, args):
    try:
        mycursor = mydb.cursor()
        mycursor.execute(query, args)
    except:
        print("Error")


def run(ID, MyDB):
    print('-------------------------------')
    print('Wellcome ' + str(ID) + ' To Restaurant Panel')
    while(True):
        print('-------------------------------')
        print("Choose One Of Below Options To Continue: ")
        print("""
        1.Show Co-operate Restaurants
        2.Show Charity With Minimum Donate
        3.Get Charity's Today Need 
        4.Send Food
        5.Get Not Contracted Charities
        6.Contract With Charity
        7.Delete Acount
        """)

        ans = input("Your Answer: ")
        if ans == '1':
            showQuery(MyDB,
                      """
            SELECT DISTINCT Name
            FROM contract
            INNER JOIN restaurant r on contract.RestaurantID = r.ID
            WHERE CharityID IN (SELECT CharityID FROM contract WHERE RestaurantID = %s) AND RestaurantID != %s;
            """,
                      ['Name'], (ID, ID,))
        elif ans == '2':
            showQuery(MyDB,
                      """
            SELECT Name as CharityName
            FROM delivery
            INNER JOIN charity c on delivery.CharityID = c.ID
            WHERE RestaurantID = %s AND CharityID IN (SELECT CharityID FROM contract WHERE contract.RestaurantID = %s)
            GROUP BY CharityID
            ORDER BY SUM(Count) LIMIT 1;
            """,
                      ['CharityName'], (ID, ID,))
        elif ans == '3':
            showQuery(MyDB,
                      """
            SELECT contract.CharityID, Name, GREATEST(DailyUsage - TodayReceive, 0) as NeededFood
            FROM contract
            INNER JOIN charity c on contract.CharityID = c.ID
            INNER JOIN (SELECT CharityID, SUM(Count) as TodayReceive FROM delivery WHERE Date = CURRENT_DATE AND State = 'Done' GROUP BY CharityID) s ON s.CharityID = contract.CharityID
            WHERE RestaurantID = %s;
            """,
                      ['ID', 'Charity Name', 'Needed Food'], (ID,))
        elif ans == '4':
            charityId = input("Enter Charity ID: ")
            amount = input("Enter Amout: ")

            justExec(MyDB,
                     """
            INSERT INTO delivery(RestaurantID, CharityID, Count)
                VALUES (%s, %s, %s);
            """, (ID, charityId, amount,))
        elif ans == '5':
            charityId = input("Enter Charity ID: ")
            amount = input("Enter Amount: ")

            justExec(MyDB,
                     """
            INSERT INTO delivery(RestaurantID, CharityID, Count)
                VALUES (%s, %s, %s);
            """, (ID, charityId, amount,))
        elif ans == '6':
            charityId = input("Enter Charity ID: ")

            justExec(MyDB,
                     """
            INSERT INTO contract(RestaurantID, CharityID)
                VALUES (%s, %s);
            """, (ID, charityId,))
        elif ans == '7':
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
