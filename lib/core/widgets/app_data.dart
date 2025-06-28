import 'package:new_flutter/features/data/hotels/hotels_data.dart';
import 'package:new_flutter/features/Data/packages/Packages.dart';
import 'package:new_flutter/features/data/places/places_data.dart';
import 'package:new_flutter/features/data/transport/transport.dart';

import '../../features/models/models.dart';

const categoriesData = [
  Models(
    id: '1',
    title: 'Packages',
    imageurl:
        'https://th.bing.com/th/id/R.cf1a2a619257d15ce25bdd73ad7a335d?rik=HVSsCzotGpZWMQ&pid=ImgRaw&r=0',
    goFor: Packages(),
  ),
  Models(
    id: '2',
    title: 'Hotels',
    imageurl:
        'https://th.bing.com/th/id/OIP.6vJXIvsQfPkFgyySyyfFjAHaEo?rs=1&pid=ImgDetMain',
    goFor: HotelsData(),
  ),
  Models(
    id: '3',
    title: 'Places',
    imageurl:
        'https://th.bing.com/th/id/R.8b59043f9e70bf29fb6182d0313ba69c?rik=f%2fILTBANFiB%2bSg&riu=http%3a%2f%2falamphoto.com%2fwp-content%2fuploads%2f2017%2f08%2fEgypt+Pyramids+Photos+(35)-388x276.jpg&ehk=BQmHrF5%2fNgRWEImOLaGdCU0pfF%2bzfmzLKWbv7PzTNIc%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1',
    goFor: PlacesData(),
  ),
  Models(
    id: '4',
    title: 'Transport',
    imageurl:
        'https://www.bouygues-construction.com/blog/wp-content/uploads/transport-en-commun_shutterstock_565772611.jpg',
    goFor: Transport(),
  ),
];
