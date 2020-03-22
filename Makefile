EXCLUSIONS	:= .git .DS_Store .gitignore .config .tmux $(wildcard .*.swp)
CANDIDATES	:= $(wildcard .??*)
DOTFILES	:= $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

deploy: ## Deploy dotfiles
	$(info ********  Create symlink of dotfiles to home directory. ********)
	@$(foreach f, $(DOTFILES), ln -snfv $(abspath $(f)) $(HOME)/$(f);)
	@bash deploy-config.sh

install: ## Install Homebrew packages, other setup
	$(info ********  Install packages. ********)
	@bash install-brew.sh
	@bash install-go.sh
	@bash install-plug.sh

init: deploy install ## Run make deploy, make install

clean: ## Remove dotfiles
	$(info ********  Remove dotfiles from home directory. ********)
	@-$(foreach f, $(DOTFILES), rm -vrf $(HOME)/$(f))

help: ## Print help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
