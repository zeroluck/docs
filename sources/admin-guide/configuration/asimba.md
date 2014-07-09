# Asimba configuration with Gluu Server


## Base installation of Asimba package

* Get the war for asimba from Gluu
* Send the war file in ~/tomcat/webapps/
* Restart tomcat, it will extract the asimba
* Get the asimba.conf template from Gluu
* Generate the keystore for your Asimba server:
    * Command: `keytool -genkeypair -keyalg RSA -alias "<ALIAS_OF_KEYSTORE>" -keypass <PASSWORD> -keystore <NAME_OF_JKS>.jks -storepass <PASSWORD>`
        * What is your first and last name?: Provide the hostname of Asimba server
        * What is the name of your organizational unit?: IT
        * What is the name of your organization?: Provide name
        * What is the name of your City or Locality?: city name
        * What is the name of your State or Province?: State name
        * What is the two-letter country code for this unit?: US
* Adding IDP / ADFS in Asimba: 
    * Gather metadata of IDP / ADFS and keep them in some place under /tomcat/webapps/asimba-saml-proxy/WEB-INF/ 
    * Collect certificate of IDP / ADFS and import them in Asimba truststore JKS

* Adding SP in Asimba: 
    * Gather metadata of SP and keep them in some place under /tomcat/webapps/asimba-saml-proxy/WEB-INF/
    * Collect certificate of SP and import them in Asimba truststore JKS

* Restart tomcat

## Apache configuration

* Configure "idp.conf": 

            <Location /asimba-saml-proxy>
                ProxyPass ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy retry=5 disablereuse=On
                ProxyPassReverse ajp://<ASIMBA_HOSTNAME>:8009/asimba-saml-proxy
    
                Order allow,deny
                Allow from all
            </Location>

* Restart httpd 

## Test Asimba setup

* Try to download the metadata of Asimba server with: `wget -c https://<HOSTNAME>/asimba-saml-proxy/profiles/saml2`
 



## Meae expugnare Nyseus non urbis se ortuque

Lorem markdownum haec ne! Contra sed non sanguine lammina, orbi arbor Teleste,
quem petit luctus [minor](http://textfromdog.tumblr.com/) pestifero vocor thyrso
nulla debuit.

Gente tenet, pater nymphae texerat ipse, tempore perfudit nubibus. Aureus
glomerataque mansura et namque exiguas agrestes discrimine exstitit caeca,
conspicuus **ablati posse**. In defendere lurida parvae illis iuncta, servaberis
responsa, cognatumque. Rerum tergo, crudelesque amens creatus, sceleratus nobis,
tua.

## In meo quo Pygmaeae ab polis mente

Facientes longum constitit sacra levis noctis, lacrimosa tactosque perit ramis
maris mittor quoque, novissima, numina erunt? Imis graminis stipes! Hasta illi
capiunt fatemur.

## Iam magna unde unguibus quoniam et frenisque

[Non fessa](http://hipstermerkel.tumblr.com/), tu bulla vulnere sic illac
Phoebus non est quo. Tiberinaque *lege* seges laeva ingratos munere, prorumpit
habitasse et arces quae. Sanguine pulsa, non stravit fuerit velox dedit inque
agnus, veterum domus. Diros levis vaccae Iovis; ille tractu enim **circumsonat**
placent teneat geminata ita.

## Silices sua adulantum videar corpus

Fatorum urnam terretur prohibetis ad est servantes possem scires. Rebar *ventis
nil* rescindere petunt volucrem et crimen canitie libens? In illa requiescere,
quanta Antimachumque movit, tempore saxum. Crudelis saevum? Luctus per
[missa](http://haskell.org/) Tyrrhena timuitque fore crepuscula conata
semihomines, pingit ignes, longius spatioque cervix laetis ad convicia!

Conplexu haerent, pars umeros in delubra equo. Modo sedem secum! A seque locum.
Sibi tota unde subibis sive est unus odium *mollit*. Quis est.

Sedesque coniugii **et fatebor anhelos**. Per in falcata saxa lignum certe in
membra exilio Inachus accipe anguem *sepulcrum sit trahatur*. Membris tento
viator sinistro scelerum felix tempora; viam mea illi convicia. Deducit herbis
cum libens, maturuit. Finiat collocat; tamen herbae aliquis simplex postquam que
rapite?

[Non fessa]: http://hipstermerkel.tumblr.com/
[minor]: http://textfromdog.tumblr.com/
[missa]: http://haskell.org/
