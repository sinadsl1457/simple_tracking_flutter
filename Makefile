# 실행 단축 명령. flutter run에 매번 붙이던 env 파일·기기 옵션을 대신 넣는다.
# 키는 env/dev.json(git 제외)에서 읽는다. VS Code에서는 .vscode/launch.json(F5)을 쓴다.
#   make run              iPhone 18 Pro 시뮬레이터
#   make run-android      Android 에뮬레이터(먼저 켜 둘 것)
#   make run DEVICE=<id>  다른 기기

DEVICE ?= iPhone 18 Pro
ENV ?= env/dev.json

.PHONY: run run-android

run:
	flutter run -d "$(DEVICE)" --dart-define-from-file=$(ENV)

run-android:
	flutter run -d emulator-5554 --dart-define-from-file=$(ENV)
