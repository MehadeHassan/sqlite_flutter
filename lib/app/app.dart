import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:sqlite_flutter/services/database_service.dart';

import '../home/home.dart';
import '../l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required DatabaseService databaseService,
  })  : _databaseService = databaseService,
        super(key: key);

  final DatabaseService _databaseService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _databaseService,
          
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomePage(),
      ),
    );
  }
}
