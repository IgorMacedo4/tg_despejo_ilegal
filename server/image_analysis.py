#image_analysis.py
from keras.models import load_model
from PIL import Image, ImageOps
import numpy as np
import tensorflow as tf
import os
from datetime import datetime
import pandas as pd  # pandas para manipulação dos dados

def prever_classe(modelo, caminho_imagem, class_names):
    image = Image.open(caminho_imagem).convert("RGB")
    size = (224, 224)
    image = ImageOps.fit(image, size, Image.Resampling.LANCZOS)
    image_array = np.asarray(image)
    normalized_image_array = (image_array.astype(np.float32) / 127.5) - 1
    data = np.ndarray(shape=(1, 224, 224, 3), dtype=np.float32)
    data[0] = normalized_image_array
    prediction = modelo(data)
    index = np.argmax(prediction)
    class_name = class_names[index].strip()
    confidence_score = prediction[0][index]
    return class_name, confidence_score

def analisar_pasta(caminho_pasta, modelo, class_names):
    resultados = []

    for root, dirs, files in os.walk(caminho_pasta):
        print(f"Analisando pasta: {root}")
        for file in files:
            if file.lower().endswith(('.png', '.jpg', '.jpeg')):
                caminho_completo = os.path.join(root, file)
                print(f"Analisando imagem: {caminho_completo}")

                try:
                    class_name, confidence_score = prever_classe(modelo, caminho_completo, class_names)
                    print(f"{file}: Class: {class_name}, Confidence Score: {confidence_score}")
                    resultados.append({
                        "Imagem/Data/Hora": file,
                        "Data/Hora Analise": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                        "Classificação": class_name,
                        "Confiança": confidence_score
                    })
                except Exception as e:
                    print(f"Erro ao analisar {file}: {e}")

    # Cria um DataFrame com os resultados
    df = pd.DataFrame(resultados)
    # Salva o DataFrame em um arquivo Excel
    df.to_excel('resultados_analise.xlsx', index=False, engine='openpyxl')

if __name__ == "__main__":
    model_path = 'converted_savedmodel/model.savedmodel'
    labels_path = 'converted_savedmodel/labels.txt'
    model = tf.keras.models.load_model(model_path)
    class_names = open(labels_path, "r").readlines()

    caminho_pasta = 'imagens_servidor/'
    analisar_pasta(caminho_pasta, model, class_names)
