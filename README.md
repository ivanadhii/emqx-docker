# EMQX Docker Deployment

Deployment EMQX menggunakan Docker Compose dengan konfigurasi custom.

## Konfigurasi

- **MQTT Port**: 1883 (TCP), 8083 (WebSocket)
- **Dashboard**: http://localhost:18083
- **Dashboard Username**: meltedbrain
- **Dashboard Password**: meltedbrain911
- **MQTT Authentication**: DISABLED (anonymous allowed, no password required)

## Cara Deploy

1. Pastikan Docker dan Docker Compose sudah terinstall
2. Jalankan command berikut di directory ini:

```bash
docker compose up -d
```

## Command Berguna

### Start EMQX
```bash
docker compose up -d
```

### Stop EMQX
```bash
docker compose down
```

### Lihat Logs
```bash
docker compose logs -f emqx
```

### Restart EMQX
```bash
docker compose restart
```

### Stop dan Hapus Data
```bash
docker compose down -v
```

## Testing MQTT Connection

### Menggunakan mosquitto_sub (Subscribe)
```bash
mosquitto_sub -h localhost -p 1883 -t test/topic
```

### Menggunakan mosquitto_pub (Publish)
```bash
mosquitto_pub -h localhost -p 1883 -t test/topic -m "Hello EMQX"
```

## File Structure

```
.
├── docker-compose.yml    # Docker Compose configuration
├── emqx.conf            # EMQX configuration file
├── emqx-data/           # Data directory (auto-created)
├── emqx-log/            # Log directory (auto-created)
└── README.md            # This file
```

## Access Dashboard

Setelah container running, akses dashboard di:
- URL: http://localhost:18083
- Username: meltedbrain
- Password: meltedbrain911

## Notes

- MQTT connections tidak memerlukan username/password (anonymous allowed)
- Hanya dashboard yang memerlukan login
- Data EMQX disimpan di volume lokal agar persistent
