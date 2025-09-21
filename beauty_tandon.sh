#!/bin/bash
#SBATCH --output=jobs/Job.%j.out
#SBATCH --error=jobs/Job.%j.err
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64GB
#SBATCH --account=pr_119_tandon_priority
#SBATCH --time=60:00:00
#SBATCH --gres=gpu:2
#SBATCH --mail-type=ALL          
#SBATCH --mail-user=zl4789@nyu.edu
#SBATCH --requeue

source /share/apps/anaconda3/2020.07/etc/profile.d/conda.sh;
conda activate gram
cd /scratch/zl4789/GRAM/command
# GRAM beauty (base config)

SEED=2023  

ITEM_ID_TYPE=split
ID_LEN=7
NUM_CF=10 
NUM_CLUSTER=128

ITEM_ID=hierarchy_v1_c${NUM_CLUSTER}_l${ID_LEN}_len32768_split # hierarchy_v1_c128_l7_len32768_split
echo ">>>>>>>>>>>>>>>>>>>>> Beauty SEED: ${SEED} ITEM_ID: ${ITEM_ID}"

CUDA_VISIBLE_DEVICES=0,1 python ../src/main_generative_gram.py --datasets Beauty \
  --distributed 1 \
  --master_port 2341 \
  --gpu 0,1 \
  --seed ${SEED} \
  --train 1 \
  --item_prompt_max_len 128 \
  --item_prompt all_text \
  --cf_model sasrec \
  --id_linking 1 \
  --max_his 20 \
  --rec_batch_size 24 \
  --gradient_accumulation_steps 2 \
  --rec_lr 1e-3 \
  --rec_epochs 30 \
  --test_epoch_rec 5 \
  --save_rec_epochs 5 \
  --save_predictions 1 \
  --top_k_similar_item ${NUM_CF} \
  --item_id_type ${ITEM_ID_TYPE} \
  --hierarchical_id_type ${ITEM_ID} \
  --lexical_id_type_user idgenrec



conda deactivate