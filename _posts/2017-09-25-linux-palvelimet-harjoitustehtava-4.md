---
ID: 266
post_title: Linux palvelimet, harjoitustehtävä 4
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2017/09/25/linux-palvelimet-harjoitustehtava-4/
published: true
post_date: 2017-09-25 22:50:53
---
Jussi Isosomppi, 25.9.2017

Tehtävä on osa Haaga-Helian Linux palvelimet -kurssia, jonka aikataulut sekä tehtävänannot löytyvät osoitteesta <a href="http://terokarvinen.com/2017/aikataulu-linux-palvelimet-ict4tn021-4-ti-ja-5-to-alkusyksy-2017-5-op">http://terokarvinen.com/.</a>
<blockquote>1a) Kokeile julkista virtuaalipalvelinta (VPS). Voit vuokrata palvelimen esimerkiksi Linodelta, Amazonilta, DigitalOceanilta, OVH:lta tai monista muista paikoista. Edullisinta on käyttää GitHub Education -paketista DigitalOceanin palveluita.

Vaihtoehto: jos et jostain syystä halua vuokrata virtuaalipalvelinta, voit kokeilla tehdä testipalvelimen vagrantilla, mutta tämä ei ole yhtä jännittävää.

1b) Laita julkinen domain-nimi osoittamaan koneeseesi. NameCheap ja Gandi ovat tunnettuja nimien vuokraajia. GitHub Education -paketista saa NameCheapilta .me domainin ilmaiseksi vuodeksi.

1c) Laita julkiselle palvelimellesi käyttäjän kotihakemistoon tallennettu sivu näkymään <a href="http://terokarvinen.com/2016/new-default-website-with-apache2-show-your-homepage-at-top-of-example-com-no-tilde">Apachen oletussivuna</a>.

1d) Etsi julkisen palvelimesi lokeista esimerkkejä murtautumisyrityksistä. Voit etsiä lisätietoa IP-osoitteista ottamatta niihin yhteyttä esimerkiksi komennoilla geoiplookup tai whois.
<div>

Vapaaehtoisia lisätehtäviä:

1e) Laita monta DNS-nimeä samaan IP-osoitteeseen. (Apache Name Based Virtual Hosting)

1f) Asenna WordPress. Se on maailman suosituin sisällönhallintajärjestelmä (CMS). Samalla opit asentamaan kolmannen osapuolen valmiita PHP-ohjelmia. WordPress kannattaa asentaa wordpress.org:sta löytyvästä tervapallosta (.tar.gz).

1g) Kokeile WordPressia kirjoittamalla esimerkkisisältöä.

WordPress vapaaehtoisia:

2a) Ota järkevät URLit (permalinks) käyttöön
2b) Vaihda teema
2c) Varmuuskopioi sisältö
2d) Palauta varmuuskopioitu sisältö puhtaaseen WordPress-asennukseen
2e) Tee WordPressiin oma teema
2f) Asenna WordPressiin plugin (esim Dofollow)
2g) Tee WordPressiin oma plugin
2h) Lisää kuvia WordPressiin (ja laita tämä toimimaan)
2i) Laita WordPress nimipohjaiseen virtuaalipalvelimeen (<a href="http://thello.foo/">http://thello.foo</a> tms)

Muita vapaaehtoisia:

3a) Asenna Drupal ja kokeile sitä
3b) Asenna Joomla ja kokeile sitä
3c) Hanki virallinen, selainten hyväksymä TLS-sertifikaatti Let’s Encryptistä
3d) Vaikea: Tee esimerkkisivu Python Flaskilla
3e) Vaikea: Tee esimerkkisivu Ruby on Rails (tuotantotyyppinen, ei pelkkä yhden käyttäjän testipalvelin)
3f) Vaikea: Tee esimerkkisivu Python Django:lla (tuotantotyyppinen, ei pelkkä yhden käyttäjän testipalvelin)

