all: env server

env: env/bin/activate
env/bin/activate: requirements.txt
	test -d env || virtualenv env
	env/bin/pip install -U pip setuptools
	env/bin/pip install -r requirements.txt
	touch env/bin/activate

server:
	# Activate virtualenv in the make shell
	( \
		. env/bin/activate; \
		honcho start; \
	)

migrate:
	( \
		. env/bin/activate; \
		python manage.py migrate; \
	)

drop:
	( \
		rm *.sqlite; \
	)

reload: drop migrate
