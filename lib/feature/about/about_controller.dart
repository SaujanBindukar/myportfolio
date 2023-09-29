import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myportfolio/feature/about/about_repository.dart';

final aboutController = FutureProvider<String>((ref) async {
  final data = await AboutController(ref).getAbout();
  return data;
});

class AboutController extends StateNotifier<String> {
  AboutController(this.ref) : super('');

  final Ref ref;

  Future<String> getAbout() async {
    final response = await ref.read(aboutRepository).getAbout();
    return response;
  }
}
