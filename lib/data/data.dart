import 'package:hust_chat/data/current_user.dart';
import 'package:hust_chat/models/models.dart';

String link = 'https://scontent.fhan2-3.fna.fbcdn.net/v/t39.30808-6/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&cb=c578a115-7e291d1f&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=pM4MixqT8AcAX-taJAh&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan2-3.fna&oh=d6547146bd71ff7d889c319978570933&oe=61BB95AF';

class FactoryData {
  static List<User> users = [
    User(
      id: 1,
      name: "Duy Minh",
      email: "duyminh@gmail.com",
      imageUrl:
        "https://scontent.fhan2-3.fna.fbcdn.net/v/t39.30808-6/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&cb=c578a115-7e291d1f&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=pM4MixqT8AcAX-taJAh&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan2-3.fna&oh=d6547146bd71ff7d889c319978570933&oe=61BB95AF",
    ),
    User(
      id: 2,
      name: "Thuý Hằng",
      email: "thuyhang@gmail.com",
      imageUrl:
      link,    ),
    User(
      id: 3,
      name: "Trần Hiếu",
      email: "tranhieu@gmail.com",
      imageUrl:
      link,      ),
    User(
      id: 4,
      name: "Đại",
      email: "nguyenvandai@gmail.com",
      imageUrl:
      link,    ),
    User(
      id: 5,
      name: "Huy Hoàng",
      email: "huyhoang@gmail.com",
      imageUrl:
      link,      ),
    User(
      id: 6,
      name: "Pham Ho Nguyen",
      email: "phamhonguyen@gmail.com",
      imageUrl:
      "http://wikicraze.com/wp-content/uploads/2018/08/alone-boy-5.jpg",
    ),
    User(
      id: 7,
      name: "Mark Zuckerberg",
      email: "markzuckerberg@facebook.com",
      imageUrl:
      "https://scontent.fsgn3-1.fna.fbcdn.net/v/t1.6435-9/79515135_10111007623880301_5111576226921709568_n.jpg?_nc_cat=1&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=2lhgZXO_vBcAX8GvF8n&_nc_oc=AQntpGFTmhh63SzfuoSUXTJd6JZdUCQBfU8RCNeRojSREKtSu9i0EjKOiSGnALv5fjY&_nc_ht=scontent.fsgn3-1.fna&oh=105237176b05ec44dadaa49254b9acd4&oe=61AE9E56",
    ),
  ];
}


final List<User> onlineUsers = [
  User(
    id: 2,
    name: 'Huy Hoàng',
    email: "markzuckerberg@facebook.com",
    imageUrl: link,
  ),
  User(
    id: 3,
    name: 'Jane Doe',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 4,
    name: 'Matthew Hinkle',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    id: 5,
    name: 'Đại',
    email: "markzuckerberg@facebook.com",
    imageUrl:
link,  ),
  User(
    id: 6,
    name: 'Trần Hiếu',
    email: "markzuckerberg@facebook.com",
    imageUrl:
    link,  ),
  User(
    id: 7,
    name: 'Thuý Hằng',
    email: "markzuckerberg@facebook.com",
    imageUrl:
      link,
  ),
  User(
    id: 8,
    name: 'Paul Pinnock',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'
  ),
  User(
      id: 10,
      name: 'Elizabeth Wong',
      email: "markzuckerberg@facebook.com",
      imageUrl:
          'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    id: 11,
    name: 'James Lathrop',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    id: 12,
    name: 'Jessie Samson',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 13,
    name: 'Huy Hoàng',
    email: "markzuckerberg@facebook.com",
    imageUrl:
    link,  ),
  User(
    id: 14,
    name: 'Jane Doe',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 15,
    name: 'Matthew Hinkle',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
  ),
  User(
    id: 16,
    name: 'Amy Smith',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
  ),
  User(
    id: 17,
    name: 'Ed Morris',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
  ),
  User(
    id: 18,
    name: 'Carolyn Duncan',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
  User(
    id: 19,
    name: 'Paul Pinnock',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  ),
  User(
      id: 20,
      name: 'Elizabeth Wong',
      email: "markzuckerberg@facebook.com",
      imageUrl:
          'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80'),
  User(
    id: 21,
    name: 'James Lathrop',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
  ),
  User(
    id: 22,
    name: 'Jessie Samson',
    email: "markzuckerberg@facebook.com",
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  ),
];

