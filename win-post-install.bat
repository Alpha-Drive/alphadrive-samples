@echo off
echo [1mInstalling pygame and the carla python api.
echo ============[0m
pip install pygame
echo.
echo [1mInstalling carla python api.
echo ============[0m
easy_install api-redist\carla-0.9.5-py3.7-win-amd64.egg

echo ============[0m
echo [1mYou are now ready to run the alpha command on the
echo python scripts in this folder.
echo.
echo e.g., try: alpha drive manual_win[0m
echo.
