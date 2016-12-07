test:
	flake8 . --max-line-length=120 --exclude='.git,.eggs,build,dist,dlogr.egg-info'
	DLOGR_ASYNC=False nosetests tests --with-coverage --cover-package=dlogr --cover-inclusive --nocapture ${ARGS}
