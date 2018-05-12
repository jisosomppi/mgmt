---
ID: 168
post_title: Linux palvelimet, harjoitustehtävä 3
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2017/09/12/linux-palvelimet-harjoitustehtava-3/
published: true
post_date: 2017-09-12 21:26:27
---
Jussi Isosomppi, 8.9.2017

Tehtävä on osa Haaga-Helian Linux palvelimet -kurssia, jonka aikataulut sekä tehtävänannot löytyvät osoitteesta <a href="http://terokarvinen.com/2017/aikataulu-linux-palvelimet-ict4tn021-4-ti-ja-5-to-alkusyksy-2017-5-op">http://terokarvinen.com/.</a>
<blockquote>a) Asenna Apache, laita käyttäjien kotisivut (http://example.com/~tero) toimimaan. Testaa esimerkkikotisivulla. <em>Tämä a-kohta on vaihdettu.</em>

b) Surffaa oman palvelimesi weppisivuja. Etsi Apachen lokista esimerkki onnistuneesta (200 ok) sivulatauksesta ja epäonnistuneesta (esim 404 not found) sivulatauksesta. Analysoi rivit.

<em>Tee jokin seuraavista (yksi riittää, useampi vapaaehtoisena lisätehtävänä):</em>

c) Tee virhe weppipalvelimella ajettavaan koodiin (esim PHP tai Python), etsi se lokista ja analysoi tuo lokirivi

d) Tee virhe johonkin Apachen asetustiedostoon, etsi ja analysoi tuo rivi. Etsimiseen sopivat esimerkiksi Apachen omat lokit, syslog sekä ‘apache2ctl configtest’.

e) Asenna ja kokeile PhpMyAdmin:a tai jotain muuta valmista weppiliittymää tietokantojen hallinnointiin.

f) Tee palvelimella ajettava weppiohjelma, joka tekee käyttäjälle jonkin yksinkertaisen laskun (esim. painoindeksi BMI)

g) Tee palvelimella ajettava weppiohjelma, joka käyttää tietokantaa. Voit tehdä jonkin yksinkertaisen CRUD-ohjelman, esimerkiksi TODO-listan

h) Tee Apachelle uusi sivu, joka näkyy suoraan palvelimen pääsivulla, mutta jonka sivuja voi muokata normaalin käyttäjän oikeuksilla (name based virtual host, DocumentRoot käyttäjän kotihakemistoon).

i) Kuinka monta eri HTTP Status:ta (200, 404, 500…) saat aiheutettua lokeihin? Selitä, miten aiheutit tilanteet ja analysoi yksi rivi kustakin statuksesta.

j) Asenna LAMP (Linux, Apache, MySQL, PHP). Testaa kunkin komponentin toiminta. Testaa lopuksi kokonaisuus. (Voit aloittaa tilanteesta, jossa Linux-käyttöjärjestelmä on jo asennettu, mutta ei muita (AMP) osia.

k) Kokeile jotain Flaskin uutta ominaisuutta flask-testipalvelimessa. Voit kokeilla esim. muotteja (templates), tietokantaa tai syötteiden ottamista lomakkeilta (forms).

l) Asenna Python Flask + PostgreSQL + Apache mod WSGI. Testaa kunkin komponentin toiminta. Testaa lopuksi kokonaisuus. (vaikea)</blockquote>
Tällä kertaa asensin Hyper-V:lle Xubuntun version 17.04, jonka päivitin heti aluksi uusimpiin versioihin komennoilla <em>sudo apt-get update </em>ja <em>sudo apt-get upgrade</em>.
<h2>a)</h2>
Asensin Apache2:n komennolla <em>sudo apt-get install -y apache2</em>, jonka jälkeen tarkistin asennuksen onnistuneen menemällä selaimella osoitteeseen <em>http://localhost/</em>, jossa Apachen testisivu näkyi kuten pitikin. Tämän jälkeen loin itselleni kotisivuhakemiston komennolla <em>mkdir /home/jussi/public_html</em>, ja otin käyttöön käyttäjäkohtaiset kotisivut komennolla <em>sudo a2enmod userdir</em>. Tämän jälkeen käynnistin Apachen uudelleen komennolla <em>sudo service apache2 restart</em>.

