from flask import Flask,request
import json
import requests
import mysql.connector
app = Flask(__name__)
mydb = mysql.connector.connect(host="localhost" , user="root" , passwd="covid@123",database = "mydb")
cursor = mydb.cursor()



# cursor.execute("CREATE TABLE Mirzapur(block INT(1),adhaar VARCHAR(12), priority INT(3))")
# cursor.execute("CREATE TABLE Ghaziabad(block INT(1),adhaar VARCHAR(12), priority INT(3))")
# cursor.execute("CREATE TABLE Lucknow(block INT(1),adhaar VARCHAR(12), priority INT(3))")
# cursor.execute("CREATE TABLE Agra(block INT(1),adhaar VARCHAR(12), priority INT(3))")
#cursor.execute("insert into agra (block,adhaar,priority) Values(1 ,'123456789012',41)")
cursor.execute("SELECT * FROM Agra")

myresult = cursor.fetchall()

for x in myresult:
  print(x)

density = {
'Agra' : 1084*100/11320,
'Lucknow' : 1815*100/11320,
'Mirzapur' : 561*100/11320,
'Ghaziabad' : 3967*100/11320,
'Varanasi': 2399*100/11320
}

pop = {
'Agra' : 1084,
'Lucknow' : 1815,
'Mirzapur' : 561,
'Ghaziabad' : 3967,
'Varanasi': 2399
}


category = {
'Working' : 70,
'Unhealthy' : 80,
'Frontline Workers' : 100,
'Lactating Women' : 60,
'Rest': 40
}





@app.route('/register',methods = ['POST'])      
def register():
    


    if request.method == 'POST':

        result = request.get_json()
        k = request.get_json(force=True)
        print(k)
        countries_api_res = requests.get('https://api.covid19india.org/state_district_wise.json')
        state = countries_api_res.json()

        a = state[k['state']]['districtData'][k['district']]['active']
        d= density[k['district']]
        cat = category[k['occupation']]

        print(d)
        print(a)
        print(cat)
        value = ((3*d) + (3*cat) + ((70 - int(k['age']))*100/70) + 3*(a/pop[k['district']]*100))/10
        print(value)
        

    #formula
    #needed age , district(population density ,active), occupation, 


        return json.dumps(d)


@app.route('/gettime',methods = ['POST'])      
def gettime():


    if request.method == 'POST':
        result = request.get_json()
        k = request.get_json(force=True)
        print(k)
        countries_api_res = requests.get('https://api.covid19india.org/state_district_wise.json')
        state = countries_api_res.json()

        a = state['Uttar Pradesh']['districtData']['Ghaziabad']['active']
    #formula


        return json.dumps(a)


if __name__ == '__main__':
   app.run(debug = True)