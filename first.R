x = matrix(rnorm(20*30), 20, 30)
y = apply(x, 2, mean)
z = apply(x, 1, mean)