#!/user/bin/env Rscript
# Rscript to plot simulation output
# Authors: Basanta Khakurel and Sebastian Höhna
# date: 2025-05-30

for (pkg in c(
  "tidyverse", "patchwork", "ggbreak", "pilot",
  "extrafont", "ggridges", "viridis", "pals", "ggview"
)) {
  if (!require(pkg, character.only = TRUE, quietly = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

set_pilot_family(family = "Montserrat")

H <- abs(log(10) / (qnorm(0.975) - qnorm(0.025)))
true_sd <- 2 * H
num_states <- 4
num_cats <- 4

datasets <- c("Tortoises", "Plants", "Cynodonts")
original_tl <- list(
  Tortoises = 3.175,
  Plants    = 10.543,
  Cynodonts = 16.706
)

Models <- c("0.005_SR", "0.05_SR", "0.5_SR", "1_SR", "2_SR", "3_SR", "4_SR", "5_SR", "Mk", "MkG")

make_plot <- function(dataset, original_tl, tag, title_text) {
  sims_data_list <- list()
  for (model in Models) {
    file_path <- paste0(
      "Additional_Simulations/Results_", dataset,
      "/Output_Simulated_Data_", model, "_", num_cats, "_Cats/morpho_sims_median.csv"
    )
    temp_data <- read.csv(file_path)
    temp_data$Model <- model
    temp_data$pct_diff <- ((temp_data$tree_length - original_tl) / original_tl) * 100
    sims_data_list[[model]] <- temp_data
  }

  combined_data <- bind_rows(sims_data_list)

  true_sr_values <- data.frame(
    Model = factor(c("Mk", "MkG", "0.005_SR", "0.05_SR", "0.5_SR", "1_SR", "2_SR", "3_SR", "4_SR", "5_SR")),
    true_rate = c(0, 0, 0.005, 0.05, 0.5, 1, 2, 3, 4, 5)
  )

  true_sd_values <- data.frame(
    Model = factor(c("Mk", "MkG", "0.005_SR", "0.05_SR", "0.5_SR", "1_SR", "2_SR", "3_SR", "4_SR", "5_SR")),
    true_rate = c(NA, true_sd, rep(true_sd, 8))
  )

  combined_data %>%
    filter(Model %in% Models) %>%
    mutate(Model = factor(Model, levels = c("Mk", "MkG", "0.005_SR", "0.05_SR", "0.5_SR", "1_SR", "2_SR", "3_SR", "4_SR", "5_SR"))) %>%
    ggplot(aes(x = sd_category)) +
    geom_point(aes(y = global_switch_rate),
      alpha = 0.6, size = 2.5, shape = 21, color = "gray50", fill = "black"
    ) +
    scale_y_continuous(
      trans = "log10",
      breaks = c(0.005, 0.05, 0.5, 5, 50, 500, 5000),
      labels = c("0.005", "0.05", "0.5", "5", "50", "500", "5000")
    ) +
    scale_x_continuous(limits = c(0, NA)) +
    geom_vline(
      data = true_sd_values, aes(xintercept = true_rate),
      linetype = "dashed", color = "red", linewidth = 0.9
    ) +
    geom_hline(
      data = true_sr_values, aes(yintercept = true_rate),
      linetype = "dashed", color = "blue", linewidth = 0.9
    ) +
    labs(
      x = expression("Standard Deviation (" * sigma * ")"),
      y = expression("Switching Rate (" * delta * ")"),
      title = paste0(tag, " ", title_text)
    ) +
    facet_wrap(~Model,
      nrow = 2,
      labeller = as_labeller(c(
        "0.005_SR" = "0.005", "0.05_SR" = "0.05", "0.5_SR" = "0.5",
        "1_SR" = "1", "2_SR" = "2", "3_SR" = "3", "4_SR" = "4", "5_SR" = "5",
        "Mk" = "0\n(Mk)", "MkG" = "0\n(Mk + ACRV)"
      ))
    ) +
    theme_pilot(
      facet_title_size = 18, axis_title_size = 18,
      axis_text_size = 15, axes = "", grid = ""
    ) +
    theme(
      plot.title = element_text(hjust = 0, vjust = 5, face = "plain", size = 20),
      panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.5),
      legend.position = "none",
      strip.text = element_text(face = "plain"),
      strip.background = element_blank(),
      plot.title.position = "plot",
      strip.placement = "outside"
    ) +
    coord_cartesian(clip = "off")
}

tags <- c("a)", "b)", "c)")
title_texts <- c("Short tree", "Moderate tree", "Long tree")

# Generate plots
plot_args <- list(
  dataset = datasets,
  original_tl = original_tl[datasets],
  tag = tags,
  title_text = title_texts
)

# Generate plots using pmap
plots <- purrr::pmap(plot_args, make_plot)

# Combine into one figure
final_plot <- wrap_plots(plots, ncol = 1)

# Save
ggsave("Plots/Simulations/sr_vs_sd_sims.pdf",
  plot = final_plot, device = cairo_pdf,
  width = 10, height = 18, dpi = 450, limitsize = FALSE, bg = "white"
)
