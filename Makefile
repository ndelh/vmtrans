up:
	@echo "docker"
	@docker compose -f ./test/docker-compose.yml up -d 
down:
	@echo "docker down"
	@docker compose -f ./test/docker-compose.yml down

clean:	down
	docker system prune -af
init:
	if [ ! -f ./initiation/.initflag ]; then \
		make -C initiation; \
	else \
		echo "init Already done"; \
	fi
re: down clean up
