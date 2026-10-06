# Palmer Penguins Linear Regression Analysis

## 📋 Project Overview
This **Intro to Data Science Lab** project analyzes the Palmer Penguins dataset using **linear regression models**. The project demonstrates complete data science workflow including data cleaning, exploratory analysis, visualization, and predictive modeling with multiple regression scenarios.

## 📊 Dataset
- **Source**: Palmer Penguins Dataset
- **Records**: 344 penguin observations (after cleaning)
- **Species**: Adelie, Chinstrap, Gentoo
- **Key Variables**:
  - `bill_length_mm` - Bill length in millimeters
  - `bill_depth_mm` - Bill depth in millimeters
  - `flipper_length_mm` - Flipper length in millimeters
  - `body_mass_g` - Body mass in grams

## 🔧 Project Methodology

### Phase 1: Data Preparation
- ✅ Loaded Palmer Penguins dataset
- ✅ Identified missing values
- ✅ Imputed missing values group-wise by species using Mean
- ✅ Subset required numerical columns

### Phase 2: Exploratory Data Analysis (EDA)
#### Summary Statistics
- Five-number summary (Min, Q1, Median, Q3, Max)
- Mean, Median, Standard Deviation calculations
- Distribution analysis per variable

#### Data Visualization
- **Histograms** - Distribution of each variable with mean lines
- **Boxplots** - Outlier detection and spread visualization
- **Correlation Analysis** - Pearson correlation coefficients

### Phase 3: Regression Modeling

#### Model 1: Body Mass vs. Flipper Length
- **Equation**: Body Mass = β₀ + β₁(Flipper Length)
- **Relationship**: Strong positive correlation
- **Predictions**: For flipper lengths 180, 190, 200, 210, 220 mm
- **Visualization**: Scatter plot with 95% confidence band

#### Model 2: Body Mass vs. Bill Length
- **Equation**: Body Mass = β₀ + β₁(Bill Length)
- **Relationship**: Positive correlation
- **Predictions**: For bill lengths 35, 40, 45, 50, 55 mm

#### Model 3: Flipper Length vs. Bill Depth
- **Equation**: Flipper Length = β₀ + β₁(Bill Depth)
- **Relationship**: Weak/negative correlation
- **Predictions**: For bill depths 14, 16, 18, 20, 22 mm

#### Model 4: Multiple Linear Regression (Full Model)
- **Equation**: Body Mass = β₀ + β₁(Flipper Length) + β₂(Bill Length) + β₃(Bill Depth)
- **Purpose**: Combined predictor model using all three variables
- **Model Comparison**: Backward elimination to identify key predictors

### Phase 4: Model Evaluation & Visualization
- 95% Confidence bands on regression plots
- Actual vs. Predicted scatter plots
- Residual Standard Error (RSE) comparison
- Model simplification through backward elimination

## 📈 Key Findings
- **Flipper Length** is the strongest predictor of Body Mass
- **Bill Length** also shows significant predictive power
- **Bill Depth** has minimal predictive contribution
- Multiple regression model improves over simple models
- Data is well-distributed within species groups

## 💻 Technologies & Libraries Used
- **Language**: R Programming
- **Data Manipulation**: dplyr
- **Visualization**: ggplot2
- **Statistical Analysis**: Base R (lm, cor, predict)
- **Environment**: RStudio

## 📁 Project Structure

Palmer-Penguins-Analysis/
├── CODE.R # Complete R script with all analyses
├── penguins.csv # Dataset
├── Assignment 2.docx # Assignment documentation
└── README.md # Project documentation


## 🎯 Skills Demonstrated
✅ Data Cleaning & Imputation  
✅ Exploratory Data Analysis (EDA)  
✅ Statistical Summary Calculations  
✅ Data Visualization (Histograms, Boxplots, Scatter Plots)  
✅ Linear Regression Modeling  
✅ Multiple Linear Regression  
✅ Model Comparison & Evaluation  
✅ Predictive Analysis  
✅ R Programming & ggplot2  

## 📊 Visualizations Generated
1. Histograms with mean lines (4 variables)
2. Boxplots (4 variables)
3. Scatter plots with regression lines (3 scenarios)
4. Confidence band plots (95% CI)
5. Actual vs. Predicted scatter plot

## 🚀 Results Summary
- Successfully trained 4 regression models
- Model 1 (Flipper Length) shows best predictive power
- Multiple regression achieves highest accuracy
- All predictions include 95% confidence intervals
- Identified key predictors through backward elimination

## 👤 Author
**Muhammad Farooq Adnan Khan**  
Data Science Lab 
GIFT University

---

**Project Type**: Inndividual projec -  Data Science  
**Last Updated**: October 2026  
**Status**: ✅ Complete