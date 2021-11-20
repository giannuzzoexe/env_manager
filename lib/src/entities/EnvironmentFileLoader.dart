// ignore_for_file: file_names

import 'package:yaml/yaml.dart';

class EnvironmentFileLoader {
  const EnvironmentFileLoader(this.name, this.file);

  final String name;
  final String file;

  /// Get the mapped version of the yaml file

  dynamic get toYaml => loadYaml(file);
}
