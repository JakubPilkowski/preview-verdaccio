# Use Node.js official image as base
FROM node:18-alpine

# Install PM2 globally
RUN npm install -g pm2

# Install Verdaccio globally
RUN npm install -g verdaccio

# Create verdaccio user
RUN addgroup -g 10001 -S verdaccio && \
    adduser -u 10001 -S -G verdaccio -h /home/verdaccio verdaccio

# Create storage directory
RUN mkdir -p /verdaccio/storage && \
    chown -R verdaccio:verdaccio /verdaccio

# Expose port 4873
EXPOSE 4873

# Create volume for persistent storage
VOLUME /verdaccio/storage

# Switch to verdaccio user
USER verdaccio

# Set working directory
WORKDIR /home/verdaccio

# Run Verdaccio with PM2
CMD ["pm2-runtime", "verdaccio"] 