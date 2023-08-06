from flask import Flask,request,jsonify
import mysql.connector as conn

app = Flask(__name__)

@app.route("/testrun")
def test():
    name=request.args.get("name")
    mobile=request.args.get("mobile")
    mailid=request.args.get("mailid")
    return 'this is my first function with name {} {} {}'.format(name,mobile,mailid)


@app.route("/fetchDBtoWeb")
def fetchDBToWeb():
    db = request.args.get('db')
    tn=request.args.get('tn')
    con = conn.connect(host='localhost',user='root',password='root',database=db)
    cursor = con.cursor(dictionary=True)
    cursor.execute("Select * from {}".format(tn))
    return jsonify(str(cursor.fetchall()))



if __name__=='__main__':
    app.run(port=5002)