from flask import Flask, render_template, request, redirect, url_for, flash, session
from models import db, Cliente, Pizza, Pedido, DetallePedido
from forms import PedidoForm
from datetime import date
from sqlalchemy import extract, func

app = Flask(__name__)
app.secret_key = 'clave_super_secreta_para_el_examen_uwu'

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:root@127.0.0.1/pizzas'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

with app.app_context():
    db.create_all()

PRECIOS_TAMANO = {'Chica': 40, 'Mediana': 80, 'Grande': 120}
PRECIO_INGREDIENTE = 10

# --- RUTA PRINCIPAL (Captura de Pedidos) ---
@app.route('/', methods=['GET', 'POST'])
def index():
    form = PedidoForm()
    
    # Inicializamos la variable de sesión si no existe
    if 'pedido' not in session:
        session['pedido'] = []
        
    # Magia anti-amnesia: Pre-llenamos el formulario si hay datos guardados en la sesión
    if request.method == 'GET' and 'cliente_temporal' in session:
        form.nombre.data = session['cliente_temporal']['nombre']
        form.direccion.data = session['cliente_temporal']['direccion']
        form.telefono.data = session['cliente_temporal']['telefono']
        form.tamano.data = session['cliente_temporal']['tamano']
        form.num_pizzas.data = session['cliente_temporal']['num_pizzas']
        
    if request.method == 'POST':
        if form.agregar.data and form.validate_on_submit():
            # Guardamos los datos del cliente y selección actual en sesión para que no se borren
            session['cliente_temporal'] = {
                'nombre': form.nombre.data,
                'direccion': form.direccion.data,
                'telefono': form.telefono.data,
                'tamano': form.tamano.data,
                'num_pizzas': form.num_pizzas.data
            }
            
            tamano = form.tamano.data
            num_pizzas = form.num_pizzas.data
            
            ingredientes = []
            if form.jamon.data: ingredientes.append('Jamón')
            if form.pina.data: ingredientes.append('Piña')
            if form.champinones.data: ingredientes.append('Champiñones')
            
            # Cálculo del subtotal
            costo_base = PRECIOS_TAMANO.get(tamano, 0)
            costo_ingredientes = len(ingredientes) * PRECIO_INGREDIENTE
            subtotal = (costo_base + costo_ingredientes) * num_pizzas
            
            pizza_dict = {
                'tamano': tamano,
                'ingredientes': ', '.join(ingredientes) if ingredientes else 'Queso',
                'num_pizzas': num_pizzas,
                'subtotal': float(subtotal)
            }
            
            pedido_actual = session['pedido']
            pedido_actual.append(pizza_dict)
            session['pedido'] = pedido_actual
            session.modified = True
            
            return redirect(url_for('index'))
            
        elif form.terminar.data and form.validate_on_submit():
            if not session.get('pedido'):
                flash('No hay pizzas en el pedido actual. ¡Agrega al menos una! >_<', 'error')
                return redirect(url_for('index'))
                
            nuevo_cliente = Cliente(
                nombre=form.nombre.data,
                direccion=form.direccion.data,
                telefono=form.telefono.data
            )
            db.session.add(nuevo_cliente)
            db.session.flush() # Obtenemos el ID del cliente sin hacer commit total aún
            
            total_pedido = sum(item['subtotal'] for item in session['pedido'])
            nuevo_pedido = Pedido(
                id_cliente=nuevo_cliente.id_cliente,
                fecha=date.today(),
                total=total_pedido
            )
            db.session.add(nuevo_pedido)
            db.session.flush()
            
            for item in session['pedido']:
                nueva_pizza = Pizza(
                    tamano=item['tamano'],
                    ingredientes=item['ingredientes'],
                    precio=(item['subtotal'] / item['num_pizzas']) 
                )
                db.session.add(nueva_pizza)
                db.session.flush()
                
                detalle = DetallePedido(
                    id_pedido=nuevo_pedido.id_pedido,
                    id_pizza=nueva_pizza.id_pizza,
                    cantidad=item['num_pizzas'],
                    subtotal=item['subtotal']
                )
                db.session.add(detalle)
            
            db.session.commit()
            session.pop('pedido', None) 
            session.pop('cliente_temporal', None) # Borramos los datos del form para el siguiente cliente
            
            flash(f'¡Pedido guardado con éxito! Importe total a pagar: ${total_pedido}', 'success')
            return redirect(url_for('index'))
        
    hoy = date.today()
    ventas_hoy = Pedido.query.filter_by(fecha=hoy).all()
    total_ventas_hoy = sum(venta.total for venta in ventas_hoy)
            
    total_temporal = sum(item['subtotal'] for item in session.get('pedido', []))
    return render_template('index.html', form=form, pedido=session.get('pedido', []), total=total_temporal, ventas_hoy=ventas_hoy, total_ventas_hoy=total_ventas_hoy)

# --- RUTA PARA QUITAR PIZZA ---
@app.route('/quitar/<int:index>')
def quitar_pizza(index):

    pedido_actual = session.get('pedido', [])
    if 0 <= index < len(pedido_actual):
        pedido_actual.pop(index) 
        session['pedido'] = pedido_actual
        session.modified = True
    return redirect(url_for('index'))

# --- RUTA PARA CONSULTAS (Por Día y/o Mes) ---
@app.route('/ventas', methods=['GET', 'POST'])
def ventas():
    ventas_encontradas = []
    gran_total = 0
    
    if request.method == 'POST':
        dia_num = request.form.get('dia_seleccionado')
        mes_num = request.form.get('mes_seleccionado')
        
        query = Pedido.query
        if dia_num and dia_num != 'todos':
            query = query.filter(func.dayofweek(Pedido.fecha) == int(dia_num))
            
        if mes_num and mes_num != 'todos':
            query = query.filter(func.month(Pedido.fecha) == int(mes_num))
            
        ventas_encontradas = query.all()
        gran_total = sum(v.total for v in ventas_encontradas)
                
    return render_template('ventas.html', ventas=ventas_encontradas, total=gran_total)

@app.route('/detalle/<int:id>', methods=['GET'])
def detalle_venta(id):
    # Buscamos el pedido por su ID. Si no existe, mandamos un error 404.
    pedido = Pedido.query.get_or_404(id)
    return render_template('detalle.html', pedido=pedido)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)