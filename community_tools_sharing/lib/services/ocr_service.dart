import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class OcrService {
  Future<Map<String, String?>> extractIdData(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(inputImage);
      await textRecognizer.close();

      String? id;
      String? expiry;

      for (final block in recognizedText.blocks) {
        final text = block.text.replaceAll(' ', '');
        final matchId = RegExp(r'\d{14}').firstMatch(text);
        if (matchId != null) id = matchId.group(0);

        final matchExp = RegExp(
          r'(\d{2}\/\d{4}|\d{2}\/\d{2}\/\d{4})',
        ).firstMatch(block.text);
        if (matchExp != null) expiry = matchExp.group(0);
      }

      return {'id': id, 'expiry': expiry};
    } catch (e) {
      throw Exception('OCR failed: $e');
    }
  }
}
