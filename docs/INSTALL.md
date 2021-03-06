## Installation

If you use `--recursive` to clone this repository, skip this section.

### Microsoft COCO Caption Evaluation

Please run following script to download evaluation codes for [Microsoft COCO Caption Evaluation](https://github.com/tylin/coco-caption) and put them under the `coco-caption` directory:

```ba
cd GL-RG
git clone https://github.com/tylin/coco-caption.git
```
Please refer to [Microsoft COCO Caption Evaluation](https://github.com/tylin/coco-caption) for more setup details.

### CIDEr Code

Please run following script to download [Consensus-based Image Description Evaluation](https://github.com/plsang/cider) and put them under the `cider` directory:

```ba
cd GL-RG
git clone https://github.com/plsang/cider.git
```



## Preparation

If you have fully cloned this repository, skip this section.

### Datasets

Download the `metadata` and `feature` from [Here](https://github.com/ylqi/GL-RG/tree/main/data) and then unzip them under the `data` directory like:
```shell
data
├── feature
│   ├── msrvtt_test_gl_feats.h5
│   ├── msrvtt_train_gl_feats.h5
│   ├── msrvtt_val_gl_feats.h5
│   ├── msvd_test_gl_feats.h5
│   ├── msvd_train_gl_feats.h5
│   └── msvd_val_gl_feats.h5
│
├── metadata
│   ├── msrvtt_test_cocofmt.json
│   ├── msrvtt_test_sequencelabel.h5
│   ├── msvd_test_cocofmt.json
│   ├── msvd_test_sequencelabel.h5
│   ├── ....
└── └── msrvtt_train_cocofmt.json
```

Those files are prepared via the scripts in `data/preprocess`:

```ba
cd data/preprocess
python build_msvd_annotation.py  # only when preparing MSVD dataset
./preprocess.sh                  # prepare MSR-VTT and MSVD dataset
```

### Pre-trained Weights

Download the pre-trained weights from [Here](https://github.com/ylqi/GL-RG/tree/main/model) and then unzip them under the `model` directory like:
```shell
model
├── GL-RG_XE_msrvtt
│   └── model.pth
│
├── GL-RG_XE_msvd
│   └── model.pth
│
├── GL-RG_DXE_msrvtt
│   └── model.pth
│
├── GL-RG_DXE_msvd
│   └── model.pth
│
├── GL-RG_DR_msrvtt
│   └── model.pth
│
└── GL-RG_DR_msvd
    └── model.pth
```

