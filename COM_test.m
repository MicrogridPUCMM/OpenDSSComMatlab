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
%DSSText.Command = 'batchedit load..* Vmin=0.8';

%% Caso 1: Sin cambios (Generador activado a 1MW, todas las cargas conectadas y a su potencia predefinida)
DSSText.Command = 'Close Line.671692';
DSSText.Command = 'Close Line.GENSW';
DSSText.Command = 'Generator.GEN632.kw = 1000';
DSSText.Command = 'Load.671.kw = 1155';
DSSText.Command = 'Load.671.kvar = 660';
DSSText.Command = 'solve mode=snap';
DSSText.Command = 'Solve';
DSSText.Command = 'Export Losses Exported\TEST_LOSSES.csv';
DSSText.Command = 'Export Voltages Exported\TEST_VOLTAGES.csv';
DSSText.Command = 'Export Currents Exported\TEST_CURRENTS.csv';
DSSText.Command = 'Export Powers MVA Exported\TEST_POWERS.csv';
%DSSText.Command = 'Show Powers';

% Datos de perdidas y potencia
LossesImport
PowerImport
loss1 = total_loss;
power1 = total_power;
losses1 = losses;
powers1 = powers;

%% Caso 2: Abriendo SW 671692
DSSText.Command = 'Open Line.671692';
DSSText.Command = 'Close Line.GENSW';
DSSText.Command = 'solve mode=snap';
DSSText.Command = 'Solve';
DSSText.Command = 'Export Losses Exported\TEST_LOSSES.csv';
DSSText.Command = 'Export Powers MVA Exported\TEST_POWERS.csv';
%DSSText.Command = 'Show Powers';

% Datos de perdidas y potencia
LossesImport
PowerImport
loss2 = total_loss;
power2 = total_power;
losses2 = losses;
powers2 = powers;

%% Caso 3: Desconectando generador
DSSText.Command = 'Close Line.671692';
DSSText.Command = 'Open Line.GENSW';
DSSText.Command = 'solve mode=snap';
DSSText.Command = 'Solve';
DSSText.Command = 'Export Losses Exported\TEST_LOSSES.csv';
DSSText.Command = 'Export Powers MVA Exported\TEST_POWERS.csv';
%DSSText.Command = 'Show Powers';

% Datos de perdidas y potencia
LossesImport
PowerImport
loss3 = total_loss;
power3 = total_power;
losses3 = losses;
powers3 = powers;

%% Caso 4: Aumentando potencia de generacion de GEN632
DSSText.Command = 'Close Line.671692';
DSSText.Command = 'Close Line.GENSW';
DSSText.Command = 'Generator.GEN632.kw = 10000';
DSSText.Command = 'solve mode=snap';
DSSText.Command = 'Solve';
DSSText.Command = 'Export Losses Exported\TEST_LOSSES.csv';
DSSText.Command = 'Export Powers MVA Exported\TEST_POWERS.csv';
%DSSText.Command = 'Show Powers';

% Datos de perdidas y potencia
LossesImport
PowerImport
loss4 = total_loss;
power4 = total_power;
losses4 = losses;
powers4 = powers;

%% Caso 5: Disminuyendo consumo de carga 671 al 10%
DSSText.Command = 'Close Line.671692';
DSSText.Command = 'Close Line.GENSW';
DSSText.Command = 'Generator.GEN632.kw = 1000';
DSSText.Command = 'Load.671.kw = 115.5';
DSSText.Command = 'Load.671.kvar = 66';
DSSText.Command = 'solve mode=snap';
DSSText.Command = 'Solve';
DSSText.Command = 'Export Losses Exported\TEST_LOSSES.csv';
DSSText.Command = 'Export Powers MVA Exported\TEST_POWERS.csv';
%DSSText.Command = 'Show Powers';

% Datos de perdidas y potencia
LossesImport
PowerImport
loss5 = total_loss;
power5 = total_power;
losses5 = losses;
powers5 = powers;

%% Resumen
loss = [loss1, loss2, loss3, loss4, loss5];
power = [power1, power2, power3, power4, power5];

figure(1);
bar(loss);
title("Total Losses")
xlabel("Cases")
ylabel("Losses (kW)")

figure(2)
bar(power)
title("Total Power")
xlabel("Cases")
ylabel("Power (MW)")
