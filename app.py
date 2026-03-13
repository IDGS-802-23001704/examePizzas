from flask import Flask, render_template, request, redirect, url_for, flash, session
from models import db, Cliente, Pizza, Pedido, DetallePedido
# from forms import PedidoForm # 

app = Flask(__name__)

app.secret_key = 'clave_secreta_uwu'


app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:root@127.0.0.1/pizzas'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

with app.app_context():
    db.create_all()

@app.route('/')
def index():
    return "¡Servidor Flask conectado a la base de datos y funcionando al 100%! | o |"

if __name__ == '__main__':
    app.run(debug=True)