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

dat <- calls_og %>% select(modulation, group, session, part, condition, minute, starts, ends, starts.sp, ends.sp, start.per, end.per)

head(dat)

dat2 <- dat %>% filter(session == 3)

nrow(dat2)


dat3 <- dat2 %>% mutate(condition = case_when(condition == "silence" ~ "A",
                                              condition == "full mask" ~ "B",
                                              condition == "half mask" ~ "C"))


View(dat3)
write.csv(dat3, "sample_data.csv", row.names = F)
