; Настройки базы данных
;base.host 	= 192.168.1.14
;base.login 	= dk
;base.password   = 0000
;base.dbase 	= dk
;base.bd 	= mysql
;base.prefix 	= kazan

; Настройки базы данных
base.host 	= localhost
base.login 	= root
base.password   = 
base.dbase 	= voter
base.bd 	= mysql
;base.prefix 	= kazan

; Настройка путей приложения
path.plugins	= /engine/plugins/
path.libs	= /engine/libs/
path.core       = /engine/core/
path.models	= /models/
path.upload	= /upload/
path.cache	= /cache/
path.layouts	= /tpl/layouts/
path.pages	= /pages/
path.tpl	= /tpl/
path.tmp	= /tmp/

; Настройки роутинга
route.default_city = kazan
route.default_page = index
route.default_action = index

; Настройки сессии
session.name    = PHPSESSID
session.timeout    = 3600
session.use_cache = false
session.table = session

; Настройки куков
cookie.host = dk ; хост для установки куков
cookie.path = / ; путь для установки куков

; Настройки авторизации
user.backend = ls
user.table_ls = user

; Настройка отладки
debug.enable = false

; Настройки отображения
view.engine = xslt

; Настройка кэша
cache.use       = false
; Вид кеширования file : files, memory : memcach
cache.type      = file
cache.prefix    = dk