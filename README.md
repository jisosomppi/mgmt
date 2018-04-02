# Salt-based centralized configuration management
**Jussi Isosomppi, 2018**

_This repository is a part of Haaga-Helia's Linux server management course, taught by Tero Karvinen. The course aims to teach students the proper use of centralized management, as well as the use of version control tools such as github.  
More info at [Tero Karvinen's home page.](http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-4-ti-5-ke-5-loppukevat-2018-5p)_

## Harjoitustehtävä H1

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

### c)
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

### d & f)
Lainasin Jori Laineen [LAMP-tilaa](https://github.com/joonaleppalahti/CCM/blob/master/salt/srv/salt/lamp.sls), koska se hoitaa aika kätevästi LAMPin käyttöönoton (asennus, vakiosivun korvaus omalla). Tein sen lisäksi oman testisivun, jossa testataan sekä Apachen että UTF-8:n toimivuus (ääkköset tekstissä ja laskutoimituksen arvon tulostus sivulle).

![screenshot2](https://raw.githubusercontent.com/jisosomppi/mgmt/master/2018-04-02%2021_16_53-Jussi's%20placeholder%20web%20page.png "Screenshot 2")

### e)
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
