
* Load the data
use "[file location removed]\data_for_glm.dta"

* Two part model for primary care cost as a function of household multimorbidity, age, gender and IMD allowing for clustering of individuals within households
twopm p_cost i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother

* Repeats the model for other outcomes
twopm p_contacts i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother
twopm op_cost i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother
twopm ae_cost i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother
twopm elect_cost i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother
twopm em_cost i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother
twopm apc_cost i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother
twopm hosp_cost i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother
twopm total_los i.selfother i.agec_at50 i.female i.imd2015_10, cluster(pracfamnumber) firstpart(logit) secondpart(glm, family(gamma) link(log))
margins i.selfother

