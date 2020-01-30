import mysql.connector
from tabulate import tabulate
import Admin
import Charity
import Restaurant
import Driver

mydb = mysql.connector.connect(
    host="localhost",
    user="mobin",
    passwd="HHO6b9J8IM4f9yxJ",
    database="sharefooddb"
)
mydb.autocommit = True


def justExec(mydb, query, args):
    mycursor = mydb.cursor()
    mycursor.execute(query, args)


def login():
    print('-------------------------------')
    username = input("Enter Your Username: ")
    password = input("Enter Your Password: ")

    mycursor = mydb.cursor()
    mycursor.execute(
        "SELECT Username, Role FROM user WHERE Username = %s AND Password = %s", (username, password,))
    myresult = mycursor.fetchall()

    if mycursor.rowcount != 0:
        if myresult[0][1] == "Admin":
            Admin.run(myresult[0][0], mydb)
        elif myresult[0][1] == "Restaurant":
            Restaurant.run(myresult[0][0], mydb)
        elif myresult[0][1] == "Driver":
            Driver.run(myresult[0][0], mydb)
        elif myresult[0][1] == "Charity":
            Charity.run(myresult[0][0], mydb)

        return True
    else:
        print("Authentication Failed")
        return False


def forget():
    print('-------------------------------')
    username = input("Enter Your Username: ")

    mycursor = mydb.cursor()
    mycursor.execute(
        "SELECT Question FROM user INNER JOIN security_question sq on user.SecurityQuestion = sq.ID WHERE Username = %s", (username,))
    myresult = mycursor.fetchall()

    if mycursor.rowcount != 0:
        ans = input(str(myresult[0][0]) + " : ")
        mycursor = mydb.cursor()
        mycursor.execute(
            "SELECT Username FROM user WHERE Username = %s AND SecurityAnswer = %s", (username, ans, ))
        myresult = mycursor.fetchall()
        if mycursor.rowcount != 0:
            newPass = input("New Password: ")
            mycursor = mydb.cursor()
            mycursor.execute(
                "UPDATE user SET Password = %s WHERE Username = %s", (newPass, username, ))
            print("Password Changed Successfully :D")
        else:
            print("Wrong Answer!")
    else:
        print("Username Not Found!")


def register():
    username = input("Enter Username: ")
    password = input("Enter Password: ")

    mycursor = mydb.cursor()
    mycursor.execute(
        "SELECT * FROM security_question")
    myresult = mycursor.fetchall()

    securityQuestion = '0'
    while(True):
        if mycursor.rowcount != 0:
            print(tabulate(myresult, headers=[
                  'ID', 'Question'], tablefmt='psql'))
        else:
            print("No Result")

        securityQuestion = input("Enter Security Question ID: ")
        if int(securityQuestion) <= mycursor.rowcount and int(securityQuestion) > 0:
            break
    securityAnswer = input("Enter Security Answer: ")
    city = input("Enter City: ")
    region = input("Enter Region: ")
    role = input("Enter Role (Driver, Charity, Restaurant): ")

    if(role == 'Restaurant'):
        name = input("Enter Name: ")
        justExec(mydb,
                 """
        INSERT INTO user VALUES (%s, %s, %s, %s, %s);
        """, (username, password, securityQuestion, securityAnswer, role, ))

        justExec(mydb,
                 """
        INSERT INTO restaurant(ID, Name, City, Region)
            VALUES (%s, %s, %s, %s);
        """, (username, name, city, region, ))

    elif(role == 'Charity'):
        name = input("Enter Name: ")
        pop = input("Enter Population: ")
        found = input("Enter Foundation Year: ")
        use = input("Enter Daily Use: ")

        justExec(mydb,
                 """
        INSERT INTO user VALUES (%s, %s, %s, %s, %s);
        """, (username, password, securityQuestion, securityAnswer, role, ))

        justExec(mydb,
                 """
        INSERT INTO charity(ID, Name, Population, City, Region, FoundationYear)
            VALUES (%s, %s, %s, %s, %s, %s);
            """, (username, name, pop, city, region, found, ))

    elif(role == 'Driver'):
        fname = input("Enter First Name: ")
        lname = input("Enter Last Name: ")
        nid = input("Enter National ID: ")

        justExec(mydb,
                 """
        INSERT INTO user VALUES (%s, %s, %s, %s, %s);
        """, (username, password, securityQuestion, securityAnswer, role, ))

        justExec(mydb,
                 """
        INSERT INTO driver(ID, NationalID, FirstName, LastName, City, Region)
            VALUES (%s, %s, %s, %s, %s, %s);
            """, (username, nid, fname, lname, city, region, ))

    else:
        print("Unknown Role")


print('-------------------------------')
print("Welcome To Food Sharing Panel")
while(True):
    print('-------------------------------')
    print("Choose One Of Below Options To Continue: ")
    print("1.Login")
    print("2.Register")
    print("3.Forget Password")
    ans = input("Your Answer: ")
    if ans == '1':
        if login():
            break
    elif ans == '2':
        register()
    elif ans == '3':
        forget()
    else:
        print("Wrong Answer!")
