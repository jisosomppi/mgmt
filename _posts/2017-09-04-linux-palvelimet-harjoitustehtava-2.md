---
ID: 105
post_title: Linux palvelimet, harjoitustehtävä 2
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2017/09/04/linux-palvelimet-harjoitustehtava-2/
published: true
post_date: 2017-09-04 00:46:23
---
Jussi Isosomppi, 3.9.2017

Tehtävä on osa Haaga-Helian Linux palvelimet -kurssia, jonka aikataulut sekä tehtävänannot löytyvät osoitteesta <a href="http://terokarvinen.com/2017/aikataulu-linux-palvelimet-ict4tn021-4-ti-ja-5-to-alkusyksy-2017-5-op">http://terokarvinen.com/.</a>
<blockquote><strong>a) Aiheuta lokiin kaksi eri tapahtumaa: yksi esimerkki onnistuneesta ja yksi esimerkki epäonnistuneesta tai kielletystä toimenpiteestä. Analysoi rivit yksityiskohtaisesti.</strong>

<strong>b) Vapaaehtoinen kohta, ei ole opetettu vielä: Asenna SSH-demoni. Kokeile omalla ssh-palvelimellasi jotain seuraavista: ssh-copy-id, sshfs, scp tai git. (Helpoin lienee scp: ‘scp foo.txt <a href="mailto:tero@example.com">tero@example.com</a>:’)</strong>

<strong>c) Tee unelmien apt-get -komento: yksi komentorivi, joka asentaa suosikkiohjelmasi.</strong>

<strong>d) Asenna komentokehotteen paketinhallinnasta kolme itsellesi uutta komentorivillä toimivaa ohjelmaa. Kokeile kutakin ohjelmaa sen pääasiallisessa käyttötarkoituksessa.</strong></blockquote>
Tämänkertainen harjoitusympäristö oli Windows 10:n Hyper-V:ssä pyörivä virtuaalinen Ubuntu 16.10-asennus, jota käytin suoraan Hyper-V:n virtuaali-KVM:n kautta. Tehtävien tekoon aikaa kului kolmisen tuntia (josta suurin osa asennusskriptin tekemiseen), raportin hiomiseen tunnin verran lisää. Harjoituksen aluksi ajoin luonnollisesti komennot <em>sudo apt-get update </em>ja <em>sudo apt-get upgrade</em>, joilla päivitin hetken käyttämättömänä olleen Ubuntu-asennuksen ajan tasalle.

<!--more-->
<h2><strong>a)</strong></h2>
Kaikki lokimerkinnät alkavat samalla kaavalla: ensin kerrotaan aika muodossa <em>kk pv hh:mm:ss</em>, jonka jälkeen tarkennetaan komennon alkuperää tietokoneen ja käyttäjän nimillä.
<h4><strong>Onnistunut sovelluksen asentaminen</strong></h4>
Annettu komento:
<blockquote><em>sudo apt-get install -y nethack-console</em></blockquote>
<em>Sep  3 16:13:47 scrw-Virtual-Machine sudo:     scrw : TTY=pts/6 ; PWD=/home/scrw ; USER=root ; COMMAND=/usr/bin/apt-get install -y nethack-console</em>

<em>Sep  3 16:13:47 scrw-Virtual-Machine sudo: pam_unix(sudo:session): session opened for user root by (uid=0)</em>

Ylläolevat rivit tulostuvat lokiin välittömästi oikean salasanan syöttämisen jälkeen. Ennen autentikointiyrityksen ratkeamista lokimerkintää ei siis synny. Ensimmäinen rivi täsmentää komennon, jolla sudo-oikeuksia on pyydetty. Toinen viesti kertoo autentikoinnin onnistuneen, ja kertoo myös mille terminaali-ikkunalle oikeudet on myönnetty (<em>uid=0</em>).

<em>Sep  3 16:13:52 scrw-Virtual-Machine sudo: pam_unix(sudo:session): session closed for user root</em>

Tämä viesti tulostuu lokiin, kun oikeudet saanut komento on valmis.
<h4><strong>Väärä salasana asentaessa</strong></h4>
Annettu komento:
<blockquote><em>sudo apt-get install -y gimp</em></blockquote>
<em>Sep  3 16:42:09 scrw-Virtual-Machine sudo: pam_unix(sudo:auth): authentication failure; logname= uid=1000 euid=0 tty=/dev/pts/6 ruser=scrw rhost=  user=scrw</em>

Tämä viesti kertoo, että sudo-oikeuksia on pyydetty väärällä salasanalla. Virhesyötön tai murtoyrityksen jäljet tallentuvat lokiin, ja sisältävät tarvittavat tiedot yrittäjän tunnistamiseen.

<em>Sep  3 16:42:19 scrw-Virtual-Machine sudo: pam_unix(sudo:auth): auth could not identify password for [scrw]</em>

Tämä viesti kertoo, ettei oikeaa salasanaa syötetty yrityksistä huolimatta.

