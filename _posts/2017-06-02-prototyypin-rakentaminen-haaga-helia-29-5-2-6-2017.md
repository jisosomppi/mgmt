---
ID: 54
post_title: >
  Prototyypin rakentaminen, Haaga-Helia
  29.5.-2.6.2017
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2017/06/02/prototyypin-rakentaminen-haaga-helia-29-5-2-6-2017/
published: true
post_date: 2017-06-02 11:02:39
---
<img class="alignnone size-full wp-image-63" src="http://46.101.223.159/wp-content/uploads/2017/06/img_20170602_104857.jpg" alt="pro-cam" width="700" height="528" />

Lopullinen prototyyppi

<strong>// <a href="http://jisosomppi.wordpress.com">Jussi Isosomppi</a> &amp; <a href="https://joonashaagaheliavalstalinuxpalvelimena.wordpress.com/">Joonas Valsta</a> // </strong>

Osallistuimme Tero Karvisen ohjaamalle Prototyypin rakentaminen -kurssille, jossa tavoitteena oli tehdä jokin sulautetun järjestelmän prototyyppi viikossa. Toteutukseen oli tarjolla mm. Arduino Uno ja ESP8266-12E -mikrokontrollereita, sekä lukuisia erilaisia sensoreita ja muita komponentteja.

<strong>Maanantai</strong>

Päätimme toteuttaa Arduinolla ohjatun aurinkosensorin ja sensorin avulla ohjattavan aurinkopaneeliasetelman. Idea kurssin työksi löytyi helposti, ja saimmekin myös heti sen toteuttamiseen tarvittavat komponentit. Valoisuustason mittaamiseen käytimme neljää LDR-sensoria (Light Dependent Resistor), joiden arvojen mukaan paneeli kääntyy aurinkoa kohti. Kytkennät tehtiin Arduinon Sensor Shieldiä käyttäen, jotta vältyttäisiin lukuisten hyppylankojen aiheuttamalta ns. ”johtospagetilta”.

<strong>Tiistai</strong>

[caption id="attachment_64" align="alignnone" width="700"]<img class="alignnone size-full wp-image-64" src="http://46.101.223.159/wp-content/uploads/2017/06/img_20170530_135710.jpg" alt="pro-cam" width="700" height="528" /> Tiistaina kasaan saatu betaversio[/caption]

Toisena päivänä saimme työstettyä koodin jo muotoon, jossa saimme sensorit seuraamaan kirkkainta valonlähdettä (testattu puhelimen taskulampulla). Koodiin lisättiin myöhemmin myös sallitut liikkumarajat aurinkopaneelille (aurinko ei paista Suomeen pohjoisesta tai suoraan ylhäältä päin). Koodi alustaa servot vakioasentoon ja aloittaa valoisuuden seurannan. Valoisuustasoja vertaamalla saadaan tietoon kirkkaimman valonlähteen (auringon) sijainti, jota kohti servot säätävät paneelia. Aloitimme projektin tukirakenteen suunnittelun sekä osien etsinnän. Projektiin hankittiin 2kpl Bilteman pihalampuista purettua aurinkopaneelia, joiden juotokset olivat kuitenkin valitettavasti niin huonolaatuisia, ettei suunniteltua jännitemittausta saatu toteutettua.

<strong>Keskiviikko</strong>

Kolmantena päivänä mittasimme olemassa olevat komponentit ja siirsimme mitat Blenderiin, jossa suunnittelimme tukirakenteen suoraan komponenttien oikeilla mitoilla. Tämän avulla vähennettiin teippailun ym. säätämisen tarvetta, sekä pienennettiin laitteen kokoa. Tukirakennetta suunnitellessa otettiin huomioon myös johtojen asettelu niin, ettei ääriasennoissakaan pitäisi tulla ongelmia johtojen pituuden takia. Johdot paketoitiin johtosuojiin sekä ulkonäön vuoksi, että kytkentöjen turvaamiseksi. Arduinolle ja Sensor Shieldille suunniteltiin kotelo, jotta lopullinen toteutus saataisiin siistin näköiseksi.

<strong>Torstai</strong>

<img class="alignnone size-full wp-image-65" src="http://46.101.223.159/wp-content/uploads/2017/06/img_20170602_104905.jpg" alt="pro-cam" width="700" height="528" />

Viimeisenä kokonaisena päivänä keskityimme lähinnä ongelmanratkaisuun, viimeistelyyn sekä 3D-tulostuksiin. Koodi muutettiin käyttämään tarkempia, itse määriteltyjä pulsseja helpomman ja epätarkemman servo.h -kirjaston sijaan. 3D-tulostetut osat viimeisteltiin ja kasattiin valmiiksi kokonaisuudeksi.

<strong>Perjantai</strong>

Projektien esittelypäivä! Aamupäivällä ehdimme vielä tehdä viimeistelyjä niin fyysisten osien kuin koodinkin parissa, sekä valmistella materiaaleja julkaisuun. Kurssista ja erityisesti omasta projektista voi olla tyytyväinen, sillä lopputuloksesta ei ihan heti arvaisi viikon rakennusaikaa.

<strong>Käytetyt osat</strong>
<ul>
 	<li>Arduino Uno R3</li>
 	<li>Arduino Sensor Shield</li>
 	<li>2x servo</li>
 	<li>4x LDR-valosensori</li>
 	<li>hyppylankoja</li>
 	<li>3D-tulostettu tukirakenne/kotelo</li>
 	<li>2kpl purettua pihavaloa (aurinkokennokäyttöisiä)</li>
</ul>
<strong>Kytkennät</strong>

LDR-sensorien arvoja luetaan Arduinon analogipinneistä 0-3, ja servoja ohjataan digitaalipinneillä 2 ja 3. Johdot on kytketty selkeyden vuoksi Arduinoon kiinnitettyyn Sensor Shieldiin. Erilisiä vastuksia toteutuksemme ei tarvitse, sillä käytämme Arduinon sisäänrakennettuja ylösvetovastuksia.
<ul>
 	<li>A0 – LDR vasen yläreuna</li>
 	<li>A1 – LDR oikea yläreuna</li>
 	<li>A2 – LDR vasen alareuna</li>
 	<li>A3 – LDR oikea alareuna</li>
 	<li>D2 – Servo vaakaliike</li>
 	<li>D3 – Servo pystyliike</li>
</ul>
<strong>Linkit</strong>

Koodimme löytyy täältä: <a href="https://github.com/jvalsta/Arduino-SunTrackingSolarPanel">https://github.com/jvalsta/Arduino-SunTrackingSolarPanel</a>

<strong>Lähteet</strong>

<a href="http://botbook.com">http://botbook.com</a>

<a href="http://sulautetut.fi">http://sulautetut.fi</a>

<a href="http://terokarvinen.com/2017/prototyypin-rakentaminen-bus4tn007-8-w22">http://terokarvinen.com/2017/prototyypin-rakentaminen-bus4tn007-8-w22</a>