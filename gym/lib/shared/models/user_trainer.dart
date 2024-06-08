import 'package:Gym/shared/models/user_abstract.dart';
import 'package:Gym/shared/models/user_client.dart';

class UserTrainer extends AbstractUser {
  // List dos clientes (API)
  late List<int> clientsIds;

  // Lista dos clientes
  late List<UserClient> listClients;
}
