import 'package:Gym/shared/models/user_abstract.dart';
import 'package:Gym/shared/models/user_trainer.dart';

class UserAdm extends AbstractUser {
  late String gynName;
  late String logoImage;
  late List<int> listTrainerIds;
  late List<UserTrainer> listUserTrainers;
}
