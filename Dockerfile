# Stage 1: Build
FROM golang:1.24-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go mod tidy
RUN go build -o kirito

# Stage 2: Runtime
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/kirito .

EXPOSE 8080

CMD ["./kirito"]
