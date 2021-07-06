.PHONY: android java8

android:
	docker build -t dant3/android:11 ./android-11

java8:
	docker build -t dant3/java8 ./java8