<em>Sep  3 16:42:19 scrw-Virtual-Machine sudo:     scrw : 2 incorrect password attempts ; TTY=pts/6 ; PWD=/home/scrw ; USER=root ; COMMAND=/usr/bin/apt-get install gimp</em>

Tämä viesti tulostuu samaan aikaan edellisen kanssa, ja antaa vielä kerran yhteenvedon virhesyötöstä. Tässä viestissä näkyy aiemman lisäksi myös virhesyöttöjen määrä.
<h2><strong>b)</strong></h2>
SSH-serverin asennukseen käytin täältä löydettyjä ohjeita: <a href="http://ubuntuhandbook.org/index.php/2016/04/enable-ssh-ubuntu-16-04-lts/">http://ubuntuhandbook.org/index.php/2016/04/enable-ssh-ubuntu-16-04-lts/</a>

Aloitin siis asennuksen etsimällä <em>apt-cache search</em>illa oikean paketin, jonka asensin komennolla <em>sudo apt-get install -y openssh-server</em>. Asennus sujui ilman vastoinkäymisiä tai virheviestejä. Tarkistin asentumisen komennolla <em>sudo service ssh status</em>, joka näyttää ssh-palvelun tilan, jos se on käynnissä. Kuvankaappaus komennon tulostuksesta alla:

<img class="alignnone size-full wp-image-116" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot-from-2017-09-03-20-38-09.png" alt="Screenshot from 2017-09-03 20-38-09" width="734" height="438" />

SSH-palvelimen asetuksia pääsee vaihtamaan muokkaamalla tiedostoa /etc/ssh/sshd_config (<em>sudo nano </em>tai <em>sudo gedit + </em>tiedostopolku). Tiedostossa määritetään mm. portti, jonka kautta yhteydet muodostetaan sekä autentikointiavainten voimassaoloaika.

<img class="alignnone size-full wp-image-117" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot-from-2017-09-03-20-58-20.png" alt="Screenshot from 2017-09-03 20-58-20" width="900" height="744" />

Tarkistin asennuksen onnistumisen selvittämällä koneen ip-osoitteen komennolla <em>ip addr show. </em>Tämän jälkeen siirryin takaisin Windowsiin, johon asennetulla Puttyllä yhdistin tuohon saamaani osoitteeseen. Putty pyysi vielä varmistuksen vahvistamattomaan sertifikaattiin luottamiesta, jonka jälkeen ssh-kirjautumisruutu ilmestyi näkyviin. Kirjautuminen Ubuntu-virtuaalikoneen tunnuksilla onnistui, joten asennus oli toimiva.

<img class="alignnone size-full wp-image-113" src="http://46.101.223.159/wp-content/uploads/2017/09/2017-09-03-21_54_55-scrwscrw-virtual-machine_.png" alt="2017-09-03 21_54_55-scrw@scrw-Virtual-Machine_ ~" width="661" height="418" />

Kokeilin myös tiedoston siirtoa scp:llä tekemällä kokeeksi tiedoston ja siirtämällä sen paikallisesta terminaalista scp-yhteydellä toiseen kansioon. Vaikein osuus tätä tehtävää oli tiedostopolkujen oikein kirjoittaminen, mutta lopuksi kuitenkin toteutus näyttää erittäinkin siistiltä. Tuloksen hahmottamiseksi asensin treen, jolla sain lähteen ja kohteen näkymään helposti samaan aikaan.

<img class="alignnone size-full wp-image-118" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot-from-2017-09-03-21-18-03.png" alt="Screenshot from 2017-09-03 21-18-03" width="824" height="455" />

SCP-komennon perusrakenne on seuraava: <em>scp lähde kohde</em>. Jos scp-kohde tai -lähde on salasanasuojattu, syötetään annetun käyttäjän salasana tämän komennon jälkeen pyydettäessä.
<h2>c)</h2>
Omaan unelmien ohjelmakombooni kuuluvat kuvaeditori GIMP, pikaviestin-/VOIP-sovellus Discord sekä musiikkipalvelu Spotify.

Hankalien asennusten vuoksi jouduin etsimään hieman apua, ja osoitteesta <a href="https://askubuntu.com/a/539293">https://askubuntu.com/a/539293</a> löytyvä cheat sheet osoittautui erittäinkin hyväksi apuvälineeksi komentojen yhdistelyssä.
<blockquote>A; B    Run A and then B, regardless of success of A

A &amp;&amp; B  Run B if A succeeded

A || B  Run B if A failed

A &amp;     Run A in background.</blockquote>
Spotifyn Linux-asennusohjeet näyttävät seuraavalta:
<blockquote># 1. Add the Spotify repository signing keys to be able to verify downloaded packages

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410

# 2. Add the Spotify repository

echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# 3. Update list of available packages

sudo apt-get update

# 4. Install Spotify

