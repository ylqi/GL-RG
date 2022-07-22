#! /bin/bash

func_training_xe()
{
    MODEL_NAME=GL-RG
    DATASET="msrvtt"
    CKPT_NAME=XE
    CKPT_DIR=output/${MODEL_NAME}_${CKPT_NAME}_${DATASET}
	mkdir -p ${CKPT_DIR}
    if [ "$DATASET" == "msvd" ]; then 
        SEQ_PER_IMG=17
    else
        SEQ_PER_IMG=20
    fi
	CUDA_VISIBLE_DEVICES=$GPU_ID python train.py    --train_label_h5 data/metadata/${DATASET}_train_sequencelabel.h5 \
                                                    --val_label_h5 data/metadata/${DATASET}_val_sequencelabel.h5 \
                                                    --test_label_h5 data/metadata/${DATASET}_test_sequencelabel.h5 \
                                                    --train_cocofmt_file data/metadata/${DATASET}_train_cocofmt.json \
                                                    --val_cocofmt_file data/metadata/${DATASET}_val_cocofmt.json \
                                                    --test_cocofmt_file data/metadata/${DATASET}_test_cocofmt.json \
                                                    --train_bcmrscores_pkl data/metadata/${DATASET}_train_evalscores.pkl \
                                                    --train_feat_h5 "" "" "" data/feature/${DATASET}_train_gl_feats.h5 \
                                                    --val_feat_h5   "" "" "" data/feature/${DATASET}_val_gl_feats.h5 \
                                                    --test_feat_h5  "" "" "" data/feature/${DATASET}_test_gl_feats.h5 \
                                                    --beam_size 5 --rnn_size 512 --eval_metric CIDEr --language_eval 1 \
                                                    --max_epochs 30 --train_seq_per_img ${SEQ_PER_IMG} --test_seq_per_img ${SEQ_PER_IMG} --batch_size 32 \
                                                    --test_batch_size 32 --learning_rate 0.0003 --lr_update 200 --save_checkpoint_from 1 --num_chunks 1 \
                                                    --train_cached_tokens data/metadata/${DATASET}_train_ciderdf.pkl \
                                                    --use_rl 0 --use_mixer 0 --mixer_from -1 --use_it 0 \
                                                    --dr_baseline_captions 0 --dr_baseline_type 0 --loglevel INFO --use_eos 0 \
                                                    --use_long_range 1 \
                                                    --use_short_range 1 \
                                                    --use_local 1 \
                                                    --model_file ${CKPT_DIR}/model.pth \
                                                    --start_from No \
                                                    --result_file ${CKPT_DIR}/model_test.json \
                                                    2>&1 | tee ${CKPT_DIR}/run.log
}

func_training_dxe()
{
    MODEL_NAME=GL-RG
    DATASET="msvd"
    CKPT_NAME=DXE
    CKPT_DIR=output/${MODEL_NAME}_${CKPT_NAME}_${DATASET}
	mkdir -p ${CKPT_DIR}
    if [ "$DATASET" == "msvd" ]; then 
        SEQ_PER_IMG=17
    else
        SEQ_PER_IMG=20
    fi
	CUDA_VISIBLE_DEVICES=$GPU_ID python train.py    --train_label_h5 data/metadata/${DATASET}_train_sequencelabel.h5 \
                                                    --val_label_h5 data/metadata/${DATASET}_val_sequencelabel.h5 \
                                                    --test_label_h5 data/metadata/${DATASET}_test_sequencelabel.h5 \
                                                    --train_cocofmt_file data/metadata/${DATASET}_train_cocofmt.json \
                                                    --val_cocofmt_file data/metadata/${DATASET}_val_cocofmt.json \
                                                    --test_cocofmt_file data/metadata/${DATASET}_test_cocofmt.json \
                                                    --train_bcmrscores_pkl data/metadata/${DATASET}_train_evalscores.pkl \
                                                    --train_feat_h5 "" "" "" data/feature/${DATASET}_train_gl_feats.h5 \
                                                    --val_feat_h5   "" "" "" data/feature/${DATASET}_val_gl_feats.h5 \
                                                    --test_feat_h5  "" "" "" data/feature/${DATASET}_test_gl_feats.h5 \
                                                    --beam_size 5 --rnn_size 512 --eval_metric CIDEr --language_eval 1 \
                                                    --max_epochs 30 --train_seq_per_img ${SEQ_PER_IMG} --test_seq_per_img ${SEQ_PER_IMG} --batch_size 32 \
                                                    --test_batch_size 32 --learning_rate 0.0003 --lr_update 200 --save_checkpoint_from 1 --num_chunks 1 \
                                                    --train_cached_tokens data/metadata/${DATASET}_train_ciderdf.pkl \
                                                    --use_dxe 1 --use_rl 0 --use_mixer 0 --mixer_from -1 --use_it 1 \
                                                    --dr_baseline_captions 0 --dr_baseline_type 0 --loglevel INFO --use_eos 0 \
                                                    --use_long_range 1 \
                                                    --use_short_range 1 \
                                                    --use_local 1 \
                                                    --model_file ${CKPT_DIR}/model.pth \
                                                    --start_from No \
                                                    --result_file ${CKPT_DIR}/model_test.json \
                                                    2>&1 | tee ${CKPT_DIR}/run.log
}

