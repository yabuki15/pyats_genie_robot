*** Settings ***
Library		ats.robot.pyATSRobot
Library		genie.libs.robot.GenieRobot
Library		unicon.robot.UniconRobot
Suite setup    Setup


*** Variables ***
${testbed}    testbed.yml		# テストベッドファイルの指定
${hostname}   leaf01
${mgmt_ip}    172.17.0.3

*** Test Cases ***
Initialize
    use testbed "${testbed}"		# テストベッドファイルの指定
    connect to all devices		# 全機器(今回は1台)へ接続

Check Hostname
    ${res_system} =    execute "net show system" on device "cum01"		# cum01でコマンド実行
    log to console  ${res_system}						# コンソール出力
    Should Contain  ${res_system}  ${hostname}					# ホスト名判定

Check Interface
    ${res_int} =    execute "net show interface" on device "cum01"
    log to console  ${res_int}
    Should Contain  ${res_int}  ${mgmt_ip}

*** Keywords ***
Setup
    use testbed "${testbed}"
    connect to device "cum01"
