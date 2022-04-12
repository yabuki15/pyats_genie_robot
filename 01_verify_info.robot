*** Settings ***
Library		ats.robot.pyATSRobot
Library		genie.libs.robot.GenieRobot
Library		unicon.robot.UniconRobot
Suite setup    Setup


*** Variables *** 
${testbed}    testbed.yml	# 全体の共通変数設定
${hostname}   leaf01
${mgmt_ip}    172.17.0.3

*** Test Cases ***
Initialize
    use testbed "${testbed}"
    connect to all devices	# testbedで設定した全ホストに接続

Check Hostname
    ${res_system} =    execute "net show system" on device "cum01"		# cum01でコマンド実行
    log to console  ${res_system}                                  # コンソールにログ出力
    Should Contain  ${res_system}  ${hostname}				        # hostnameの文字列が存在するか判定

Check Interface
    ${res_int} =    execute "net show interface" on device "cum01"
    log to console  ${res_int}
    Should Contain  ${res_int}  ${mgmt_ip}

*** Keywords ***
Setup       # キーワード Setup で指定した処理を実行する。日本語も対応
    use testbed "${testbed}"
    connect to device "cum01"
