FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /graphhopper

# Install necessary tools
RUN apt-get update && apt-get install -y git maven wget && rm -rf /var/lib/apt/lists/*

# Clone GraphHopper repository
RUN git clone https://github.com/graphhopper/graphhopper.git /graphhopper

# Copy configuration file
COPY config.yml ./config.yml

# Build GraphHopper
RUN mvn -f /graphhopper/pom.xml clean install -DskipTests

# Expose port 8989 for the GraphHopper server
EXPOSE 8989

# Script to download OSM file and start GraphHopper
RUN echo '#!/bin/sh' > /entrypoint.sh && \
    echo 'wget -O /data.osm.pbf $OSM_URL' >> /entrypoint.sh && \
    echo 'java -Xmx2g -Ddw.graphhopper.datareader.file=/data.osm.pbf -jar web/target/graphhopper-web-*.jar server co>    chmod +x /entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
