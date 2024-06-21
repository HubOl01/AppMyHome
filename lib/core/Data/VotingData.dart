import '../Model/votingModel.dart';

List<VoteModel> voting = [
  VoteModel(
      title: "Голосование по вопросам благоустройства и инфраструктуры",
      description:
          "Наша Управляющая компания проводит голосование по ряду важных вопросов, касающихся благоустройства и улучшения инфраструктуры нашего дома и двора. Ваше мнение очень важно для нас, так как оно позволит принять решения, которые сделают наш дом более комфортным и удобным для проживания.",
      votingQuestions: [
        VotingQuestion(
          id: 1,
          questionText: 'Озеленение двора',
          options: ['Да, поддерживаю', 'Нет, не поддерживаю'],
        ),
        VotingQuestion(
          id: 2,
          questionText: 'Установка детской площадки',
          options: ['Да, необходимо', 'Нет, не нужно'],
        ),
        VotingQuestion(
          id: 3,
          questionText: 'Переход на энергосберегающие технологии',
          options: ['Да, поддерживаю', 'Нет, не поддерживаю'],
        ),
        VotingQuestion(
          id: 4,
          questionText: 'Установка видеонаблюдения',
          options: ['Да, необходимо', 'Нет, не нужно'],
        ),
        VotingQuestion(
          id: 5,
          questionText: 'Создание велосипедной парковки',
          options: ['Да, поддерживаю', 'Нет, не поддерживаю'],
        ),
      ],
      contacts:
          "Если у вас возникнут вопросы или потребуется дополнительная информация, пожалуйста, свяжитесь с нами по телефону +7 (123) 456-7890 или отправьте письмо на электронную почту uk@example.com.",
      now: DateTime(2024, DateTime.now().month, DateTime.now().day-1),
      startDate: DateTime(2024, DateTime.now().month, DateTime.now().day),
      endDate: DateTime(2024, DateTime.now().month, DateTime.now().day+7))
];
