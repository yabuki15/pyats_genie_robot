*** Settings ***
Library		ats.robot.pyATSRobot
Library		genie.libs.robot.GenieRobot
Library		unicon.robot.UniconRobot
Suite setup    Setup


*** Variables ***
${testbed}    testbed.yml		# $B%F%9%H%Y%C%I%U%!%$%k$N;XDj(B
${hostname}   leaf01
${mgmt_ip}    172.17.0.3

*** Test Cases ***
Initialize
    use testbed "${testbed}"		# $B%F%9%H%Y%C%I%U%!%$%k$N;XDj(B
    connect to all devices		# $BA45!4o(B($B:#2s$O(B1$BBf(B)$B$X@\B3(B

Check Hostname
    ${res_system} =    execute "net show system" on device "cum01"		# cum01$B$G%3%^%s%I<B9T(B
    log to console  ${res_system}						# $B%3%s%=!<%k=PNO(B
    Should Contain  ${res_system}  ${hostname}					# $B%[%9%HL>H=Dj(B

Check Interface
    ${res_int} =    execute "net show interface" on device "cum01"
    log to console  ${res_int}
    Should Contain  ${res_int}  ${mgmt_ip}

*** Keywords ***
Setup
    use testbed "${testbed}"
    connect to device "cum01"
