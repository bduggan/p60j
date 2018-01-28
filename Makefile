
static: fosdem-static.ipynb
	jupyter nbconvert fosdem-static.ipynb --to slides

fosdem.slides.html: fosdem.ipynb
	jupyter nbconvert fosdem.ipynb --to slides
