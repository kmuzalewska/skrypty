Program napisany przez Klare Muzalwską w ramach zajęć z języków skryptowych.

Przed pierwszym uruchomieniem programu na komputerze należy wykonać komendę:
																			make
Aby uruchomić serwer należy wykonać komendę:
											./server.sh (bądź ./server.tcsh w zależności od tego którego shela chemy użyć)
											lub
											./server.sh -s (bądź ./server.tcsh -s w zależności od tego którego shela chemy użyć)


Aby uruchomić clienta należy wykonać komendę:
											./client.sh (bądź ./client.tcsh w zależności od tego którego shela chemy użyć)
											lub
											./server.sh -c (bądź ./server.tcsh -c w zależności od tego którego shela chemy użyć)
Aby serwer zaczą zliczać wywołania należy go najpierw włączyć.

Dostępne są flagi:
			-c 		wczesniej omówiona
			-s 		wczesniej omówiona
			-p 		NR_PORTU zmienia nr portu (NR_PORTU to liczba) z domyślnego, na którym stawiamy serwer / chcemy się dostać (w zależności od tego czy działamy jako klient czy sewer)
			-i 		NR_IP zmienia nr IP (NR_IP to liczba w formacie 127.0.0.1) z domyślnego na którym stawiamy serwer / chcemy się dostać (w zależności od tego czy działamy jako klient czy sewer)
			-lp		zmieniamy miejsce gdzie znajduje się plik, gdzie zapisuje się liczba wywołań danego serwera
