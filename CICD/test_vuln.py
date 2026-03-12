import sqlite3

def insecure_login(username, password):
    conn = sqlite3.connect('test.db')
    query = f"SELECT * FROM users WHERE username= {'username}' AND password = '{password}'"
    conn.execute(query)

    api_key = "AKIAIOSFODNN7EXAMPLE"
    return True
