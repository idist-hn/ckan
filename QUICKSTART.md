# CKAN Local Development Setup

This guide will help you get CKAN running locally on your machine.

## Prerequisites

- Docker and Docker Compose installed
- Python 3.9+ (if running without Docker)
- PostgreSQL 12+ (if running without Docker)
- Solr 8+ (if running without Docker)
- Node.js 16+ (for frontend assets)

## Option 1: Docker Compose (Recommended) 🐳

The easiest way to get started is using the Docker Compose setup from the `.devcontainer` directory.

### Steps:

1. **Start the services:**
   ```bash
   cd .devcontainer
   docker compose up -d
   ```

2. **Install Python dependencies and set up CKAN:**
   ```bash
   # Access the CKAN container
   docker compose exec ckan bash
   
   # Inside the container, install dependencies
   pip install --user -r /workspace/requirements.txt
   pip install --user -r /workspace/dev-requirements.txt
   
   # Install CKAN in development mode
   cd /workspace
   python setup.py develop --user
   ```

3. **Generate configuration file:**
   ```bash
   ckan generate config ckan.ini
   ```

4. **Set up storage directory:**
   ```bash
   mkdir -p /workspace/data
   ckan config-tool ckan.ini ckan.storage_path=/workspace/data
   ```

5. **Initialize the database:**
   ```bash
   ckan db init
   ```

6. **Create a sysadmin user:**
   ```bash
   ckan user add ckan_admin email=admin@example.com password=test1234
   ckan sysadmin add ckan_admin
   ```

7. **Run CKAN:**
   ```bash
   ckan -c ckan.ini run --host 0.0.0.0
   ```

8. **Access CKAN:**
   - Open http://localhost:5001 in your browser
   - Login with username: `ckan_admin`, password: `test1234`

### Services available:
- **CKAN**: http://localhost:5001
- **PostgreSQL**: localhost:5432 (user: `ckan_default`, password: `pass`, db: `ckan_default`)
- **Solr**: http://localhost:8983 (requires setup - see below)
- **Redis**: localhost:6379 (optional for cookie sessions)
- **DataPusher**: http://localhost:8800

### Setting up Solr (Required for Search)

Solr is required for CKAN's search functionality. You have two options:

**Option A: Using Docker (Recommended)**
```bash
docker run --name ckan-solr -p 8983:8983 -d ckan/ckan-solr:2.12-solr9
```

**Note:** If you get "manifest unknown" errors, the tag may not exist. Try `master` tag first for development versions.

**Option B: Manual Installation**
1. Install Java:
   ```bash
   sudo apt-get install openjdk-11-jdk
   ```

2. Download and install Solr 9.x from https://solr.apache.org/downloads.html

3. Create a CKAN core in Solr using the schema from `ckan/config/solr/`

For detailed instructions, see: https://docs.ckan.org/en/latest/maintaining/installing/solr.html

---

## Option 2: Manual Source Install

Follow the official CKAN installation guide:
https://docs.ckan.org/en/latest/maintaining/installing/install-from-source.html

### Quick summary:

1. **Create and activate a Python virtual environment:**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies:**
   ```bash
   pip install --upgrade pip
   pip install -r requirements.txt
   pip install -r dev-requirements.txt
   ```

3. **Install CKAN:**
   ```bash
   python setup.py develop
   ```

4. **Set up PostgreSQL database:**
   - Create a PostgreSQL database named `ckan_default`
   - Create a user `ckan_default` with password `pass`

5. **Generate config file:**
   ```bash
   ckan generate config ckan.ini
   ```

6. **Configure database connection in `ckan.ini`:**
   ```ini
   sqlalchemy.url = postgresql://ckan_default:pass@localhost/ckan_default
   ```

7. **Set up Solr:**
   - Install and configure Solr 8+
   - Create a CKAN core using the configs in `ckan/config/solr/`

8. **Initialize database:**
   ```bash
   ckan db init
   ```

9. **Create admin user:**
   ```bash
   ckan user add admin email=admin@example.com password=admin123
   ckan sysadmin add admin
   ```

10. **Install frontend dependencies:**
    ```bash
    npm install
    npm run build
    ```

11. **Run CKAN:**
    ```bash
    ckan -c ckan.ini run
    ```

---

## Option 3: Test Infrastructure (For Testing Only)

If you just want to run tests, use the test infrastructure setup:

```bash
cd test-infrastructure
./setup.sh    # Sets up the test environment
./execute.sh  # Runs the tests
```

**Note:** This is not intended for running the application, only for testing.

---

## Troubleshooting

### Port already in use
If port 5001 is already in use, you can change it in `.devcontainer/docker-compose.yml` or use a different port when running:
```bash
ckan -c ckan.ini run --host 0.0.0.0 --port 5002
```

### Database connection issues
Make sure PostgreSQL is running and the credentials in `ckan.ini` are correct.

### Solr connection issues
**CKAN will start without Solr, but search won't work.** To fix:
1. Install and start Solr (see "Setting up Solr" section above)
2. Ensure the `ckan` core exists in Solr
3. Check the `solr_url` setting in `ckan.ini` (default: `http://127.0.0.1:8983/solr/ckan`)
4. Rebuild the search index: `ckan search-index rebuild`

### Redis connection issues
**Redis is optional if using cookie sessions.** CKAN will run with warnings if Redis is not available. Background jobs won't work without Redis. To install:
```bash
sudo apt-get install redis-server
sudo systemctl start redis-server
```

---

## Useful Commands

- **View logs:**
  ```bash
  docker compose logs -f ckan
  ```

- **Stop services:**
  ```bash
  docker compose down
  ```

- **Run tests:**
  ```bash
  pytest --ckan-ini=test-core.ini ckan ckanext
  ```

- **Rebuild assets:**
  ```bash
  npm run build
  npm run watch  # For development with auto-rebuild
  ```

---

## Next Steps

- Check the [CKAN Documentation](https://docs.ckan.org)
- Read the [Contributing Guide](CONTRIBUTING.md)
- Explore the [User Guide](https://docs.ckan.org/en/latest/user-guide.html)

