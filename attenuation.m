clear
clc


eirp = 56; %dbW
f = 20e9;
bw = 50; %MHz



maps = exist('maps.mat','file');
p836 = exist('p836.mat','file');
p837 = exist('p837.mat','file');
p840 = exist('p840.mat','file');
matFiles = [maps p836 p837 p840];
if ~all(matFiles)
    if ~exist('ITURDigitalMaps.tar.gz','file')
        url = 'https://www.mathworks.com/supportfiles/spc/P618/ITURDigitalMaps.tar.gz';
        websave('ITURDigitalMaps.tar.gz',url);
        untar('ITURDigitalMaps.tar.gz');
    else
        untar('ITURDigitalMaps.tar.gz');
    end
    addpath(cd);
end

cfg = p618Config;
cfg.Frequency = 20e9;  % Signal frequency in Hz
cfg.Latitude = 43.2313;      % North direction
cfg.Longitude = -78.4810;    % West direction


elev_range = 5:1:90;

elevation_angle = size(elev_range);
gaseous_attenuation = zeros(elevation_angle);
cloud_attenuation = zeros(elevation_angle);
rain_attenuation = zeros(elevation_angle);
scintillation_attenuation = zeros(elevation_angle);
total_attenuation = zeros(elevation_angle);
for  n = 1:numel(elev_range)
     cfg.ElevationAngle = elev_range(n);
     pl =  p618PropagationLosses(cfg, ...
                            'StationHeight',0.031, ...
                            'Temperature',283.6, ... 
                            'Pressure',1009.48, ...
                            'WaterVaporDensity',13.79);
    gaseous_attenuation(n) = pl.Ag;
    cloud_attenuation(n) = pl.Ac;
    rain_attenuation(n) = pl.Ar;
    scintillation_attenuation(n) = pl.As;
    total_attenuation(n) = pl.At;
end


plot(elev_range,gaseous_attenuation,'--');
hold on;
plot(elev_range,cloud_attenuation,'--');
hold on;
plot(elev_range,rain_attenuation,'--');
hold on;
plot(elev_range,scintillation_attenuation,'--');
hold on;
plot(elev_range,total_attenuation);
legend('Gaseous','Cloud','Rain','Scintillation','Total');
grid on;
xlabel('Elevation Angle (degrees)');
ylabel('Attenuation (dB)');
title('Earth-Space Propagation Losses Versus Elevation Angle');