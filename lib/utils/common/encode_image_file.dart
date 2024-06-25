import 'package:universal_html/html.dart' as html;

Future<String?> encodeImageFile(String? imageUrl) async {
  if (imageUrl == null) {
    return null;
  }

  final response = await html.HttpRequest.request(
    imageUrl,
    responseType: 'blob',
  );

  final reader = html.FileReader();
  reader.readAsDataUrl(response.response as html.Blob);
  await reader.onLoad.first;

  final result = reader.result as String;

  List<String> resultSplit = result.split(',');

  final String resultOk = resultSplit[1].trim();

  return resultOk;
}
