DEBS=$(shell find . -type f -name "*.deb")

APT_FTPARCHIVE=apt-ftparchive
GPG=gpg
GZIP=gzip
GZIPFLAGS=

include gpg.mk

GPGFLAGS+=--batch --yes -q -abs

Release.gpg: Release
	@echo -n Signing Release...
	@$(GPG) $(GPGFLAGS) -o $@ $<
	@echo done.

Release: Packages.gz
	@echo -n Generating Release...
	@$(APT_FTPARCHIVE) release . > $@
	@echo done.

Packages.gz: Packages
	@echo -n Compressing Packages list...
	@$(GZIP) -9c < $< > $@
	@echo done.

Packages: $(DEBS)
	@echo -n Generating Package list...
	@$(APT_FTPARCHIVE) packages . > $@
	@echo done.

mrclean: clean
	$(RM) $(DEBS)

clean:
	$(RM) Packages* Release*
