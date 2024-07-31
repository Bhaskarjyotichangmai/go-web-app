FROM golang:1.22.5 as base

WORKDIR /app

# Copy go.mod file
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy the source code
COPY . .

# Build the application
RUN go build -o main .

FROM gcr.io/distroless/base

# Copy the built application from the previous stage
COPY --from=base /app/main .

# Copy static files
COPY --from=base /app/static ./static

# Expose port 8080
EXPOSE 8081

# Command to run the application
CMD ["./main"]
