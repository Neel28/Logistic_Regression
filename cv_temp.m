load fisheriris

indices = crossvalind('Kfold',species,10);
test = (indices == 1); train = ~test;