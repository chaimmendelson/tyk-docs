# Use an official Hugo image to build the site
FROM klakegg/hugo:ext-alpine AS hugo-builder

# Set working directory
WORKDIR /src

# Copy the site source code into the container
COPY . .

# Build the Hugo site
RUN ["make", "hugo"]

# Use an official Apache HTTP Server image to serve the site
FROM httpd:alpine

# Copy the Hugo-generated site from the hugo-builder stage to the Apache document root
COPY --from=hugo-builder /src/public/ /usr/local/apache2/htdocs/

# Expose port 80 to access the site
EXPOSE 80

# Start the Apache server
CMD ["httpd-foreground"]
