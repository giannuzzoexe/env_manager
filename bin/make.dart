import 'dart:io';

void main(List<String> arguments) async {
  try {
    File file = await File("envdir/application.yaml").create(recursive: true);

    final initialValues = StringBuffer();

    //Production Variables
    initialValues.write('production:');
    initialValues
        .write('[ns]displayname: "My Awesome Production Application Name"');

    //Development Variables
    initialValues.write('[n][n]development:');
    initialValues
        .write('[ns]displayname: "My Awesome Development Application Name"');

    file.writeAsStringSync(wParse(initialValues.toString()));
  } catch (exc) {
    print(exc);
  }
}

String wParse(String s) {
  return s.replaceAll("[ns]", "\n  ").replaceAll("[n]", "\n");
}
