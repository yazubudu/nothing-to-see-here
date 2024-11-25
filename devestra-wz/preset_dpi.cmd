@echo off
REM Убедитесь, что у вас есть права администратора для выполнения этих команд


setlocal enabledelayedexpansion

REM Путь к текстовому документу


set "file=unblock_list.txt"


set "hostsfile=C:\Windows\System32\drivers\etc\hosts"


set "backupfile=%hostsfile%.bak"

REM Создание резервной копии файла hosts


copy %hostsfile% %backupfile%

REM Временный файл для хранения новых записей


set "tempfile=temp_hosts.txt"

REM Чтение файла с сайтами


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


move /y %tempfile% %hostsfile%

echo Все сайты разблокированы.


pause

REM Восстановление файла hosts из резервной копии


move /y %backupfile% %hostsfile%

echo Файл hosts восстановлен.


cmd

 Копировать код
endlocal