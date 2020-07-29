.PHONY: android java8

android:
	docker build -t dant3/android ./android

java8:
	docker build -t dant3/java8 ./java8
