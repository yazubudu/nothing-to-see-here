@echo off
REM Убедитесь, что у вас есть права администратора для выполнения этих команд

setlocal enabledelayedexpansion

REM Путь к текстовому документу


set "file=unblock_list.txt"


set "hostsfile=C:\Windows\System32\drivers\etc\hosts"


set "tempfile=temp_hosts.txt"

REM Убедиться, что файл unblock_list.txt существует


if not exist "%file%" (


    echo Файл %file% не найден. Убедитесь, что он находится в той же директории, что и скрипт.


    pause


    exit /b


)

REM Чтение файла с сайтами и создание временного файла


(


    REM Копируем уже существующий файл hosts


    type %hostsfile%


    


    for /f "delims=" %%a in (%file%) do (


        echo Проверка %%a...


        


        REM Проверка, существует ли запись


        findstr /i "%%a" %hostsfile% > nul


        if errorlevel 1 (


            echo 0.0.0.0 %%a


        ) else (


            echo Запись %%a уже существует.


        )


    )


) > %tempfile%

REM Заменить старый hosts файл новым


move /y %tempfile% %hostsfile% > nul


if %errorlevel% neq 0 (


    echo Не удалось обновить файл hosts. Проверьте права доступа.


    pause


    exit /b


)

echo Все сайты разблокированы.


pause


cmd

 Копировать код
endlocal