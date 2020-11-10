#!/bin/bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

g2p=g2p_en

./asr.sh \
    --lang en \
    --train_set train_nodev \
    --valid_set train_dev \
    --test_sets "train_nodev" \
    --use_lm false \
    --token_type phn \
    --g2p "${g2p}" \
    --srctexts "data/train_nodev/text" "$@"
