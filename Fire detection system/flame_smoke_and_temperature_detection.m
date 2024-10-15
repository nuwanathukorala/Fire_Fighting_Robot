% Simulation parameters
simulationTime = 120;  % Simulation time in seconds
sampleTime = 20;       % Sample time in seconds
time = 0:sampleTime:simulationTime;

% Sensor data arrays
smokeDetect = zeros(size(time));
temperatureSensor = zeros(size(time));

% Water pump activation
waterPump = zeros(size(time));

% Sensor thresholds
smokeThreshold = 60;
temperatureThreshold = 25;  % Adjust based on room temperature (30°C in this case)

% Room temperature
roomTemperature = 30;

% Simulation loop
for i = 1:length(time)
  % Simulate sensor readings
  smoke = rand() * 100;  % Random smoke level (replace with actual sensor data)
  temperature = rand() * 50 + roomTemperature;  % Random temperature + room temperature offset


  % Record sensor data
  smokeDetect(i) = smoke;
  temperatureSensor(i) = temperature;
 

  % Fire detection logic
  fireDetected = false;
  if smoke > smokeThreshold || temperature - roomTemperature > temperatureThreshold 
    fireDetected = true;
  end

  % Water pump activation
  if fireDetected
    waterPump(i) = 1;
  else
    waterPump(i) = 0;
  end

  % Display information
  fprintf('Time: %ds - Smoke: %0.2f, Temperature: %0.2f \n', time(i), smoke, temperature);
  if fireDetected
    fprintf('Fire detected! \n');
  else
    fprintf('No fire detected.\n');
  end

  pause(sampleTime);
end

% Plot the results
figure;

subplot(2,1,1);
stairs(time, smokeDetect, 'b-', 'LineWidth', 1.5);
title('Smoke Detection');
xlabel('Time (seconds)');
ylabel('Smoke Level');
ylim([-10 110]);
grid on;

subplot(2,1,2);
stairs(time, temperatureSensor, 'r-', 'LineWidth', 1.5);
title('Temperature Sensor');
xlabel('Time (seconds)');
ylabel('Temperature (°C)');
ylim([25 45]);
grid on;

