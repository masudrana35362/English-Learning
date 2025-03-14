import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../service/dynamic/dynamics_service.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => DynamicsService()),
  ];
}
