
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth1:
      addresses:
       - 172.31.11.165/20
       - 172.31.9.191/20
      dhcp4: no
      routes:
       - to: 0.0.0.0/0
         via: 172.31.0.1 # Default gateway
         table: 1000
       - to: 172.31.11.165
         via: 0.0.0.0
         scope: link
         table: 1000
       - to: 172.31.9.191
         via: 0.0.0.0
         scope: link
         table: 1000
      routing-policy:
        - from: 172.31.11.165
          table: 1000
        - from: 172.31.9.191
          table: 1000
```
