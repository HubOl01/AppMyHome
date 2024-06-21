import 'dart:async';

import 'package:MyAppHome/core/Data/VotingData.dart';
import 'package:MyAppHome/core/Model/votingModel.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'crud_vote_state.dart';

class CrudVoteCubit extends Cubit<List<VoteModel>> {
 final BehaviorSubject<List<VoteModel>> _voteSubject = BehaviorSubject.seeded(voting);

  CrudVoteCubit() : super(voting);

  Stream<List<VoteModel>> get voteStream => _voteSubject.stream;
  Future readVote() async {
    print("readCheck");
    return state;
  }

  void updateCheck(int index, VoteModel vote) {
    state.insert(index, vote);
    print("updateCheck");
    emit(state);
    _voteSubject.add(state);
  }

}
