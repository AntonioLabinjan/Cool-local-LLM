#!/usr/bin/env sh
# One-time (or after changing models in .env): download the configured models into the Ollama volume.
set -e
cd "$(dirname "$0")/.."
set -a; . ./.env; set +a
docker compose up -d ollama
for m in "${LLM_MODEL:-qwen3:4b}" "${EMBEDDING_MODEL:-nomic-embed-text}"; do
  echo "Pulling $m ..."
  docker compose exec ollama ollama pull "$m"
done
echo "Done. Start the app with: docker compose up -d --build"
