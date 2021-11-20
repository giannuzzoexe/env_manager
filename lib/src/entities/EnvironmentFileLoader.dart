// ignore_for_file: file_names

import 'package:yaml/yaml.dart';

class EnvironmentFileLoader {
  const EnvironmentFileLoader(this.name, this.file);

  final String name;
  final String file;

  dynamic get toYaml => loadYaml(file);
}
