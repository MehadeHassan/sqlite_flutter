import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:sqlite_flutter/services/database_service.dart';
import 'app/app.dart';
import 'app/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runZonedGuarded(
    () => runApp(App(
      databaseService: DatabaseService(),
    )),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