</div></blockquote>
Tämänkertainen testiympäristo oli DigitalOceanin palvelimella pyörivä Ubuntu 16.04.3 -asennus, jota käytin SSH-yhteyden yli PuTTYllä.
<h2>1a</h2>
Aloitin viikon tehtävät hankkimalla oman virtuaalipalvelimen ja domainin. Palvelimeksi valitsin DigitalOceanin halvimman vaihtoehdon, jonka  kuitenkin pitäisi olla vähintäänkin riittävä tämänhetkisiin tarpeisiini. DigitalOceanilta sai GitHub Education -paketin kautta 50$ käyttövaraa, mutta tilin aktivointi vaati joko luottokortin tiedot tai 5$ alkumaksun PayPalin kautta.

Otin yhteyden virtuaalipalvelimeen PuTTY:n avulla, käyttäen DigitalOceanin sivuilta löytyvää IP-osoitetta ja sähköpostilla tullutta rootin salasanaa. Otin ensimmäiset askeleet palvelimen suojaamiseksi ei-toivotuilta vierailta seuraamalla <a href="http://terokarvinen.com/2017/first-steps-on-a-new-virtual-private-server-an-example-on-digitalocean">Tero Karvisen ohjeita</a>, eli otin palomuurin käyttöön, loin itselleni uuden käyttäjätunnuksen, poistin root-tunnuksen salasanan ja SSH-kirjautumisen käytöstä sekä tietysti myös päivitin koneen ohjelmiston. Lisäsin myös jo valmiiksi palomuuriin mainitun poikkeuksen Apachea varten, eli <em>sudo ufw allow 80/tcp</em>.
<h2>1b</h2>
Domainiksi otin halvimman vaihtoehdon, eli myöskin GitHub Education -paketissa tarjotun, ilmaisen .me -domainin vuodeksi NameCheapilta. Domainin rekisteröinti oli todella helppoa, ja käyttäjän WHOIS-tietojen suojaus kuuluu automaattisesti domainiin.

Domainin aliosoitteiden ohjaus ulkoisiin sivuihin oli myöskin helppoa, ja ohjaukset vaikuttivat toimivan aika lailla välittömästi. Tein heti aluksi ohjaukset omalle WordPress -sivulleni (ei itse hostatulle), virtuaalipalvelimelle sekä omaan LinkedIn -profiiliini. Tarkoituksena siis luoda joitain oman nettisivun vaatimia linkityksiä valmiiksi.

Päädomainin antaminen omalle palvelimelle osoittautui huomattavasti haastavammaksi. Eniten päänvaivaa aiheutti juurikin tähän tilanteeseen tarkoitettu <a href="https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars">DigitalOceanin oma ohje</a>, joka on kirjoitettu vuonna 2012, jossa ilmeisesti kuvataan jotakin NameCheapin vanhaa käyttöliittymäversiota.

Löysin kuitenkin lopulta tilanteeseen vaaditut asetukset, yhdistellen <a href="https://www.digitalocean.com/community/tutorials/how-to-set-up-a-host-name-with-digitalocean">DigitalOceanin yleisohjetta</a> sekä <a href="https://www.namecheap.com/support/knowledgebase/article.aspx/767/10/how-can-i-change-the-nameservers-for-my-domain">NameCheapin ohjetta</a>. NameCheapin domain-asetuksista piti valita käyttöön Custom DNS, jonka jälkeen pyydetyiksi nimipalvelimiksi asetetaan DigitalOceanin nimipalvelimet (ns1, ns2, ns3.digitalocean.com). Tämän jälkeen DNS-palvelimen asetuksia hallitaan DigitalOceanin sivuilta.

<img class="alignnone size-full wp-image-344" src="http://46.101.223.159/wp-content/uploads/2017/09/h4_1.png" alt="h4_1" width="498" height="162" />

Domainin siirtyminen toisen tahon haltuun saattaa kuitenkin kestää jopa viisi päivää, joten en valitettavasti päässyt vielä toistaiseksi näkemään toimintaa käytännössä.
<h2>1c</h2>
Tätä kohtaa varten asensin ensin Apachen (<em>sudo apt-get install -y apache2</em>), otin käyttöön käyttäjien kotisivut (<em>a2enmod userdir</em>) ja loin kyseiseen hakemistoon (<em>/home/jussi/public_html</em>) perinteisen "Hello World!" sisältöisen index.html tiedoston. Tämän jälkeen suuntasiin muokkaamaan Apachen asetuksia, eli <em>cd</em> <em>/etc/apache2/sites-enabled/</em>, jossa annoin komennon <em>sudo nano 000-default.conf</em>, jolla pääsin tarkastelemaan Apachen vakioasetuksia.

