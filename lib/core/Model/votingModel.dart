class VoteModel {
  final String title;
  final String description;
  final List<VotingQuestion> votingQuestions;
  final String contacts;
  final DateTime now;
  final DateTime startDate;
  final DateTime endDate;

  VoteModel(
      {required this.title,
      required this.votingQuestions,
      required this.description,
      required this.contacts,
      required this.now,
      required this.startDate,
      required this.endDate});
}

class VotingQuestion {
  final int id;
  final String questionText;
  final List<String> options;
  int? selectedOption;

  VotingQuestion({
    required this.id,
    required this.questionText,
    required this.options,
    this.selectedOption,
  });
}

class Voting {
  final List<VotingQuestion> questions;

  Voting({required this.questions});

  void castVote(int questionId, int optionIndex) {
    final question = questions.firstWhere((q) => q.id == questionId);
    if (optionIndex >= 0 && optionIndex < question.options.length) {
      question.selectedOption = optionIndex;
    } else {
      throw ArgumentError('Invalid option index');
    }
  }

  Map<String, String> getResults() {
    final Map<String, String> results = {};
    for (var question in questions) {
      results[question.questionText] = question.selectedOption != null
          ? question.options[question.selectedOption!]
          : 'No vote';
    }
    return results;
  }
}
