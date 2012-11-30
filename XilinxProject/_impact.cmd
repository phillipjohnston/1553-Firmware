setMode -bs
setMode -bs
setMode -bs
setMode -bs
setCable -port auto
Identify -inferir 
identifyMPM 
assignFile -p 2 -file "D:/Documents/GitHub/1553-Firmware/XilinxProject/system.bit"
Program -p 2 
setMode -bs
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
saveProjectFile -file "D:\Documents\Texts\Colloge\Senior Design\Test-projects\dt_2_chip_scope_2\\auto_project.ipf"
setMode -bs
setMode -bs
deleteDevice -position 1
deleteDevice -position 1
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
