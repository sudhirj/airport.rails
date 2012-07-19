.PHONY: build deploy test autotest templates clean show compile setup

build: airport.js

MOCHA = node_modules/mocha/bin/mocha tests/*.coffee -G --compilers coffee:coffee-script

test:
	@echo "\nRunning JS tests..."
	@$(MOCHA)

autotest:
	@$(MOCHA) -w

templates: templates/*.html
	@echo "\nBuilding templates..."
	@node_modules/liz/bin/liz templates/*.html -o app/templates.js

airport.js: templates app/*.js app/*.coffee
	@echo "\nBrowserifying code..."
	@node_modules/browserify/bin/cmd.js -o airport.js app/app.coffee
	@echo "\nDone. Built airport.js (`du -sk airport.js | awk '{print $$1}'`kb)"

clean:
	@echo "\nCleaning output directory..."
	@rm app/templates.js
	@rm -f output/*

show:
	@echo "\nCurrent distribution:"
	@ls -lh output

setup:
	npm install	
