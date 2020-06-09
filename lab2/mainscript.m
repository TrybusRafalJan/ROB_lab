% malutki plik do uruchomienia funkcji pdf
load pdf_test.txt
size(pdf_test)

% ile jest klas?
labels = unique(pdf_test(:,1))

% ile jest pr�bek w ka�dej klasie?
[labels'; pdf_test(:,1) == labels')] %suma element�w gdy warto�� = label(1,2)
		  % ^^^ dobrze by�oby pomy�le� o tym wyra�eniu
      %w pdf_test(:,1) s� etykiety w labels' rodzaje tych etykiet

% jak uk�adaj� si� pr�bki?
plot2features(pdf_test, 2, 3)
%plot 2 i 3 kolumny w 1-szej s� etykiety


pdfindep_para = para_indep(pdf_test)
% para_indep jest do zaimplementowania, tak �eby dawa�a:

% pdfindep_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%       0.21772   0.19172
%       0.19087   0.27179

% teraz do zaimplementowania jest sama funkcja licz�ca pdf 
%  przygotowuj�c te dane skorzysta�em z funkcji normpdf
%  ta funkcja jest zdefiniowana w pakiecie statistics i w mojej
%  lokalnej konfiguracji musz� najpierw za�adowa� ten pakiet:

pkg load statistics % mo�e nie by� konieczne
pi_pdf = pdf_indep(pdf_test([2 7 12 17],2:end), pdfindep_para)

%pi_pdf =
%  1.4700e+000  4.5476e-007
%  3.4621e+000  4.9711e-005
%  6.7800e-011  2.7920e-001
%  5.6610e-008  1.8097e+000

% wielowymiarowy rozk�ad normalny - parametry ...

pdfmulti_para = para_multi(pdf_test)

%pdfmulti_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    mu =
%       0.7970000   0.8200000
%      -0.0090000   0.0270000
%    sig =
%    ans(:,:,1) =
%       0.047401   0.018222
%       0.018222   0.036756
%    ans(:,:,2) =
%       0.036432  -0.033186
%      -0.033186   0.073868  

% ... i funkcja licz�ca g�sto��
% paradoksalnie sytuacja jest tutaj prostsza, bo w pakiecie
% macie Pa�stwo plik mvnpdf.m zawieraj�cy funkcj�, kt�ra
% liczy wielowymiarow� funkcj� g�sto�ci prawdobie�stwa rozk�adu
% normalnego

pm_pdf = pdf_multi(pdf_test([2 7 12 17],2:end), pdfmulti_para)

%pm_pdf =
%  7.9450e-001  6.5308e-017
%  3.9535e+000  3.8239e-013
%  1.6357e-009  8.6220e-001
%  4.5833e-006  2.8928e+000

% parametry dla aproksymacji oknem Parzena
% t� funkcj� macie Pa�stwo gotow� - u�ywam w niej cell arrays
% warto doczyta�: https://octave.org/doc/v4.2.1/Cell-Arrays.html

pdfparzen_para = para_parzen(pdf_test, 0.5)
									 % ^^^ szeroko�� okna

%pdfparzen_para =
%  scalar structure containing the fields:
%    labels =
%       1
%       2
%    samples =
%    {
%      [1,1] =
%         1.10000   0.95000
%         0.98000   0.61000
% .....
%         0.69000   0.93000
%         0.79000   1.01000
%      [2,1] =
%        -0.010000   0.380000
%         0.250000  -0.440000
% .....
%        -0.110000   0.030000
%         0.120000  -0.090000
%    }
%    parzenw =  0.50000

pp_pdf = pdf_parzen(pdf_test([2 7 12 17],2:end), pdfparzen_para)

%pp_pdf =
%  9.7779e-001  6.1499e-008
%  2.1351e+000  4.2542e-006
%  9.4059e-010  9.8823e-001
%  2.0439e-006  1.9815e+000


% wreszcie mo�na zaj�� si� kartami!
% wcze�niejszy fragment mo�na spokojnie usun�� po uruchomieniu
% funkcji licz�cych pdf
[train test] = load_cardsuites_data();

