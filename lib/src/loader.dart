import 'dart:io';

import 'package:env_manager/src/entities/EnvironmentFileEntity.dart';
import 'package:env_manager/src/entities/EnvironmentFileLoader.dart';
import 'package:env_manager/src/memory.dart';

Future<void> locateAndLoad(List<EnvironmentFileLoader> envFiles) async {
  Memory.memoryStorage.clear();
  List<String> tan = [];

  for (EnvironmentFileLoader file in envFiles) {
    EnvironmentFileEntity entity = EnvironmentFileEntity(file.name, file.toYaml);
    if (tan.contains(entity.name)) {
      throw FileSystemException(
        "Duplicated environment file found! Try to change the file name => ${entity.name}",
        null,
        const OSError("Duplicated file name found", 308641),
      );
    }
    Memory.memoryStorage.add(entity);
    tan.add(entity.name);
  }
}
