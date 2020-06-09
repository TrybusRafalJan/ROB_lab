function pdf = pdf_multi(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa wielowymiarowego r. normalnego
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - macierze kowariancji cech (warstwa na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	pdf = zeros(rows(pts), rows(para.mu));
	
  
  class = rows(para.mu);
  for sample_id = 1:rows(pts)
    sample = pts(sample_id, :);
    for cls = 1:class    
      pdf(sample_id, cls) = mvnpdf(sample, para.mu(cls, :), para.sig(:,:,cls));
    end
  end
end
