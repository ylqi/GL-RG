# GL-RG: Global-Local Representation Granularity for Video Captioning

![PyTorch 1.6.0](https://img.shields.io/badge/pytorch-1.0.1-green.svg)
![License MIT](https://badgen.net/badge/license/MIT/blue)
![docs](https://img.shields.io/badge/docs-latest-blue)
![issues](https://img.shields.io/github/issues/ylqi/GL-RG.svg)
![Github stars](https://img.shields.io/github/stars/ylqi/GL-RG.svg)

![framework.png](Figs/framework.png)

The code of IJCAI22 paper *"GL-RG: Global-Local Representation Granularity for Video Captioning"*. 

`GL-RG` exploit extensive vision representations from different video ranges to improve linguistic expression. We devise a novel global-local encoder to produce rich semantic vocabulary. With our incremental training strategy, `GL-RG` successfully leverages the global-local vision representation to achieve fine-grained captioning on video contents. 




## Dependencies

* Python 2.7
* Pytorch 0.2 or 1.0
* [Microsoft COCO Caption Evaluation](https://github.com/tylin/coco-caption)
* [CIDEr](https://github.com/plsang/cider)
* numpy, scikit-image, h5py, requests 

This repo was tested with Python 2.7, [PyTorch](https://pytorch.org) 1.0.1 (or 0.2.0), [cuDNN](https://developer.nvidia.com/cudnn) 10.0 (or 6.0), with [CUDA](https://developer.nvidia.com/cuda-toolkit) 8.0. But it should be runnable with more recent [PyTorch](https://pytorch.org)>=1.0 (or >=0.2, <=1.0) versions.

You can use anaconda or miniconda to install the dependencies:
```bash
conda create -n GL-RG-pytorch python=2.7 pytorch=1.0 scikit-image h5py requests
conda activate GL-RG-pytorch
```

or you can install the dependencies following this script:

```ba
conda env create -f environment.yaml
conda activate GL-RG-pytorch
```



## Installation

First clone the this repository to any location using `--recursive`:

```ba
git clone --recursive https://github.com/ylqi/GL-RG.git
```

Check out the `coco-caption/`,  `cider/`,  `data/` and `model/` projects into your working directory. If not, please find detailed steps [INSTALL.md](docs/INSTALL.md) for installation and dataset preparation.

Then, please run following script to download [Stanford CoreNLP 3.6.0](http://stanfordnlp.github.io/CoreNLP/index.html) models into `coco-caption/`:

```bash
cd coco-caption
./get_stanford_models.sh
```



## Datasets

- MSR-VTT: [http://ms-multimedia-challenge.com/2017/dataset](http://ms-multimedia-challenge.com/2017/dataset)

- MSVD: [https://www.microsoft.com/en-us/download/details.aspx?id=52422](https://www.microsoft.com/en-us/download/details.aspx?id=52422)

  

## Model Zoo

| Models | Dataset | Exp. | B@4 | M | R | C | Links |
| :--------: | :---------: | :-----------: | :----------: | :----------: | :----------: | :----------: | :----------: |
| GL-RG | MSR-VTT | XE | 45.5  | 30.1 | 62.6 | 51.2 | [GL-RG_XE_msrvtt](model/GL-RG_XE_msrvtt/model.pth) |
| GL-RG | MSR-VTT | DXE | **46.9** | 30.4 | 63.9 | 55.0 | [GL-RG_DXE_msrvtt](model/GL-RG_DXE_msrvtt/model.pth) |
| GL-RG + IT | MSR-VTT | DR | **46.9** | **31.2** | **65.7** | **60.6** | [GL-RG_DR_msrvtt](model/GL-RG_DR_msrvtt/model.pth) |
| GL-RG | MSVD | XE | 55.5 | 37.8 | 74.7 | 94.3 | [GL-RG_XE_msvd](model/GL-RG_XE_msvd/model.pth) |
| GL-RG | MSVD | DXE | 57.7 | 38.6 | 74.9 | 95.9 | [GL-RG_DXE_msvd](model/GL-RG_DXE_msvd/model.pth) |
| GL-RG + IT | MSVD | DR | **60.5** | **38.9** | **76.4** | **101.0** | [GL-RG_DR_msvd](model/GL-RG_DR_msvd/model.pth) |



## Test

Check out the trained model weights under the `model/` directory (following [Installation](docs/INSTALL.md)) and run:
```bash
./test.sh
```

**Note:** Please modify `MODEL_NAME`, `EXP_NAME` and `DATASET` in `test.sh` if experiment setting changes. For more details please refer to [TEST.md](docs/TEST.md).



## Train

For **Seeding Phase** (*e.g.*, using XE):

```shell
./train.sh 1  # | 0 - using XE | 1 - using DXE |
```

For **Boosting Phase **(*e.g.*, using DR with b1):

```shell
./train.sh 3  # | 2 - with SCST baseline | 3 - with b1 baseline | 4 - with b2 baseline |
```

**Note:** For higher performance, please increase the batch size using `--batch_size` in `train.sh`. For more variants, please set `--start_from` in `train.sh` to determine the Incremental Training entrance model,  set `--use_long_range`, `--use_short_range` and `--use_local` to enable different global-local features:

- `--use_long_range`: enable long-range features.
- `--use_short_range`: enable short-range features.
- `--use_local`: enable local-keyframe features.

Modify the `DATASET` (choices: 'msrvtt', 'msvd') in `train.sh` when switch to MSR-VTT or MSVD benchmark.



## License

`GL-RG` is released under the [MIT license](LICENSE).



## Acknowledgements
We are truly thankful of the following prior efforts in terms of knowledge contributions and open-source repos.
+ SA-LSTM: Describing Videos by Exploiting Temporal Structure (ICCV'15) [[paper]](https://www.cv-foundation.org/openaccess/content_iccv_2015/papers/Yao_Describing_Videos_by_ICCV_2015_paper.pdf) [[implement code]](https://github.com/hobincar/SA-LSTM)
+ SCST: Self-critical Sequence Training for Image Captioning (CVPR'17) [[paper]](https://arxiv.org/pdf/1612.00563.pdf) [[implement code]](https://github.com/ruotianluo/self-critical.pytorch)
+ RecNet: Reconstruction Network for Video Captioning (CVPR'18) [[paper]](https://openaccess.thecvf.com/content_cvpr_2018/papers/Wang_Reconstruction_Network_for_CVPR_2018_paper.pdf) [[official code]](https://github.com/hobincar/RecNet) 
+ SAAT: Syntax-Aware Action Targeting for Video Captioning (CVPR'20) [[paper]](https://openaccess.thecvf.com/content_CVPR_2020/papers/Zheng_Syntax-Aware_Action_Targeting_for_Video_Captioning_CVPR_2020_paper.pdf) [[official code]](https://github.com/SydCaption/SAAT)



## Citation
If you find our work useful in your research, please consider citing:
```
@InProceedings{yan2018GL-RG,
    title={GL-RG: Global-Local Representation Granularity for Video Captioning},
    author={Liqi Yan, Qifan Wang, Yiming Cui, Fuli Feng, Xiaojun Quan, Xiangyu Zhang and Dongfang Liu},
    booktitle={IJCAI},
    year={2022}
}
```
