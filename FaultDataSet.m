clear all;
clc;

%% Crear un objeto que inicia el motor de OpenDSS
DSSObj = actxserver('OpenDSSEngine.DSS');
if ~DSSObj.Start(0)
    disp('Unable to start the OpenDSS Engine')
    return
end
DSSText = DSSObj.Text; % Establece una consola para enviar comandos
DSSCircuit = DSSObj.ActiveCircuit;

%% Compila el circuito
DSSText.Command = 'Compile C:\Users\USER\OneDrive\Escritorio\USAID\OpenDSS\13Bus\IEEE13Nodeckt.dss';

%% Buses y Lineas
buses = [633 634 671 645 646 692 675 611 652 670 632 680];
lineas = [650632 632670 670671 671680 632633 632645 645646 692675 671684 684611 684652];

%% L-L fault Dataset Generation
for i=1:1    
    if i > 1
        cmd1 = sprintf("Fault.fLL%d.enabled = False",i-1);
        DSSText.Command = cmd1;
    end
    cmd2 = sprintf("Fault.fLL%d.enabled = True",i);
    DSSText.Command = cmd2;
    
    DSSText.Command = 'solve mode = daily number=1';
    DSSText.Command = 'Solve';
    
    DSSText.Command = "Export Monitor 650632";
    DSSText.Command = "Export Monitor 632670";
    DSSText.Command = "Export Monitor 670671";
    DSSText.Command = "Export Monitor 671680";
    DSSText.Command = "Export Monitor 632633";
    DSSText.Command = "Export Monitor 632645";
    DSSText.Command = "Export Monitor 645646";
    DSSText.Command = "Export Monitor 692675";
    DSSText.Command = "Export Monitor 671684";
    DSSText.Command = "Export Monitor 684611";
    DSSText.Command = "Export Monitor 684652";
    
    data = table;
    for j=1:12
        
    end
    %Importar voltajes
    %Importar corrientes
    %Importar potencias
    
    %Unificar datos bus de origen, voltajes, corrientes y potencias
end

test = importTest("IEEE13Nodeckt_Mon_684611_1.csv");
