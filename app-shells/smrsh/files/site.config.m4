define(`confCCOPTS', `@@confCCOPTS@@')
define(`confSTDIO_TYPE', `portable')
define(`confENVDEF', `-DXDEBUG=0')
define(`confLDOPTS', `-s')
define(`confMANOWN', `root')
define(`confMANGRP', `root')
define(`confMANMODE', `644')
define(`confMAN1SRC', `1')
define(`confMAN5SRC', `5')
define(`confMAN8SRC', `8')
define(`confLDOPTS_SO', `-shared -Wl')
APPENDDEF(`conf_smrsh_ENVDEF', `-DSMRSH_PATH=\"/bin:/usr/bin\"')
APPENDDEF(`conf_smrsh_ENVDEF', `-DSMRSH_CMDDIR=\"/var/lib/smrsh\"')
