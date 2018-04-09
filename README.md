# Salt-based centralized configuration management
**Jussi Isosomppi, 2018**

_This repository is a part of Haaga-Helia's Linux server management course, taught by Tero Karvinen. The course aims to teach students the proper use of centralized management, as well as the use of version control tools such as github.  
More info at [Tero Karvinen's home page.](http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-4-ti-5-ke-5-loppukevat-2018-5p)_

## H1

### Tehtävänanto
>a) Lue virallisesta Salt Getting Started Guide -kirjasta luvut Understanding SaltStack (noin 8 alasivua) ja SaltStack Fundamentals (6 alasivua, ei tarvitse asentaa demoympäristöä) ja SaltStack Configuration Management: Functions (1 alasivu). (Tätä lukutehtävää ei tarvitse raportoida).
>
>b) Silmäile Laineen 2017 varastossa olevia salt -asetuksia. (Tätä lukutehtävää ei tarvitse raportoida).
>
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
```
jussi@conman-VM:/srv/salt$ tail -n +1 *
==> basicapps.sls <==
basic_apps:
  pkg.installed:
    - pkgs:
      - htop
      - tree
      - git

==> hello.sls <==
/tmp/helloworld.txt:
  file.managed:
    - source: salt://helloworld.txt

==> helloworld.txt <==
Hello salty world!

// Created by salt-master

==> top.sls <==
base:
  '*':
    - hello
    - basicapps
```

![screenshot1](https://raw.githubusercontent.com/jisosomppi/mgmt/master/2018-04-02%2018_15_26-jussi%40conman-VM_%20_srv_salt.png "Screenshot 1")

### H1d & H1f)
Lainasin Jori Laineen [LAMP-tilaa](https://github.com/joonaleppalahti/CCM/blob/master/salt/srv/salt/lamp.sls), koska se hoitaa aika kätevästi LAMPin käyttöönoton (asennus, vakiosivun korvaus omalla). Tein sen lisäksi oman testisivun, jossa testataan sekä Apachen että UTF-8:n toimivuus (ääkköset tekstissä ja laskutoimituksen arvon tulostus sivulle).

![screenshot2](https://raw.githubusercontent.com/jisosomppi/mgmt/master/2018-04-02%2021_16_53-Jussi's%20placeholder%20web%20page.png "Screenshot 2")

### H1e)
Komennolla `sudo salt '*' grains.item virtual` sain tarkistettua, että virtuaalikoneeni on virtuaalinen:
```
jussi@conman-VM:/srv/salt$ sudo salt '*' grains.item virtual
[WARNING ] Key 'file_ignore_glob' with value None has an invalid type of NoneType, a list is required for this value
[WARNING ] Key 'file_ignore_glob' with value None has an invalid type of NoneType, a list is required for this value
[WARNING ] Key 'file_ignore_glob' with value None has an invalid type of NoneType, a list is required for this value
[WARNING ] Key 'file_ignore_glob' with value None has an invalid type of NoneType, a list is required for this value
conman-VM:
    ----------
    virtual:
        qemu
```

## H2

### Tehtävänanto
>Tehtävät tästä eteenpäin (h2, h3…) tulee ratkaista tekemällä Saltin tila (state), ellei tehtävänannosta muuta ilmene. Tee ensin käsin, automatisoi vasta sitten. Muista testata lopputulos.
>
>a) Opiskele yllä aikataulussa olevat artikkelit. (Tätä lukutehtävää ei tarvitse raportoida). Luettava materiaali on kunkin tapaamiskerran kohdalla, esimerkiksi nyt “2. Package-file-server. [...] Luettavaa: Karvinen 2018: Pkg-File-Service – Control Daemons with Salt..”
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

### H2c & H2e)

Asensin manuaalisesti paketin `libapache2-mod-php`, ja kävin kommentoimassa tarvittavat rivit pois tiedostosta `/etc/apache2/mods-available/php7.0.conf`. Kokeilin aiemmin tekemälläni sivulla PHP:n toimivuuden sekä yleisellä sivulla (`/var/www/html`) että käyttäjän kotisivulla (`~/public_html`), jonka jälkeen kopion muokatun asetustiedoston `/srv/salt` kansioon odottamaan käyttöä. Lisäsin aiempaan Apache-stateen PHP:n asennuksen ja asetustiedoston korvaamisen (sekä sen tarkistuksen palvelun uudelleenkäynnistystä varten).

Lisäsin myös samalla vakiosivun lisäyksen `/etc/skel`:iin, jotta uusilla käyttäjillä olisi valmiiksi toimiva testisivu. Määritin myös tämän kohdan luomaan kansiot niiden puuttuessa.

Valmis Apache-state näyttää tältä:

```
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

### H2d)

