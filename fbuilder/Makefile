.PHONY: image
REMOTE_IMAGE="dant3/fbuilder:latest"

image:
	docker build -t $(REMOTE_IMAGE) .
	docker push $(REMOTE_IMAGE)
