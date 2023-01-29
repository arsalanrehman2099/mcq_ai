import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfApi {
  static Future<File> generatePdf({String? header, String? pdfContent}) async {
    final pdf = Document();

    final image = await imageFromAssetBundle('assets/answer-sheet.png');

    pdf.addPage(MultiPage(
      build: (context) => [
        Header(text: header, margin: const EdgeInsets.only(bottom: 25.0)),
        Paragraph(text: pdfContent ?? ""),
        Footer(
            title: Text(
                'Your answers must be only on the provided answer sheet.')),
        SizedBox(height: 5.0),
        Footer(
            title: Text('BEST OF LUCK',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Image(image)
      ],
    ));

    return saveDocument(name: 'Quiz.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFilex.open(url);
  }
}
