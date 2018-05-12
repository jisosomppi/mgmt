---
ID: 69
post_title: Linux palvelimet, harjoitustehtävä 1
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2017/08/23/linux-palvelimet-harjoitustehtava-1/
published: true
post_date: 2017-08-23 21:48:17
---
Jussi Isosomppi, 23.8.2017

Tehtävä on osa Haaga-Helian Linux palvelimet -kurssia, jonka aikataulut sekä tehtävänannot löytyvät osoitteesta <a href="http://terokarvinen.com/2017/aikataulu-linux-palvelimet-ict4tn021-4-ti-ja-5-to-alkusyksy-2017-5-op">http://terokarvinen.com/.</a>
<blockquote><em>a) Tee oma Linux-livetikku. Kokeile sitä jossain muussa kuin koulun koneessa. Tämä kohta ei edellytä asentamista – jos kuitenkin asennat, ota ensin varmuuskopiot.
</em>

<em>b) Listaa testaamasi koneen rauta (‘sudo lshw -short -sanitize’).</em>

<em>c) Asenna kolme itsellesi uutta ohjelmaa. Kokeile kutakin ohjelmaa sen pääasiallisessa käyttötarkoituksessa.</em>

<em>d) Mitä lisenssiä kukin näistä ohjelmista käyttää? Selitä lyhyesti, mitä oikeuksia ja velvolisuuksia tuosta lisenssistä seuraa.</em>

<em>d) Listaa käyttämäsi ohjelmat (esim. MS Word), kunkin ohjelman käyttötarkoitus (esim. Tekstinkäsittely) ja vastaava vapaa Linux-ohjelma (esim. LibreOffice Writer). Jos johonkin tarkoitukseen ei löydy vapaata Linux-ohjelmaa, listaa sekin.</em>

<em>f) Vapaaehtoinen lisätehtävä: varmuuskopioi tiedostosi (voit käyttää esimerkiksi ulkoista USB-levyä)</em></blockquote>
<!--more-->

a) Poltin tuoreimman Xubuntun (16.04.3 LTS) 16-gigaiselle USB-tikulle käyttäen omaa suosikkiani <a href="https://etcher.io/">Etcheriä (Windows, Linux, MacOS, toimii myös ilman asennusta!)</a>. Tikku toimi ensimmäisellä kerralla, toisin kuin kolmesti epäonnistunut UnetBootinilla tehty. Omalla läppärillä (Fujitsu Lifebook P772) boottivalikkoon pääsi painamalla F12:ta (vaikkakin USB-asema oli jo valmiiksi boottijärjestyksen kärjessä). GRUB latautui suoraan, ja kokeilutilaan pääsi liiempiä odottelematta.

b) Terminaliin syötetty komento “sudo lshw -short -sanitize” tulostaa kattavan listan koneen laitteistosta. Listasta paljastuvat käytännössä kaikki koneen komponentit, sekä niiden tyypit   ja väylät, joihin ne on kytketty.

<img class="alignnone size-full wp-image-75" src="http://46.101.223.159/wp-content/uploads/2017/08/asdasdasd.png" alt="asdasdasd" width="1280" height="800" />

c) Ensimmäiseksi ohjelmaksi valitsin kehutun AutoKeyn, jolla voidaan määrittää näppäinoikoteihin valmiita makroja. Näin vaikkapa salasanan tai allekirjoituksen saa täytettyä yhdellä painalluksella automaattisesti. Ohjelma asentuu terminalin kautta komennolla “sudo apt-get install -y autokey-qt”. Kyseinen qt-versio sisältää graafisen käyttöliittymän, joka löytyy sovellusvalikosta. Asennuksen ja omien lauseiden lisäämisen jälkeen ohjelmaa voi käyttää vaikka LibreOfficessa (oletus: ctrl-F7). Tallennetut tekstit löytyvät nopeasti avautuvasta pikavalikosta. Esimerkiksi monirivisen oman osoitteenkin saa helposti lisättyä tiedostoon.

Toiseksi ohjelmaksi valitsin Gnome Disk Utilityn (“sudo apt-get install -y gnome-disk-utility”), joka tunnilla nopeasti nähtynä vaikutti erittäin toimivalta Linux-pohjaiselta vaihtoehdolta live-tikkujen luomiseen. Asennuksen jälkeen ohjelma löytyy ohjelmavalikosta nimellä “Disks”. Loin työkalua käyttäen uuden Xubuntu -livetikun, joka toimi täysin samalla tavalla kuin aiempi, Windows 10:ssä Etcherillä luotu.

Kolmanneksi valitsin GIMPin, koska Xubuntusta vaikuttaa puuttuvan kuvaeditori.  Asennuksessa kesti hetken, kun eri paketit latautuivat. “apt-cache search gimp” -komennolla etsimällä ja tuloksista  arvaamalla asennuskomennoksi löytyi “sudo apt-get install -y gimp”, joka vaikutti olevan oikea vaihtoehto. Ohjelmavalikosta löytyvä GIMP tuntuu ensikertalaisen käsissä vähintäänkin riittävän monipuoliselta.

d) AutoKey &amp; GIMP – GNU GPLv3 – ohjelmaa saa käyttää, jakaa ja muokata käytännössä täysin vapaasti. GPL kuitenkin määrittää, että ohjelman mukana on tarjottava joko lähdekoodi tai selvät ohjeet sen hankkimiseen. Lisenssiä ei saa myöskään muuttaa tai poistaa, vaan myös muokatun version on käytettävä GPL-lisenssiä.

Gnome Disk Utility  - LGPL v2+  - LGPL -koodia saa liittää myös ei-vapaan koodin yhteyteen, eikä vapautta linkitetyn koodin käyttöön taata. Näin LGPL-lisensoitua koodia voidaan käyttää mm. suljetuissa sovelluksissa.

e)

Steam                                                  Myös Linuxille, osa peleistä toimi

Battle.net (Blizzard client)              Ei tukea :(

Discord                                               Myös Linuxille!

Chrome                                               Chromium

Spotify                                                 Löytyy Linuxille <a href="https://www.spotify.com/fi/download/linux/">(vaatii pientä kikkailua)</a>

MS Office 365                                     LibreOffice (varauksella)

Notepad++                                          notepadqq, Sublime Text

paint.net                                              GIMP

Greenshot                                           Vain Windows ja MacOS

OpenRCT2                                           Myös Linuxille!

WinDirStat                                          Baobab (Disk Usage Analyzer)

WinSCP                                                Filezilla

f) Päivitin aiemman varmuuskopion tärkeistä tiedostoista käyttäen Windows 10:n omaa työkalua. Lisäksi kaikki vanhat valokuvat, videot, kirjoitukset jne. olivat jo ennestään turvattuna kahteen kertaan (Ulkoinen kovalevy sekä muistitikku, kiinni kytketyn kovalevyn lisäksi). Tarkoituksena on siirtää valtaosa mediasta omalta koneelta kotiserverille RAID1 -kokoonpanoon, ja ajastaa siirrot pöytäkoneelta automaattisiksi. Nämä toki offline-varmuuskopioiden lisäksi.
<h2></h2>
&nbsp;
<h6>Tätä dokumenttia saa kopioida ja muokata GNU General Public License (versio 2 tai uudempi) mukaisesti. Lisätietoa: <a class="urlextern" title="http://www.gnu.org/licenses/gpl.html" href="http://www.gnu.org/licenses/gpl.html">http://www.gnu.org/licenses/gpl.html</a></h6>