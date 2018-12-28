# Script to copy MySQL DB definition file to 10g and 11g Oracle OGG environments
# Run as root
# Source MySQL
. /home/oracle/mysql.env

SCRIPTS=/home/oracle/LabPrep

# Cleanup current GG MySQL environment
$GG/ggsci paramfile $SCRIPTS/Lab5/clean_mysql.oby
if [ -f $PRM"/jagent.prm" ];
then
        mv $PRM/jagent.prm $PRM/jagent.tmp
        rm -f $PRM/*prm
	rm -f $PRM/*oby
        mv $PRM/jagent.tmp $PRM/jagent.prm
else
        rm -f $PRM/*prm
	rm -f $PRM/*oby
fi

if [ ! -d "$SQL" ];
then
        mkdir $GG/dirsql
fi

# Create defs dir in GG MySQL environment
echo "Create defs dir in GG MySQL environment"
if [ ! -d "$DEF" ];
then
        mkdir $GG/dirdef
fi

rm -f $SQL/*.sql
rm -f $DAT/*
rm -f $RPT/*
rm -f $DEF/*

# Copy lab files to GG MySQL environment
echo "Copy lab files to GG MySQL environment"
cp -r $SRC/dirprm/* $PRM
cp -r $SRC/dirsql/* $SQL

chown -R mysql:mysql $PRM
chown -R mysql:mysql $SQL
chmod 777 -R $SQL

# Create amea database tables for MySQL
echo "Create amea database tables for MySQL"
mysql -u amea -pamea < $SQL/source_database.sql
mysql -u amea -pamea < $SQL/seed_database.sql

echo "Oracle GoldenGate Preparation Complete"
