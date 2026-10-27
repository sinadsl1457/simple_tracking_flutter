import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';
import 'package:simple_tracking/features/push/presentation/cubit/push_cubit.dart';

import '../../fakes/async.dart';
import '../../fakes/fake_repositories.dart';

void main() {
  late List<PushEffect> effects;

  PushCubit makeCubit(FakePushRepository repository) {
    final cubit = PushCubit(repository);
    effects = [];
    cubit.effects.listen(effects.add);
    addTearDown(cubit.close);
    return cubit;
  }

  const cafe = PushMessage(
    title: '주변 카페',
    destination: PushDestination.search('카페'),
  );
  const notice = PushMessage(title: '공지', destination: PushDestination.none());

  test('꺼진 앱을 알림으로 열었으면 시작하자마자 그곳으로 간다', () async {
    await makeCubit(FakePushRepository(initial: cafe)).start();
    await flush();

    expect(effects, [const PushEffect.open(PushDestination.search('카페'))]);
  });

  test('백그라운드에서 탭하면 이동, 갈 곳이 없으면 아무것도 안 한다', () async {
    final repository = FakePushRepository();
    await makeCubit(repository).start();

    repository.opened
      ..add(cafe)
      ..add(notice);
    await flush();

    expect(effects, [const PushEffect.open(PushDestination.search('카페'))]);
  });

  test('보고 있는 중에 오면 앱 안 배너, 배너의 "보기"로 이동', () async {
    final repository = FakePushRepository();
    final cubit = makeCubit(repository);
    await cubit.start();

    repository.foreground.add(cafe);
    await flush();
    cubit.openInApp(cafe);
    await flush();

    expect(effects, [
      const PushEffect.showInApp(cafe),
      const PushEffect.open(PushDestination.search('카페')),
    ]);
  });

  test('권한이 허용되면 토큰을 받아 상태에 둔다', () async {
    final repository = FakePushRepository();
    final cubit = makeCubit(repository);
    await cubit.start();

    repository.tokenEvents.add('token-1');
    await flush();

    expect(cubit.state.permission, PushPermission.granted);
    expect(cubit.state.token, 'token-1');
  });

  test('권한이 거부되면 토큰 등록을 시작하지 않는다', () async {
    final repository = FakePushRepository(permission: PushPermission.denied);
    final cubit = makeCubit(repository);
    await cubit.start();

    expect(cubit.state.permission, PushPermission.denied);
    expect(repository.tokensListened, isFalse);
  });
}
