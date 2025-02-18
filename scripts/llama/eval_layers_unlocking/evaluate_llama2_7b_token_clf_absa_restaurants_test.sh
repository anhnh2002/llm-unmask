#!/bin/bash
 
#PBS -q gpu
#PBS -l select=1:ngpus=1:ncpus=8:mem=16GB
#PBS -o output
#PBS -e output

cd ${PBS_O_WORKDIR:-""}

MODEL_ID="meta-llama/Llama-2-7b-hf"
DO_LOWER_CASE=False
BATCH_SIZE=16
DATASET_NAME="absa-restaurants"
BASE_MODEL_NAME="llama"
MODELS_SAVED_PATH="models/absa-restaurants/llama2-7b-layers-unlocking"
SPLIT="test"
TASK_TYPE="token_clf"
NAME="evaluate_llama2_7b_absa-restaurants_test_layers_unlocking"

module load scientific/pytorch/2.0.0-ngc

export IMAGE_PATH="/lustre/home/ddukic/generative_ie.sif"

run-singlegpu.sh /lustre/home/ddukic/generative-ie/baselines/eval_decoder_model_layers_unlocking.py \
	--model_id "$MODEL_ID" \
    --do_lower_case $DO_LOWER_CASE \
    --batch_size $BATCH_SIZE \
    --dataset_name "$DATASET_NAME" \
    --base_model_name "$BASE_MODEL_NAME" \
    --models_saved_path "$MODELS_SAVED_PATH" \
    --split "$SPLIT" \
    --task_type "$TASK_TYPE" \
    --name "$NAME"
