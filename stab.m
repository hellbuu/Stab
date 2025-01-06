% Autor: Hellder
% Programa: Stab
% Versão 1.0
% Cálculo da contribuição da asa para estabilidade estática longitudinal
% Bibliografia: Fundamentos da Engenharia Aeronáutica

close all; 
clear all;
clc;

% requisitos: cm_alpha < 0 & cm_0 > 0 

% contribuição da asa

% cmacgw -> cm_alpha asa
% cm0cgw -> cm_zero asa
% hcg -> dist cg - bordo de ataque
% hac -> dist ca - bordo de ataque
% cma -> corda media aerodinamica
% cmac -> momento no ca
% cl0w -> cl_aoa = 0
% claw -> cl_alpha da asa
% e0
% arw
% cm0t
% vh
% n
% clat
% iw
% it 

cmac = 0;
cl0w = 0;
hcg = 0;
hac = 0;
cma = 0;
claw = 0;
e0 = 0;
arw = 0;
cm0t = 0;
vh = 0;
n = 0;
clat = 0;
iw = 0;
it = 0;

dados = {cmac, cl0w, hcg, hac, cma, claw, arw, cm0t, vh, n, clat, iw, it};

mensagens = {
    'Insira o cmac: ',
    'Insira o cl0: ',
    'Insira o hcg: ',
    'Insira o hac: ',
    'Insira o cma: ',
    'Insira o claw: ',
    'Insira o arw: ',
    'Insira o cm0t: ',
    'Insira o vh: ',
    'Insira o n: ',
    'Insira o clat: ',
    'Insira a iw: ',
    'Insira a it: '
};

for i = 1:13
    dados{i} = input(mensagens{i});
end

cmac = dados{1};
cl0w = dados{2};
hcg = dados{3};
hac = dados{4};
cma = dados{5};
claw = dados{6};
arw = dados{7};
cm0t = dados{8};
vh = dados{9};
n = dados{10};
clat = dados{11};
iw = dados{12};
it = dados{13};

cmacgw = claw * ((hcg / cma) - (hac / cma));
cm0cgw = cmac + cl0w * ((hcg / cma) - (hac / cma));

valores_cmcgw = zeros(1, 15);

for aoa = 1:15
    cmcgw = cm0cgw + (cmacgw * aoa);
    valores_cmcgw(aoa) = cmcgw;
    % fprintf('Para aoa = %d, cmcgw = %.5f\n', aoa, cmcgw);
end

e0 = (57.3 * 2 * cl0w) / (pi * arw);

cm0t = vh * n * clat * (iw - it + e0);

de_da = (57.3 * 2 * claw) / (pi * arw);

cmat = - vh * n * clat * (1 - de_da);
cmcgt = cm0t + cmat * aoa;

valores_cmcgt = zeros(1, 15);

for aoa = 1:15
    cmcgt = cm0t + (cmat * aoa);
    valores_cmcgt(aoa) = cmcgt;
    % fprintf('Para aoa = %d, cmcgt = %.5f\n', aoa, cmcgt);
end

% gráfico contribuição asa 
figure;
plot(1:15, valores_cmcgw, '-o', 'LineWidth', 2, 'MarkerSize', 6);
title('Gráfico de C_m_cg_w vs. AoA');
xlabel('Ângulo de Ataque (AoA)');
ylabel('C_m_cg_w');
xlim([0 15]);
ylim([-0.19 0.16]);
grid on; 

% gráfico contribuição empenagem
figure;
plot(1:15, valores_cmcgt, '-o', 'LineWidth', 2, 'MarkerSize', 6);
title('Gráfico de C_m_cg_t vs. AoA');
xlabel('Ângulo de Ataque (AoA)');
ylabel('C_m_cg_t');
xlim([0 15]);
ylim([-0.19 0.16]);
grid on; 
