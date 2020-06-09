function pdf = pdf_parzen(pts, para)
% Aproksymuje wartoœæ gêstoœci prawdopodobieñstwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz)
% para - struktura zawieraj¹ca parametry:
%	para.samples - tablica komórek zawieraj¹ca próbki z poszczególnych klas
%	para.parzenw - szerokoœæ okna Parzena
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
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
