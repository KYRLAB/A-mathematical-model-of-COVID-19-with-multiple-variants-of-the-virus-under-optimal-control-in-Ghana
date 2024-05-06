---
# A-mathematical-model-of-COVID-19-with-multiple-variants-of-the-virus-under-optimal-control-in-Ghana
This project is provided to share the data and utility code for the paper "A mathematical model of COVID-19 with multiple variants of the virus under optimal control in Ghana," published in PLOS ONE.
Project Overview and Purpose
---

## Installation and Usage
This code is written in MATLAB. To utilize the code, you need to have the Optimization Toolbox installed. Below are the instructions for each folder and file:

- **data folder**: This folder contains the utilized data. The file Ghana_only_covid19_data.csv stores the data organized by the authors.
- **main.m**: This file is for data fitting. You can load the desired data from the data folder using CovidTable = readtable('data/Ghana_only_covid19_data.csv'). Running this file will save the transmission rate and output fitting figures.
- **fitting_result_plot.m**: After running main.m, this file outputs the fitted figure in the required format.
- **optimal_control.m**: This code is for experimenting with optimal control. Variables u1, u2, and u3 are assigned to l, m, and p, respectively. These variables can be modified as needed. The output displays the simulation results of optimal control over time as figures.
- **diffun.m**: This file contains the differential equation system used.
- **call_parameters.m**: This file contains functions to save and load the utilized variables.
- **set_compartments.m**: This file contains functions to load data belonging to the utilized compartments, preprocess them, and export them as output.
- **FitToODE.m**: This code fits the data into the implemented differential equations in diffun.m. The Runge-Kutta 45 ode solver was used.

## Citations
If you use model in your work or conference, please cite us as follows

```
@misc{Youngho-Min-et al-2023,
    author = {Youngho Min, Young Rock Kim, and Young Rock Kim},
    title = {A-mathematical-model-of-COVID-19-with-multiple-variants-of-the-virus-under-optimal-control-in-Ghana},
    year = {2024},
    publisher = {GitHub},
    journal = {GitHub repository},
    howpublished = {\url{https://github.com/KYRLAB/A-mathematical-model-of-COVID-19-with-multiple-variants-of-the-virus-under-optimal-control-in-Ghana}}
}
```

## Contact
**Email**: mathmyh@khu.ac.kr

---
