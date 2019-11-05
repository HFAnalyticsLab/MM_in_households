# =======================================================
# Project: Multimorbidity in Households
# Purpose: Run two-part models to estimate activity and cost of primary and secondary health care by level of household multimorbidity
# Author: Mai Stafford & Kathryn Dreyer
# Date: 01/11/2019
# =======================================================


##########################################################################################
# 1. Hospital costs (APC + OP + AE)

#part1
logistic.fit <- glm(anyhosp ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(hosp_cost ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$hosp_cost>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit))) # exponentiated coeff is the factor by which the arithmetic mean outcome on the original scale is multiplied. e.g. the expected hosp cost is 1.25 times higher for women cf men

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(hosp_cost=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")


##########################################################################################
# 2. Elective and non-elective admission costs

#Elective

#part1
logistic.fit <- glm(anyelect ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(elect_cost ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$elect_cost>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit))) # exponentiated coeff is the factor by which the arithmetic mean outcome on the original scale is multiplied. e.g. the expected hosp cost is 1.25 times higher for women cf men

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(elect_cost=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")



#Non-elective

#part1
logistic.fit <- glm(anyemerg ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(em_cost ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$em_cost>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit))) # exponentiated coeff is the factor by which the arithmetic mean outcome on the original scale is multiplied. e.g. the expected hosp cost is 1.25 times higher for women cf men

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(em_cost=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")


##########################################################################################
# 3. LOS
# part1

logistic.fit <- glm(anylos ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(total_los ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$total_los>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit))) 

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(total_los=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")



##########################################################################################
# 3. A&E 

#part1
logistic.fit <- glm(anyae ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(ae_cost ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$ae_cost>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit))) # exponentiated coeff is the factor by which the arithmetic mean outcome on the origianl scale is multiplied. e.g. the expected hosp cost is 1.25 times higher for women cf men

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(ae_cost=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")




##########################################################################################
# 4. OP 

#part1
logistic.fit <- glm(anyop ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(op_cost ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$op_cost>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit)))

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(op_cost=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")




##########################################################################################
# 5. Primary care contacts

logistic.fit <- glm(anyprim ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(p_contacts ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$p_contacts>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit))) 

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(p_contacts=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")



##########################################################################################
# 6. Primary care costs

logistic.fit <- glm(anyprim ~ selfother + female + agec_at50 + imd2015_10, data_for_glm, family=binomial())
summary(logistic.fit)
exp(cbind(OR=coef(logistic.fit), confint(logistic.fit)))

#part2
gamma.fit <- glm(p_cost ~ selfother + female + agec_at50 + imd2015_10, family = Gamma( link = log), data_for_glm[data_for_glm$p_cost>0,])
gamma.fit
exp(cbind(OR=coef(gamma.fit), confint(gamma.fit))) 

phat <- predict(logistic.fit, data_for_glm, type="response")
pred <- data.table(p_cost=data_for_glm)
pred$gamma <- phat * predict(gamma.fit, data_for_glm, type="response")





