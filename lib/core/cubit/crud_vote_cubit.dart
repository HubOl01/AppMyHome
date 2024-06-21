import 'package:MyAppHome/core/Data/VotingData.dart';
import 'package:MyAppHome/core/Model/votingModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'crud_vote_state.dart';

class CrudVoteCubit extends Cubit<List<VoteModel>> {
  CrudVoteCubit() : super(voting);

  Future readVote() async {
    print("readCheck");
    emit(state);
  }

  void updateCheck(int index, VoteModel vote) {
    state.insert(index, vote);
    print("updateCheck");
    return emit(state);
  }
}
