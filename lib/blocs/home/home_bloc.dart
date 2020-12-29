import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_back4app/blocs/home/home_states.dart';
import 'package:flutter_bloc_back4app/data/models/message.dart';
import 'package:flutter_bloc_back4app/repositories/message_repos.dart';

class HomeCubit extends Cubit<HomeState> {
  final MessageRepository messageRepository;

  HomeCubit({this.messageRepository})
      : assert(messageRepository != null),
        super(HomeLoading());

  Future<void> sendMessagePressed({String message}) async {
    emit(HomeLoading());
    try {
      bool result = await messageRepository.sendMessage(
        message: message,
      );

      if (result) {
        emit(SendMessageSuccess());
      } else {
        emit(Failure(error: 'Send message Failed'));
      }
    } catch (error) {
      emit(Failure(error: error.toString()));
    }
  }

  Future<void> homeStarted() async {
    emit(HomeLoading());
    try {
      List<Message> result = await messageRepository.loadAllMessages();
      emit(HomeLoaded(lstMessages: result));
    } catch (error) {
      emit(Failure(error: error.toString()));
    }
  }
}
