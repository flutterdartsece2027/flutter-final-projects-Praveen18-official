@echo off
setlocal

:: Build the Flutter web app
echo Building Flutter web app...
flutter build web --release --web-renderer html --dart-define=FLUTTER_WEB_USE_SKIA=true

:: Run the web server
echo Starting web server...
cd build/web
python -m http.server 8000

if %ERRORLEVEL% NEQ 0 (
    echo Flutter run failed
    exit /b %ERRORLEVEL%
)

exit /b 0
