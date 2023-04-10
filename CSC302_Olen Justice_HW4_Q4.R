#Olen Justice
#CSC 302
#HW4 Question 4

#Changed date to start at 01-01-2015 nad changed colors to blue, yellow and red. 
# scale_x_date(name = "year",
#limits = ymd(min("2015-01-01"), ymd("2017-01-01"))) +
 # scale_color_manual(values = c("blue", "yellow", "red")


library(magrittr)
load("~/UofM-Flint/CSC 302/Rstudio/Rscripts/preprint_growth.rda") #please change the path if needed
head(preprint_growth)
preprint_growth %>% filter(archive == "bioRxiv") %>%
  filter(count > 0) -> biorxiv_growth
preprints<-preprint_growth %>% filter(archive %in%
                                        c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")) %>%filter(count > 0) %>%
  mutate(archive = factor(archive, levels = c("bioRxiv", "arXiv q-bio", "PeerJ Preprints")))

preprints_final <- filter(preprints, date == ymd("2015-01-01"))
ggplot(preprints) +
  aes(date, count, color = archive, fill = archive) +
  geom_line(size = 1) +
  scale_y_continuous(
    limits = c(0, 600), expand = c(0, 0),
    name = "preprints / month",
    sec.axis = dup_axis( #this part is for the second y axis
      breaks = preprints_final$count, #and we use the counts to position our labels
      labels = c("arXivq-bio", "PeerJPreprints", "bioRxiv"),
      name = NULL)
  ) +
  scale_x_date(name = "year",
               limits = ymd(min("2015-01-01"), ymd("2017-01-01"))) +
  scale_color_manual(values = c("blue", "yellow", "red"),
                     name = NULL) +
  theme(legend.position = "none")

