FROM golang:1.19-alpine
LABEL stage=test
WORKDIR /opt/demo/
RUN apk upgrade
RUN apk add --no-cache git
COPY . .
EXPOSE 8000 8080 7000
RUN go build -race -o /bin/ ./cmd/...

