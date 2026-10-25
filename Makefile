# 실행 단축 명령. flutter run에 매번 붙이던 env 파일·기기 옵션을 대신 넣는다.
# 키는 env/dev.json(git 제외)에서 읽는다. VS Code에서는 .vscode/launch.json(F5)을 쓴다.
#   make run              iPhone 18 Pro 시뮬레이터
#   make run-android      Android 에뮬레이터(먼저 켜 둘 것)
#   make run DEVICE=<id>  다른 기기
#   make run-gps / make run-android-gps
#                         env의 FIXED_LOCATION을 비워 실제 GPS로 실행(시뮬레이터는 가상 위치를 따로 넣어야 함)

DEVICE ?= iPhone 18 Pro
ENV ?= env/dev.json

# --dart-define은 파일 값보다 나중에 적용되어 같은 키를 덮어쓴다.
GPS_DEFINE = --dart-define=FIXED_LOCATION=

.PHONY: run run-android run-gps run-android-gps

run:
	flutter run -d "$(DEVICE)" --dart-define-from-file=$(ENV)

run-android:
	flutter run -d emulator-5554 --dart-define-from-file=$(ENV)

run-gps:
	flutter run -d "$(DEVICE)" --dart-define-from-file=$(ENV) $(GPS_DEFINE)

run-android-gps:
	flutter run -d emulator-5554 --dart-define-from-file=$(ENV) $(GPS_DEFINE)
