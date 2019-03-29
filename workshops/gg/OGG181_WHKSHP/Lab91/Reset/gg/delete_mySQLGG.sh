#!/bin/bash

# Always include a comment at the top

cd /opt/app/oracle/product/18.1.0_GGMySQL
./ggsci <<EOF
sleep 5
Start Manager
sleep 5
Stop ER *
sleep 15
Delete ER * !
sleep 5
Stop Manager !
sleep 5
Exit
EOF

rm ./dirdat/*
rm ./dirrpt/*
