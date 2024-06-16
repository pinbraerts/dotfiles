source >/dev/null 2>&1 "venv/bin/activate" || test -d venv && micromamba activate -p "$(pwd)/venv" || true

if test -f ".env"; then
	set -a
	source "$(pwd)/.env"
	set +a
fi
