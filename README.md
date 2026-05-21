# Fog Visibility Estimation using CNNs and Random Forests

⚠️ Non-commercial use only  
This project is provided for academic and research purposes. Commercial use is strictly prohibited.

## Overview
This repository contains a hybrid machine learning framework for fog visibility estimation using both computer vision and meteorological data analysis.

The project was developed for the ECMI Student Competition 2024 and combines:
- A Convolutional Neural Network (CNN) approach for estimating visibility directly from images
- A Random Forest regression model based on meteorological variables such as temperature and pressure
- A custom dataset generation pipeline for paired visual and meteorological data

The objective is to provide a more accurate and scalable solution for quantitative fog visibility estimation compared to traditional binary fog classification systems.

## Features
- Custom fog visibility dataset
- CNN-based visibility estimation
- Random Forest regression analysis
- Meteorological data preprocessing
- Model evaluation and visualization
- Research paper and presentation material included

## Folder Structure

├── CNN
│   ├── mains
│   │   ├── cnn.ipynb
│   │   ├── foggy.ipynb
│   │   └── Visibility.ipynb
│   │
│   └── resources
│       ├── dataset
│       ├── example
│       ├── images
│       ├── valid
│       ├── visibility
│       └── weights
│
├── Presentation
│   ├── Images
│   └── Fog_and_Visibility.pdf
│
└── Random_Forest
    ├── data.csv
    ├── Random_Forest.R
    └── Statistical_Analysis.R

## Usage

### CNN Approach
Open the notebooks inside:

CNN/mains/

Run:
- cnn.ipynb
- foggy.ipynb
- Visibility.ipynb

Datasets and trained weights are stored in:

CNN/resources/

### Random Forest Approach
Run the R scripts inside:

Random_Forest/

Main scripts:
- Random_Forest.R
- Statistical_Analysis.R

## Methods

### Computer Vision
The CNN model estimates fog visibility directly from environmental images using supervised learning techniques.

### Statistical Modeling
The Random Forest model predicts visibility using meteorological variables including:
- Temperature
- Pressure
- Humidity
- Additional derived estimators

## Results
The repository includes:
- Validation examples
- Trained model weights
- Experimental figures
- Statistical analyses
- Final report and presentation material

## Competition
This project was developed as part of the ECMI Student Competition 2024.

## Authors
Academic project developed for research and educational purposes.
