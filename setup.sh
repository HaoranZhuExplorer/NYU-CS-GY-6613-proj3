#!/bin/bash

# normalize system
touch ~/.no_auto_tmux
sed -i '/To disconnect without closing your processes/d' .bashrc
nvidia-smi

# git
apt-get update && apt-get install -y git wget curl
git clone git@github.com:HaoranZhuExplorer/NYU-CS-GY-6613-proj3.git $HOME/proj

# dataset ~3G
# In this project you will focus only on Python language
apt-get update && apt-get install -y aria2
aria2c -x 16 -s 16 --dir=/dev/shm https://s3.amazonaws.com/code-search-net/CodeSearchNet/v2/python.zip
mkdir -p /dev/shm/data
unzip /dev/shm/python.zip -d /dev/shm/data
command rm /dev/shm/python.zip
# mv /dev/shm/python.zip $HOME
ln -s /dev/shm/data $HOME/proj/code/resources/data

# conda
apt-get update && apt-get install -y aria2
aria2c -x 16 -s 16 --dir=/dev/shm https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
[[ -d /opt/conda ]] && command rm -r /opt/conda
bash /dev/shm/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
command rm /dev/shm/Miniconda3-latest-Linux-x86_64.sh
/opt/conda/bin/conda init
source $HOME/.bashrc

# environment ~3.5G
# Setup Python 3.6 (Need for other dependencies)
# Pin TF Version on v1.12.0
conda deactivate
conda env remove -n proj
conda create -y -n proj
conda activate proj
conda install -y python=3.6
conda install -y tensorflow-gpu='1.*'
conda clean -y --all
pip --no-cache-dir install --upgrade \
    altair==3.2.0 \
    annoy==1.16.* \
    docopt==0.6.2 \
    dpu_utils==0.1.34 \
    ipdb==0.12.2 \
    jsonpath_rw_ext==1.2.2 \
    jupyter==1.0.0 \
    more_itertools==7.2.0 \
    numpy==1.16.5 \
    pandas==0.25.0 \
    parso==0.5.1 \
    pygments==2.4.2 \
    pyyaml==5.3 \
    requests==2.22.0 \
    scipy==1.3.1 \
    SetSimilaritySearch==0.1.7 \
    toolz==0.10.0 \
    tqdm==4.34.0 \
    typed_ast==1.4.0 \
    wandb==0.8.12 \
    wget==3.2
python -c 'import tensorflow as tf; print(tf.__version__);'
LC_ALL=C.UTF-8 LANG=C.UTF-8 wandb login

# program
( cd $HOME/proj/code/src && conda activate proj && python train.py --testrun )

# run
(
cd $HOME/proj/code/src
conda activate proj
python train.py \
    --model selfatt ../trained_models \
    ../resources/data/python/final/jsonl/train \
    ../resources/data/python/final/jsonl/valid \
    ../resources/data/python/final/jsonl/test
)

# predict
python predict.py --wandb_run_id liqi0816/CodeSearchNet/2nvjacrm
