# ---- HINTER
HINTER = ttfautohint --no-info # Use ttfautohint (fast fuzzy hinting, requires an external tool)
# HINTER = fontforge ./scripts/Autohint.pe # Use fontforge (sharp hinting)
# HINTER = cp # Skip hinting

# ---- OPTIONS
SOURCECODEOPTS  =
NASUMOPTS       =
NERDFONTOPTS    =
MERGEOPTS       = --visiblespace

# ---- OUTPUT FILENAMES
SOURCE_SOURCECODE = ./fonts/SourceCodePro-Regular.ttf
SOURCE_NASUM      = ./fonts/NasuM-Regular-20200227.ttf
SOURCE_NERDFONT   = ./fonts/SymbolsNerdFont-Regular.ttf
TMP_SOURCECODE    = ./tmp/SourceCodePro-Regular_adjusted.ttf
TMP_NASUM         = ./tmp/NasuM-Regular-20200227_adjusted.ttf
TMP_NERDFONT      = ./tmp/SymbolsNerdFont-Regular_adjusted.ttf
UNHINTED_OUTPUT   = ./tmp/nasucode-Medium_unhinted.ttf
HINTED_OUTPUT     = ./dist/nasucode-Medium.ttf

all: $(HINTED_OUTPUT)

$(HINTED_OUTPUT): $(UNHINTED_OUTPUT)
	$(HINTER) $(UNHINTED_OUTPUT) $(HINTED_OUTPUT)

$(UNHINTED_OUTPUT): ./scripts/nasucode.pe $(TMP_SOURCECODE) $(TMP_NASUM) $(TMP_NERDFONT)
	fontforge ./scripts/nasucode.pe $(MERGEOPTS) $(TMP_SOURCECODE) $(TMP_NASUM) $(TMP_NERDFONT) $(UNHINTED_OUTPUT)

$(TMP_NERDFONT): ./scripts/NerdFont.pe Makefile $(SOURCE_NERDFONT)
	fontforge ./scripts/NerdFont.pe $(NERDFONTOPTS) $(SOURCE_NERDFONT) $(TMP_NERDFONT)

$(TMP_SOURCECODE): ./scripts/SourceCodePro.pe Makefile $(SOURCE_SOURCECODE)
	fontforge ./scripts/SourceCodePro.pe $(SOURCECODEOPTS ) $(SOURCE_SOURCECODE) $(TMP_SOURCECODE)

$(TMP_NASUM): ./scripts/NasuM.pe Makefile $(SOURCE_NASUM)
	fontforge ./scripts/NasuM.pe $(NASUMOPTS) $(SOURCE_NASUM) $(TMP_NASUM)

clean:
	rm ./tmp/*.ttf
	rm ./dist/*.ttf
