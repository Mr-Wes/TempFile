@echo off
@title bat ����ִ��git����
mode con lines=18 cols=80

D:
set /a path.length=5
set path[1]=D:\TempFile
set url[1]=git@github.com:Mr-Wes/TempFile.git
set path[2]=D:\programworkspace\AndroidProjects
set url[2]=git@github.com:Mr-Wes/AndroidProjects.git
set path[3]=D:\programworkspace\CProjects
set url[3]=git@github.com:Mr-Wes/CProjects.git
set path[4]=D:\programworkspace\JavaProjects
set url[4]=git@github.com:Mr-Wes/JavaProjects
set path[5]=D:\programworkspace\PythonProjects
set url[5]=git@github.com:Mr-Wes/PythonProjects

set log_path=D:\programsoftware\Git\my_script_log\

rem ȡ��ϵͳʱ��������־�ļ��ļ�����
for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set ct=%%a
set log=%ct:~0,14%.log

:start
cls
echo ========================================
echo          Starting automatic git commit
echo 1.git push                                    2.git pull
echo ���������ַ����˳�����
echo ========================================
set /p input="������ѡ����ţ�"
:h0
if %input% EQU 1 (
	goto push_ui
) ^
else if %input% EQU 2 (
	goto pull_ui
) else (
	exit
)

:push_ui
cls
echo ========================================
echo          Starting automatic git commit push
goto show_list1

:show_list1
SetLocal EnableDelayedExpansion
for /l %%n in (1,1,%path.length%) do (
	echo %%n��!path[%%n]!
)
set /a c=%path.length%+1
echo %c%��All of them
set /a c=%path.length%+2
echo %c%��������һ����
SetLocal DisableDelayedExpansion
echo ========================================
set /p input="������ѡ����ţ�"

:h1
if %input% EQU 1 (
	set current_exe_path=%path[1]%
	set current_exe_url=%url[1]%
	goto doing_push
) ^
else if %input% EQU 2 (
	set current_exe_path=%path[2]%
	set current_exe_url=%url[2]%
	goto doing_push
) ^
else if %input% EQU 3 (
	set current_exe_path=%path[3]%
	set current_exe_url=%url[3]%
	goto doing_push
) ^
else if %input% EQU 4 (
	set current_exe_path=%path[4]%
	set current_exe_url=%url[4]%
	goto doing_push
) ^
else if %input% EQU 5 (
	set current_exe_path=%path[5]%
	set current_exe_url=%url[5]%
	goto doing_push
) ^
else if %input% EQU 6 (
	echo hi
) ^
else if %input% EQU 7 (
	goto start
) else (
	set /p input="�����������������"
	goto h1
) 

:doing_push
cls
cd %current_exe_path%
echo ��ʼ�ύ...
echo ��ʼ�ύ... >> %log_path%\%log%
echo �л���֧
git checkout master
echo �ϲ���֧
git merge master temp >> %log_path%\%log%
echo ��ѯ״̬
git status >> %log_path%\%log%
echo ��������ļ�
git add . >> %log_path%\%log%
echo �����ύ
git commit -m "ScriptBack %date% %time%" >> %log_path%\%log%
echo �����ϴ�...
echo ��ʼ�ϴ�... >> %log_path%\%log%
git push %current_exe_url% master >> %log_path%\%log%
echo �лط�֧
git checkout temp
echo ִ����ϣ�
echo ִ����ϣ� >> %log_path%\%log%
echo  1.������һ����		2.git pull
echo ����������˳�
set /p input="������ѡ����ţ�"
if %input% EQU 1 do (
	set current_exe_path=""
	set current_exe_url=""
	goto push_ui
) ^
else if %input% EQU 2 (
	goto doing_pull
) else (
	else (exit)
)

:pull_ui
cls
echo ========================================
echo          Starting automatic git commit pull
goto show_list2

:show_list2
SetLocal EnableDelayedExpansion
for /l %%n in (1,1,%path.length%) do (
	echo %%n��!path[%%n]!
)
set /a c=%path.length%+1
echo %c%��All of them
set /a c=%path.length%+2
echo %c%��������һ����
SetLocal DisableDelayedExpansion
echo ========================================
set /p input="������ѡ����ţ�"

:h2
if %input% EQU 1 (
	set current_exe_path=%path[1]%
	set current_exe_url=%url[1]%
	goto doing_pull
) ^
else if %input% EQU 2 (
	set current_exe_path=%path[2]%
	set current_exe_url=%url[2]%
	goto doing_pull
) ^
else if %input% EQU 3 (
	set current_exe_path=%path[3]%
	set current_exe_url=%url[3]%
	goto doing_pull
) ^
else if %input% EQU 4 (
	set current_exe_path=%path[4]%
	set current_exe_url=%url[4]%
	goto doing_pull
) ^
else if %input% EQU 5 (
	set current_exe_path=%path[5]%
	set current_exe_url=%url[5]%
	goto doing_pull
) ^
else if %input% EQU 6 (
	echo hi
) ^
else if %input% EQU 7 (
	goto start
) else (
	set /p input="�����������������"
	goto h1
) 

:doing_pull
cls
cd %current_exe_path%
echo ��ʼ����...
echo ��ʼ����... >> %log_path%\%log%
echo �л���֧
git checkout master
echo ��������...
git push %current_exe_url% master >> %log_path%\%log%
echo �лط�֧
git checkout temp
echo �ϲ���֧
git merge temp master >> %log_path%\%log%
echo ִ����ϣ�
echo ִ����ϣ� >> %log_path%\%log%
echo  1.������һ����		����������˳�
set /p input="������ѡ����ţ�"
if %input% EQU 1 do (
	set current_exe_path=""
	set current_exe_url=""
	goto start
) else (
	else (exit)
)



