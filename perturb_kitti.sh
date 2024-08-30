#!/bin/bash

weather_types=("rain" "snow" "fog")
noise_types=("uniform_noise" "gaussian_noise" "background_noise" "impulse_noise" \
             "uniform_noise_radial" "gaussian_noise_radial" "impulse_noise_radial" \
             "upsampling" )
density_types=("cutout" "density_inc" "density_dec" "beam_del" "layer_del")

corruptions=("${weather_types[@]}" "${noise_types[@]}" "${density_types[@]}")
dataroot="~/projects/SLAM_datasets/"

base_cmd="python perturb_pointcloud.py --dataset kitti --dataroot $dataroot --nworkers 16"

for subset in "09" "10"; do
    for corruption in "${corruptions[@]}"; do
        for severity in {1..5}; do
            cmd="$base_cmd --subset $subset --corruption $corruption --severity $severity"
            echo $cmd
            eval $cmd
        done
    done
done
