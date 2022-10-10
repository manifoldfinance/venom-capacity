# VENOM: Mempool Capacity


$X(N)=\frac{\lambda N}{1+\sigma(N-1)+\kappa N(N-1)}$


## Equation 

X(N)=(lambda N)/(1+sigma(N-1)+kappa N(N-1))


    N is a number of nodes
    X(N) is throughput of the system of N nodes, e.g., 100 requests per second
    λ is a throughput of the system with one node X(1)
    σ is a coefficient of contention, e.g., σ=0.05 (5%)
    κ is a coefficient of crosstalk, e.g., κ=0.02 (2%)


## Usage 

Start
```bash
docker-compose up
```

## Monitor 

### Grafana 

<pre>
usr: admin <br>
paswd: admin <br>
</pre>

[http://localhost:3000/d/__zqZa-Zz/rpc-capacity-manager?orgId=1&refresh=5s](http://localhost:3000/d/__zqZa-Zz/rpc-capacity-manager?orgId=1&refresh=5s)

### Prometheus

[http://localhost:9090/](http://localhost:9090/)


### Naive Adaptive 

```bash
ORIGIN_WORKTIME=2s CLIENT_ORIGIN=http://proxy:7000 PROXY_ADAPTIVE=true docker-compose up
```

#### Results

client sends 5 requests per second and receives between 2.4 rps and 2.7 rps (HTTP 200) <br>
proxy oscillates between 4 and 6 in-flight requests <br>
origin processes between 2.7 and 3 requests per second <br>
origin has served requests with average latency 2.2 seconds <br>
origin has served 50% of requests (50th percentile) within 2 seconds <br>
origin has served 99% of requests (99th percentile) within 3 seconds with periodic spikes <br>