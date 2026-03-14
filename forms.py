from flask_wtf import FlaskForm
from wtforms import StringField, RadioField, BooleanField, IntegerField, SubmitField
from wtforms.validators import DataRequired, NumberRange
from wtforms.fields import DateField
from datetime import date

class PedidoForm(FlaskForm):
    # Datos del cliente
    nombre = StringField('Nombre', validators=[DataRequired(message="El nombre es obligatorio")])
    direccion = StringField('Dirección', validators=[DataRequired(message="La dirección es obligatoria")])
    telefono = StringField('Teléfono', validators=[DataRequired(message="El teléfono es obligatorio")])
    fecha = DateField('Fecha del Pedido', format='%Y-%m-%d', default=date.today)
    
    tamano = RadioField('Tamaño Pizza', choices=[
        ('Chica', 'Chica $40'),
        ('Mediana', 'Mediana $80'),
        ('Grande', 'Grande $120')
    ], validators=[DataRequired(message="Selecciona un tamaño de pizza")])
    
    jamon = BooleanField('Jamón $10')
    pina = BooleanField('Piña $10')
    champinones = BooleanField('Champiñones $10')
    
    num_pizzas = IntegerField('Cantidad', validators=[
        DataRequired(message="Ingresa la cantidad"),
        NumberRange(min=1, message="Debes pedir al menos 1 pizza")
    ])
    
    agregar = SubmitField('Agregar')
    terminar = SubmitField('Terminar')