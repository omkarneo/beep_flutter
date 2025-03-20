abstract class UseCase<Type, P> {
  Future<Type> call({required P params});
}