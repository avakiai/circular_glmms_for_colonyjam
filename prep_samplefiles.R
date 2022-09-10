library(tidyverse)
data_path <- c('./../../1-data')

# Load call data and wrangle some summaries...
calls_og <- read.csv(file.path(data_path,'exp_1_call_data.csv')) %>%
  mutate(group = factor(group), 
         order = factor(order), 
         familizarization = factor(familiarization), # grouping variables
         session = as.numeric(session), 
         part = factor(part), # dummy-ready version of condition
         # categorical predictors
         condition = factor(condition, 
                            levels = c("silence","full mask","half mask"))) 



head(calls_og)

dat <- calls_og %>% select(modulation, group, session, condition, minute, start.per)

head(dat)

dat2 <- dat %>% filter(session == 3)

nrow(dat2)


dat3 <- dat2 %>% mutate(condition = case_when(condition == "silence" ~ "A",
                                              condition == "full mask" ~ "B",
                                              condition == "half mask" ~ "C")) %>%
                 mutate(max.per = 1/modulation, .before = "start.per") %>% 
                # convert period of call onsets into phases between 0 and 2pi
                mutate(start.phase = (start.per/max.per)*(2*pi), .before = "start.per") %>%
                select(-max.per)


View(dat3)
write.csv(dat3, "sample_data.csv", row.names = F)
