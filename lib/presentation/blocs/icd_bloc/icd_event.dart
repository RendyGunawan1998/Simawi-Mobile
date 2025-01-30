// icd_event.dart
abstract class IcdEvent {}

class FetchIcdDetailsEvent extends IcdEvent {
  final String diagnosa;

  FetchIcdDetailsEvent(this.diagnosa);
}
