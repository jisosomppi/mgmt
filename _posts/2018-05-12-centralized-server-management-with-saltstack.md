---
ID: 469
post_title: >
  Centralized server management with
  SaltStack
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2018/05/12/centralized-server-management-with-saltstack/
published: true
post_date: 2018-05-12 09:52:00
---
# Salt-based centralized configuration management
**Jussi Isosomppi, 2018**

_This repository is a part of Haaga-Helia's Linux server management course, taught by Tero Karvinen. The course aims to teach students the proper use of centralized management, as well as the use of version control tools such as github.  
More info at [Tero Karvinen's home page.](http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-4-ti-5-ke-5-loppukevat-2018-5p)_

## Yleistä reposta

### Skriptit
* `gitup`: 1-click github commit
* `startup.sh`: tekee koneesta salt-masterin omilla asetuksilla
* `spreadsalt.sh`: siirtää salt-masterin tiedostot paikalleen

## H1

### Tehtävänanto

>c) Asenna Salt Master ja Slave pull-arkkitehtuurilla (eli master on server). Voit laittaa herran ja orjan myös samalle koneelle. Kokeile suorittamalla salt:illa komentoja etänä.
>
>d) Kokeile jotain Laineen esimerkistä lainattua tilaa tai tee jostain tilasta oma muunnelma. Muista testata lopputuloksen toimivuus. Huomaa, että varastossa on myös keskeneräisiä esimerkkejä, kuten Battlenet-asennus Windowsille.
>
>e) Kerää laitetietoja koneilta saltin grains-mekanismilla.
>
>f) Oikeaa elämää. Säädä Saltilla jotain pientä, mutta oikeaa esimerkiksi omalta koneeltasi tai omalta virtuaalipalvelimelta. (Kannattaa kokeilla Saltia oikeassa elämässä, mutta jos se ei onnistu, rakenna jotain oikeaa konettasi vastaava virtuaaliympäristö ja tee asetus siinä).
>
>g) Vapaaehtoinen: asenna ja konfiugroi jokin palvelin Saltilla. (package-file-server)

### H1c)
Aloitin kurssin luomalla uuden virtuaalikoneen, johon asensin Ubuntu 16.04.4 LTS:n (64-bit). Virtuaalikoneen alustana toimii Proxmox-pohjainen kotipalvelimeni. Päivitin Ubuntuun uusimmat paketit ja otin palomuurin käyttöön. Tein palomuuriin aukot SSH:ta ja Salt-masteria varten, jonka jälkeen siirryin Promoxin selainpohjaisesta konsolista käyttämään Puttyä toisella koneella. Asensin tälle samalle koneelle sekä masterin että minionin, jonka jälkeen muutin minionin asetuksiin oikean hostin, käynnistin palvelut uudelleen ja hyväksyin minionin avaimen.

Tämän jälkeen testasin toimivuutta ajamalla komennon `sudo salt '*' cmd.run 'hostname -I'`, joka palautti koneen IP-osoitteen. Siirryin kirjoittamaan tiloja, joista ensimmäinen on pelkkä testitiedoston luominen, ja toinen varmistaa muutaman perusohjelman asennuksen.

Kansion `/srv/salt` sisältö on seuraava:
``` yaml
jussi@conman-VM:/srv/salt$ tail -n +1 *
==&gt; basicapps.sls &lt;==
basic_apps:
  pkg.installed:
    - pkgs:
      - htop
      - tree
      - git

==&gt; hello.sls &lt;==
/tmp/helloworld.txt:
  file.managed:
    - source: salt://helloworld.txt

==&gt; helloworld.txt &lt;==
Hello salty world!

// Created by salt-master

==&gt; top.sls &lt;==
base:
  &#039;*&#039;:
    - hello
    - basicapps
```

