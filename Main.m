%%
%% Main
%%
warning off
clear all
clc
close all
choice2 = questdlg('Select  a Algorithm!', ...
    'Select  Dataset', ...
    'Gravitational Search Algorithm','Binnery Gravitational Search Algorithm','No thank you');
% Handle response
switch choice2
    case 'Gravitational Search Algorithm'
        disp([choice2 ' , Selected.'])
      GSA                                   % Call GSA Function 
    case 'Binnery Gravitational Search Algorithm'
        disp([choice2 ' , Selected.'])
        BGSA                             % Call BGSA Function
end
