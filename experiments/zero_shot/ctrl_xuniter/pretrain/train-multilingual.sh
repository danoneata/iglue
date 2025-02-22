#!/bin/bash

DATA=/mnt/private-share/speechDatabases/conceptual-captions
# ANNOS=$DATA/annotations
ANNOS=/home/doneata/work/tt-mml/data/cc/translations/m2m-100-md-seed-1337
FEATS=$DATA/resnet101-faster-rcnn-genome-imgfeats/volta
OUTPUT_DIR=output
LOGGING_DIR=logs

# --bert_model xlm-roberta-base \
# --from_pretrained xlm-roberta-base \
# --config_file volta/config/ctrl_xuniter_base.json \

CUDA_VISIBLE_DEVICES=1 python train_concap_multilingual.py \
  --bert_model bert-base-multilingual-cased \
  --from_pretrained bert-base-multilingual-cased \
  --config_file config/ctrl_muniter_base.json \
  --train_batch_size 4 \
  --gradient_accumulation_steps 4 \
  --max_seq_length 66 \
  --learning_rate 1e-4 --adam_epsilon 1e-6 --adam_betas 0.9 0.999 --weight_decay 0.01 --warmup_proportion 0.1 --clip_grad_norm 5.0 \
  --objective 1 \
  --annotations_path $ANNOS \
  --features_path $FEATS \
  --output_dir $OUTPUT_DIR \
  --logdir $LOGGING_DIR \
  --num_train_epochs 10 \
  --num_workers 0
