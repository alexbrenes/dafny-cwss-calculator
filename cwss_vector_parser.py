cwss_vector = input()
cwss_vector = cwss_vector[1:-1]
factors = cwss_vector.split('/')
ordered_factors = [None] * 16
factor_idx = {
    'TI':0,
    'AP':1,
    'AL':2,
    'IC':3,
    'FC':4,
    'RP':5,
    'RL':6,
    'AV':7,
    'AS':8,
    'IN':9,
    'SC':10,
    'BI':11,
    'DI':12,
    'EX':13,
    'EC':14,
    'P':15
}
for factor in factors:
    [F, FV] = factor.split(':')
    [_, W] = FV.split(',')
    ordered_factors[factor_idx[F]] = float(W)
print(ordered_factors)
