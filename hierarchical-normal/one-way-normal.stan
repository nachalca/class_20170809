data {
  int<lower=1> N;
  int<lower=1> J;
  int<lower=1, upper=J> idx_J[N];
  vector[N] y;
}
parameters {
  real alpha;
  vector[J] theta;
  real<lower=0> sigma_y;
  real<lower=0> sigma_theta;
}
model {
  y ~ normal(alpha + theta[idx_J], sigma_y);
  
  sigma_y ~ cauchy(0, 10);
  sigma_theta ~ normal(0, 3);
  alpha ~ normal(100, 20);
  theta ~ normal(0, sigma_theta); 
}
generated quantities {
  vector[N] y_rep;
  
  for (n in 1:N)
    y_rep[n] = normal_rng(alpha + theta[idx_J[n]], sigma_y); 
}
