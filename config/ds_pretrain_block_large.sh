#! /bin/bash

script_path=$(realpath $BASH_SOURCE)
script_dir=$(dirname $script_path)

config_json="$script_dir/ds_config.json"
gpt_options=" \
       --block-lm \
       --experiment-name block-lm-large \
       --model-parallel-size ${MP_SIZE} \
       --num-layers 24 \
       --hidden-size 1024 \
       --num-attention-heads 16 \
       --seq-length 512 \
       --max-position-embeddings 1024 \
       --save /root/data/checkpoints \
       --train-iters 100000 \
       --resume-dataloader \
       --train-data bert-large \
       --lazy-loader \
       --tokenizer-type BertWordPieceTokenizer \
       --tokenizer-model-type bert-large-uncased \
       --split 949,50,1 \
       --distributed-backend nccl \
       --lr-decay-style cosine \
       --lr-decay-iters 80000 \
       --lr-decay-ratio 0.05 \
       --warmup .01 \
       --checkpoint-activations \
       --deepspeed-activation-checkpointing \
       --fp16 \
"
gpt_options="${gpt_options}
               --deepspeed \
               --deepspeed_config ${config_json} \
"