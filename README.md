# GraphHopper Docker Setup

This repository provides a Docker-based setup for running [GraphHopper](https://github.com/graphhopper/graphhopper), a routing engine for OpenStreetMap data. The setup allows users to either build their own Docker image or use a pre-built image available on Docker Hub.

## Features
- Simple Docker setup to run GraphHopper.
- Configurable OSM data and routing profiles.
- Pre-built image available on Docker Hub for quick deployment.

## Requirements
- [Docker](https://www.docker.com/): Ensure Docker is installed and running on your system.

---

## Using the Pre-Built Image from Docker Hub

You can skip building the image and directly use the pre-built image hosted on Docker Hub.

### Steps to Run:

1. Pull the pre-built Docker image:
   ```bash
   docker pull baghaee/docker-graphhopper
   ```

2. Run the Docker container:
   ```bash
   docker run -d -p 8989:8989 -e OSM_URL=https://download.geofabrik.de/europe/andorra-latest.osm.pbf baghaee/docker-graphhopper
   ```

### Explanation:
- `-d`: Runs the container in detached mode (in the background).
- `-p 8989:8989`: Maps port 8989 of the host to port 8989 of the container.
- `-e OSM_URL=<url>`: Environment variable to specify the OSM data file URL.

After running the above command, the GraphHopper server will be accessible at:

```
http://localhost:8989/
```

---

## Building and Running Your Own Docker Image

If you want to build the image locally, follow these steps:

### 1. Clone the Repository
```bash
git clone <repository-url>
cd <repository-folder>
```

### 2. Build the Docker Image
```bash
sudo docker build -t my-graphhopper .
```

### 3. Run the Docker Container
```bash
docker run -d -p 8989:8989 -e OSM_URL=https://download.geofabrik.de/europe/andorra-latest.osm.pbf my-graphhopper
```

### Customizing Configuration

You can customize the `config.yml` file before building the image. A sample configuration file (`config-example.yml`) is provided in this repository. To use your custom configuration:

1. Modify `config-example.yml` as needed.
2. Rename it to `config.yml`.
3. Rebuild the Docker image using the steps above.

---

## Explanation of Docker Setup

### Dockerfile

The `Dockerfile` used for this setup:

- **Base Image:** Uses `openjdk:17-jdk-slim` for a lightweight Java environment.
- **Tools:** Installs `git`, `maven`, and `wget` for cloning and building GraphHopper.
- **Configuration:** Copies a `config.yml` file into the container.
- **Entrypoint Script:** Downloads the specified OSM file and starts the GraphHopper server.

### Config File

The configuration file (`config-example.yml`) defines:
- **Routing profiles:** Such as `car`.
- **Ignored highways:** Specifies which highways to ignore during routing.
- **Graph storage location:** Location where GraphHopper stores pre-processed data.
- **Port Configuration:**
  The port where GraphHopper listens can be changed in the `server` section of `config.yml` (if specified). For example:
  ```yaml
  server:
    application_connectors:
      - type: http
        port: 8989
  ```
  You can change `8989` to any desired port. Ensure the Docker `-p` flag maps this new port correctly.

- **Memory Settings:**
  You can configure memory-related parameters such as the maximum heap size for Java (`-Xmx2g`) in the entrypoint script or directly within the Docker container.

---

## Accessing Logs

To view logs of the running container:
```bash
docker logs <CONTAINER_ID>
```
- Use `docker ps` to find the container ID.

For real-time logs:
```bash
docker logs -f <CONTAINER_ID>
```

---

## Stopping and Removing Containers

To stop a running container:
```bash
docker stop <CONTAINER_ID>
```

To remove stopped containers:
```bash
docker rm <CONTAINER_ID>
```

---

## License
This project is licensed under the MIT License. See the LICENSE file for details.

