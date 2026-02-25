FROM gcc:latest

WORKDIR /app

# Copy all runtime/build inputs needed by the TSS.
COPY src/ ./src/
COPY data/ ./data/
COPY frontend/ ./frontend/
COPY build.bat ./build.bat

# Build the TSS binary.
RUN chmod +x ./build.bat && ./build.bat

# TSS serves HTTP and listens for UDP on the same port.
EXPOSE 14141/tcp
EXPOSE 14141/udp

# Start TSS when the container starts. 
# (note, exits immidately if no stdin is present. try running with `-it`)
CMD ["/usr/local/bin/start-tss"]
