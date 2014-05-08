SPECFILE := libgccjit.spec
VERSION := $(shell rpm -q --qf "%{VERSION}\n" --specfile $(SPECFILE)| head -1)
RELEASE := $(shell rpm -q --qf "%{RELEASE}\n" --specfile $(SPECFILE)| head -1)

# Make a tarball from a local checkout
tarball:
	./make-tarball.sh

srpm:
	rpmbuild -bs $(SPECFILE) --define="_sourcedir $(shell pwd)"

rpm:
	rpmbuild -ba $(SPECFILE) --define="_sourcedir $(shell pwd)"

# Given an rpmbuild, skip ahead to the %install phase
rpm-skip-to-install:
	rpmbuild --short-circuit -bi $(SPECFILE) --define="_sourcedir $(shell pwd)"

# Upload to a location that COPR can read from
upload-srpm:
	scp \
	  ~/rpmbuild/SRPMS/libgccjit-$(VERSION)-$(RELEASE).src.rpm \
	  dmalcolm@fedorapeople.org:public_html/gcc/libgccjit-srpms

local-mock-fedora-20-x86_64:
	mock --rebuild \
	  ~/rpmbuild/SRPMS/libgccjit-$(VERSION)-$(RELEASE).src.rpm \
	  -r fedora-20-x86_64

local-mock-epel-6-x86_64:
	mock --rebuild \
	  ~/rpmbuild/SRPMS/libgccjit-$(VERSION)-$(RELEASE).src.rpm \
	  -r epel-6-x86_64

local-mock-epel-6-i386:
	mock --rebuild \
	  ~/rpmbuild/SRPMS/libgccjit-$(VERSION)-$(RELEASE).src.rpm \
	  -r epel-6-i386
