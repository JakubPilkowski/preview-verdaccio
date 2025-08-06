# Preview Verdaccio

A private npm registry using Verdaccio for managing preview packages.

## Overview

This project provides a Dockerized Verdaccio instance that serves as a private npm registry. It's configured to run with PM2 for process management and includes persistent storage for packages.

## Features

- **Private npm registry** using Verdaccio
- **Process management** with PM2
- **Persistent storage** for packages
- **Dockerized** for easy deployment
- **Security** with dedicated user account

## Quick Start

### Build the Docker image

```bash
docker build -t preview-verdaccio .
```

### Run the container

```bash
docker run -d \
  --name verdaccio \
  -p 4873:4873 \
  -v verdaccio-storage:/verdaccio/storage \
  preview-verdaccio
```

### Access the registry

- **Web UI**: http://localhost:4873
- **Registry URL**: http://localhost:4873

## Configuration

### Using the registry

1. **Add the registry to npm**:
   ```bash
   npm config set registry http://localhost:4873
   ```

2. **Login to the registry**:
   ```bash
   npm login --registry http://localhost:4873
   ```

3. **Publish packages**:
   ```bash
   npm publish --registry http://localhost:4873
   ```

### Reset to use npmjs.org

```bash
npm config set registry https://registry.npmjs.org/
```

## Docker Compose

You can also use Docker Compose for easier management:

```yaml
version: '3.8'
services:
  verdaccio:
    build: .
    ports:
      - "4873:4873"
    volumes:
      - verdaccio-storage:/verdaccio/storage
    restart: unless-stopped

volumes:
  verdaccio-storage:
```

## Development

### Local development

```bash
# Install dependencies
npm install -g verdaccio pm2

# Run Verdaccio
pm2-runtime verdaccio
```

## Ports

- **4873**: Verdaccio web interface and registry API

## Volumes

- **/verdaccio/storage**: Persistent storage for npm packages

## Security

The container runs as a non-root user (`verdaccio`) for enhanced security. 