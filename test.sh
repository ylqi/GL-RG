#!/usr/bin/env bash

GPU_ID=0

MODEL_NAME=GL-RG
EXP_NAME=DR         # Choices: [XE, DXE, DR]
DATASET=msvd        # Choices: [msrvtt, msvd]

MODEL_DIR=model     # Choices: [model, output]


if [ "$DATASET" == "msvd" ]; then 
    SEQ_PER_IMG=17
else
    SEQ_PER_IMG=20
fi

func_GL-RG_testing()
{
        CUDA_VISIBLE_DEVICES=${GPU_ID} python test.py   --model_file ${MODEL_DIR}/${MODEL_NAME}_${EXP_NAME}_${DATASET}/model.pth \
                                                        --test_label_h5 data/metadata/${DATASET}_test_sequencelabel.h5 \
                                                        --test_cocofmt_file data/metadata/${DATASET}_test_cocofmt.json \
                                                        --test_feat_h5  "" "" "" data/feature/${DATASET}_test_gl_feats.h5 \
                                                        --use_long_range 1 \
                                                        --use_short_range 1 \
                                                        --use_local 1 \
                                                        --beam_size 5 \
                                                        --language_eval 1 \
                                                        --test_seq_per_img ${SEQ_PER_IMG} \
                                                        --test_batch_size 32 \
                                                        --loglevel INFO \
                                                        --result_file ${MODEL_DIR}/${MODEL_NAME}_${EXP_NAME}_${DATASET}/test_result.json
}


func_GL-RG_testing