MAINTAINER Orta Therox
+ ARG BRANCH="master"
+ ARG COMMIT=""
+ LABEL branch=${BRANCH}
+ LABEL commit=${COMMIT}

ADD . /app
WORKDIR /app

+ # Now set it as an env var
+ ENV COMMIT_SHA=${COMMIT}
+ ENV COMMIT_BRANCH=${BRANCH}

FROM golang:alpine AS build-env
WORKDIR /usr/local/go/src/github.com/ktapasvi/push-workflow-example
COPY . /usr/local/go/src/github.com/ktapasvi/push-workflow-example
RUN go install -ldflags="-w -s"

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build-env /usr/local/go/bin/push-workflow-example /bin/push-workflow-example
CMD ["push-workflow-example"]

EXPOSE 8500
