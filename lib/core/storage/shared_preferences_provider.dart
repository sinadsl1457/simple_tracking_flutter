// [core/storage] SharedPreferences 자리. 여는 데 await가 필요해서 레시피에서는 만들지 않는다.
// main.dart가 runApp 전에 열어 ProviderScope(overrides:)로 넣는다. 테스트도 같은 방법으로 넣는다.

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_provider.g.dart';

/// 빈 자리. main에서 overrideWithValue로 채운다(get_it의 @preResolve 자리).
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider는 main.dart에서 overrideWithValue로 넣어야 한다',
  );
}
