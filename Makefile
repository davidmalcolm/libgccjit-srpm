srpm:
	rpmbuild -bs libgccjit.spec --define="_sourcedir $(shell pwd)"

rpm:
	rpmbuild -ba libgccjit.spec --define="_sourcedir $(shell pwd)"

rpm-install:
	rpmbuild --short-circuit -bi libgccjit.spec --define="_sourcedir $(shell pwd)"