func_training_rl_scst()
{
    MODEL_NAME=GL-RG
    DATASET="msvd"
    CKPT_NAME=RL
    CKPT_DIR=output/${MODEL_NAME}_${CKPT_NAME}_${DATASET}
	mkdir -p ${CKPT_DIR}
    if [ "$DATASET" == "msvd" ]; then 
        SEQ_PER_IMG=17
    else
        SEQ_PER_IMG=20
    fi
	CUDA_VISIBLE_DEVICES=$GPU_ID python train.py    --train_label_h5 data/metadata/${DATASET}_train_sequencelabel.h5 \
                                                    --val_label_h5 data/metadata/${DATASET}_val_sequencelabel.h5 \
                                                    --test_label_h5 data/metadata/${DATASET}_test_sequencelabel.h5 \
                                                    --train_cocofmt_file data/metadata/${DATASET}_train_cocofmt.json \
                                                    --val_cocofmt_file data/metadata/${DATASET}_val_cocofmt.json \
                                                    --test_cocofmt_file data/metadata/${DATASET}_test_cocofmt.json \
                                                    --train_bcmrscores_pkl data/metadata/${DATASET}_train_evalscores.pkl \
                                                    --train_feat_h5 "" "" "" data/feature/${DATASET}_train_gl_feats.h5 \
                                                    --val_feat_h5   "" "" "" data/feature/${DATASET}_val_gl_feats.h5 \
                                                    --test_feat_h5  "" "" "" data/feature/${DATASET}_test_gl_feats.h5 \
                                                    --beam_size 5 --rnn_size 512 --eval_metric CIDEr --language_eval 1 \
                                                    --max_epochs 100 --train_seq_per_img ${SEQ_PER_IMG} --test_seq_per_img ${SEQ_PER_IMG} --batch_size 32 \
                                                    --test_batch_size 32 --learning_rate 0.0001 --lr_update 200 --save_checkpoint_from 1 --num_chunks 1 \
                                                    --train_cached_tokens data/metadata/${DATASET}_train_ciderdf.pkl \
                                                    --use_rl 1 --use_mixer 1 --mixer_from -1 --use_it 0 \
                                                    --dr_baseline_captions 0 --dr_baseline_type 0 --loglevel INFO --use_eos 1 \
                                                    --use_long_range 1 \
                                                    --use_short_range 1 \
                                                    --use_local 1 \
                                                    --model_file ${CKPT_DIR}/model.pth \
                                                    --start_from output/${MODEL_NAME}_DXE_${DATASET} \
                                                    --result_file ${CKPT_DIR}/model_test.json \
                                                    2>&1 | tee ${CKPT_DIR}/run.log
}

