#load_img_server.py
import firebase_admin
from firebase_admin import credentials, storage
import os

class ImageLoader:
    def __init__(self, cred_path, bucket_url, path=''):
        self.cred = credentials.Certificate(cred_path)
        firebase_admin.initialize_app(self.cred, {'storageBucket': bucket_url})
        self.bucket = storage.bucket()
        self.path = path

    def download_images(self):
        blobs = self.bucket.list_blobs(prefix=self.path)
        for blob in blobs:
            local_path = os.path.join('imagens_servidor/', blob.name)
            os.makedirs(os.path.dirname(local_path), exist_ok=True)
            blob.download_to_filename(local_path)
            print(f'Imagem baixada: {local_path}')
