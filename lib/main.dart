import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:canal/firebase_options.dart';
import 'package:canal/initialization/bootstrap/bootstrap.dart';
import 'package:canal/initialization/bootstrap/firebase_bootstrap.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /// * uncomment this if you need to sign out when switching between Firebase projects (emulator <--> firebase backend)
  /// await FirebaseAuth.instance.signOut();
  
  /// turn off the # in the URLs on the web
  usePathUrlStrategy();
  /// ensre URL changes  in the address bar when using push / pushNamed
  /// more info here:
  /// * https://docs.google.com/document/d/1VCuB85D5kYxPR3qYOjVmw8boAGKb7k62heFyfFHTOvw/edit
  GoRouter.optionURLReflectsImperativeAPIs = true;
  /// create an app bootstrap instance
  final appBootstrap = AppBootstrap();
  /// * uncomment this to connect to the Firebase emulators
  appBootstrap.setupEmulators();
  /// create a container configured with all the Firebase repositories
  final container = await appBootstrap.createFirebaseProviderContainer();
  /// use the container above to create the root widget
  final root = appBootstrap.createRootWidget(container: container);
  /// start the app
  runApp(root);
}
