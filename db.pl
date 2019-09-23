use DBI;


 DBI->install_driver("mysql")
  or die "Mysql geht nicht";
 
 my $dbh = DBI->connect("DBI:CSV:f_dir = I:\xampp\htdocs\gaestebuch")
            or die "Konnte Datenbank nicht öffen!";