abstract class CRUDAll {
  dynamic create();
  void read(var id);
  void update();
  void delete();
  dynamic readAll();
}

class ObjectParamUnimplementedError implements UnimplementedError {
  String error() => 'Le paramette n\'a pas été implementé corectement';

  @override
  String? get message => throw UnimplementedError();

  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}