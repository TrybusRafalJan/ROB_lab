function pdf = pdf_indep(pts, para)
% Liczy funkcjê gêstoœci prawdopodobieñstwa przy za³o¿eniu, ¿e cechy s¹ niezale¿ne
% pts zawiera punkty, dla których liczy siê f-cjê gêstoœci (punkt = wiersz, bez etykiety!)
% para - struktura zawieraj¹ca parametry:
%	para.mu - wartoœci œrednie cech (wiersz na klasê)
%	para.sig - odchylenia standardowe cech (wiersz na klasê)
% pdf - macierz gêstoœci prawdopodobieñstwa
%	liczba wierszy = liczba próbek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wiêc go alokujê
	pdf = zeros(rows(pts), rows(para.mu));
	
	for col = 1:rows(para.mu)
		for row = 1:columns(para.mu)
			onedim(:, row) = normpdf(pts(:, row), para.mu(col, row), para.sig(col, row));
		endfor
		pdf(:, col) = prod(onedim, 2);
	endfor

end
