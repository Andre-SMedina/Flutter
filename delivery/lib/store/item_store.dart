import 'package:mobx/mobx.dart';

//TODO: mobx runner => executar no terminal: dart run build_runner watch. Para criar os arquivos do mobx e observar as mudanças
part 'item_store.g.dart';

class ItemStore = _ItemStore with _$ItemStore;

abstract class _ItemStore with Store {
  @observable
  int valorContador = 0;

  @action
  void adicionaItem() {
    valorContador++;
  }

  @action
  void removerItem() {
    valorContador--;
  }
}