<img class="alignnone size-full wp-image-393" src="http://46.101.223.159/wp-content/uploads/2017/09/h4_2.png" alt="h4_2" width="328" height="179" />

Toinen kohta alun kommentoitujen ohjeiden jälkeen on <em>DocumentRoot</em>, joka osoittaa vakioasetuksilla kansioon <em>/var/www/html/</em>. Kun tähän tilalle vaihtaa oman kotihakemiston (<em>/home/jussi/public_html/</em>) ja käynnistää palvelun uudelleen (<em>sudo service apache2 restart</em>), vaihtuu palvelimen IP-osoitteesta löytyvä sivu itse tehtyyn.
<h2>1d</h2>
Murtoyritysten seuranta on auth.logia (<em>tail -F /var/log/auth.log</em>) lukemalla helppoa ja myös todella pelottavaa näin ensikertalaiselle. Melkeinpä heti serverin rekisteröinnistä lähtien lokiin alkoi ilmestyä kymmeniä yrityksiä minuutissa, vaikkei palvelinta ollut vielä edes linkitetty domainiin. <a href="http://geoiplookup.net/">Geoiplookup</a> paljasti jokaisen testaamani IP-osoitteen (n. 10 kpl) sijaitsevan Kiinassa.

<img class="alignnone size-full wp-image-360" src="http://46.101.223.159/wp-content/uploads/2017/09/h4_3.png" alt="h4_3" width="1137" height="559" />

Yritysten määrästä huolestuneena vaihdoin vielä oman salasanani vahvempaan sekä asensin estotyökalu Fail2ban:in (<em>sudo apt-get install -y fail2ban</em>). Fail2ban tarkkailee kirjautumisyrityksiä ja (vakioasetuksilla) estää osoitteet, joista vastaanotetaan kolme epäonnistunutta kirjautumisyritystä kymmenen minuutin aikana. Ylläolevassa kuvassa näkyvät 15 minuutin aikana tulleet yritykset <span style="text-decoration: underline;">Fail2ban:in asennuksen jälkeen</span>.
<h2>1f</h2>
Asensin palvelimelle WordPressin seuraamalla <a href="https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lamp-on-ubuntu-16-04">DigitalOceanin ohjeita</a>. Ohjeiden seuraaminen oli helppoa, sillä ne olivat tarkat ja erittäin kattavat. Ohjeiden loppupuolella päänvaivaa aiheutti IP-osoitteesta vastaava, omatekoinen "Hello World!" -sivu, jonka korvaamisesta WordPressillä ei mainittu ohjeistuksessa mitään. Ratkaisu ongelmaan oli navioginti kansioon <em>/var/www/html/</em>, ja tiedoston <em>index.html </em>poistaminen. Tämän jälkeen WordPress-asennuksen luoma <em>index.php</em> ottaa vallan ja tuo WordPressin asetussivun näkyviin palvelimen IP-osoitteeseen. Jatkossa omaa WordPressiä pääsee hallitsemaan osoitteesta <em>http://palvelimen-osoite.domain/login</em>.

<img class="alignnone size-full wp-image-388" src="http://46.101.223.159/wp-content/uploads/2017/09/h4_4.png" alt="h4_4.png" width="381" height="551" />
<h6>TÄTÄ DOKUMENTTIA SAA KOPIOIDA JA MUOKATA GNU GENERAL PUBLIC LICENSE (VERSIO 2 TAI UUDEMPI) MUKAISESTI. LISÄTIETOA: <a class="urlextern" title="http://www.gnu.org/licenses/gpl.html" href="http://www.gnu.org/licenses/gpl.html">HTTP://WWW.GNU.ORG/LICENSES/GPL.HTML</a></h6>