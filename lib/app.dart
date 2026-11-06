// [앱 셸] MaterialApp과 앱 전체에 하나뿐인 것들(PushCubit, 스낵바 messenger)을 둔다.
// 라우트 표는 app_router.dart. 화면별 Cubit은 거기서, 앱 전체 Cubit은 여기(MaterialApp 위)서 만든다.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_tracking/app_router.dart';
import 'package:simple_tracking/core/di/injection.dart';
import 'package:simple_tracking/features/push/presentation/cubit/push_cubit.dart';
import 'package:simple_tracking/features/push/presentation/push_effect_listener.dart';

/// PushEffectListener가 MaterialApp 위에 있어서
/// ScaffoldMessenger.of(context)로 못 찾는다. 키로 꺼낸다.
final _messengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 앱이 살아 있는 동안 하나. 화면(라우트)이 바뀌어도 사라지지 않는다.
      create: (_) {
        final cubit = getIt<PushCubit>();
        unawaited(cubit.start());
        return cubit;
      },
      child: PushEffectListener(
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
      ),
    );
  }
}
