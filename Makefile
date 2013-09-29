PROJECT = erl_ssl_test

# options

# PLT_APPS =
# ERLC_OPTS =
# DIALYZER_OPTS =

# dependencies

DEPS = ranch
dep_ranch = https://github.com/extend/ranch.git 0.8.4

# standard targets

include erlang.mk

check test: all
	@./check-ciphers.sh
