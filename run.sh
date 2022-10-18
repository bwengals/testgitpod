TOKEN=$(openssl rand -hex 24)
jupyter lab --NotebookApp.token=${TOKEN}
