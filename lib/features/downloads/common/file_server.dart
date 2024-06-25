import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';

downloadFile(Uint8List? bytes, String eventName, String typeDownload) async {
  await FileSaver.instance.saveFile(
      name: '$typeDownload-$eventName',
      bytes: bytes,
      ext: 'xlsx',
      mimeType: MimeType.microsoftExcel);
}
