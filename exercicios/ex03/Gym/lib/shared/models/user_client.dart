import 'package:Gym/shared/models/training_block.dart';
import 'package:Gym/shared/models/user_abstract.dart';

class UserClient extends AbstractUser {
  late String uniqueCodeClient;
  late List<TrainingBlock> listTrainingBlock;
}
