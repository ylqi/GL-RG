import sys
import argparse


def parse_opt():
    parser = argparse.ArgumentParser()

    parser.add_argument('--msvd_csv_path', default="input/msvd/MSR_Video_Description_Corpus.csv", help='path to the MSR Video Description Corpus.csv file of the msvd dataset')
    parser.add_argument('--msvd_video_name2id_map', default="input/msvd/youtube_mapping.txt", help='path to the youtube_mapping.txt file of the msvd dataset')
    parser.add_argument('--msvd_train_anno_json_path', default="input/msvd/train_videodatainfo.json", help='path to the train annotations.json file of the msvd dataset')
    parser.add_argument('--msvd_val_anno_json_path', default="input/msvd/val_videodatainfo.json", help='path to the val annotations.json file of the msvd dataset')
    parser.add_argument('--msvd_test_anno_json_path', default="input/msvd/test_videodatainfo.json", help='path to the test annotations.json file of the msvd dataset')
    args = parser.parse_args()
    return args
