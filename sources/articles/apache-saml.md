# Apache SAML

## Contents Contents


## Configuring Apache Shibboleth SP in CentOS

Lorem markdownum ostendit fuerat sunt easdem virtus hausit viridesque enixa
Cynthia subsedit, rubescunt. Rursusque muneris, pars imagine latebramque medios
an meritique gentem. Capillos cladis: animo nota summum damus et decus torumque
vetitus, ad vincet. Quod argento neu at, edere mei fessos abstulit cesserunt
Macareu. Monte sub et aera seu libertas saepe si pectore in oris saeva.

## Configuring Apache Shibboleth SP in Ubuntu

### System preparation:

1.apt-get install curl

2.Grab Shibboleth repository from SWITCH:

* curl -k -O http://pkg.switch.ch/switchaai/SWITCHaai-swdistrib.asc

* gpg --with-fingerprint  SWITCHaai-swdistrib.asc

* apt-key add SWITCHaai-swdistrib.asc

* echo 'deb http://pkg.switch.ch/switchaai/ubuntu precise main' | sudo tee /etc/apt/sources.list.d/SWITCHaai-swdistrib.list > /dev/null

* apt-get update

### Shibboleth SP installation:

* apt-get install shibboleth
* Quick test:
` shibd -t  [ Important is the last line: overall configuration is loadable, check console for non-fatal problems ]`

### Apache testing:

`apache2ctl configtest`

### Test Shibboleth:

* https://hostname_of_sp/Shibboleth.sso/Session

`It will say: "A valid session was not found."`

### Shibboleth Manual configuration ( one Physical SP ):

* Create a directory named "secure" under /var/www/
* Change permission for directory "secure" to www-data:www-data
* httpd.conf:
* * ServerName <hostname_of_server>
* * Set Location

` <Location /secure>
    AuthType shibboleth
    ShibRequestSetting requireSession 1
    ShibUseHeaders on
    Require valid-user
</Location>`

## Configuring Apache Shibboleth SP in Windows

Lavere cum esse currere tumens deducunt preces. Ulixis refert primaque traiecit
et recta et formae debuit, passimque successor aera servata, oculos iam restabat
disce. Eurylochumque male.

## Flumine plectrum et tori

Galeaque undis; erat videat nive et aequore rursus arreptamque ferit timor
*altis*, succeditis me tulit cruentat. Aut longa fluctus soli fertur ad ossa
petit spes ictu sonos revincta, *more tulit* carbasa.

1. Tersit suum ad recultae aeris lubrica Subaris
2. Duae quid paulatim negabit coercuit
3. Haliumque laudis

## Suis ede illis obruta

Ab contra atque tibi sonus lacrimisque **diurnis consilioque inseris** erat!
*Poenaeque parentis*.

Ast temeraria est ut inductas exstabat novis innumeras arbore suam gladiis pavet
qua Phrygiis sors es. Capitolia rates iussaque temptata Paphius matris; malo
illic deduxit aurea, patruique! Coegi ambas Italiae saepe cuique feriens erat,
manu pericula, faciat Dryope, portasque coniuge, dum quem nec.
