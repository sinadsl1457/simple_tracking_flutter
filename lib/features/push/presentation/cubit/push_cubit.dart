// [push/presentation] 앱 전체에 하나뿐인 푸시 Cubit. 수신 경로 3가지(포그라운드·백그라운드 탭·종료 후 탭)를
// effect 두 종류(open, showInApp)로 모은다. 만드는 곳: app.dart(MaterialApp 위). 테스트: test/features/push/push_cubit_test.dart
// 화면 이동은 하지 않는다(BuildContext·router를 모름). 어디로 갈지는 effect로 내보내고 app.dart가 이동시킨다.

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_tracking/core/presentation/effect_cubit.dart';
import 'package:simple_tracking/features/push/domain/push_message.dart';
import 'package:simple_tracking/features/push/domain/push_permission.dart';
import 'package:simple_tracking/features/push/domain/push_repository.dart';
import 'package:simple_tracking/features/push/presentation/cubit/push_state.dart';

export 'push_state.dart';

@injectable
class PushCubit extends Cubit<PushState>
    with EffectEmitter<PushState, PushEffect> {
  PushCubit(this._push) : super(const PushState());

  final PushRepository _push;
  final _subscriptions = <StreamSubscription<Object?>>[];

  /// 호출: app.dart에서 Cubit을 만들 때 한 번.
  ///
  /// 순서가 중요하다. 구독을 먼저 걸어야 권한 팝업이 떠 있는 동안 온 메시지도 놓치지 않는다.
  /// 종료 상태에서 탭해 실행된 경우([PushRepository.initialMessage])는 스트림으로 오지 않아서 따로 꺼낸다.
  Future<void> start() async {
    _subscriptions.addAll([
      _push.foregroundMessages().listen(
        (m) => emitEffect(PushEffect.showInApp(m)),
      ),
      _push.openedMessages().listen(_open),
    ]);

    if (await _push.initialMessage() case final message?) _open(message);

    final permission = await _push.requestPermission();
    if (isClosed) return;
    emit(state.copyWith(permission: permission));
    // 권한이 없으면 토큰을 받아도 알림이 안 뜬다. 서버에 쓸모없는 주소를 주지 않도록 허용된 뒤에만 등록한다.
    if (permission == PushPermission.granted) {
      _subscriptions.add(_push.tokens().listen(_onToken));
    }
  }

  /// 호출: 앱 안 배너의 "보기" 버튼.
  void openInApp(PushMessage message) => _open(message);

  void _open(PushMessage message) {
    if (message.destination case NoDestination()) return;
    emitEffect(PushEffect.open(message.destination));
  }

  /// 서버가 생기면 여기서 "토큰 등록" UseCase를 부른다(서버 API repo + 이 repo 조합 → UseCase 자리).
  void _onToken(String token) {
    if (isClosed) return;
    emit(state.copyWith(token: token));
  }

  @override
  Future<void> close() async {
    await Future.wait(_subscriptions.map((s) => s.cancel()));
    await super.close();
  }
}
