import 'package:food_gate/src/scoped-model/food_model.dart';
import 'package:food_gate/src/scoped-model/user_scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped-model/food_model.dart';

class MainModel extends Model with FoodModel, UserModel {}
