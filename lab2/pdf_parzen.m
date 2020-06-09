function pdf = pdf_parzen(pts, para)
% Aproksymuje warto�� g�sto�ci prawdopodobie�stwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.samples));

	for cl=1:rows(para.labels)
    hn = para.parzenw / sqrt(rows(para.samples{cl}));
    pdf_all = zeros(size(para.samples{cl}), columns(pts));
        
		for sample = 1 : rows(pts)
			for feature = 1 : columns(pts)
				pdf_all(:, feature) = normpdf(para.samples{cl}(: , feature), pts(sample, feature), hn);
			end
			pdf(sample, cl) = mean(prod(pdf_all,2));
		end
        
    end
end
