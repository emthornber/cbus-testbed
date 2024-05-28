################################################################################
#
#   28 May, 2024 - E M Thornber
#   Created (from canpi-web-app-ssr)
#
################################################################################

export SDIR := ${shell pwd}
export BFILE := "$(SDIR)/target/arm-unknown-linux-gnueabihf/release/cbus-tb"
export ODIR := "$(SDIR)/package"

all: clean package

.PHONY: all build clean release test package

build:
	( cd frontend; CARGO_TARGET_DIR=../target-trunk trunk build )
	( cd server;   cargo build )

clean:
	( cd frontend; CARGO_TARGET_DIR=../target-trunk trunk clean )
	( cd server; cargo clean )
	find . -name dist -type d | xargs rm -rf

package: release
	$(MAKE) -f $@/Makefile pkgs

release:
	( cd frontend; CARGO_TARGET_DIR=../target-trunk trunk build )
	( cd server;   cargo build --release )

test:
	( cd server; cargo test )