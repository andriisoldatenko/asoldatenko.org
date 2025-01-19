# renovate depName=github.com/igorshubovych/markdownlint-cli
markdownlint_cli_version=v0.43.0

## Install 'markdownlint' if it is missing
prerequisites/markdownlint:
	npm install -g --force markdownlint-cli@$(markdownlint_cli_version)

## Runs markdownlint using existing .markdownlint.json config file through all .md files in the project
markdown/lint:
	# --disable MD034 MD037 - workaround for errors in k8s.io/api package (type PersistentVolumeClaimSpec)
	markdownlint --disable MD034 MD037 -- .
