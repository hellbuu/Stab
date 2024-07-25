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

cmac = 0;
cl0w = 0;
hcg = 0;
hac = 0;
cma = 0;
claw = 0;

dados = {cmac, cl0w, hcg, hac, cma, claw};

mensagens = {
    'Insira o cmac: ',
    'Insira o cl0: ',
    'Insira o hcg: ',
    'Insira o hac: ',
    'Insira o cma: ',
    'Insira o claw: '
};

for i = 1:6
    dados{i} = input(mensagens{i});
end

cmac = dados{1};
cl0w = dados{2};
hcg = dados{3};
hac = dados{4};
cma = dados{5};
claw = dados{6};

cmacgw = claw * ((hcg / cma) - (hac / cma));
cm0cgw = cmac + cl0w * ((hcg / cma) - (hac / cma));

valores_cmcgw = zeros(1, 15);

for aoa = 1:15
    cmcgw = cm0cgw + (cmacgw * aoa);
    valores_cmcgw(aoa) = cmcgw;
    % fprintf('Para aoa = %d, cmcgw = %.5f\n', aoa, cmcgw);
end

figure;
plot(1:15, valores_cmcgw, '-o', 'LineWidth', 2, 'MarkerSize', 6);
title('Gráfico de C_m_cg_w vs. AoA');
xlabel('Ângulo de Ataque (AoA)');
ylabel('C_m_cg_w');
xlim([0 15]);
ylim([-0.19 0.16]);
grid on; 
