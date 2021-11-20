import 'package:env_manager/src/entities/EnvironmentFileEntity.dart';
import 'package:env_manager/src/entities/EnvironmentFileLoader.dart';
import 'package:env_manager/src/memory.dart';

/// Method to load the environment files in memory before the application's start
///
/// [mandatory] envFiles: List<EnvironmentFileLoader> => List of all environment name/files that need to be loaded

Future<void> locateAndLoad(List<EnvironmentFileLoader> envFiles) async {
  Memory.memoryStorage.clear();
  List<String> tan = [];

  for (EnvironmentFileLoader file in envFiles) {
    EnvironmentFileEntity entity =
        EnvironmentFileEntity(file.name, file.toYaml);
    if (tan.contains(entity.name)) {
      throw Exception(
          "Duplicated environment file found! Try to change the file name => ${entity.name}");
    }
    Memory.memoryStorage.add(entity);
    tan.add(entity.name);
  }
}
