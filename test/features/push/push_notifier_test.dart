// [push/presentation] PushNotifier: 만들어지자마자(build) 수신을 시작하고, 세 경로를 effect 두 종류로 모은다.
// 저장소는 pushRepositoryProvider를 가짜로 덮어써서 넣는다.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_tracking/features/push/data/push_providers.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';
import 'package:simple_tracking/features/push/presentation/push_notifier.dart';

import '../../fakes/async.dart';
import '../../fakes/fake_repositories.dart';

void main() {
  late List<PushEffect> effects;
  late ProviderContainer container;

  /// 앱 맨 위 위젯이 watch하는 것처럼 Notifier를 깨운다. 이 순간 build()에서 시작한다.
  PushNotifier start(FakePushRepository repository) {
    container = ProviderContainer.test(
      overrides: [pushRepositoryProvider.overrideWithValue(repository)],
    );
    final notifier = container.read(pushProvider.notifier);
    effects = [];
    notifier.effects.listen(effects.add);
    return notifier;
  }

  PushState state() => container.read(pushProvider);

  const cafe = PushMessage(
    title: '주변 카페',
    destination: PushDestination.search('카페'),
  );
  const notice = PushMessage(title: '공지', destination: PushDestination.none());

  test('꺼진 앱을 알림으로 열었으면 시작하자마자 그곳으로 간다', () async {
    start(FakePushRepository(initial: cafe));
    await flush();

    expect(effects, [const PushEffect.open(PushDestination.search('카페'))]);
  });

  test('백그라운드에서 탭하면 이동, 갈 곳이 없으면 아무것도 안 한다', () async {
    final repository = FakePushRepository();
    start(repository);
    await flush();

    repository.opened
      ..add(cafe)
      ..add(notice);
    await flush();

    expect(effects, [const PushEffect.open(PushDestination.search('카페'))]);
  });

  test('보고 있는 중에 오면 앱 안 배너, 배너의 "보기"로 이동', () async {
    final repository = FakePushRepository();
    final notifier = start(repository);
    await flush();

    repository.foreground.add(cafe);
    await flush();
    notifier.openInApp(cafe);
    await flush();

    expect(effects, [
      const PushEffect.showInApp(cafe),
      const PushEffect.open(PushDestination.search('카페')),
    ]);
  });

  test('권한이 허용되면 토큰을 받아 상태에 둔다', () async {
    final repository = FakePushRepository();
    start(repository);
    await flush();

    repository.tokenEvents.add('token-1');
    await flush();

    expect(state().permission, PushPermission.granted);
    expect(state().token, 'token-1');
  });

  test('권한이 거부되면 토큰 등록을 시작하지 않는다', () async {
    final repository = FakePushRepository(permission: PushPermission.denied);
    start(repository);
    await flush();

    expect(state().permission, PushPermission.denied);
    expect(repository.tokensListened, isFalse);
  });

  test('창고가 닫히면(앱 종료) 구독을 끊는다', () async {
    final repository = FakePushRepository();
    start(repository);
    await flush();

    container.dispose();

    expect(repository.foreground.hasListener, isFalse);
    expect(repository.opened.hasListener, isFalse);
  });
}
