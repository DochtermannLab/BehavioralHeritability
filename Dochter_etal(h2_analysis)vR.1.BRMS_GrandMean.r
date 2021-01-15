#### BRMS Global Mean ####
library(brms);library(MCMCglmm)
h2.prior2<-get_prior(Heritability+.001~ 1 + (1|phylo)+(1|Study.ID), data=Data, family=Beta)
h2.mcmc<- brm(Heritability+.001~ 1 +(1|phylo)+ (1|Study.ID), 
              family = Beta, data = Data, prior= h2.prior2,
              control = list(adapt_delta = 0.99),
              chains = 8, cores = 4, iter = 10000, warmup = 2500)

plot(h2.mcmc)
x<-posterior_samples(h2.mcmc,"Intercept")
summary(h2.mcmc)
posterior.mode(as.mcmc(plogis(x$b_Intercept)))
HPDinterval(as.mcmc(plogis(x$b_Intercept)))
plot(as.mcmc(plogis(x$b_Intercept)))