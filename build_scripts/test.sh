#!/bin/bash -xe

. $(dirname $0)/common.sh

python -m jiocloud.apply_resources ssh_config --project_tag=${project_tag} ${mappings_arg} environment/${layout:-full}.yaml > ssh_config

ssh -F ssh_config -l ${ssh_user:-jenkins} gcp1_${project_tag} '~jenkins/tempest/run_tempest.sh -N "tempest\.*(?!(.*thirdparty)|(.*baremetal)|(.*data_processing)|(.*messaging)|(.*orchestration)|(.*vpnaas)|(.*test_metering)|(.*cli)|(.*test_load_balancer)|(.*fwaas))"' || true
