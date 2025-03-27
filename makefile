run-swagger:
	docker rm -f swagger-autobase ;\
	docker run --name swagger-autobase \
	   -d \
	   --rm -p $(SWAGGER_PORT):8080 \
	   -e DEEP_LINKING=true \
	   -e DEFAULT_MODELS_EXPAND_DEPTH=2 \
	   -e DEFAULT_MODEL_EXPAND_DEPTH=2 \
	   -e SWAGGER_JSON=/autobase-merged-external-api.json \
	   -v $(FS_PREFIX)$(shell pwd)/:/api swaggerapi/swagger-ui;
	until curl -s -f -o /dev/null "http://127.0.0.1:$(SWAGGER_PORT)"; do sleep 1; done;
	$(shell xdg-open http://127.0.0.1:$(SWAGGER_PORT) &);