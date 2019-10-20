@echo off
@title bat 交互执行git命令
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

rem 取得系统时间用做日志文件文件名字
for /f "tokens=2 delims==" %%a in ('wmic os get localdatetime /value') do set ct=%%a
set log=%ct:~0,14%.log

:start
cls
echo ========================================
echo          Starting automatic git commit
echo 1.git push                                    2.git pull
echo 输入其他字符将退出程序
echo ========================================
set /p input="请输入选择序号："
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
	echo %%n：!path[%%n]!
)
set /a c=%path.length%+1
echo %c%：All of them
set /a c=%path.length%+2
echo %c%：返回上一界面
SetLocal DisableDelayedExpansion
echo ========================================
set /p input="请输入选择序号："

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
	set /p input="输入错误，请重新输入"
	goto h1
) 

:doing_push
cls
cd %current_exe_path%
echo 开始提交...
echo 开始提交... >> %log_path%\%log%
echo 切换分支
git checkout master
echo 合并分支
git merge master temp >> %log_path%\%log%
echo 查询状态
git status >> %log_path%\%log%
echo 添加所有文件
git add . >> %log_path%\%log%
echo 正在提交
git commit -m "ScriptBack %date% %time%" >> %log_path%\%log%
echo 正在上传...
echo 开始上传... >> %log_path%\%log%
git push %current_exe_url% master >> %log_path%\%log%
echo 切回分支
git checkout temp
echo 执行完毕！
echo 执行完毕！ >> %log_path%\%log%
echo  1.返回上一界面		2.git pull
echo 其他任意键退出
set /p input="请输入选择序号："
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
	echo %%n：!path[%%n]!
)
set /a c=%path.length%+1
echo %c%：All of them
set /a c=%path.length%+2
echo %c%：返回上一界面
SetLocal DisableDelayedExpansion
echo ========================================
set /p input="请输入选择序号："

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
	set /p input="输入错误，请重新输入"
	goto h1
) 

:doing_pull
cls
cd %current_exe_path%
echo 开始更新...
echo 开始更新... >> %log_path%\%log%
echo 切换分支
git checkout master
echo 正在下载...
git push %current_exe_url% master >> %log_path%\%log%
echo 切回分支
git checkout temp
echo 合并分支
git merge temp master >> %log_path%\%log%
echo 执行完毕！
echo 执行完毕！ >> %log_path%\%log%
echo  1.返回上一界面		其他任意键退出
set /p input="请输入选择序号："
if %input% EQU 1 do (
	set current_exe_path=""
	set current_exe_url=""
	goto start
) else (
	else (exit)
)



