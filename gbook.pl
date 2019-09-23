#!"\xampp\perl\bin\perl.exe" -w

### Aufruf des CGI-Moduls ###
use CGI qw(:standard);
use Fcntl qw(:flock);
use strict;

### Gästebuch öffnen ###

my $gaeste = "gaestebuch.html";

open(GAESTEBUCH, "+< $gaeste")
	or die "Das Gaestebuch konnte nicht geöffnet werden!\n";

flock(GAESTEBUCH, LOCK_EX);

### Einlesen der Formulardaten ###

my $name = param('eingabe');
my $EMail = param('EMail');
my $kommentar = param('kommentar');

### Eintrag ins Gaestebuch ###


my $neueintrag = <<HERE_TEXT;
<div style="background-color: #DCDCDC">
<p >
<b>Name:</b> <i>$name</i><br>
<b>E-Mail:</b> <i>$EMail</i>
</p>
<h4 >Kommentar:</h4>
<i>$kommentar</i>
</div>
<hr>
HERE_TEXT

seek(GAESTEBUCH, -16 , 2);
print GAESTEBUCH "$neueintrag\nZur&uuml;ck zum
<a href=\"
eingabeform.html\">Eingabeformular.</a>
<br>........................................................................<br>
\n</body>\n</html>";
close(GAESTEBUCH);

### Dankseite ###

my $danke = <<HERE_TEXT2;
Content-type: text/html; charset=utf8

<html>
<head>
	<title>Dankseite</title>
</head>
<body>
	<h1>Hallo $name!</h1>
	<h4>Danke f&uuml;r Deinen Eintrag ins G&auml;stebuch.</h4>
	<hr>

	<p>
	Wenn Sie die Eintr&auml;ge im G&auml;stebuch<br>
	lesen wollen klicken Sie bitte <a href="gaestebuch.html">hier</a>
	</p>

	<p>
	Zum Eingabeformular geht es <a href="eingabeform.html">hier</a>
	zur&uuml;ck
	</p>

</body>
</html>
HERE_TEXT2

print $danke;