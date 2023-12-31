# The development analyses followed Valerie 2023 NN.
# <Intrinsic activity development unfolds along a sensorimotor–association cortical axis in youth>
library('visreg');
library('mgcv')
library('ggplot2')

rm(list = ls())
root_dir <- 'F:/Cui_Lab/Projects/Connectional_Variability_Gradient/'
working_dir <- paste0(root_dir,'step_06_development_effects/')

p_value <- matrix(0, 2, 1);
partial_R2 <- matrix(0, 2, 1);

file_list <- c('gam_age_alignment_nodal','gam_age_slope_net')
y_name <- c('Gradient alignment','Gradient slope')
i = 1

for (file_name in file_list)
{
  gam.data <- read.csv(paste0(working_dir,file_name,'.csv'));
  gam.model <- gam(Gradient ~ s(Age, k=3) + Gender + HeadMotion, method = "REML", data = gam.data);
  gam.model.results <- summary(gam.model)
  
  gam.nullmodel <- gam(Gradient ~ Gender + HeadMotion, method = "REML", data = gam.data);
  gam.nullmodel.results <- summary(gam.nullmodel)
  
  ##Full versus reduced model anova p-value
  p_value[i] <- anova.gam(gam.nullmodel,gam.model,test='Chisq')$`Pr(>Chi)`[2]
  
  ##Full versus reduced model direction-dependent partial R squared
  ### effect size
  sse.model <- sum((gam.model$y - gam.model$fitted.values)^2)
  sse.nullmodel <- sum((gam.nullmodel$y - gam.nullmodel$fitted.values)^2)
  partial_R2[i] <- (sse.nullmodel - sse.model)/sse.nullmodel
  
  lm.model <- lm(Gradient ~ Age + Gender + HeadMotion, data = gam.data);
  t <- summary(lm.model)$coefficients[2, 3];
  
  if (t < 0) {
    partial_R2[i] <- -partial_R2[i];
  }
  
  ###################
  v <- visreg(gam.model, "Age", plot=FALSE)
  
  color_min = min(v$res$visregRes)
  color_max = max(v$res$visregRes)
  color_mid = mean(v$res$visregRes)
  
  Fig <- plot(v, xlab = "Age (years)", ylab = y_name[i],
              line.par = list(col = '#7499C2'), fill = list(fill = '#D9E2EC'), gg=TRUE,  rug=FALSE) + 
    theme_classic() +
    geom_point(data=v$res, aes(x=Age, y=visregRes, color=visregRes), size=1.5, alpha = 1, shape=19)+
    scale_color_gradient2(low = "#2473B5", high = "#CF1A1D", mid = "#F6FBFF",
                          midpoint = color_mid, limit = c(color_min,color_max))+
    theme(legend.position="none") +
    theme(axis.text=element_text(size=16, color='black'), axis.title=element_text(size=16), aspect.ratio = 1) +
    scale_x_continuous(expand = c(0.01, 0),limits = c(9, 22), breaks = seq(9, 22, by = 2))
  
  Fig <- switch(
    i,
    "1" = Fig + scale_y_continuous(expand = c(0, 0),breaks = seq(0.75, 0.81, by = 0.02)),
    "2" = Fig + scale_y_continuous(expand = c(0, 0),limits = c(0.255, 0.345), breaks = seq(0.26, 0.34, by = 0.02))
  )
  
  Fig
  
  ggsave(paste0(working_dir,file_name,'.png'),plot=Fig,width = 12,height = 10,units = "cm",dpi = 1200)
  
  i = i+1
}

results_table <- data.frame(
  matrices = y_name,
  partial_R2 = partial_R2,
  p_value = p_value
)

results_table <- t(results_table)
write.table(results_table,paste0(working_dir,'gam_development.csv'),sep = ",",col.names = FALSE)

GAM_results <- cbind(round(partial_R2,digits = 2),p_value)
GAM_results
