Dawid Tracz
gr. 2

realizacja piątej pry skryptów bash/tcsh (server)

/*Kod był pisany na systemie ubuntu pod którym zostały rozwiązane wszystkie błędy. Z doświadczenia wiem, ze na wydziałowym debianie rzeczy czasami działały inaczej -- mam nadzieje, że w tym przypadku tak nie będzie.*/

Program zawiera parę skryptów:
-> server.sh
-> server.csh
a oprócz tego:
1)pliki *.rc *.dat, oraz odpowiadające im *.csh z danymi
2)plik makefile, który:
-kopiuje pliki z danymi jako ukryte do folderu domowego (który zgodnie z ustaleniem miał być domyślny)
-daje prawa wykonawcze do skryptów użytkownikowi
3)plik terminator.sh, symulujący zakończenie pracy systemu, tj wysyłajacy z odstepem SIGTERM i SIGKILL do grupy procesu (oraz wszystkich jego dzieci) podanego jako argument wywołania. (praktyczny z wywołaniem ./server.sh &; niepraktyczny, dla wersji *.csh, gdyż ona w ogóle nie przechwytuje sygnału, bo nie może (tylko SIGINT się da), tylko na bierząco zapisuje licznik wywołań do pliku)

dostępne falgi (w obu skryptach)
-i | -IP [arg]
	ustawia IP
-p | --port
	ustawia port
--save
	(nadpisuje plik z danymi bierzącymi (wcześniej poadnymi) ustawieniami)
-r | --reset
	resetuje licznik
-sset [arg]
	argumentem jest ścieżka do nowego pliku z portem i IP
	(nadpisuje ścieżkę do domyślnego pliku i od razu korzysta z nowego)
-cset [arg]
	argumentem jest ścieżka do nowego pliku licznikiem
	(nadpisuje ścieżkę do domyślnego pliku i od razu korzysta z nowego)
-c | --client
	uruchamia server w roli clienta
-s | --server
	uruchamia server w roli serweru (opcja domyślna i nadrzędna względem -c | --client)