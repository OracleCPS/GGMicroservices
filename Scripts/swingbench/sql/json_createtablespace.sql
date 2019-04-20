create &tablespacemodel tablespace &tablespace datafile &datafile
size &datafilesize
autoextend on next 64M maxsize unlimited
extent management local uniform size 1M
segment space management auto;

-- exit;