![screenshot1](https://raw.githubusercontent.com/jisosomppi/mgmt/master/images/2018-04-02%2018_15_26-jussi%40conman-VM_%20_srv_salt.png "Screenshot 1")

### H1d & H1f)
Lainasin Jori Laineen [LAMP-tilaa](https://github.com/joonaleppalahti/CCM/blob/master/salt/srv/salt/lamp.sls), koska se hoitaa aika kätevästi LAMPin käyttöönoton (asennus, vakiosivun korvaus omalla). Tein sen lisäksi oman testisivun, jossa testataan sekä Apachen että UTF-8:n toimivuus (ääkköset tekstissä ja laskutoimituksen arvon tulostus sivulle).

![screenshot2](https://raw.githubusercontent.com/jisosomppi/mgmt/master/images/2018-04-02%2021_16_53-Jussi's%20placeholder%20web%20page.png "Screenshot 2")

### H1e)
Komennolla `sudo salt '*' grains.item virtual` sain tarkistettua, että virtuaalikoneeni on virtuaalinen:
```
jussi@conman-VM:/srv/salt$ sudo salt &#039;*&#039; grains.item virtual
[WARNING ] Key &#039;file_ignore_glob&#039; with value None has an invalid type of NoneType, a list is required for this value
[WARNING ] Key &#039;file_ignore_glob&#039; with value None has an invalid type of NoneType, a list is required for this value
[WARNING ] Key &#039;file_ignore_glob&#039; with value None has an invalid type of NoneType, a list is required for this value
[WARNING ] Key &#039;file_ignore_glob&#039; with value None has an invalid type of NoneType, a list is required for this value
conman-VM:
    ----------
    virtual:
        qemu
```

## H2

### Tehtävänanto
>_Tehtävät tästä eteenpäin (h2, h3…) tulee ratkaista tekemällä Saltin tila (state), ellei tehtävänannosta muuta ilmene. Tee ensin käsin, automatisoi vasta sitten. Muista testata lopputulos._
>
>b) Laita käyttäjien kotisivut toimimaan Apachella.
>
>c) Laita PHP toimimaan käyttäjien kotisivuilla. (Huomaa, että PHP toimii oletuksena kaikkialla muualla kuin käyttäjien public_html-kotisivuilla.)
>
>d) Rakenna tila (state), joka tekee Apachelle uuden nimipohjaisen virtuaalipalvelimen (name based virtual hosting). Voit simuloida nimipalvelun toimintaa hosts-tiedoston avulla.
>
>e) Tee tila, joka laittaa esimerkkikotisivun uusille käyttäjille. Voit laittaa esimerkkikotisivu /etc/skel/:iin, niin se tulee automaattisesti ‘adduser tero’ komennolla käyttäjiä luodessa.
>
>f) Eri asetukset. Tee Package-File-Service tilalla eri asetuksia kuin ne, mitä tehtiin tunnilla; ja eri kuin mitä teit/teet h2 muissa kohdissa. Voit muuttaa jotain toista asetusta samoista demoneista tai valita kokonaan eri demonit.

### H2b)

Asensin ensin Apachen koneelle manuaalisesti, jonka jälkeen korvasin vakiosivun uudella, omalla sivulla, joka testaa suoraan PHP:n ja UTF-8:n toimivuuden. Tämän jälkeen otin käyttäjien kotisivut käyttöön komennolla `sudo a2enmod userdir`, ja testasin käyttäjän kotisivun näkyvän selaimella.

