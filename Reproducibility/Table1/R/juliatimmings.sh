#!/bin/sh

R < 15x100x1.r --no-save
rm pdredge15x100x1.csv  
R < 15x100x4.r --no-save
rm pdredge15x100x4.csv   
R < 15x100x16.r --no-save
rm pdredge15x100x16.csv 
R < 15x100x32.r --no-save
rm pdredge15x100x32.csv 

R < 15x1000x1.r --no-save  
rm pdredge15x1000x1.csv 
R < 15x1000x4.r --no-save  
rm pdredge15x1000x4.csv 
R < 15x1000x16.r --no-save
rm pdredge15x1000x16.csv 
R < 15x1000x32.r --no-save
rm pdredge15x1000x32.csv 

R < 15x10000x1.r --no-save  
rm pdredge15x10000x1.csv 
R < 15x10000x4.r --no-save  
rm pdredge15x10000x4.csv 
R < 15x10000x16.r --no-save
rm pdredge15x10000x16.csv 
R < 15x10000x32.r --no-save
rm pdredge15x10000x32.csv 

R < 20x100x1.r --no-save
rm pdredge20x100x1.csv  
R < 20x100x4.r --no-save
rm pdredge20x100x4.csv   
R < 20x100x16.r --no-save
rm pdredge20x100x16.csv 
R < 20x100x32.r --no-save
rm pdredge20x100x32.csv 

R < 20x1000x1.r --no-save  
rm pdredge20x1000x1.csv 
R < 20x1000x4.r --no-save  
rm pdredge20x1000x4.csv 
R < 20x1000x16.r --no-save
rm pdredge20x1000x16.csv 
R < 20x1000x32.r --no-save
rm pdredge20x1000x32.csv 

R < 20x10000x1.r --no-save  
rm pdredge20x10000x1.csv 
R < 20x10000x4.r --no-save  
rm pdredge20x10000x4.csv 
R < 20x10000x16.r --no-save
rm pdredge20x10000x16.csv 
R < 20x10000x32.r --no-save
rm pdredge20x10000x32.csv 