% pierwszy rzut oka na dane
size(train)
size(test)
labels = unique(train(:,1))
unique(test(:,1))
[labels'; sum(train(:,1) == labels')]

% pierwszym zadaniem po za�adowaniu danych jest sprawdzenie,
% czy w zbiorze ucz�cym nie ma pr�bek odstaj�cych
% do realizacji tego zadania przydadz� si� funkcje licz�ce
% proste statystyki: mean, median, std, 
% wy�wietlenie histogramu cech(y): hist
% spojrzenie na dwie cechy na raz: plot2features (dostarczona w pakiecie)

[mean(train); median(train)]
t =abs(mean(train) - median(train))
% hist domy�lnie dzieli zakres warto�ci na 10 koszyk�w
% wy�wietlenie w ten spos�b 8 etykiet do�� dobrze ilustruje 
% dzia�anie hist
hist(train(:,1))

% to nie s� cechy, kt�re wykorzysta�bym do klasyfikacji - mo�na
% znale�� du�o lepsze; do sprawdzania, czy s� warto�ci odstaj�ce
% nawet te cechy wystarcz�


% do identyfikacji odstaj�cych pr�bek doskonale nadaj� si� wersje
% funkcji min i max z dwoma argumentami wyj�ciowymi

[mv midx] = min(train)

% poniewa� warto�ci minimalne czy maksymalne da si� wyznaczy� zawsze,
% dobrze zweryfikowa� ich odstawanie spogl�daj�c przynajmniej na s�siad�w
% podejrzanej pr�bki w zbiorze ucz�cym

% powiedzmy, �e podejrzana jest pr�bka 41
midx_1 = 642
train(midx-1:midx+1, :)

midx_2 = 186
train(midx-1:midx+1, :)

% je�li nabra�em przekonania, �e pr�bka midx jest do usuni�cia, to:
size(train)
train(midx_1, :) = []; % usuni�cie wiersza midx z macierzy
size(train)

size(train)
train(midx_2, :) = []; % usuni�cie wiersza midx z macierzy
size(train)

[mean(train); median(train)]
t =abs(mean(train) - median(train))

plot2features(train, 2, 4) 


% procedur� szukania i usuwania warto�ci odstaj�cych trzeba powtarza� do skutku

% po usuni�ciu warto�ci odstaj�cych mo�na zaj�� si� wyborem DW�CH cech dla klasyfikacji
% w tym przypadku w zupe�no�ci wystarczy poogl�da� wykresy dw�ch cech i wybra� te, kt�re
% daj� w miar� dobrze odseparowane od siebie klasy

% Po ustaleniu cech (dok�adniej: indeks�w kolumn, w kt�rych cechy siedz�):
first_idx = 2;
second_idx = 5;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

% to nie jest najros�dniejszy wyb�r; 4 i 6 na pewno trzeba zmieni�

% tutaj jawnie tworz� struktur� z parametrami dla klasyfikatora Bayesa 
% (po prawdzie, to dla funkcji licz�cej g�sto�� prawdobie�stwa) z za�o�eniem,
% �e cechy s� niezale�ne

pdfindep_para = para_indep(train); %obliczone wcze�niej funkcjie
pdfmulti_para = para_multi(train); 
pdfparzen_para = para_parzen(train, 0.0001); 
% w sprawozdaniu trzeba podawa� szeroko�� okna (nie liczymy tego parametru z danych!)	
%%%%TUTAJ!!!

% wyniki do punktu 3
base_ercf = zeros(1,3)
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
base_ercf

%%%%%%%% TESTY RÓŻNYCH PARAMETRÓW %%%%%%%


[train test] = load_cardsuites_data();

midx_1 = 642
train(midx_1, :) = []; % usuni�cie wiersza midx z macierzy  %%% wyrzucenie próbek odstających

midx_2 = 186
train(midx_2, :) = []; % usuni�cie wiersza midx z macierzy


plot2features(train, 2, 4) 

first_idx = 2;
second_idx = 4;
train = train(:, [1 first_idx second_idx]); %%%%% wybór cech do budowy klasyfikatora
test = test(:, [1 first_idx second_idx]);

