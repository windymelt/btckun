.PHONY: run installdeps docker-build

run: installdeps
	/root/.roswell/bin/qlot exec ros -Q . localup.ros

installdeps: qlfile qlfile.lock
	/root/.roswell/bin/qlot install

docker-build:
	docker build --force-rm=true -t "btckun:$(shell git describe --candidates=0 --tags)" .
