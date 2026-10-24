// [core/di] get_it 컨테이너와 injectable 진입점. main.dart가 configureDependencies()를 부른다.
// 실제 등록 코드는 생성 파일 injection.config.dart (build_runner).

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/di/injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => getIt.init();