func_training_it_dr_b1()
{
    MODEL_NAME=GL-RG
    DATASET="msvd"
    CKPT_NAME=DR
    CKPT_DIR=output/${MODEL_NAME}_${CKPT_NAME}_${DATASET}
	mkdir -p ${CKPT_DIR}
    if [ "$DATASET" == "msvd" ]; then 
        SEQ_PER_IMG=17
    else
        SEQ_PER_IMG=20
    fi
	CUDA_VISIBLE_DEVICES=$GPU_ID python train.py    --train_label_h5 data/metadata/${DATASET}_train_sequencelabel.h5 \
                                                    --val_label_h5 data/metadata/${DATASET}_val_sequencelabel.h5 \
                                                    --test_label_h5 data/metadata/${DATASET}_test_sequencelabel.h5 \
                                                    --train_cocofmt_file data/metadata/${DATASET}_train_cocofmt.json \
                                                    --val_cocofmt_file data/metadata/${DATASET}_val_cocofmt.json \
                                                    --test_cocofmt_file data/metadata/${DATASET}_test_cocofmt.json \
                                                    --train_bcmrscores_pkl data/metadata/${DATASET}_train_evalscores.pkl \
                                                    --train_feat_h5 "" "" "" data/feature/${DATASET}_train_gl_feats.h5 \
                                                    --val_feat_h5   "" "" "" data/feature/${DATASET}_val_gl_feats.h5 \
                                                    --test_feat_h5  "" "" "" data/feature/${DATASET}_test_gl_feats.h5 \
                                                    --beam_size 5 --rnn_size 512 --eval_metric CIDEr --language_eval 1 \
                                                    --max_epochs 100 --train_seq_per_img ${SEQ_PER_IMG} --test_seq_per_img ${SEQ_PER_IMG} --batch_size 32 \
                                                    --test_batch_size 32 --learning_rate 0.0001 --lr_update 200 --save_checkpoint_from 1 --num_chunks 1 \
                                                    --train_cached_tokens data/metadata/${DATASET}_train_ciderdf.pkl \
                                                    --use_rl 1 --use_mixer 1 --mixer_from 1 --use_it 1 \
                                                    --dr_baseline_captions 20 --dr_baseline_type 1 --loglevel INFO --use_eos 1 \
                                                    --use_long_range 1 \
                                                    --use_short_range 1 \
                                                    --use_local 1 \
                                                    --model_file ${CKPT_DIR}/model.pth \
                                                    --start_from output/${MODEL_NAME}_DXE_${DATASET} \
                                                    --result_file ${CKPT_DIR}/model_test.json \
                                                    2>&1 | tee ${CKPT_DIR}/run.log
}


func_training_it_dr_b2()
{
    MODEL_NAME=GL-RG
    DATASET="msvd"
    CKPT_NAME=DR
    CKPT_DIR=output/${MODEL_NAME}_${CKPT_NAME}_${DATASET}
	mkdir -p ${CKPT_DIR}
    if [ "$DATASET" == "msvd" ]; then 
        SEQ_PER_IMG=17
    else
        SEQ_PER_IMG=20
    fi
	CUDA_VISIBLE_DEVICES=$GPU_ID python train.py    --train_label_h5 data/metadata/${DATASET}_train_sequencelabel.h5 \
                                                    --val_label_h5 data/metadata/${DATASET}_val_sequencelabel.h5 \
                                                    --test_label_h5 data/metadata/${DATASET}_test_sequencelabel.h5 \
                                                    --train_cocofmt_file data/metadata/${DATASET}_train_cocofmt.json \
                                                    --val_cocofmt_file data/metadata/${DATASET}_val_cocofmt.json \
                                                    --test_cocofmt_file data/metadata/${DATASET}_test_cocofmt.json \
                                                    --train_bcmrscores_pkl data/metadata/${DATASET}_train_evalscores.pkl \
                                                    --train_feat_h5 "" "" "" data/feature/${DATASET}_train_gl_feats.h5 \
                                                    --val_feat_h5   "" "" "" data/feature/${DATASET}_val_gl_feats.h5 \
                                                    --test_feat_h5  "" "" "" data/feature/${DATASET}_test_gl_feats.h5 \
                                                    --beam_size 5 --rnn_size 512 --eval_metric CIDEr --language_eval 1 \
                                                    --max_epochs 100 --train_seq_per_img ${SEQ_PER_IMG} --test_seq_per_img ${SEQ_PER_IMG} --batch_size 32 \
                                                    --test_batch_size 32 --learning_rate 0.0001 --lr_update 200 --save_checkpoint_from 1 --num_chunks 1 \
                                                    --train_cached_tokens data/metadata/${DATASET}_train_ciderdf.pkl \
                                                    --use_rl 1 --use_mixer 1 --mixer_from 1 --use_it 1 \
                                                    --dr_baseline_captions 20 --dr_baseline_type 2 --loglevel INFO --use_eos 1 \
                                                    --use_long_range 1 \
                                                    --use_short_range 1 \
                                                    --use_local 1 \
                                                    --model_file ${CKPT_DIR}/model.pth \
                                                    --start_from output/${MODEL_NAME}_DXE_${DATASET} \
                                                    --result_file ${CKPT_DIR}/model_test.json \
                                                    2>&1 | tee ${CKPT_DIR}/run.log
}

GPU_ID=0
case "$1" in
    0) echo "Train XE model" && func_training_xe;;
    1) echo "Train DXE model" && func_training_dxe;;
    2) echo "Train RL model (using SCST baseline)" && func_training_rl_scst;;
    3) echo "Train DR (IT) model (using B1, where baseline is computed from GT captions)" && func_training_it_dr_b1;;
    4) echo "Train DR (IT) model (using B2, where baseline is computed from model sampled captions)" && func_training_it_dr_b2;;
    *) echo "No input" ;;
esac