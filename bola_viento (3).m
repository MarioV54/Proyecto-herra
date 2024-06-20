clear
clc
% Solicitud de entrada del usuario
m = input("Ingrese la masa de la bola (kg): "); % masa en kg
while m <= 0
    disp("La masa debe ser un valor positivo.");
    m = input("Ingrese la masa de la bola (kg): ");
end

L = input("Ingrese la longitud de la cuerda (m): "); % longitud de la cuerda en m
while L <= 0
    disp("La longitud de la cuerda debe ser un valor positivo.");
    L = input("Ingrese la longitud de la cuerda (m): ");
end

g = 9.81; % aceleración debido a la gravedad en m/s^2

% Rango de fuerzas F
F = linspace(0, 1000, 1000); % generando 1000 valores para F

% Cálculo de la altura máxima H como función de F
H = (2 * F.^2 * L) ./ (F.^2 + (m * g)^2);

% Crear la gráfica
figure;
plot(F, H, 'b-', 'LineWidth', 2); % gráfica de H
xlabel('Fuerza del viento F (N)');
ylabel('Altura máxima alcanzada H (m)');
title('Altura máxima alcanzada en función de la fuerza del viento');
grid on;

% Evaluación de H para F = 1.00 N y F = 10.0 N
F1 = 1.00; % Fuerza en N
H1 = (2 * F1^2 * L) / (F1^2 + (m * g)^2);
F10 = 10.0; % Fuerza en N
H10 = (2 * F10^2 * L) / (F10^2 + (m * g)^2);
Fa = input("Ingrese una fuerza para la animacion: "); % Fuerza en N
Ha = (2 * Fa^2 * L) / (Fa^2 + (m * g)^2);
% Mostrar los resultados
fprintf('Para una fuerza del viento de F = 1.00 N, la altura máxima alcanzada es %.4f m\n', H1);
fprintf('Para una fuerza del viento de F = 10.0 N, la altura máxima alcanzada es %.4f m\n', H10);
fprintf('Para una fuerza del viento de F = %s N, la altura máxima alcanzada es %.4f m\n', num2str(Fa), Ha);

% Añadir puntos específicos a la gráfica
hold on;
plot(F1, H1, 'ro', 'MarkerSize', 8, 'DisplayName', 'F = 1.00 N');
plot(F10, H10, 'go', 'MarkerSize', 8, 'DisplayName', 'F = 10.0 N');
plot(Fa, Ha, 'bo', 'MarkerSize', 8, 'DisplayName', 'F = 10.0 N');
legend('H en función de F', 'F = 1.00 N', 'F = 10.0 N', ['F = ', num2str(Fa), ' N']);
hold off;

% Simulación de la situación
fprintf('\nImagine que una bola de masa %0.2f kg está colgada de una cuerda de longitud %0.2f m.\n', m, L);
disp('El viento sopla constantemente hacia la derecha, haciendo que la bola se balancee.');
disp('La altura máxima alcanzada por la bola antes de volver a balancearse hacia abajo depende de la fuerza del viento aplicada.');
disp('El programa calcula y grafica la altura máxima alcanzada en función de la fuerza del viento.');
disp(['Además, muestra la altura máxima para una fuerza de viento de 1.00 N, 10.0 N y ' num2str(Fa) ' N'])


% Resolviendo para encontrar la altura máxima H y theta_max
H_anim = (2 * Fa^2 * L) / (Fa^2 + (m * g)^2);
theta_max = acos((L - H_anim) / L);

% Tiempo de simulación
t_max = 2 * sqrt(2 * L / g);  % tiempo estimado para el balanceo completo
dt = 0.01;  % incremento de tiempo
t = 0:dt:t_max;

% Inicialización de la figura
figure;
axis equal;
axis([-1.5*L 1.5*L -1.5*L 1.5*L]);  % Ajustamos los límites del eje para que Y positivo sea visible
hold on;
line([-1.5*L 1.5*L], [0 0], 'Color', 'k', 'LineWidth', 1.5);  % suelo
pivot = plot(0, 0, 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
ball = plot(0, -L, 'ro', 'MarkerSize', 20, 'MarkerFaceColor', 'r');
rod = plot([0 0], [0 -L], 'k', 'LineWidth', 2);
title('Animación de la bola bajo la influencia del viento');
xlabel('X (m)');
ylabel('Y (m)');

% Animación
for i = 1:length(t)
    theta = theta_max * cos(sqrt(g/L) * t(i));  % Ángulo en el tiempo t
    x = L * sin(theta);  % Coordenada X
    y = -L * cos(theta); % Coordenada Y (negativa porque es hacia abajo)
    
    % Actualizar la posición de la bola y la cuerda
    set(ball, 'XData', x, 'YData', y);
    set(rod, 'XData', [0 x], 'YData', [0 y]);
    
    drawnow;
end