pkg load statistics
pdfindep_para = para_indep(train); %obliczone wcze�niej funkcjie
pdfmulti_para = para_multi(train); 
pdfparzen_para = para_parzen(train, 0.001); 



base_ercf = zeros(1,3)
base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
base_ercf

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% W kolejnym punkcie przyda si� funkcja reduce, kt�ra redukuje liczb� pr�bek w poszczeg�lnych
% klasach (w tym przypadku redukcja b�dzie taka sama we wszystkich klasach - ZBIORU UCZ�CEGO)
% Poniewa� reduce ma losowa� pr�bki, to eksperyment nale�y powt�rzy� 5 (lub wi�cej) razy
% W sprawozdaniu prosz� poda� tylko warto�� �redni� i odchylenie standardowe wsp��czynnika b��du
% Wyobra�am sobie, �e w ka�dym powt�rzeniu eksperymentu tworz�
% now� wersj� zbioru ucz�cego:
%   reduced_train = reduce(train, parts(i) * ones(1, class_count))

parts = [0.1 0.25 0.5];
rep_cnt = 5; % przynajmniej

% YOUR CODE GOES HERE 
%

train(:, 1); % same etykiety
unique(train(:, 1));
class = rows(unique(train(:, 1))); % licbza klas = 8

% inicjalizacja - ilość powtórzeń na ilość podzieleń
array_indep = zeros(rep_cnt, columns(parts)) 
array_multi = zeros(rep_cnt, columns(parts))
array_parzen = zeros(rep_cnt, columns(parts))

for partNr = 1:columns(parts) % iteracja po różnych ilościach podziału
  part = parts(partNr);
  for i = 1:rep_cnt  %iteracja po ilościach powtórzeń
    
    reduced_train = reduce(train, part * ones(1, class));
    
    pdfindep_para = para_indep(reduced_train);
    pdfmulti_para = para_multi(reduced_train);
    pdfparzen_para = para_parzen(reduced_train, 0.001);
    
    array_indep(i, partNr) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
    array_multi(i, partNr) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
    array_parzen(i, partNr) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
  end  
end
% ^^ oblicza ilość poprawnych zaklasyfikowań

%srednie dla 5 pomiarow
mean_indep = mean(array_indep);
std_indep = std(array_indep);

mean_multi = mean(array_multi);
std_multi = std(array_multi);

mean_parzen = mean(array_parzen);
std_parzen = std(array_parzen);

% Punkt 5 dotyczy jedynie klasyfikatora z oknem Parzena (na pe�nym zbiorze ucz�cym)

parzen_widths = [0.0001, 0.00025, 0.0005, 0.00075, 0.001, 0.0025, 0.005, 0.0075 0.01];
parzen_res = zeros(1, columns(parzen_widths));

% YOUR CODE GOES HERE 
%

 for j = 1:columns(parzen_widths)
  

  pdfparzen_para = para_parzen(train, parzen_widths(j));  
  parzen_res(1, j) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
  
end


[parzen_widths; parzen_res]
% Tu a� prosi si� do�o�y� do danych numerycznych wykres
semilogx(parzen_widths, parzen_res)

% W punkcie 6 redukcja dotyczy ZBIORU TESTOWEGO, natomiast warto
% zadba� o to, �eby parametry dla funkcji pdf by�y policzone
% na ca�ym zbiorze ucz�cym (po poprzednich eksperymentach tak 
% raczej nie jest)
% Poniewa� losujemy pr�bki, to wypada powt�rzy� eksperyment 
% stosown� liczb� razy i u�redni� wyniki
% reduced_test = reduce(test, parts) 

apriori = [0.165 0.085 0.085 0.165 0.165 0.085 0.085 0.165]; % r�ne prawdopodobie�stwa apriori
parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0]; %podzia�
rep_cnt = 5; % powt�rka, �eby nie zapomnie�

% YOUR CODE GOES HERE 
%

