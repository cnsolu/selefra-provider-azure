# ------------------------------------------------- --------------------------------------------------------------------

init:: install_selefra_terraform_provider_scaffolding
	 export TERRAFORM_PROVIDER_URL=${TERRAFORM_PROVIDER}
	 ./bin/selefra-terraform-provider-scaffolding init

install_selefra_terraform_provider_scaffolding::
	 chmod u+x ./install-scaffolding.sh
	 ./install-scaffolding.sh

# ------------------------------------------------- --------------------------------------------------------------------

test:: generate
	 export SELEFRA_TEST_TABLES=${TABLES}
	 cd ./resources
	 go run test
	 cd -

build:: generate
	 go build

generate::
	 export TERRAFORM_PROVIDER_URL=${TERRAFORM_PROVIDER}
	 ./bin/selefra-terraform-provider-scaffolding generate
	 cp ./go.mod ./resources/go.mod
	 cd ./resources
	 go mod tidy
	 cd -

clean::
	rm -rf ./resources
	rm -rf ./bin

help::
	 @grep '^[^.#]\+:\s\+.*#' Makefile | \
	 sed "s/\(.\+\):\s*\(.*\) #\s*\(.*\)/`printf "\033[93m"`\1`printf "\033[0m"`     \3 [\2]/" | \
	 expand -t20

# ------------------------------------------------- --------------------------------------------------------------------


