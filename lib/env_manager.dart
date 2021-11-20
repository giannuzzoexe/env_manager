library env_manager;

import 'src/memory.dart';

export 'src/loader.dart' show locateAndLoad;
export 'src/entities/EnvironmentFileLoader.dart' show EnvironmentFileLoader;

dynamic get(String envName, {bool? withProduction}) {
  withProduction = Memory.production;
  if (withProduction) return Memory.memoryStorage.where((element) => element.name == envName).single.content[Memory.production ? "production" : "development"];
  return Memory.memoryStorage.where((element) => element.name == envName).single.content;
}

void useProductionEnvironment(bool setToProduction) => Memory.production = setToProduction;
