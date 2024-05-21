# Usa una imagen base, por ejemplo Python para una aplicación en Flask
FROM python:3.8
 
# Establece el directorio de trabajo
WORKDIR /usr/src/app
 
# Copia los archivos de requerimientos y los instala
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
 
# Copia el resto de los archivos de la aplicación
COPY . .
 
# Expone el puerto en el que la aplicación escuchará
EXPOSE 5000
 
# Comando para ejecutar la aplicación
CMD ["python", "app.py"]