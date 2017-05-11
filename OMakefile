.PHONY: run installdeps docker-build

run: installdeps
	$(HOME)/.roswell/bin/qlot exec ros localup.ros

installdeps: qlfile qlfile.lock
	$(HOME)/.roswell/bin/qlot install

docker-build:
	docker build --force-rm=true -t "btckun:$(shell git describe --candidates=0 --tags)" .
