import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/routes.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

const String PARSE_APP_ID = '8MceXz6TcG5cY1NAweWyFiWgBkSuTMf4bfS2z9sj';
const String PARSE_APP_URL = 'https://parseapi.back4app.com';
const String MASTER_KEY = 'EYeDspB0mGBSjA7wYYSxlq3rQS95twuXWWbbIUal';
const String LIVE_QUERY_URL = 'wss://trongdth.back4app.io';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onCreate(Cubit cubit) {
    super.onCreate(cubit);
    print('onCreate -- cubit: ${cubit.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(Cubit cubit, Change change) {
    super.onChange(cubit, change);
    print('onChange -- cubit: ${cubit.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('onError -- cubit: ${cubit.runtimeType}, error: $error');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onClose(Cubit cubit) {
    super.onClose(cubit);
    print('onClose -- cubit: ${cubit.runtimeType}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Parse().initialize(
    PARSE_APP_ID,
    PARSE_APP_URL,
    masterKey: MASTER_KEY,
    liveQueryUrl: LIVE_QUERY_URL,
    autoSendSessionId: true,
    debug: true,
  );

  runApp(
    Routes(),
  );
}
