# Lightweight alpine OS, weight only 5mb, everything else is Go # # environment
FROM golang:1.11.5

ENV GOOGLE_APPLICATION_CREDENTIALS  /home/boqunzhang5858/Documents/Around/service/around-sa.json

# Define working directory
WORKDIR /go/src/github.com/zhangbq5858/around

# Add files from your laptop to WORKDIR inside the docker image
ADD . /go/src/github.com/zhangbq5858/around

# Install dependencies
RUN go get -v \
cloud.google.com/go/bigtable \
cloud.google.com/go/storage \
github.com/auth0/go-jwt-middleware \
github.com/dgrijalva/jwt-go \
github.com/go-redis/redis \
github.com/gorilla/mux \
github.com/olivere/elastic.v6 \
github.com/pborman/uuid \
github.com/pkg/errors \
golang.org/x/oauth2/google

# check out elasticsearch client for version 6+
RUN cd /go/src/github.com/olivere/elastic && git reset --hard fa7c1d1a1f4461ffa42377866f1c127860a557ff

# Expose port
EXPOSE 8080

# Entrypoint
CMD ["/usr/local/go/bin/go", "run", "user.go", "main.go"]