sudo apt-get install spotify-client</blockquote>
Joten yhdistetään nämä muotoon:
<blockquote>sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410 <strong>&amp;&amp;</strong> echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list <strong>&amp;&amp;</strong> sudo apt-get install -y spotify-client</blockquote>
Gimpin asennus onnistuu yksinkertaisesti paketinhallinnasta komennolla
<blockquote><em>sudo apt-get install -y gimp</em>.</blockquote>
Discordin asennus taas on hieman vaativampi, mutta onnistuu kuitenkin komentokehotteen kautta:
<blockquote><em>cd ~/Downloads</em>

<em>wget -O discord-0.0.1.deb https://discordapp.com/api/download?platform=linux&amp;format=deb</em></blockquote>
Paketin latautumisen jälkeen asennetaan se komennolla:
<blockquote><em>sudo dpkg -i discord-0.0.1.deb</em></blockquote>
Nämä komennot saa leivottua helposti yhteen:
<blockquote><em>cd ~/Downloads <strong>&amp;&amp;</strong> wget -O discord-0.0.1.deb "<a href="https://discordapp.com/api/download?platform=linux&amp;format=deb">https://discordapp.com/api/download?platform=linux&amp;format=deb"</a> <strong>&amp;&amp;</strong> sudo dpkg -i discord-0.0.1.deb</em></blockquote>
Nämä kolme asennusta saa niputettua yhteen seuraavasti:
<blockquote>#!/bin/sh

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410 <strong>&amp;&amp;</strong> echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list <strong>&amp;&amp;</strong> sudo apt-get update &amp;&amp; sudo apt-get install -y spotify-client <em>gimp</em> <strong>&amp;&amp;</strong> cd ~/Downloads <strong>&amp;&amp;</strong> wget -O discord-0.0.1.deb “<a href="https://discordapp.com/api/download?platform=linux&amp;format=deb">https://discordapp.com/api/download?platform=linux&amp;format=deb</a>” <strong>&amp;&amp;</strong> sudo dpkg -i discord-0.0.1.deb</blockquote>
Ylläolevan komentosarjan voi tallentaa tiedostoon (itsellä install.sh), jonka jälkeen se on helppo siirtää toiseen asennukseen tai ajaa komentoriviltä. Tiedostolle on annettava vielä suoritusoikeus (<em>chmod +x install.sh)</em>. Tämän jälkeen skriptin voi ajaa komennolla <em>sh install.sh. </em>Komento pyöri loppuun asti, mutta antoi virheviestin Discordin asentumisesta.

<img class="alignnone size-full wp-image-157" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-04_00-06-36.png" alt="Screenshot_2017-09-04_00-06-36" width="579" height="384" />

Discord ei käynnisty kunnolla, vaan jättää pelkän harmaan ruudun näytölle. Virheviestien mukaan kyse on puuttuvista paketeista, jotka kuitenkin asentuivat ilmaisinalueelle ilmestyneestä ”Distribution Upgrade” -napista. Uudelleenkäynnistyksen jälkeen myös Discord toimi oikein.

&nbsp;
<h4>Tärkeimmät huomiot pitkästä hienosäädöstä:</h4>
Pakettilistaus on päivitettävä uuden repon lisäyksen jälkeen! Discordin asennuspaketin osoitteessa on &amp;-merkki, joka tulkitaan skriptissä erottajaksi; tämä vältetään lainausmerkeillä.
<h2> d)</h2>
Asensin jo ylempänä Nethackin (<em>sudo apt-get install -y</em> <em>nethack-console</em>)<em>,</em> tekstipohjaisen seikkailun, joka loistaa ajattomalla karulla charmillaan. Kuten viime tunnilla varoitettiin, tämä peli vie aikaa juuri niin paljon kuin sitä on.

Lisäksi asensin tälläkin kerralla treen (<em>sudo apt-get install -y tree</em>), joka tarjoaa hakemistorakenteita erittäin selvässä visuaalisessa muodossa. Tälläkin kerralla selvästä rakenteesta oli höytyä, kun tutustuin scp:n käyttöön.

Asensin myös taas pitkästä aikaa Irssin (<em>sudo apt-get install -y irssi</em>), terminaalipohjaisen IRC-clientin. Allaolevassa kuvassa on listattu irssin komennot, joiden opetteleminen vei taas oman aikansa.

<img class="alignnone size-full wp-image-158" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-04_00-38-59.png" alt="Screenshot_2017-09-04_00-38-59" width="579" height="384" />

&nbsp;
<h6>TÄTÄ DOKUMENTTIA SAA KOPIOIDA JA MUOKATA GNU GENERAL PUBLIC LICENSE (VERSIO 2 TAI UUDEMPI) MUKAISESTI. LISÄTIETOA: <a class="urlextern" title="http://www.gnu.org/licenses/gpl.html" href="http://www.gnu.org/licenses/gpl.html">HTTP://WWW.GNU.ORG/LICENSES/GPL.HTML</a></h6>