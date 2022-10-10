FROM golang:1.19-alpine AS build
LABEL stage=intermediate

RUN apk upgrade
RUN apk add --no-cache git bind-tools
WORKDIR /opt/demo/
COPY . .
RUN CGO_ENABLED=0 go install \
    --ldflags "-s" -a -installsuffix cgo \
    ./cmd/...

FROM scratch
USER nobody
EXPOSE 8000 8080 7000
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /go/bin/origin /bin/origin
COPY --from=build /go/bin/client /bin/client
COPY --from=build /go/bin/proxy /bin/proxy


LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Capacity" \
      org.label-schema.description="Capacity Mempool" \
      org.label-schema.url="https://manifoldfinance.com" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/manifoldfinance/Capacity.git" \
      org.label-schema.vendor="CommodityStream, Inc." \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"