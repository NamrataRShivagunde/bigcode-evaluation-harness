#!/bin/bash

# List of tasks
tasks=(
  'perturbed-humaneval-format-num_seeds_2'
  'perturbed-humaneval-format-num_seeds_3'
  'perturbed-humaneval-format-num_seeds_4'
  'perturbed-humaneval-format-num_seeds_5'
  
  'perturbed-humaneval-func_name-num_seeds_1'
  'perturbed-humaneval-func_name-num_seeds_2'
  'perturbed-humaneval-func_name-num_seeds_3'
  'perturbed-humaneval-func_name-num_seeds_4'
  'perturbed-humaneval-func_name-num_seeds_5'
  
  'perturbed-humaneval-natgen-num_seeds_1'
  'perturbed-humaneval-natgen-num_seeds_2'
  'perturbed-humaneval-natgen-num_seeds_3'
  'perturbed-humaneval-natgen-num_seeds_4'
  'perturbed-humaneval-natgen-num_seeds_5'
  
  'perturbed-humaneval-nlaugmenter-num_seeds_1'
  'perturbed-humaneval-nlaugmenter-num_seeds_2'
  'perturbed-humaneval-nlaugmenter-num_seeds_3'
  'perturbed-humaneval-nlaugmenter-num_seeds_4'
  'perturbed-humaneval-nlaugmenter-num_seeds_5'
)

# Accelerate launch command
accelerate_cmd="accelerate launch  main.py \
  --model microsoft/phi-2 \
  --max_length_generation 1024 \
  --batch_size 1 \
  --do_sample True \
  --n_samples 1 \
  --allow_code_execution \
  --save_generations \
  --save_references \
  --trust_remote_code \
"

# Loop over tasks
for task in "${tasks[@]}"; do

  cmd="$accelerate_cmd"
 
  # Adjust paths based on task name and seed
  save_generations_path="generations/generations_recode_${task}.json"
  metric_output_path="metric_output/metric_${task}.json"
  
  # Append paths to the command
  cmd+=" --tasks $task --save_generations_path $save_generations_path --metric_output_path $metric_output_path > metric_output/recode/metric_recode_$task.txt"
  
  # Run the command
  echo "Running command for task: $task"
  echo "$cmd"
  eval "$cmd"
done
