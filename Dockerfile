FROM nginx:alpine

# Create a simple error page
RUN echo '<html><body><h1>Error</h1><p>The requested operation could not be completed.</p></body></html>' > /usr/share/nginx/html/error.html

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy our custom configuration
COPY nginx.conf /etc/nginx/conf.d/proxy.conf

# Expose the port we want to run on
EXPOSE 1026

# Use the "daemon off" directive to keep the container running
CMD ["nginx", "-g", "daemon off;"]