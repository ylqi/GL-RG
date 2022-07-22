#!/usr/bin/env bash

func_standalize_format()
{
    func_standalize_format_msrvtt2016()
    {
        python standalize_format.py --input_file datasets/input/${DATASET}/${SPLIT}_videodatainfo.json\
                                    --output_json output/metadata/${DATASET}_${SPLIT}_datainfo.json\
                                    --dataset ${DATASET}\
                                    --split ${SPLIT}
    }
    func_standalize_format_msrvtt2017()
    {
        python standalize_format.py --input_file datasets/input/${DATASET}/${SPLIT}_videodatainfo.json\
                                    --output_json output/metadata/${DATASET}_${SPLIT}_datainfo.json\
                                    --dataset ${DATASET}\
                                    --split ${SPLIT}
    }
    func_standalize_format_yt2t()
    {
        python standalize_format.py --input_file datasets/input/${DATASET}/naacl15/sents_${SPLIT}_lc_nopunc.txt\
                                    --output_json output/metadata/${DATASET}_${SPLIT}_datainfo.json\
                                    --dataset ${DATASET}\
                                    --split ${SPLIT}
    }
    DATASET="msvd"
    SPLIT="train"   && echo "Standalize data "${SPLIT} && func_standalize_format_msrvtt2016
    SPLIT="val"     && echo "Standalize data "${SPLIT} && func_standalize_format_msrvtt2016
    SPLIT="test"    && echo "Standalize data "${SPLIT} && func_standalize_format_msrvtt2016
    #DATASET="msrvtt2017"
    #SPLIT="train"   && echo "Standalize data "${SPLIT} && func_standalize_format_msrvtt2017
    #SPLIT="val"     && echo "Standalize data "${SPLIT} && func_standalize_format_msrvtt2017
    #SPLIT="test"    && echo "Standalize data "${SPLIT} && func_standalize_format_msrvtt2017
    #DATASET="yt2t"
    #SPLIT="train"   && echo "Standalize data "${SPLIT} && func_standalize_format_yt2t
    #SPLIT="val"     && echo "Standalize data "${SPLIT} && func_standalize_format_yt2t
    #SPLIT="test"    && echo "Standalize data "${SPLIT} && func_standalize_format_yt2t
}

func_preprocess_datainfo()
{
    func_preprocess_datainfo_msrvtt2016()
    {
        python preprocess_datainfo.py   --input_json output/metadata/${DATASET}_${SPLIT}_datainfo.json\
                                        --output_json output/metadata/${DATASET}_${SPLIT}_proprocessedtokens.json
    }
    DATASET="msvd"
    SPLIT="train"   && echo "Preprocess data info "${SPLIT} && func_preprocess_datainfo_msrvtt2016
    SPLIT="val"     && echo "Preprocess data info "${SPLIT} && func_preprocess_datainfo_msrvtt2016
    SPLIT="test"    && echo "Preprocess data info "${SPLIT} && func_preprocess_datainfo_msrvtt2016
}

func_build_vocab()
{
    func_build_vocab_msrvtt2016()
    {
        python build_vocab.py   --input_json output/metadata/${DATASET}_${SPLIT}_proprocessedtokens.json \
                                --output_json output/metadata/${DATASET}_${SPLIT}_vocab.json \
                                --word_count_threshold 3
    }
    DATASET="msvd"
    SPLIT="train"   && echo "Build vocabulary "${SPLIT} && func_build_vocab_msrvtt2016
    SPLIT="val"     && echo "Build vocabulary "${SPLIT} && func_build_vocab_msrvtt2016
    SPLIT="test"    && echo "Build vocabulary "${SPLIT} && func_build_vocab_msrvtt2016
}

func_create_sequencelabel()
{
    func_create_sequencelabel_thread()
    {
        python create_sequencelabel.py  --vocab_json output/metadata/${DATASET}_${SPLIT}_vocab.json \
                                        --captions_json output/metadata/${DATASET}_${SPLIT}_proprocessedtokens.json\
                                        --max_length 30 \
                                        --output_h5 output/metadata/${DATASET}_${SPLIT}_sequencelabel.h5
    }
    DATASET="msvd"
    SPLIT="train"   && echo "Create sequence label "${SPLIT} && func_create_sequencelabel_thread
    SPLIT="val"     && echo "Create sequence label "${SPLIT} && func_create_sequencelabel_thread
    SPLIT="test"    && echo "Create sequence label "${SPLIT} && func_create_sequencelabel_thread
}

func_convert_datainfo2cocofmt()
{
    func_convert_datainfo2cocofmt_thread()
    {
        python convert_datainfo2cocofmt.py  --input_json output/metadata/${DATASET}_${SPLIT}_datainfo.json \
                                            --output_json output/metadata/${DATASET}_${SPLIT}_cocofmt.json
    }
    DATASET="msvd"
    SPLIT="train"   && echo "Convert standalized datainfo to coco format for language evaluation "${SPLIT} && func_convert_datainfo2cocofmt_thread
    SPLIT="val"     && echo "Convert standalized datainfo to coco format for language evaluation "${SPLIT} && func_convert_datainfo2cocofmt_thread
    SPLIT="test"    && echo "Convert standalized datainfo to coco format for language evaluation "${SPLIT} && func_convert_datainfo2cocofmt_thread
}

func_compute_ciderdf()
{
    func_compute_ciderdf_thread()
    {
        python compute_ciderdf.py   --captions_json output/metadata/${DATASET}_${SPLIT}_proprocessedtokens.json\
                                    --output_pkl output/metadata/${DATASET}_${SPLIT}_ciderdf.pkl\
                                    --output_words \
                                    --vocab_json output/metadata/${DATASET}_${SPLIT}_vocab.json
    }
    DATASET="msvd"
    SPLIT="train"   && echo "pre-compute document frequency for computing CIDEr of on model samples "${SPLIT} && func_compute_ciderdf_thread
    SPLIT="val"     && echo "pre-compute document frequency for computing CIDEr of on model samples "${SPLIT} && func_compute_ciderdf_thread
    SPLIT="test"    && echo "pre-compute document frequency for computing CIDEr of on model samples "${SPLIT} && func_compute_ciderdf_thread
}

func_compute_evalscores()
{
    func_compute_evalscores_thread()
    {
        python compute_scores.py    --cocofmt_file output/metadata/${DATASET}_${SPLIT}_cocofmt.json\
                                    --output_pkl output/metadata/${DATASET}_${SPLIT}_evalscores.pkl\
                                    --remove_in_ref
    }
    DATASET="msvd"
    SPLIT="train"   && echo "pre-compute evaluation scores (BLEU_4, CIDEr, METEOR, ROUGE_L) "${SPLIT} && func_compute_evalscores_thread
    SPLIT="val"     && echo "pre-compute evaluation scores (BLEU_4, CIDEr, METEOR, ROUGE_L) "${SPLIT} && func_compute_evalscores_thread
    SPLIT="test"    && echo "pre-compute evaluation scores (BLEU_4, CIDEr, METEOR, ROUGE_L) "${SPLIT} && func_compute_evalscores_thread
}



##############################################################
## Caption pre-processing
##############################################################
func_standalize_format
func_preprocess_datainfo
func_build_vocab
func_create_sequencelabel
func_convert_datainfo2cocofmt
func_compute_ciderdf
func_compute_evalscores

##############################################################
## Video pre-processing
##############################################################
#func_extract_video_features
