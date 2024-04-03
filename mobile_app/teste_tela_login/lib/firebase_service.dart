//firebase_service.dart
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:intl/intl.dart'; // Adicione esta importação para formatar a data e a hora

class FirebaseService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImages(List<File> imagesFiles, {required int lote}) async {
    // Formatar a data e a hora atual
    String formattedDate =
        DateFormat('yyyy-MM-dd_HH:mm:ss').format(DateTime.now());
    String folderName =
        "lote_${lote}_$formattedDate"; // Nome da pasta com identificação do lote e a hora

    for (File imageFile in imagesFiles) {
      String fileName = Path.basename(imageFile.path);
      try {
        // Referência para o local no Firebase onde a imagem será salva, incluindo a pasta do lote
        Reference ref = storage.ref().child('$folderName/images/$fileName');

        // Upload da imagem
        await ref.putFile(imageFile);

        // Opcional: obter a URL da imagem após o upload
        String imageUrl = await ref.getDownloadURL();
        print('Imagem Enviada: $imageUrl');
      } catch (e) {
        print(e);
      }
    }
  }
}
