# ASPECT to ECOMAN Converter

This repository contains a MATLAB script designed to convert geodynamic model outputs from [ASPECT](https://aspect.geodynamics.org/) into input files compatible with [ECOMAN](https://newtonproject.geoscienze.unipd.it/ecoman/).



This script serves as a post-processing utility that:
- Reads and interprets output data from ASPECT simulations
- Reformats and transforms the data structure to match the expected input format of ECOMAN
- Facilitates a  workflow between geodynamic modeling and seismic interpretation



##  Requirements

- MATLAB (R2020 or later recommended)
- ASPECT output files 


## Usage

1. Place your ASPECT output files as .csv format in the working directory. The .csv file sould contain informations of "Time", "Velocity:x" , "Velocity:y", "Velocity:z", "Temperature", "Pressure" from ASPECT model.
2. Run the script in MATLAB.
3. The script will generate output files ready to be used as input for ECOMAN.

## References

For a detailed description of the ASPECT–ECOMAN coupling workflow, see:

Poulami Roy, *Lower Mantle Anisotropy due to Plume Generation from Large Low-Shear-Velocity Provinces, PhD Thesis, University of Potsdam, 2024. https://doi.org/10.25932/publishup-66761

   
