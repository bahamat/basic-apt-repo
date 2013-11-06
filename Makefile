DEBS=$(shell find . -type f -name "*.deb")

include gpg.mk

Release.gpg: Release
	@echo -n Signing Release...
	@gpg $(GPGOPTS) --batch --yes -q -abs -o $@ $<
	@echo done.

Release: Packages.gz
	@echo -n Generating Release...
	@apt-ftparchive release . > $@
	@echo done.

Packages.gz: Packages
	@echo -n Compressing Packages list...
	@gzip -9c < $< > $@
	@echo done.

Packages: $(DEBS)
	@echo -n Generating Package list...
	@apt-ftparchive packages . > $@
	@echo done.

mrclean: clean
	$(RM) $(DEBS)

clean:
	$(RM) Packages* Release*