array_indep = zeros(rep_cnt, 1); %inicjalizacja ilo�� powt�rze� x 1 ( w ka�deym inna wart)
array_multi = zeros(rep_cnt, 1);
array_parzen = zeros(rep_cnt, 1);

for i = 1:rep_cnt
    
    reduced_test = reduce(test, parts); %redukcja zbioru testowego
	  labelsOnly = reduced_test(:, 1) % tylko kolumna z etykiet�
    
    pdfindep_para = para_indep(train); % nowe warto�ci paramter�w
    pdfmulti_para = para_multi(train);
    pdfparzen_para = para_parzen(train, 0.001);
    
    
    array_indep(i, 1) = mean(bayescls(reduced_test(:,2:end), @pdf_indep, pdfindep_para, apriori) != reduced_test(:,1));
    
    
    array_multi(i, 1) = mean(bayescls(reduced_test(:,2:end), @pdf_multi, pdfmulti_para, apriori) != reduced_test(:,1));
   
    
   
    array_parzen(i, 1) = mean(bayescls(reduced_test(:,2:end), @pdf_parzen, pdfparzen_para, apriori) != reduced_test(:,1));
    
    
end

mean_indep = mean(array_indep);
std_indep = std(array_indep);

mean_multi = mean(array_multi);
std_multi = std(array_multi);

mean_parzen = mean(array_parzen);
std_parzen = std(array_parzen);

[[mean_indep std_indep],[mean_multi std_multi], [mean_parzen std_parzen]]


% W ostatnim punkcie trzeba zastanowi� si� nad normalizacj�
std(train(:,2:end))
% Mo�e warto sprawdzi�, jak to wygl�da w poszczeg�lnych klasach?

% Normalizacja potrzebna?
% Je�li TAK, to jej parametry s� liczone TYLKO na zbiorze ucz�cym
% Procedura normalizacji jest aplikowana do zbioru ucz�cego i testowego
% Poniewa� zbiory ucz�cy i testowy s� przyzwoitej wielko�ci 
% klasyfikujecie Pa�stwo testowy za pomoc� ucz�cego (nie ma
% potrzeby u�ycia leave-one-out)


% YOUR CODE GOES HERE 
%
%%%NORMALIZAJCA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%WCZYTANIE DANYCH%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load train.txt; %wczytanie danych
load test.txt;

first_idx = 2; % ponowne ustawienie cech 2 i 4
second_idx = 4;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

midx_1 = 642
midx_2 = 186



train(midx_1, :) = []; 

train(midx_2, :) = []; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

atrr1_mean = mean(train(:,2));
atrr1_std = std(train(:,2));

atrr2_mean = mean(train(:,3));
atrr2_std = std(train(:,3));


trainNorm = zeros(size(train));


trainNorm(:, 1) = train(:, 1);
%normalizacja
trainNorm(:, 2) = (train(:, 2) - atrr1_mean)/atrr1_std;
trainNorm(:, 3) = (train(:, 3) - atrr2_mean)/atrr2_std;

%dane testowe znormalizowane
testNorm = zeros(size(test));

testNorm(:, 1) = test(:, 1);
testNorm(:, 2) = (test(:, 2) - atrr1_mean)/atrr1_std;
testNorm(:, 3) = (test(:, 3) - atrr2_mean)/atrr2_std;



errorCount = 0;

for i = 1:rows(test)
  
  testsample = testNorm(i, 2:end);
  
  res = cls1nn(trainNorm, testsample);
  
  if res != test(i, 1)
    errorCount++;
  end
  
end

totalERROR = errorCount/rows(test)

%%%BEZ NORMALIZAJCji%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load train.txt; %wczytanie danych
load test.txt;

first_idx = 2; % ponowne ustawienie cech 2 i 4
second_idx = 4;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

midx_1 = 642
midx_2 = 186



train(midx_1, :) = []; 

train(midx_2, :) = []; 

errorCount = 0;

for j = 1:rows(test)
  
  test_probka = test(j, 2:end);
  
  res = cls1nn(train, test_probka);
  
  if res != test(j, 1)
    errorCount++;
  end
  
end

TotalERROR = errorCount/rows(test)



