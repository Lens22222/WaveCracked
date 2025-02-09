@echo off
echo Setting up Python, pip, and required packages...

REM Check if Python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python is not installed. Downloading and installing Python...
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe' -OutFile 'python-installer.exe'"
    if %errorlevel% neq 0 (
        echo Failed to download Python installer. Please check your internet connection.
        exit /b 1
    )
    start /wait python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    del python-installer.exe
    echo Python installed successfully.
) else (
    echo Python is already installed.
)

REM Check if pip is installed
where pip >nul 2>nul
if %errorlevel% neq 0 (
    echo pip is not installed. Installing pip...
    powershell -Command "Invoke-WebRequest -Uri 'https://bootstrap.pypa.io/get-pip.py' -OutFile 'get-pip.py'"
    if %errorlevel% neq 0 (
        echo Failed to download get-pip.py. Please check your internet connection.
        exit /b 1
    )
    python get-pip.py
    del get-pip.py
    echo pip installed successfully.
) else (
    echo pip is already installed.
)

REM Install required packages
echo Installing required packages...
pip install wheel tinyaes pyinstaller pyaes urllib3
if %errorlevel% neq 0 (
    echo Failed to install required packages.
    exit /b 1
)
echo Required packages installed successfully.

echo Setup completed successfully.
pause