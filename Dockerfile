# Use Node.js official image as base
FROM node:18-alpine

# Install PM2 globally
RUN npm install -g pm2

# Install Verdaccio globally
RUN npm install -g verdaccio

# Create verdaccio user
RUN addgroup -g 10001 -S verdaccio && \
    adduser -u 10001 -S -G verdaccio -h /home/verdaccio verdaccio

# Copy Verdaccio configuration
COPY config.yml /verdaccio/config.yml
RUN chown verdaccio:verdaccio /verdaccio/config.yml

# Expose port 4873
EXPOSE 4873

# Create volume for persistent storage
VOLUME /verdaccio/storage

# Switch to verdaccio user
USER verdaccio

# Set working directory
WORKDIR /home/verdaccio

# Run Verdaccio with PM2, binding to all interfaces
CMD ["pm2-runtime", "verdaccio", "--", "-c", "/verdaccio/config.yml", "-l", "0.0.0.0:4873"]

