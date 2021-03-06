#!/bin/bash

#SBATCH --nodes=1
#SBATCH --time=120:00:00
#SBATCH --job-name=rws-pcfg
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tuananh@robots.ox.ac.uk
#SBATCH -o ./jobs_out_err/rws_pcfg_%j.out
#SBATCH -e ./jobs_out_err/rws_pcfg_%j.err

cd /data/engs-woodgroup/magd3733/rwspp/pcfg

TRAIN_MODE=$1
NUM_PARTICLES=$2
SEED=$3

module load python/anaconda3/5.0.1
source activate $HOME/torch-env
python --version
python -c "import torch; print('torch version = {}'.format(torch.__version__))"
python -u run.py --train-mode $TRAIN_MODE \
                 --num-particles $NUM_PARTICLES \
                 --seed $SEED | tee ./jobs_out_err/rws_pcfg_${PBS_JOBID}_temp.out_err
