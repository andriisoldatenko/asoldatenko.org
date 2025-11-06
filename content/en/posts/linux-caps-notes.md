+++
title = 'Linux Caps Notes'
date = 2025-11-02T18:53:59+01:00
draft = true
+++


## Intro

```bash
man capabilities
```

> For  the  purpose  of performing permission checks, traditional UNIX
> implementations distinguish two categories  of
> processes:  privileged  processes (whose effective user ID
> is 0, referred to as superuser or root), and  unprivileged
> processes  (whose  effective  UID is nonzero).  Privileged
> processes bypass all kernel permission checks,  while  un‐
> privileged processes are subject to full permission check‐
> ing based on the process's credentials (usually: effective
> UID, effective GID, and supplementary group list).

### How to check human redable caps of running proc


Find a process's pid:

```bash
ps aux
```

Now we can find effective capabilities
```bash
cat /proc/1872/status | grep CapEff
CapEff: 000001ffffffffff
```

As you can see format is not human readable: `000001ffffffffff`.

We can decode it using `capsh`:
```bash
capsh --decode=000001ffffffffff
0x000001ffffffffff=cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,cap_block_suspend,cap_audit_read,cap_perfmon,cap_bpf,cap_checkpoint_restore
```

Now let's say we want to run proc which will bind port less then
1024 (which requires to bind `cap_net_bind_service`).

TODO: add go example with server to bind a socket at 900 port
```go

// go program
```

```bash
go build -o bind_port_900
```

```bash
setcap 'cap_net_bind_service=+ep' ./bind_port_900
```


Try run as normal user:
```bash
./bind_port_900
```
