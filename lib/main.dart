import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/auth/auth_events.dart';
import 'package:flutter_bloc_back4app/repositories/user_repos.dart';
import 'package:flutter_bloc_back4app/routes.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

const String PARSE_APP_ID = '';
const String PARSE_APP_URL = 'https://parseapi.back4app.com';
const String MASTER_KEY = '';
const String LIVE_QUERY_URL = 'wss://trongdth.back4app.io';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}


void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  await Parse().initialize(
    PARSE_APP_ID,
    PARSE_APP_URL,
    masterKey: MASTER_KEY,
    liveQueryUrl: LIVE_QUERY_URL,
    autoSendSessionId: true,
    debug: true,
    coreStore: await CoreStoreSharedPrefsImp.getInstance(),
  );
  
  runApp(
    BlocProvider<AuthBloc>(
      builder: (context) {
        return AuthBloc(userRepository: UserRepository())
              ..dispatch(AppStarted());
      },
      child: Routes(),
    )
  );
} 