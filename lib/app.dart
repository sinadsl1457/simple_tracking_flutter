// [앱 셸] MaterialApp과 앱 전체에 하나뿐인 것들(푸시 effect, 스낵바 messenger)을 둔다.
// 라우트 표는 app_router.dart. 상태는 provider가 갖는다.
// 푸시는 PushEffectListener가 앱 시작과 함께 깨운다.

import 'package:flutter/material.dart';
import 'package:simple_tracking/app_router.dart';
import 'package:simple_tracking/features/push/presentation/push_effect_listener.dart';

/// PushEffectListener가 MaterialApp 위에 있어서
/// ScaffoldMessenger.of(context)로 못 찾는다. 키로 꺼낸다.
final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return PushEffectListener(
      messengerKey: _messengerKey,
      onOpen: (destination) =>
          appRouter.go(pushDestinationLocation(destination)),
      child: MaterialApp.router(
        title: '심플맵',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: _messengerKey,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF356DF3),
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          ),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
