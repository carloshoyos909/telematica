# Usa una imagen base de Python
FROM python:3.10-slim

# Establecer un directorio de trabajo
WORKDIR /app

# Copiar los archivos de requisitos e instalar las dependencias
COPY requirements.txt .
RUN pip install -r ./requirements.txt

# Copiar el resto de los archivos de la aplicación
COPY static ./static
COPY templates ./templates
COPY ./web.py .

# Exponer el puerto en el que se ejecutará la aplicación
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD [ "python", "web.py" ]