#!/bin/bash

# Always include a comment at the top

cd /opt/app/oracle/product/18.1.0_GGMySQL
./ggsci <<EOF

Start Manager
pause 2
Stop ER *
pause 5
Delete ER * !
pause 2
Stop Manager !
pause 2
Exit
EOF

rm ./dirdat/*
rm ./dirrpt/*
