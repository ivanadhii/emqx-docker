.PHONY: help up down restart logs status clean pull build test-pub test-sub shell

help:
	@echo "EMQX Docker Management"
	@echo ""
	@echo "Available commands:"
	@echo "  make up          - Start EMQX container"
	@echo "  make down        - Stop EMQX container"
	@echo "  make restart     - Restart EMQX container"
	@echo "  make logs        - Show EMQX logs (follow mode)"
	@echo "  make status      - Show container status"
	@echo "  make clean       - Stop and remove all data (WARNING: deletes volumes)"
	@echo "  make pull        - Pull latest EMQX image"
	@echo "  make build       - Build/rebuild containers"
	@echo "  make test-pub    - Test MQTT publish"
	@echo "  make test-sub    - Test MQTT subscribe"
	@echo "  make shell       - Enter EMQX container shell"

up:
	@echo "Starting EMQX..."
	docker compose up -d
	@echo ""
	@echo "EMQX is starting..."
	@echo "Dashboard: http://localhost:18083"
	@echo "Username: meltedbrain"
	@echo "Password: meltedbrain911"
	@echo "MQTT Port: 1883 (no auth required)"

down:
	@echo "Stopping EMQX..."
	docker compose down

restart:
	@echo "Restarting EMQX..."
	docker compose restart
	@echo "EMQX restarted!"

logs:
	@echo "Following EMQX logs (Ctrl+C to exit)..."
	docker compose logs -f emqx

status:
	@echo "Container Status:"
	@docker compose ps
	@echo ""
	@echo "EMQX Health:"
	@docker exec emqx emqx ping 2>/dev/null || echo "EMQX not responding"

clean:
	@echo "WARNING: This will delete all EMQX data!"
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		echo "Cleaning up..."; \
		docker compose down -v; \
		rm -rf emqx-data emqx-log; \
		echo "Cleanup complete!"; \
	else \
		echo "Cancelled."; \
	fi

pull:
	@echo "Pulling latest EMQX image..."
	docker compose pull

build:
	@echo "Building containers..."
	docker compose up -d --build

test-pub:
	@echo "Publishing test message to topic 'test/topic'..."
	@docker exec emqx emqx_ctl publish test/topic "Hello from EMQX at $$(date)" || \
	echo "Pastikan EMQX sudah running (make up)"

test-sub:
	@echo "Subscribing to topic 'test/topic' (Ctrl+C to exit)..."
	@echo "Tip: Buka terminal lain dan run 'make test-pub' untuk test"
	@mosquitto_sub -h localhost -p 1883 -t "test/topic" || \
	echo "Install mosquitto-clients: sudo apt-get install mosquitto-clients"

shell:
	@echo "Entering EMQX container shell..."
	docker exec -it emqx sh
