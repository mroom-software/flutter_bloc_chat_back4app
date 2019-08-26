import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/home/home_bloc.dart';
import 'package:flutter_bloc_back4app/blocs/home/home_events.dart';
import 'package:flutter_bloc_back4app/blocs/home/home_states.dart';
import 'package:flutter_bloc_back4app/data/models/message.dart';
import 'package:flutter_bloc_back4app/data/validators/name_validator.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _message;
  HomeBloc _homeBloc;
  List<Message> lst;

  @override
  void initState() {
    lst = List<Message>();
    _handleLiveQuery();
    super.initState();
  }

  Widget _buildListOfMessages(HomeState state) {
    if (state is HomeLoaded) {
      lst = state.lstMessages;
    }
    return Stack(
      children: <Widget>[
        ListView.separated(
          itemCount: lst.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                color: (index % 2 == 0) ? Colors.grey.shade100 : Colors.grey.shade200,
                height: 55,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: (index % 2 == 0) ? Alignment.bottomLeft : Alignment.bottomRight ,
                      child: Text(
                        lst[index].user.objectId,
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                    ),
                    Align(
                      alignment: (index % 2 == 0) ? Alignment.bottomLeft : Alignment.bottomRight ,
                      child: Text(
                        lst[index].message,
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 1,
            color: Colors.white12,
          ),
        ),
        _buildMessageBox(),
      ],
    );
  }

  Widget _buildMessageBox() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Form(
            key: _formKey,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: TextFormField(
                    key: Key('Message'),
                    validator: NameFieldValidator.validate,
                    onSaved: (value) => _message = value,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Message',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: _sendMessage,
                    child: Icon(
                      Icons.send
                    ),
                  ),
                ),
              ],
            ),
            
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     _homeBloc = BlocProvider.of<HomeBloc>(context);

    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'MESSAGES',
              style: Theme.of(context).textTheme.headline,
            ),
            elevation: 0.5,
          ),
          body: _buildListOfMessages(state)
        );
      },
    );
  }

  void _handleLiveQuery() async {
    final LiveQuery liveQuery = LiveQuery(debug: true);
    QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Messages'));

    print('LiveQueryURL ${ParseCoreData().liveQueryURL}');

    liveQuery.on(LiveQueryEvent.create, (value) {
      print('*** CREATE ***: ${DateTime.now().toString()}\n $value ');
      Message m = Message.clone().fromJson(jsonDecode(value.toString()));
      lst.add(m);
      setState(() {
      });
    });

    liveQuery.on(LiveQueryEvent.update, (value) {
      print('*** UPDATE ***: ${DateTime.now().toString()}\n $value ');
    });

    liveQuery.on(LiveQueryEvent.delete, (value) {
      print('*** DELETE ***: ${DateTime.now().toString()}\n $value ');
    });

    await liveQuery.subscribe(query);
    print('Subscribe done');
  }

  bool _validateAndSave() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _sendMessage() {
    if(_validateAndSave()) {
      _homeBloc.dispatch(SendMessagePressed(message:_message));
    }
  }
}