FROM golang:1.19 AS builder

WORKDIR /app

RUN go mod init hello

COPY hello.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello .

FROM scratch

WORKDIR /app

COPY --from=builder /app/hello .

CMD ["./hello"]