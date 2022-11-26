compose:
	docker compose up -d --build --remove-orphans

down:
	docker compose down

bash:
	docker compose exec app /bin/bash

root:
	docker compose exec -u root app /bin/bash
