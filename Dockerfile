FROM openresty/openresty:alpine-fat

# Copy nginx configuration
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf

# Expose the port
EXPOSE 80

# Command to run
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]