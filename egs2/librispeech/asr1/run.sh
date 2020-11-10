#!/bin/bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="train_960"
valid_set="dev"
#test_sets="test_clean test_other dev_clean dev_other"
test_sets="test_clean dev_clean"

asr_config=conf/tuning/train_asr_transformer3.yaml
lm_config=conf/tuning/train_lm_adam.yaml
inference_config=conf/decode_asr.yaml

g2p=g2p_en # Include no word separator

./asr.sh \
    --lang en \
    --ngpu 1 \
    --max_wav_duration 30 \
    --token_type phn \
    --cleaner tacotron \
    --use_lm false \
    --g2p "${g2p}" \
    --asr_config "${asr_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --lm_train_text "data/${train_set}/text data/local/other_text/text" \
    --bpe_train_text "data/${train_set}/text" "$@"
