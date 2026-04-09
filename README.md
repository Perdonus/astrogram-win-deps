# astrogram-win-deps

Предподготовленные Windows-зависимости для Astrogram Desktop.

Тут хранятся только манифесты и служебные скрипты. Сами тяжёлые бинарные наборы публикуются как release assets:

- `astrogram-win-libs.tar.zst`
- `astrogram-win-thirdparty.tar.zst`
- `astrogram-win-sources.tar.zst`

Использование: основной CI Astrogram скачивает latest release этого репозитория и распаковывает только нужные наборы перед configure/build.
