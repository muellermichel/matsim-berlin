#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

scenario_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
matsim_dir=${scenario_dir}/../matsim
echo "syncing ${scenario_dir} with FDR"
rsync -rlv --delete-after --exclude='*/.git' --exclude='scenarios/berlin-v5.1-1pct/output*' --filter="dir-merge,- .gitignore" "${scenario_dir}" muellmic@fdr4.ethz.ch:~
rsync -rlv --delete-after --exclude='*/.git' --exclude='scenarios/berlin-v5.1-1pct/output*' --filter="dir-merge,- .gitignore" "${matsim_dir}" muellmic@fdr4.ethz.ch:~
rsync -rlv muellmic@fdr4.ethz.ch:~/matsim-berlin/output_* "${scenario_dir}" && :