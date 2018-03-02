.PHONY: android java8

android:
	docker build -t android ./android

java8:
	docker build -t java8 ./java8
