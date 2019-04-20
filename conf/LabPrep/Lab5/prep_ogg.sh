# prep_ogg.sh
# Prepare OGG Workshop environments by Lab number

# Check for proper input
if [[ $# -eq 0 || $# -gt 1 ]];
then
        echo "prep_ogg.sh [1 - 7]"
        exit
fi

if [[ $1 -lt 1 || $1 -gt 6 ]];
then
        echo "Valid lab input is 1 to 7"
        exit
fi

SCRIPTS=$HOME/LabPrep
# Source Oracle 12c
. /home/oracle/12c.env

# Cleanup current GG 12c environment
echo "Cleanup current GG 12c environment"
$GG/ggsci paramfile $SCRIPTS/Lab$1/clean_ogg.oby
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

# Create sql scripts dir in GG 12c environment
if [ ! -d "$SQL" ];
then
	mkdir $GG/dirsql
fi

# Create defs dir in GG 12c environment
echo "Create defs dir in GG 12c environment"
if [ ! -d "$DEF" ];
then
        mkdir $GG/dirdef
fi

# Create macro dir in GG 12c environment
echo "Create macro dir in GG 12c environment"
if [ ! -d "$MAC" ];
then
        mkdir $GG/dirmac
fi
	
rm -f $SQL/*
rm -f $DAT/*
rm -f $RPT/*
rm -f $DEF/*
rm -f $MAC/*
rm -f $GG/dirout/*
rm -f $GG/ENCKEYS

# Copy lab files to GG 12c environment
echo "Copy lab files to GG 12c environment"
cp -rf $SRC/dirprm/Lab$1/* $PRM
cp -rfp $SRC/dirsql/Lab$1/* $SQL
cp -rf $SRC/dirmac/* $MAC
cp -rf $SRC/GLOBALS $GG
cp -rf $SRC/ENCKEYS.done $GG

# drop tables from ORCL12 in the AMER schema
sqlplus amer/amer @$SCRIPTS/Lab$1/clean_db.sql

# manage ogg users for labs
sqlplus / as sysdba @$SCRIPTS/Lab$1/prep_ogg.sql
sqlplus amer/amer@orcl12c @$GG/dirsql/database.sql

# Source Oracle 11g
. /home/oracle/11g.env

# Cleanup current GG 11G environment
echo "Cleanup current GG 11G environment"
$GG/ggsci paramfile $SCRIPTS/Lab$1/clean_ogg.oby
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

# Create sql scripts dir in GG 11G environment
if [ ! -d "$SQL" ];
then
        mkdir $GG/dirsql
fi

# Create defs dir in GG 11G environment
echo "Create defs dir in GG 11G environment"
if [ ! -d "$DEF" ];
then
	mkdir $GG/dirdef
fi

# Create macro dir in GG 11G environment
echo "Create macro dir in GG 11G environment"
if [ ! -d "$MAC" ];
then
        mkdir $GG/dirmac
fi

rm -f $SQL/*
rm -f $DAT/*
rm -f $RPT/*
rm -f $DEF/*
rm -f $MAC/*
rm -f $GG/dirout/*
rm -f $GG/ENCKEYS

# Copy lab files to GG 11G environment
echo "Copy lab files to GG 11G environment"
cp -rf $SRC/dirprm/Lab$1/* $PRM
cp -rfp $SRC/dirsql/Lab$1/* $SQL
cp -rf $SRC/dirmac/* $MAC
cp -rf $SRC/GLOBALS $GG
#cp -f $SRC/ENCKEYS $GG

# drop tables from ORCL11 in the EURO schema
sqlplus euro/euro @$SCRIPTS/Lab$1/clean_db.sql

# manage ogg users for labs
sqlplus / as sysdba @$SCRIPTS/Lab$1/prep_ogg.sql

echo "Oracle GoldenGate Preparation Complete"

