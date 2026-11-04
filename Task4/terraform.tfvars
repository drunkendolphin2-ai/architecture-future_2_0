# Заменить на свои значения.
# Авторизация — ключ сервисного аккаунта, файл key.json рядом с конфигурацией (в .gitignore).
service_account_key_file = "key.json"
cloud_id                 = "b1gbmg1vggqglajcn35r"
folder_id                = "b1geqlu61cc6tdvdbdhp"
zone                     = "ru-central1-a"

ssh_allowed_cidrs   = ["0.0.0.0/0"] # лучше заменить на свой IP: ["x.x.x.x/32"]
ssh_public_key_path = "~/.ssh/id_ed25519.pub"
