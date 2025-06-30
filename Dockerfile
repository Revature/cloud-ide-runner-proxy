FROM openresty/openresty:alpine-fat

# Create necessary directories
RUN mkdir -p /usr/local/openresty/nginx/conf /usr/local/openresty/nginx/html/static

# Copy configuration files
COPY nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY proxy_headers.conf /usr/local/openresty/nginx/conf/proxy_headers.conf

# Copy HTML templates and static assets
COPY port_error.html /usr/local/openresty/nginx/html/port_error.html
COPY port_help.html /usr/local/openresty/nginx/html/port_help.html
COPY static/ /usr/local/openresty/nginx/html/static/
COPY invalid_credentials.html /usr/local/openresty/nginx/html/invalid_credentials.html
COPY connection_exists.html /usr/local/openresty/nginx/html/connection_exists.html

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:20000/health || exit 1

# Run as non-root user for security
RUN addgroup -g 101 -S nginx && \
    adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

# Expose port
EXPOSE 20000

# Command to run
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]