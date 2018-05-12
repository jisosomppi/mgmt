---
ID: 434
post_title: Linux palvelimet, harjoitustehtävä 6
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2017/10/09/linux-palvelimet-harjoitustehtava-6/
published: true
post_date: 2017-10-09 07:36:09
---
Jussi Isosomppi, 9.10.2017

Tehtävä on osa Haaga-Helian Linux palvelimet -kurssia, jonka aikataulut sekä tehtävänannot löytyvät osoitteesta <a href="http://terokarvinen.com/2017/aikataulu-linux-palvelimet-ict4tn021-4-ti-ja-5-to-alkusyksy-2017-5-op">http://terokarvinen.com/.</a>
<blockquote>a) Kirjoita ja suorita “Hei maailma” kolmella kielellä. Asenna tarvittavat ympäristöt.

b) Palauta linkki sivuun, josta löytyvät kaikki kotitehtäväraporttisi. Arviointi tehdään ensisijaisesti tästä linkistä. Linkki voi olla esimerkiksi blogin etusivu (jos blogissa on vain kotitehtävät) tai sivuun, jossa on linkki kuhunkin kuuteen tehtävään.</blockquote>
Tällä kertaa tein tehtävät tuoreella Xubuntu 16.04.3 -virtuaalikoneella, jonka käytön aloitin komennolla <em>sudo apt-get update.</em> Ensimmäisenä koodiesimerkkinä tein yksinkertaisen bash-skriptin:

<img class="alignnone size-medium wp-image-435" src="http://jisosomppi.me/wp-content/uploads/2017/10/h6_1png-300x106.png" alt="" width="300" height="106" />

Toisena esimerkkinä tein saman koodin pythonilla:

<img class="alignnone size-medium wp-image-436" src="http://jisosomppi.me/wp-content/uploads/2017/10/h6_2-300x83.png" alt="" width="300" height="83" />

Kolmantena tein vielä ohjelman javascriptillä, jonka ajamiseen latasin node.js:än. Sen asentaminen vaati hieman työtä, mutta onnistui helposti <a href="https://nodejs.org/en/download/package-manager/">asennusohjeiden</a> avulla. Annoin siis seuraavat komennot:
<blockquote>curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs</blockquote>
Tämän jälkeen kirjoitin ja ajoin tiedoston helloworld.js seuraavasti:

<img class="alignnone size-medium wp-image-437" src="http://jisosomppi.me/wp-content/uploads/2017/10/h6_3-300x66.png" alt="" width="300" height="66" />
<h6>TÄTÄ DOKUMENTTIA SAA KOPIOIDA JA MUOKATA GNU GENERAL PUBLIC LICENSE (VERSIO 2 TAI UUDEMPI) MUKAISESTI. LISÄTIETOA: <a class="urlextern" title="http://www.gnu.org/licenses/gpl.html" href="http://www.gnu.org/licenses/gpl.html">HTTP://WWW.GNU.ORG/LICENSES/GPL.HTML</a></h6>