FROM golang:1.19-alpine AS build
LABEL stage=intermediate

RUN apk upgrade
RUN apk add --no-cache git bind-tools

WORKDIR /opt/demo/
COPY . .

RUN --mount=type=cache,target=/root/.cache/go-build CGO_ENABLED=0 GOOS=linux go install \
    --ldflags "-s -X main.version=${VERSION}" -a -installsuffix cgo \
    ./cmd/...

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Capacity" \
      org.label-schema.description="Capacity Mempool" \
      org.label-schema.url="https://manifoldfinance.com" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/manifoldfinance/Capacity.git" \
      org.label-schema.vendor="CommodityStream, Inc." \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

FROM scratch AS origin
USER nobody
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /go/bin/origin /bin/origin
EXPOSE 8000

FROM scratch AS proxy
USER nobody
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /go/bin/proxy /bin/proxy
EXPOSE 8080

FROM scratch AS client
USER nobody
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /go/bin/client /bin/client
EXPOSE 7000