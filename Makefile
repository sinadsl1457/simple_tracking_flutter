# 실행 단축 명령. flutter run에 매번 붙이던 env 파일·기기 옵션을 대신 넣는다.
# 키는 env/dev.json(git 제외)에서 읽는다. VS Code에서는 .vscode/launch.json(F5)을 쓴다.
#   make run           iOS 시뮬레이터
#   make run-android   Android 에뮬레이터(먼저 켜 둘 것)
#   make run-d         내 아이폰 실기기(USB 또는 무선 연결)
# 내 위치는 항상 실제 GPS다. 시뮬레이터·에뮬레이터는 그 기기의 가상 위치를 쓴다(docs/ARCHITECTURE.md "내 위치").

SIMULATOR ?= iPhone 18 Pro
EMULATOR ?= emulator-5554
# 내 아이폰 UDID(flutter devices로 확인). 이름("iPhone")은 시뮬레이터와 겹칠 수 있어 ID로 지정한다.
MY_DEVICE ?= 00008150-0012182A2233401C
ENV ?= env/dev.json

.PHONY: run run-android run-d

run:
	flutter run -d "$(SIMULATOR)" --dart-define-from-file=$(ENV)

run-android:
	flutter run -d $(EMULATOR) --dart-define-from-file=$(ENV)

run-d:
	flutter run -d $(MY_DEVICE) --dart-define-from-file=$(ENV)
