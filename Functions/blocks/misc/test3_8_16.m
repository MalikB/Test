%% Demonstrate the effect of various modes on energy consumption
setup
testArr = {'Description' 'Enet' 'Emcu' 'Etrx' 'Emcu/Enet' 'Etrx/Enet'};
for trxLPM = 0:1
    config.trxLPM = trxLPM;
    for LPM = [0 3]
        config.LPM = LPM;
        for n = [1 10 50 100]
            for txDataParam = 0:1
                config.txDataParam = txDataParam;
                [eNet, eMCU, eTRX] = operateCycle(config, n);
                desc = sprintf('trxLPM: %d, mcuLPM: %d, n: %d, txDataParam: %d', trxLPM, LPM, n, txDataParam); 
                row = {desc, eNet, eMCU, eTRX, eMCU/eNet, eTRX/eNet};
                testArr = [testArr; row]; % outputs a cell array with descriptions and values
            end
        end
    end
end
        