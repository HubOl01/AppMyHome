// import 'package:command_flutter/ProfileCom/model/profile.dart';

// import '../model/task.dart';

import '../model/profile.dart';
import '../model/task.dart';

int indexProfile = 0;

// List<ProfileModel> profiles = [
//   ProfileModel(surname: "Иванов", name: "Максим")
// ];

List<ProfileModel> profiles = [
  ProfileModel(surname: "Иванов", name: "Иван", job: "Слесарь", tasks: [
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
    Task(
        id: "543210",
        data: DateTime(2023, 12, 3),
        type: "Заявка в ТСЖ",
        message:
            "Прошу предоставить информацию о планах по благоустройству придомовой территории. Мы хотели бы предложить свои идеи для улучшения.",
        address: "ул. Березовая, д. 456, Кв. 3",
        phone: "+1112233445",
        userId: "user012",
        status: "закрыто"),
    Task(
        id: "345678",
        data: DateTime(2023, 12, 3),
        type: "Заявка в ТСЖ",
        message:
            "Просим произвести замену стояков водоснабжения в нашем доме. Обнаружены утечки в нескольких квартирах.",
        address: "ул. Клёновая, д. 101, Кв. 8",
        phone: "+9998887770",
        userId: "user345",
        status: "в работе"),
    Task(
        id: "234567",
        data: DateTime(2023, 12, 4),
        type: "Заявка в ТСЖ",
        message:
            "Предлагаем установить контейнеры для сортировки мусора. Это поможет сделать наше ТСЖ более экологичным.",
        address: "ул. Сосновая, д. 222, Кв. 10",
        phone: "+5556667778",
        userId: "user123",
        status: "не завершена"),
    Task(
        id: "876543",
        data: DateTime(2023, 12, 6),
        type: "Заявка в ТСЖ",
        message:
            "Просим предоставить информацию о процедуре голосования по вопросам повышения безопасности в нашем жилом комплексе.",
        address: "ул. Дубовая, д. 333, Кв. 15",
        phone: "+3332221114",
        userId: "user456",
        status: "не завершена"),
  ]),
  ProfileModel(surname: "Иванов", name: "Иван", job: "Слесарь", tasks: [
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
    Task(
        id: "987654",
        data: DateTime(2023, 12, 2),
        type: "Заявка в ТСЖ",
        message:
            "Прошу рассмотреть мою заявку на проведение ремонта в подъезде. Необходимо заменить освещение и покрасить стены.",
        address: "ул. Липовая, д. 789, Кв. 5",
        phone: "+9876543210",
        userId: "user789",
        status: "открыто"),
  ]),
];
