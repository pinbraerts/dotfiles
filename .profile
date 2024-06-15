test -f "venv/bin/activate" && source "venv/bin/activate" || test -d "venv" && micromamba activate -p "$(pwd)/venv"
if test -f ".env"; then
	set -a
	source "$(pwd)/.env"
	set +a
fi
