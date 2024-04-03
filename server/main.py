from load_img_server import ImageLoader
import tensorflow as tf
from image_analysis import analisar_pasta

class Main:
    def __init__(self):
        self.cred_path = 'viabilidade-tecnica-trash-firebase.json'
        self.bucket_url = 'viabilidade-tecnica-trash.appspot.com'
        self.model_path = 'converted_savedmodel/model.savedmodel'
        self.labels_path = 'converted_savedmodel/labels.txt'
        self.images_dir = 'imagens_servidor/'

    def run(self):
        # Baixar imagens
        print("Iniciando o download das imagens...")
        loader = ImageLoader(self.cred_path, self.bucket_url, '')
        loader.download_images()
        print("Arquivos baixados.")

        # Carregar modelo e rótulos
        print("Carregando modelo e rótulos...")
        model = tf.keras.models.load_model(self.model_path)
        with open(self.labels_path, "r") as file:
            class_names = [line.strip() for line in file.readlines()]

        # Analisar imagens
        print("Iniciando a análise das imagens...")
        analisar_pasta(self.images_dir, model, class_names)
        print("Análise concluída.")

if __name__ == "__main__":
    main = Main()
    main.run()
