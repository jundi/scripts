if [[ $# -eq 2 ]]; then
	gs -dPDFA -dBATCH -dNOPAUSE -dUseCIEColor -sProcessColorModel=DeviceCMYK -sDEVICE=pdfwrite -sPDFACompatibilityPolicy=1 -sOutputFile=$2 $1
else
	echo "usage: pdf2pdfa input.pdf output.pdf"
fi
