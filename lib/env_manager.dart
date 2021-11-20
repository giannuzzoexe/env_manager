library env_manager;

import 'src/memory.dart';

export 'src/loader.dart' show locateAndLoad;
export 'src/entities/EnvironmentFileLoader.dart' show EnvironmentFileLoader;

/// Method to get an environment variable from the system
///
/// [mandatory] envName: String => Environment file name
/// [optional]  withProduction: bool => define if you want the variable inside the production env or in the development env

dynamic get(String envName, {bool? withProduction}) {
  withProduction = Memory.production;
  if (withProduction)
    return Memory.memoryStorage
        .where((element) => element.name == envName)
        .single
        .content[Memory.production ? "production" : "development"];
  return Memory.memoryStorage
      .where((element) => element.name == envName)
      .single
      .content;
}

/// Select the default environment to get the variables

void useProductionEnvironment(bool setToProduction) =>
    Memory.production = setToProduction;
