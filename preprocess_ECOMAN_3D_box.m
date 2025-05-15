clc; clear all; close all;
path_1 = '/Users/poulami/Documents/gmod25/box_3d/test/';
cd(path_1);

output_dir = '/Users/poulami/Documents/gmod25/box_3d/test/';
file = dir ([path_1 'p_19.csv']);filenames = {file.name};    %%%% Load Paraview .csv files here


filenames=natsortfiles(filenames)
A=numel(filenames);

k=1;
for k=1:1

path_file = sprintf('%s',path_1,filenames{k});
fprintf('%i/%i\n', k,A)
tic
table1=make_drexm_3d_for_box_model(path_file, [2, Inf]);


nx1= 436  ;%number of nodes along axis 1
    nx2= 146  ;%number of nodes along axis 2
    nx3= 146  ;%number of nodes along axis 3, set to 1 in 2D
    nodenum=nx1*nx2*nx3;

%A) Load here the Eulerian fields of your geodynamic model
        V1model=  table1.velocity0 ; %velocity along the axis 1
        V1model_sec=[V1model]/3.15e7; % unit conversion from m/year to m/sec
        V2model=  table1.velocity2 ;%velocity along the axis 2
        V2model_sec=[V2model]/3.15e7;
        V3model=  table1.velocity1 ; %velocity along the axis 3
        V3model_sec=[V3model]/3.15e7;
        Tkmodel= table1.T; %Temperature
        Pmodel= table1.p ; %Pressure
        
        % Fdmodel=zeros(nodenum,1);
        time1=table1.Time(k); %total elapsed time
       
       
        time=[time1]*3.154e7; %time in sec

       
        dt= 3.15e13  ; %elapsed time from previous output file, currently every 1 time steps (1 Ma)
       
        
        t=[dt time]; % array with time infos (in sec or adimensional)
  %B)Transform the 1D data from Paraview to D-Rex_M format
        

        
 Tk = zeros(nodenum,1); P = Tk; V1 = Tk; V2 = Tk; V3 = Tk; 
        Fd = ones(nodenum,1);
        for x1=1:nx1
            for x2=1:nx2
                for x3=1:nx3
                    para_gi = x1 + (x2-1)*nx1 + (x3-1)*nx1*nx2;
                    drex_gi = x3 + (x1-1)*nx3 + (x2-1)*nx1*nx3;

                    Tk(drex_gi) = Tkmodel(para_gi);%table1.T(para_gi);
                    P(drex_gi)  = Pmodel(para_gi);%table1.p(para_gi);
                    V1(drex_gi) = V1model_sec(para_gi);%table1.velocity0(para_gi)/3.15e7;
                    V2(drex_gi) = V2model_sec(para_gi);%table1.velocity2(para_gi)/3.15e7;
                    V3(drex_gi) = V3model_sec(para_gi);%table1.velocity1(para_gi)/3.15e7;


                end
            end
        end




 
 


 




 %C)Save arrays in HDF5 format files
       
        fname=['vtp', num2str(19,'%.4d'),'.h5'];  %% original
       system(['rm ',fname])
        % hdf5write(fname,'/rock/Rho',Rho, 'WriteMode', 'append'); %if a particular file needs to be converted with a specific time%
       h5create(fname,'/Nodes/V1',size(V1));
       h5write(fname,'/Nodes/V1',V1);
       h5create(fname,'/Nodes/V2',size(V2));
       h5write(fname,'/Nodes/V2',V2);
       h5create(fname,'/Nodes/V3',size(V3));
       h5write(fname,'/Nodes/V3',V3);
       h5create(fname,'/Nodes/P',size(P));
       h5write(fname,'/Nodes/P',P);
       h5create(fname,'/Nodes/Fd',size(Fd));
       h5write(fname,'/Nodes/Fd',Fd);
       h5create(fname,'/Nodes/Tk',size(Tk));
       h5write(fname,'/Nodes/Tk',Tk);

       
       h5writeatt(fname,'/','Time',t);

       
       

        


       
        disp('moving file');
        movefile(fname,output_dir);
      




end
toc





