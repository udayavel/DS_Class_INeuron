from flask import Flask,request,jsonify
import mysql.connector
import pymongo

app = Flask(__name__)

myclient = pymongo.MongoClient('mongodb+srv://Udayavel:root@cluster0.gqsn3hi.mongodb.net/?retryWrites=true&w=majority')
mydb = myclient['apitask']
mycol = mydb["employee"]
# MY SQL
@app.route('/insertSQL',methods=['GET','POST'])
def insert_SQL():
    if request.method=='POST':
        emp_name=request.json['emp_name']
        emp_no=request.json['emp_no']
        emp_city=request.json['emp_city']
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            password="root",
            database="apitask"
        )
        mycursor = mydb.cursor()
        sql = "INSERT INTO employee (emp_name, emp_no, emp_city) VALUES (%s, %s, %s)"
        val = (emp_name, emp_no,emp_city)
        mycursor.execute(sql, val)
        mydb.commit()
        return jsonify(str("Inserted Successfully"))


@app.route('/updateSQL',methods=['GET','POST'])
def update_SQL():
    if request.method=='POST':
        emp_city=request.json['emp_city']
        emp_no = request.json['emp_no']
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            password="root",
            database="apitask"
        )
        mycursor = mydb.cursor()
        sql = "UPDATE employee SET emp_city = '"+emp_city+"' WHERE emp_no = '"+emp_no+"'"
        mycursor.execute(sql)
        mydb.commit()
        return jsonify(str("City Updation Successfully"))

@app.route('/deleteSQL',methods=['GET','POST'])
def delete_SQL():
    if request.method=='POST':
        emp_no = request.json['emp_no']
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            password="root",
            database="apitask"
        )
        mycursor = mydb.cursor()
        sql = "DELETE FROM employee WHERE emp_no = '"+emp_no+"'"
        mycursor.execute(sql)
        mydb.commit()
        return jsonify(str("Record Deletion Successfully"))


@app.route('/fetchSQL',methods=['GET','POST'])
def fetch_SQL():
    if request.method=='POST':
        emp_no = request.json['emp_no']
        mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            password="root",
            database="apitask"
        )
        mycursor = mydb.cursor()
        sql = "SELECT * FROM employee WHERE emp_no = '"+emp_no+"'"
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        return jsonify(str(myresult))


# MONGO DB

@app.route('/insertMNG',methods=['GET','POST'])
def insert_MNG():
    if request.method=='POST':
        emp_name=request.json['emp_name']
        emp_no=request.json['emp_no']
        emp_city=request.json['emp_city']
        mydict = {"emp_no": emp_no, "emp_name": emp_name,"emp_city" : emp_city}
        x = mycol.insert_one(mydict)
        return jsonify(str("Inserted Successfully"))

@app.route('/updateMNG',methods=['GET','POST'])
def update_MNG():
    if request.method=='POST':
        emp_no=request.json['emp_no']
        emp_city=request.json['emp_city']
        myquery = {"emp_no": emp_no}
        newvalues = {"$set": {"emp_city": emp_city}}
        x = mycol.update_one(myquery,newvalues)
        return jsonify(str("Updation Successfully"))


@app.route('/deleteMNG',methods=['GET','POST'])
def delete_MNG():
        if request.method=='POST':
            emp_no = request.json['emp_no']
            myquery = {"emp_no": emp_no}
            x = mycol.delete_one(myquery)
            return jsonify(str("Deletion Successfully"))


@app.route('/fetchMNG',methods=['GET','POST'])
def fetch_MNG():
        if request.method=='POST':
            emp_no = request.json['emp_no']
            myquery = {"emp_no": emp_no}
            x = mycol.find_one()
            return jsonify(str(x))








if __name__ == '__main__':
    app.run()


