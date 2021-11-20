<!--`-->

Usually in an application it is necessary to have at hand a system to manage global variables (or environment variables) to propagate inside the application. env_manager does just that, it manages your environment variables in a smart way.

# How it works
Your environment variables are stored in a folder called `envdir`, this folder will contain all of your environment variable files and you can divide them up as you see fit.

Below is an example of a project folder that uses `env_manager`.
```
your_project
├───android
│└───...
├───assets
│└───...
├───build
│└───...
│
├───envdir
│├───application.yaml
│├───another_env_file.yaml
│└───example_env_folder
│	└───example_env_file_inside_folder.yaml
│
├───ios
│└───...
├───lib
│└───...
├───test
│└───...
├───.flutter-plugins
├───.flutter-plugins-dependencies
├───.gitattributes
├───.gitignore
├───.metadata
├───.packages
├───analysis_options.yml
├───your_project.iml
├───pubspec.lock
├───pubspec.yaml
└───README.md
```

# Setup the package in your application
Add the package in the dependecies section of your `pubspec.yaml` file.
```yaml
env_manager: ^0.1.2
```

and execute the `flutter pub get` to fetch the package from `pub.dev`.

After the fetch, execute the `flutter pub run env_manager:make` to create the `envdir` in your project root directory, inside this folder your can create all your environment files (even with different folders).

**IMPORTANT:** All environment files must use the following format
```yaml
production:
	example_A_variable: "My A variable in production"
	example_B_variable: "My B variable in prodution"
	...

development:
	example_A_variable: "My A variable in development"
	example_B_variable: "My B variable in development"
```
All variables must be the same for production and development sections.

After this, you need to add the environment files in the `assets` section inside the `pubspec.yaml` file.

```yaml
...
flutter:
	assets:
		- assets/myexampleimage.png
		- assets/anotherexampleimage.jpg
		...

		#Env Files
		- envdir/application.yaml
		- envdir/example_folder/new_env_file.yaml
		...
...
```

# Add the code in your application

In your main class, add the following snippt before the `runApp` method

```dart
...
void main() async {
	WidgetsFlutterBinding.ensureInitialized();

	await env.locateAndLoad([
		env.EnvironmentFileLoader("myEnvName", await rootBundle.loadString("envdir/application.yaml")),
		env.EnvironmentFileLoader("myEnvName2", await rootBundle.loadString("envdir/example_folder/new_env_file.yaml")),
		..other files to load..
	]);

	...
}
...
```
You can also setup the environment to reply with production variables or with development variables using

```dart 
env.useProductionEnvironment(true | false);
```
**IMPORTANT:** By default is set to false

or you can call directly the environment using the get method (By default will take the useProductionEnvironment value)

```dart
env.get("myEnvName")["variable_name"]
env.get("myEnvName", withProduction: true | false)["variable_name"]
```
