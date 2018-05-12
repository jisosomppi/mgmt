---
ID: 442
post_title: Linux palvelimet, harjoitustehtävä 5
author: jussi
post_excerpt: ""
layout: post
permalink: >
  http://jisosomppi.me/2017/10/02/linux-palvelimet-harjoitustehtava-5/
published: true
post_date: 2017-10-02 07:40:10
---
<div>

Jussi Isosomppi, 2.10.2017

Tehtävä on osa Haaga-Helian Linux palvelimet -kurssia, jonka aikataulut sekä tehtävänannot löytyvät osoitteesta <a href="http://terokarvinen.com/2017/aikataulu-linux-palvelimet-ict4tn021-4-ti-ja-5-to-alkusyksy-2017-5-op">http://terokarvinen.com/.</a>

&nbsp;

</div>
<blockquote>
<h4>d4) (ryhmä 4-ti) Asenna LAMP ja lue tietokantaa PHP-ohjelmalla. (Pitkähkö tehtävä)</h4>
</blockquote>
<div></div>
<div>Aloitin tämän tehtävän uudella Xubuntu 16.04.3 livetikulla, ja syöttämällä tutun komennon <em>sudo apt-get install. </em>Tämän jälkeen seurasin <a href="http://terokarvinen.com/2016/read-mysql-database-with-php-php-pdo">Tero Karvisen ohjeita</a>, ja aloitin vaadittavien ohjelmien asennuksen. Tämän jälkeen otin käyttöön käyttäjien kotihakemistot (<em>a2enmod userdir</em>), sallin PHP-koodin suorittamisen käyttäjien kotisivuilla muokkaamalla asetustiedostoa (<em>sudoedit /etc/apache2/mods-available/php7.0.conf # comment out module to allow PHP in userdir</em>) ja käynnistin Apachen uudelleen (<em>sudo service apache2 restart</em>). Tämän jälkeen loin itselleni public_html -kansion (<em>cd; mkdir public_html</em>) ja sen sisään index.php -tiedoston (<em>echo '&lt;?php print(2+2+"\n\n"); ?&gt;'&gt; index.php</em>). Tämän jälkeen sivu on näkyvissä Firefoxilla tai curlilla, ja sen lähdekoodi sisältää ainoastaan yhtälön 2+2 vastauksen.</div>
<div></div>
<div>Tämän jälkeen siirryin luomaan tietokantaa. Kirjauduin roottina mysql:ään (<em>mysql -u root -p</em>), annoin asentaessa valitun salasanan ja loin uuden tietokannan (<em>CREATE DATABASE hattujussi CHARACTER SET utf8;</em>). Tämän jälkeen annoin tietokannan oikeudet uudelle mysql-käyttäjälle "hattujussi" (<em>GRANT ALL ON hattujussi.* TO hattujussi@localhost IDENTIFIED BY 'salasanatuleetähän;</em>). Tämän jälkeen voidaan poistua mysql:stä komennolla <em>exit</em> ja kokeilla juuri luotua käyttäjää kirjautumalla uudelleen komennolla <em>mysql -u hattujussi -p </em>ja antamalla äsken määritetty salasana. Tämän jälkeen voidaan syöttää tietokantaan sisältöä komennoilla</div>
<blockquote>
<div>mysql&gt; USE hattujussi;
mysql&gt; CREATE TABLE hats(id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(1024));
mysql&gt; INSERT INTO hats(name) VALUES ('Cap');
mysql&gt; INSERT INTO hats(name) VALUES ('Ninja Hood');
mysql&gt; INSERT INTO hats(name) VALUES ('White Helmet');
mysql&gt; SELECT * FROM hats;
+----+--------------+
| id | name |
+----+--------------+
| 1 | Cap |
| 2 | Ninja Hood |
| 3 | White Helmet |
+----+--------------+</div></blockquote>
<div>Tämän jälkeen voidaan poistua mysql:stä ja muokata tiedoston ~/public_html/index.php sisältöä seuraavanlaiseksi:</div>
<blockquote>
<div>

&lt;?php
// public_html/index.php - Read MySQL from PHP
// (c) 2016 Tero Karvinen http://TeroKarvinen.com

// MySQL Login
$user='hattujussi';
$password='salasanatuleetähän';

// Data Source Name i.e. connection details
$database=$user;
$dsn="mysql:host=localhost;charset=UTF8;dbname=$database";

// Open Connection, create new object of PDO class
$pdo=new PDO($dsn, $user, $password);

// Perform SQL Query
$pdoStatement=$pdo-&gt;prepare('SELECT * FROM hats;');
$pdoStatement-&gt;execute();
$hits=$pdoStatement-&gt;fetchAll();

// Print the $hits Array
foreach($hits as $row) {
echo "&lt;p&gt;".$row['id']." ".$row['name']."&lt;/p&gt;\n";
}
?&gt;

</div></blockquote>
<div>Tämän jälkeen Firefoxilla tai curlilla saadaan näkyviin tietokannan sisältämät tiedot.</div>
<div></div>
<div><img class="alignnone size-full wp-image-445" src="http://jisosomppi.me/wp-content/uploads/2017/10/h6_4.png" alt="" width="182" height="145" /></div>
<div></div>
<blockquote>
<h4>e4) (ryhmä 4-ti) Asenna WordPress ja luo esimerkkisisältöä.</h4>
</blockquote>
&nbsp;
<h6>TÄTÄ DOKUMENTTIA SAA KOPIOIDA JA MUOKATA GNU GENERAL PUBLIC LICENSE (VERSIO 2 TAI UUDEMPI) MUKAISESTI. LISÄTIETOA: <a class="urlextern" title="http://www.gnu.org/licenses/gpl.html" href="http://www.gnu.org/licenses/gpl.html">HTTP://WWW.GNU.ORG/LICENSES/GPL.HTML</a></h6>