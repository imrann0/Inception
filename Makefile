# Build Docker image
build:
	docker-compose build

# Start the container
up:
	docker-compose up -d

# Stop the container
down:
	docker-compose down

# Rebuild and restart the container
restart:
	docker-compose down
	docker-compose build
	docker-compose up -d

# Clean up unused Docker resources
clean:
	docker system prune -f
