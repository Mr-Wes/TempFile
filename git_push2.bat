@echo off
@title bat 交互执行git命令
mode con lines=18 cols=80

rem ############可设置项###############

E:
set /a path.length=5
set path[1]=E:\code\TempFile
set url[1]=git@github.com:Mr-Wes/TempFile.git
set path[2]=E:\code\AndroidProjects
set url[2]=git@github.com:Mr-Wes/AndroidProjects.git
set path[3]=E:\code\CProjects
set url[3]=git@github.com:Mr-Wes/CProjects.git
set path[4]=E:\code\JavaProjects
set url[4]=git@github.com:Mr-Wes/JavaProjects
set path[5]=E:\code\PythonProjects
set url[5]=git@github.com:Mr-Wes/PythonProjects

set log_path=D:\programsoftware\Git\my_script_log\

rem ####################################

rem 取得系统时间用做日志文件文件名字
for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set ct=%%a
set log=%ct:~0,14%.log
rem flag_function=1时表示进行push操作，flag_function=2时表示进行pull操作
set /a flag_function=0

:start
cls
echo ========================================
echo          Starting automatic git commit
echo 1.git push                                    2.git pull
echo 注：输入其他字符将退出程序
echo ========================================
set /p input="请输入选择序号："
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
set /a flag_function=1
goto show_list

:pull_ui
cls
echo ========================================
echo          Starting automatic git commit pull
set /a flag_function=2
goto show_list

:show_list
SetLocal EnableDelayedExpansion
for /l %%n in (1,1,%path.length%) do (
	echo %%n：!path[%%n]!
)
set /a x=%path.length%+1
echo %x%：All of them
set /a y=%path.length%+2
echo %y%：返回上一界面
echo ========================================
set /p input="请输入选择序号："

:h1
if %input% LEQ %path.length% (
	set current_exe_path=!path[%input%]!
	set current_exe_url=!url[%input%]!
	SetLocal DisableDelayedExpansion
) ^
else if %input% EQU %x% (
	echo all of them
) ^
else if %input% EQU %y% (
	set /a flag_function=0
	goto start
) else (
	set /p input="输入错误，请重新输入"
	goto h1
)
echo %flag_function%
if %flag_function% EQU 1 (
	goto doing_push
) ^
else if %flag_function% EQU 2 (
	goto doing_pull
) else (
	set /a flag_function=0
	goto start
)

:doing_push
cls
cd %current_exe_path%
echo 开始提交... >> %log_path%\%log%
echo 切换分支 >> %log_path%\%log%
git checkout master >> %log_path%\%log%
echo 合并分支 >> %log_path%\%log%
git merge master temp >> %log_path%\%log%
echo 查询状态 >> %log_path%\%log%
git status >> %log_path%\%log%
echo 添加所有文件 >> %log_path%\%log%
git add . >> %log_path%\%log%
echo 正在提交 >> %log_path%\%log%
git commit -m "ScriptBack %date% %time%" >> %log_path%\%log%
echo 开始上传... >> %log_path%\%log%
git push %current_exe_url% master >> %log_path%\%log%
echo 切回分支 >> %log_path%\%log%
git checkout temp >> %log_path%\%log%
echo 执行完毕！ >> %log_path%\%log%
echo 1.返回上一界面		2.git pull
echo 注：其他任意键退出
set /p input="请输入选择序号："
if %input% EQU 1 (
	set current_exe_path=""
	set current_exe_url=""
	goto push_ui
) ^
else if %input% EQU 2 (
	set /a flag_function=2
	goto doing_pull
) else (
	exit
)

:doing_pull
cls
cd %current_exe_path%
echo 开始更新... >> %log_path%\%log%
echo 切换分支 >> %log_path%\%log%
git checkout master >> %log_path%\%log%
echo 正在下载... >> %log_path%\%log%
git push %current_exe_url% master >> %log_path%\%log%
echo 切回分支 >> %log_path%\%log%
git checkout temp
echo 合并分支 >> %log_path%\%log%
git merge temp master >> %log_path%\%log%
echo 执行完毕！ >> %log_path%\%log%
echo  1.返回主界面
echo 注：其他任意键退出
set /p input="请输入选择序号："
if %input% EQU 1 (
	set current_exe_path=""
	set current_exe_url=""
	set /a flag_function=0
	goto start
) else (
	exit
)