Tämän jälkeen siirryin selaimella osoitteeseen <em>http://localhost/~jussi</em>, joka tarjosi näkyviin tyhjän hakemiston. Siirryin public_html -hakemistoon, johon loin uuden tiedoston komennolla <em>nano index.html</em>, ja kirjoitin tiedostoon "Hello world!". Tiedoston tallentamisen (CTRL-X, Y, Enter) jälkeen päivitin sivun <em>http://localhost/~jussi</em> selaimessa, ja näin kirjoittamani viestin.

<img class="alignnone size-full wp-image-249" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-10_21-40-21-e1505240146879.png" alt="Screenshot_2017-09-10_21-40-21" width="576" height="137" />
<h2>b &amp; i)</h2>
HTTP-koodien rakenne on melko selkeä ja yksinkertainen:

<img class="alignnone size-full wp-image-246" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-10_21-40-06.png" alt="Screenshot_2017-09-10_21-40-06" width="1105" height="57" />
<ol>
 	<li>Sivua pyytäneen koneen IP-osoite</li>
 	<li>Serverin kellonaika pyynnön saapuessa</li>
 	<li>Saatu pyytö (GET) ja sisältö, johon se kohdistuu</li>
 	<li>HTTP-statuskoodi</li>
 	<li>Sisällön koko, tavua</li>
 	<li>Pyynnön välittänyt sivu (jos suora pyyntö, näkyy vain "-")</li>
 	<li>Käyttäjän tiedot (Selain, käyttöjärjestelmä, järjestelmäarkkitehtuuri...)</li>
</ol>
Osoitteen <em>http://localhost/ </em>lataaminen tuottaa lokiin (<em>tail -F /var/log/apache2/access-log</em>) HTTP-koodin 200 (OK) sekä itse sivulle, että sille sijaitsevalle Ubuntu-logolle.

<img class="alignnone size-full wp-image-256" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-10_21-42-31.png" alt="Screenshot_2017-09-10_21-42-31" width="1137" height="42" />

Sivun päivittäminen selaimessa tarkistaa palvelimelta, onko sisältö muuttunut. Koska ei ole, päivitys palauttaa koodin 304 (Unchanged).

Jos yritän ladata olematonta sivua, saan vastaukseksi virheilmoituksen ja koodin 404 (Not Found).

<img class="alignnone size-full wp-image-253" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-10_21-53-32.png" alt="Screenshot_2017-09-10_21-53-32" width="576" height="244" />

Kielletyn sivun tai kansion latausyritys taas johtaa koodiin 403 (Forbidden).

<img class="alignnone size-full wp-image-254" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-10_21-53-38.png" alt="Screenshot_2017-09-10_21-53-38" width="576" height="246" />
<h2>d)</h2>
Tein pienen muutoksen tiedoston Apachen asetuksiin komennolla <em>sudoedit /etc/apache2/apache2.conf</em>, vaihdoin arvon ${APACHE_RUN_DIR} muotoon ${APACHE_RUN_DIRt}. Kyseinen arvo määrittää Apachen päähakemiston, ja sen muuttaminen ja palvelun uudelleenkäynnistys (<em>sudo service apache2 restart</em>) johtikin Apachen täyteen hajoamiseen.

Virhe näkyy ainakin Xubuntun syslogissa (<em>/var/log/syslog</em>):

<img class="alignnone size-full wp-image-259" src="http://46.101.223.159/wp-content/uploads/2017/09/screenshot_2017-09-10_22-56-01.png" alt="Screenshot_2017-09-10_22-56-01" width="1134" height="143" />

&nbsp;
<h6>TÄTÄ DOKUMENTTIA SAA KOPIOIDA JA MUOKATA GNU GENERAL PUBLIC LICENSE (VERSIO 2 TAI UUDEMPI) MUKAISESTI. LISÄTIETOA: <a class="urlextern" title="http://www.gnu.org/licenses/gpl.html" href="http://www.gnu.org/licenses/gpl.html">HTTP://WWW.GNU.ORG/LICENSES/GPL.HTML</a></h6>