Tämän jälkeen loin itselleni [esimerkin](http://terokarvinen.com/2018/apache-user-homepages-automatically-salt-package-file-service-example) mukaisen salt-tilan Apachen asennukseen ja käyttäjän sivujen käyttöönottoon. Ajoin tilan uudelle minionille saltin kautta, ja totesin sen toimineen.

### H2c)

Asensin manuaalisesti paketin `libapache2-mod-php`, ja kävin kommentoimassa tarvittavat rivit pois tiedostosta `/etc/apache2/mods-available/php7.0.conf`. Kokeilin aiemmin tekemälläni sivulla PHP:n toimivuuden sekä yleisellä sivulla (`/var/www/html`) että käyttäjän kotisivulla (`~/public_html`), jonka jälkeen kopion muokatun asetustiedoston `/srv/salt` kansioon odottamaan käyttöä. Lisäsin aiempaan Apache-stateen PHP:n asennuksen ja asetustiedoston korvaamisen (sekä sen tarkistuksen palvelun uudelleenkäynnistystä varten).

### H2d)
*[Tähän kohtaan lähteenä](https://httpd.apache.org/docs/2.4/vhosts/examples.html#default)*

Lisäsin ensin uuden testisivun "testi.sivu" `/etc/hosts`:iin, jonka jälkeen varmistin uudelleenohjauksen toimivuuden pingaamalla uutta osoitetta onnistuneesti. Tämän jälkeen muokkasin tiedostoa `/etc/apache2/sites-available/000-default.conf`, ja lisäsin sinne uuden virtualhostin, joka ohjaa kansioon `/var/www/html2`. Tein selkeyden vuoksi erilaisen testisivun tuohon kansioon, jotta sain helposti testattua sen toimivuuden. 

![screenshot3](https://raw.githubusercontent.com/jisosomppi/mgmt/master/images/2018-04-10%2002_02_08-jussi%40nacl_%20%7E_mgmt.png "Screenshot 3")

Tämän jälkeen tein tästä seuraavan salt-staten:
``` yaml
# Package

apache2:
  pkg.installed:

# File

/etc/hosts:
  file.managed:
    - source: salt://vhost/hosts

/etc/apache2/sites-available/000-default.conf:
  file.managed:
    - source: salt://vhost/testi.sivu.conf

# Service

apache2service:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-available/000-default.conf
```

Lisäsin virtual hostin vakiosivun luomisen aiempaan Apache-stateen.

### H2e)

Lisäsin vielä aiempaan Apache-stateen vakiosivun lisäyksen `/etc/skel`:iin, jotta uusilla käyttäjillä olisi valmiiksi toimiva testisivu. Määritin myös tämän kohdan luomaan kansiot niiden puuttuessa.

Valmis Apache-state näyttää tältä:
``` yaml
# Package

install_apache:
  pkg.installed:
    - pkgs:
      - apache2
      - libapache2-mod-php

# File

/var/www/html/index.php:
  file.managed:
    - source: salt://apache/public_index.php

/var/www/html2/index.php:
  file.managed:
    - source: salt://apache/alt_index.php
    - makedirs: True

/etc/skel/public_html/index.php:
  file.managed:
    - source: salt://apache/user_index.php
    - makedirs: True

/etc/apache2/mods-available/php7.0.conf:
  file.managed:
    - source: salt://apache/php7.0.conf

/etc/apache2/mods-enabled/userdir.conf:
  file.symlink:
    - target: ../mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
  file.symlink:
    - target: ../mods-available/userdir.load

# Service

apache2service:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load
      - file: /etc/apache2/mods-available/php7.0.conf
```

## H3

### Tehtävänanto

>b) Tiedosto muotista: tee yksinkertainen SLS-tilatiedosto, joka laittaa muuttujan tiedostoon. Käytä jinjan kontekstimuuttujaa (template: jinja, context: …).
>
>c) SLS tilaa Jinjalla: tee yksinkertainen SLS-tilatiedosto, joka käyttää for-in -silmukaa. Voit esimerkiksi tehdä kolme tiedostoa silmukalla. (Tässä tehtävässä siis käytetään jinjaa vain SLS-tiedoston sisällä, älä sotke samaan esimerkkiin tekstitiedostojen sisällön muuttamista.)
>
>d) SSH-demonin portti: tee tila, joka asentaa SSH-demonin valittuun porttiin. Käytä portin valintaan Jinjaa, siten että sshd_config:issa “Port:”-kohdan arvo tulee Jinjan muuttujasta.
>
>e) Kokeile jonkun toisen opiskelijan tekemää Salt-tilaa. Kokeiltava tila voi olla mistä vain harjoituksesta. Opiskelijoiden raportteja ja koodeja löydät tämän sivun perästä kommenteista.

### H3b)

Tein ensimmäiseksi Jinja-tilaksi yksinkertaisen Hello world! -tilan, joka luo testitiedoston minionille ja täyttää sen statessa määritellyllä tiedolla:

``` yaml
/tmp/hellojinja.txt:
  file.managed:
    - source: salt://hellojinja/hellojinja.txt
    - template: jinja
    - context:
      filecontent: Hello world!

```
Ajoin tilan paikalliselle minionille:

