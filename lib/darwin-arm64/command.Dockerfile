FROM alpine:3.14
RUN apk add --no-cache bash
RUN apk add --no-cache git
RUN apk add --no-cache python3

COPY ./scripts/github-code.sh /github-code.sh
RUN mkdir -p /results
ENTRYPOINT ["/github-code.sh"]