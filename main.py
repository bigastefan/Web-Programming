# Modul sa klasama za MySQL
import pymysql
import flask
from flask import Flask
# Flaskov modul za rad sa MySQL
from flaskext.mysql import MySQL
from flask import request



app = Flask(__name__, static_url_path="")

mysql = MySQL(cursorclass=pymysql.cursors.DictCursor)

app.config["MYSQL_DATABASE_USER"] = "bigara"
app.config["MYSQL_DATABASE_PASSWORD"] = "8stefan8biga"
app.config["MYSQL_DATABASE_DB"] = "mydb"
app.config["MYSQL_DATABASE_HOST"] = "localhost"


mysql.init_app(app)

users = []

@app.route("/")
def home():

    return app.send_static_file("home.html")



@app.route("/performances", methods=["GET"])
def performances():
    
    cursor = mysql.get_db().cursor()
    cursor.execute("SELECT * FROM performance")
    listOfPerformances = cursor.fetchall()
    return flask.jsonify(listOfPerformances)



@app.route("/users", methods=["GET"])
def login_check():

    cursor = mysql.get_db().cursor()
    cursor.execute("SELECT * FROM user")
    listOfUsers = cursor.fetchone()
                
    return flask.jsonify(listOfUsers)



@app.route("/performance", methods=["POST"])
def add_performance():

    data = request.json

    db = mysql.get_db()

    cursor = db.cursor()

    q = "INSERT INTO mydb.performance (name, duration, genre, cast, price) VALUES (%s, %s, %s, %s, %s);"

    
    cursor.execute(q, (data["name"], data["duration"], data["genre"], data["cast"], data["price"]))

    print(q)

    db.commit()
    

    return flask.jsonify({"status":"done"}), 201


@app.route("/reg", methods=["POST"])
def add_user():

    data = request.json

    db = mysql.get_db()

    cursor = db.cursor()

    q = "INSERT INTO mydb.user (name, surname, username, password, email, user_id) VALUES ( %s, %s, %s, %s, %s, %s);"
    
    cursor.execute(q, (data["username"], data["password"], data["name"], data["surname"], data["email"], data["userid"]))

    print(q)

    db.commit()
    

    return flask.jsonify({"status":"done"}), 201

 


@app.route("/performances/<int:id_performances>", methods=["GET"])
def get_performance(id_performances):

    for i, e in enumerate (listOfPerformances):
        if e["id"] == id_performances:

            return flask.jsonify(e)
    
    return "", 404



@app.route("/deletePerf/<int:id_performance>", methods=["DELETE"])
def deletePerf(id_performance):

    db = mysql.get_db()

    cursor = db.cursor()

    cursor.execute("DELETE FROM performance WHERE id=%s", (id_performance))

    db.commit()

    return ""

@app.route("/changePerf/<int:id_performance>", methods=["PUT"])
def changePerf(id_performance):

    
    # Dobavljanje podataka iz tela zahteva.
    data = request.json
    # Dobavljanje objekta baze.
    db = mysql.get_db()
    # Dobavljanje kursora.
    cursor = db.cursor()

    q = "UPDATE `mydb`.`performance` SET `name`= %s, `duration`= %s, `genre`= %s, `cast`= %s, `price`= %s, `desc`= %s WHERE `id`= %s;"

    cursor.execute(q, (data["name"], data["duration"], data["genre"], data["cast"], data["price"], data["desc"], id_performance))
    
    # cursor.execute(q)

    db.commit()

    return ""


# @app.route("/reserve/<int:id_performance>", methods=["POST"])
# def changePerf(id_performance):

#     data = request.json

#     db = mysql.get_db()

#     cursor = db.cursor()

#     q = "INSERT INTO mydb.ticket (name, duration, genre, cast, price) VALUES (%s, %s, %s, %s, %s);"





app.run("", 8000, threaded=True)