![screenshot4](https://raw.githubusercontent.com/jisosomppi/mgmt/master/images/2018-04-17%2020_47_52-saltmaster%40nacl_%20%7E_mgmt.png "Screenshot 4")

Jonka jälkeen tarkistin tilan toimineen toivotusti:

![screenshot5](https://raw.githubusercontent.com/jisosomppi/mgmt/master/images/2018-04-17%2020_49_58-saltmaster%40nacl_%20%7E_mgmt.png "Screenshot 5")

### H3c)

Tein for in -silmukan, joka tekee `/tmp`-kansioon alikansion ja kolme testitiedostoa:

``` python
{% for testfile in [&#039;testone.txt&#039;, &#039;testtwo.txt&#039;, &#039;testthree.txt&#039;] %}

/tmp/loop/{{ testfile }}:
  file.managed:
    - source: salt://jinjaloop/loopbase.txt
    - makedirs: True
    - template: jinja
    - context:
      file: {{ testfile }}

{% endfor %}
```

Ajoin tilan ja tarkistin sen toimineen odotetusti:

![screenshot6](https://raw.githubusercontent.com/jisosomppi/mgmt/master/images/2018-04-17%2021_16_15-saltmaster%40nacl_%20%7E_mgmt_srvsalt_jinjaloop.png "Screenshot 6")

![screenshot7](https://raw.githubusercontent.com/jisosomppi/mgmt/master/images/2018-04-17%2021_16_51-saltmaster%40nacl_%20%7E_mgmt_srvsalt_jinjaloop.png "Screenshot 7")

### H3d)

Muokkasin hieman aiemmin tehtyä SSH-statea lisäämällä siihen Jinja-templaten:

``` yaml
openssh-server:
  pkg.installed

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://ssh/sshd_config
    - template: jinja
    - context:
      sshd_port: 8888
sshd:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config
```

Ajoin tilan minionilla: 

![screenshot8](https://github.com/jisosomppi/mgmt/blob/master/images/2018-04-17%2021_40_32-saltmaster%40nacl_%20%7E_mgmt.png "Screenshot 8")

*Portin vaihtaminen ei katkaissut käynnissä olevaa SSH-yhteyttä!*

Tämän jälkeen kokeilin kirjautua minioniin uudelleen SSH-yhteydellä, ja portin 22 käytöstä oli tuloksena virhe. Uudella portilla kirjautuminen onnistui normaalisti.

## H4

### Tehtävänanto

>b) Tee kahdella orjalla esimerkki, jossa orjat saavat eri muuttujan pilarista. Tarkista ‘pillars.items’, että kummalekin orjalle mene eri tieto. Tee jokin muu kuin tunnilla tehty sshd-esimerkki.
>
>c) Tee kahdella orjalla esimerkki, jossa toinen orja saa muuttujan pilarista ja toinen käyttää oletusarvoa (pillar.get). Tee jokin muu kuin tunnilla tehty sshd-esimerkki.

### H4b)

Määritin pillariin kolmelle eri konetyypille kaksi eri muuttujaa, ssh-portin ja helloworld-tiedostoon tulostuvan käyttäjänimen. Tarkistin komennolla `sudo salt '*' pillar.items`, että kukin minion sai tietoonsa vain sen, mitä kuuluikin:

![screenshot9](https://github.com/jisosomppi/mgmt/blob/master/images/Screenshot_2018-04-23_12-43-44.png?raw=true "Screenshot 9")

### H4c)

Määritin uuden minionin salt-ID:ksi "rogueminion", joka ei vastaa yhtään osumaa pilarissa. Tämän jälkeen testasin `hello`-tilaa, joka luo minioneille tiedoston `/tmp/helloworld.txt`. Komento loi halutusti tuon tiedoston jokaiselle minionille, jonka jälkeen tarkistin sen sisällön kultakin koneelta:

![screenshot10](https://github.com/jisosomppi/mgmt/blob/master/images/Screenshot_2018-04-23_12-53-28.png?raw=true "Screenshot 10")

## H5

>a) Valitse aihe omaksi kurssityöksi ja varaa se kommenttina aikataulusivun perään.
>
>b) Julkaise raportti MarkDownilla. Jos käytät GitHub:ia, se tekee muotoilun automaattisesti “.md”-päätteisiin dokumentteihin.
>
>c) Aja oma Salt-tila suoraan git-varastosta. Voit joko tehdä tilan alusta lähtien itse tai forkata sirottimen.

### H5a)
Varasin kurssin lopputehtävän aiheeksi Samba-tiedostopalvelimen asennuksen ja konfiguroinnin.

### H5b)
Tämä raportti on laadittu Markdownilla, joskaan ei varmasti täydellisesti sitä käyttäen.

### H5c)
Salt-tilojen ajaminen omasta varastosta onnistuu helposti, ohjaamalla komennot oikeaan kansioon: 

`wget https://raw.githubusercontent.com/jisosomppi/mgmt/master/startup.sh && bash startup.sh`  
Ajaa tekemäni startup-skriptin, joka mm. kloonaa tällä kurssilla käyttämäni Git-repon  

`sudo salt-call --local --file-root ~/mgmt/srvsalt/ --pillar-root ~/mgmt/srvpillar/ state.highstate`  
Ohjaa Saltin oikeaan kansioon, ja ajaa top.sls -tilaan määritetyt komennot.  

## H6

>a) Kultainen polku. Tee ensimmäinen versio modulistasi, joka toimii ainakin optimiolosuhteissa. Jos jokin säätö on poikkeuksellisen hankala, voit tehdä sen tässä versiossa käsin, ja dokumentoida ajamasi käskyt. (Valmis moduli tarvitaan vasta esitykseen ensi viikolla).
>
>b) Kokeile moduliasi tyhjässä koneessa. Voit käyttää virtualboxia, vagranttia tai livetikkua.
>
>c) Käyttäjätarina (user story): ketkä ovat modulisi käyttäjät? Mitä he haluavat saada aikaan modulillasi? Missä tilanteessa he sitä käyttävät? Mitkä ovat tärkeimmät parannukset käyttäjän kannalta, joita moduliin pitäisi vielä tehdä? Tähän c-kohtaan vain sanallinen vastaus, tämä kohta ei poikkeuksellisesti edellytä testejä tietokoneella.