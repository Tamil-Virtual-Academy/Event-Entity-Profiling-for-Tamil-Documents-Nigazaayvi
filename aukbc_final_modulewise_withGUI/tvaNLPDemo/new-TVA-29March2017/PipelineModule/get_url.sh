perl 1hindu-crawl.pl > inter1.txt
perl 1hindu-tamil-extract.pl inter1.txt >> url-list.txt
perl crawl.pl http://www.dinamani.com/ > inter1.txt
perl 1dinamani-tamil-extract.pl inter1.txt >> url-list.txt
perl crawl.pl http://tamil.oneindia.com/ > inter1.txt
perl 1oneinda-tamil-extract.pl inter1.txt >> url-list.txt
perl malai-malar-crawl.pl  > inter1.txt
perl malaimalar-tamil-extract.pl inter1.txt >> url-list.txt
perl crawl.pl http://makkalkural.net/news/ > inter1.txt
perl makkalkural-tamil-extract.pl inter1.txt >> url-list.txt
perl crawl_store.pl  url-list.txt
