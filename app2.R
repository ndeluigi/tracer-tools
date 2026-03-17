#install.packages(c("shiny", "DT", "ggplot2", "dplyr", "qrcode", "jsonlite"))

library(shiny)
library(DT)
library(ggplot2)
library(dplyr)
library(qrcode)
library(jsonlite)

# Define UI
ui <- fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      tabsetPanel(id = "sidebar_tabs",
                  # Q_salt tab
                  tabPanel("Q_salt",
                           h3("Salt dilution discharge"),
                           numericInput("mass_salt", 
                                        "Mass of Salt Added (g)", 
                                        value = 1000, 
                                        min = 0),
                           numericInput("background_cond", 
                                        "Background Conductivity (µS/cm)", 
                                        value = 359, 
                                        min = 0),
                           numericInput("time_step", 
                                        "Time Step for Logging (s)", 
                                        value = 1, 
                                        min = 1),
                           
                           hr(),
                           
                           h4("Conductivity data"),
                           helpText("Paste conductivity values (one per line or comma/space separated)"),
                           textAreaInput("conductivity_data", 
                                         "Conductivity Timeseries (µS/cm)", 
                                         rows = 10,
                                         value = "359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359.4\n359.6\n359.3\n359.2\n361.6\n375.2\n419.2\n487.4\n530\n559.4\n557.4\n542.4\n483.6\n454.55\n425.5\n419.1\n408.5\n394.3\n381\n369.2\n366.6\n358.6\n360\n362.1\n361\n361\n360.2\n348\n357.9"),
                           
                           actionButton("calculate_salt", "Calculate Q from Salt", class = "btn-primary")
                  ),
                  
                  # Q_rhoWT tab
                  tabPanel("Q_rhoWT",
                           h3("Rhodamine WT discharge"),
                           numericInput("mass_rhodamine_injected", 
                                        "Mass of Rhodamine WT Injected (g)", 
                                        value = 3, 
                                        min = 0,
                                        step = 0.01),
                           numericInput("background_fluorescence", 
                                        "Background Fluorescence (RFU or ppb)", 
                                        value = 0.01, 
                                        min = -2,
                                        step = 0.01),
                           numericInput("time_step_rho", 
                                        "Time Step for Logging (s)", 
                                        value = 1, 
                                        min = 1),
                           numericInput("water_temperature_rho", 
                                        "Water Temperature (°C)", 
                                        value = 5, 
                                        min = 0, 
                                        max = 30,
                                        step = 0.1),
                           
                           hr(),
                           
                           h4("Fluorescence data"),
                           helpText("Paste fluorescence values (one per line or comma/space separated)"),
                           textAreaInput("fluorescence_data", 
                                         "Fluorescence Timeseries (RFU or ppb)", 
                                         rows = 10,
                                         value = "0.01\n0.05\n0.01\n0.05\n0.05\n0.05\n0.01\n0.05\n0.01\n0.05\n0.05\n0.01\n0.05\n0.05\n0.01\n0.05\n0.05\n0.05\n0.05\n0.05\n0.01\n0.01\n0.01\n0.05\n0.05\n0.05\n0.05\n0.05\n0.01\n0.1\n0.05\n0.05\n0.1\n0.05\n0.1\n0.14\n0.14\n0.14\n0.18\n0.26\n0.35\n0.52\n0.56\n0.73\n1.19\n1.28\n2.12\n2.17\n2.21\n2.76\n2.93\n3.18\n4.11\n4.78\n4.99\n6.39\n7.19\n7.49\n7.82\n9.68\n10.19\n12.01\n12.43\n13.78\n14.62\n15\n15.26\n16.4\n18\n19.14\n20.33\n21.09\n22.1\n22.27\n23.87\n24.85\n25.35\n25.73\n26.49\n26.92\n27.17\n28.01\n28.39\n28.65\n28.73\n28.98\n29.28\n29.7\n29.7\n29.79\n29.66\n29.66\n29.75\n29.66\n29.45\n29.24\n29.2\n28.86\n28.9\n28.39\n27.72\n27.55\n27.55\n26.92\n27\n26.66\n26.28\n26.2\n25.86\n25.35\n25.35\n24.89\n24.38\n24\n23.45\n23.11\n22.48\n21.13\n20.83\n20.5\n19.95\n19.95\n19.4\n18.72\n18.34\n17.67\n16.99\n17.07\n17.16\n17.12\n16.44\n15.93\n15.47\n15.3\n14.84\n14.16\n14.33\n14.16\n13.61\n12.98\n12.77\n12.39\n11.84\n11.84\n11.25\n11.03\n11.12\n10.27\n10.06\n9.98\n9.6\n9.85\n9.01\n8.97\n8.54\n8.33\n8.04\n7.87\n7.53\n7.19\n7.06\n6.94\n6.73\n6.47\n6.18\n6.26\n5.97\n5.71\n5.25\n5.42\n5.16\n4.99\n4.91\n4.78\n4.32\n4.32\n4.15\n4.11\n4.11\n3.85\n3.6\n3.69\n3.56\n3.43\n3.14\n3.14\n3.09\n2.93\n2.59\n2.63\n2.67\n2.59\n2.46\n2.29\n2.29\n2.25\n2.12\n2.12\n2.04\n1.91\n1.91\n1.79\n1.66\n1.74\n1.57\n1.53\n1.49\n1.49\n1.45\n1.4\n1.32\n1.28\n1.32\n1.24\n1.11\n1.19\n1.07\n1.02\n0.98\n0.98\n0.98\n0.94\n0.94\n0.86\n0.81\n0.77\n0.77\n0.73\n0.64\n0.64\n0.64\n0.6\n0.6\n0.6\n0.56\n0.56\n0.52\n0.52\n0.48\n0.48\n0.48\n0.48\n0.39\n0.39\n0.39\n0.39\n0.35\n0.35\n0.35\n0.31\n0.31\n0.35\n0.31\n0.31\n0.31\n0.26\n0.26\n0.26\n0.26\n0.26\n0.26\n0.18\n0.18\n0.26\n0.18\n0.18\n0.26\n0.18\n0.18\n0.18\n0.18\n0.14\n0.18\n0.14\n0.14\n0.18\n0.14\n0.18\n0.14\n0.14\n0.14\n0.14\n0.1\n0.14\n0.14\n0.1\n0.1"),
                           
                           actionButton("calculate_rhodamine", "Calculate Q from Rhodamine", class = "btn-primary")
                  ),
                  
                  # Injections tab
                  tabPanel("Injections",
                           h3("Tracer mass calculator"),
                           helpText("Calculate required masses for arabinose, glucose, and rhodamine WT based on salt slug test."),
                           
                           h4("Salt slug test parameters"),
                           numericInput("mass_salt_inj", 
                                        "Mass of Salt Added (g)", 
                                        value = 1000, 
                                        min = 0),
                           numericInput("background_cond_inj", 
                                        "Background Conductivity (µS/cm)", 
                                        value = 359, 
                                        min = 0),
                           numericInput("time_step_inj", 
                                        "Time Step for Logging (s)", 
                                        value = 1, 
                                        min = 1),
                           numericInput("water_temperature", 
                                        "Water Temperature (°C)", 
                                        value = 5, 
                                        min = 0, 
                                        max = 30,
                                        step = 0.1),
                           
                           hr(),
                           
                           h4("Target tracer concentrations"),
                           numericInput("target_arabinose", 
                                        "Target Arabinose Increase (ppb)", 
                                        value = 100, 
                                        min = 0),
                           numericInput("target_glucose", 
                                        "Target Glucose Increase (ppb)", 
                                        value = 100, 
                                        min = 0),
                           numericInput("target_rhodamine", 
                                        "Target Rhodamine WT Increase (ppb)", 
                                        value = 30, 
                                        min = 0),
                           helpText("ppb = µg/L. Mass will be calculated based on effective width."),
                           
                           hr(),
                           
                           h4("Conductivity data for injections"),
                           helpText("Paste conductivity values from salt slug test (one per line or comma/space separated)"),
                           textAreaInput("conductivity_data_inj", 
                                         "Conductivity Timeseries (µS/cm)", 
                                         rows = 10,
                                         value = "359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359\n359.4\n359.6\n359.3\n359.2\n361.6\n375.2\n419.2\n487.4\n530\n559.4\n557.4\n542.4\n483.6\n454.55\n425.5\n419.1\n408.5\n394.3\n381\n369.2\n366.6\n358.6\n360\n362.1\n361\n361\n360.2\n348\n357.9"),
                           
                           actionButton("calculate_injections", "Calculate Tracer Masses", class = "btn-success")
                  ),
                  
                  # Settings tab
                  tabPanel("Settings",
                           h3("Global settings"),
                           
                           h4("Calibration parameters"),
                           numericInput("calib_value", 
                                        "Calibration Value (1/b)", 
                                        value = 1915.89616, 
                                        step = 0.00001),
                           helpText("b = 1 / calibration value, in (g/L)/(µS/cm)"),
                           
                           hr(),
                           
                           h4("Rhodamine WT parameters"),
                           numericInput("rhodamine_concentration", 
                                        "Rhodamine WT Solution Concentration (%)", 
                                        value = 23.83, 
                                        min = 0, 
                                        max = 100,
                                        step = 0.01),
                           numericInput("rhodamine_temp_coeff", 
                                        "Rhodamine Temperature Coefficient (°C⁻¹)", 
                                        value = 0.026, 
                                        min = 0.020, 
                                        max = 0.030,
                                        step = 0.001),
                           helpText("Rhodamine mass accounts for solution concentration."),
                           helpText("Temperature correction: Fluorescence decreases ~2-3% per °C. Masses are corrected to 25°C reference."),
                           
                           hr(),
                           
                           h4("Sampling strategy"),
                           numericInput("n_samples_breakthrough", 
                                        "Samples During Breakthrough Curve", 
                                        value = 13, 
                                        min = 3,
                                        max = 100),
                           helpText("Number of samples to collect during the breakthrough curve (excluding background)."),
                           helpText("One sample should capture the peak, others spread to represent the full curve.")
                  )
      ),
      
      hr(),
      
      downloadButton("download_report", "Download Report (CSV)")
    ),
    
    mainPanel(
      tabsetPanel(id = "tabs",
                  tabPanel("Results",
                           h3("Discharge calculation results"),
                           uiOutput("results_summary"),
                           
                           # Only show tracer mass requirements for Injections workflow
                           conditionalPanel(
                             condition = "output.show_tracer_masses",
                             hr(),
                             h4("Tracer mass requirements"),
                             uiOutput("tracer_mass_results")
                           ),
                           
                           hr(),
                           h4("Calculation details"),
                           verbatimTextOutput("calculation_details")
                  ),
                  
                  tabPanel("Data Table",
                           DTOutput("data_table")
                  ),
                  
                  tabPanel("Plot",
                           plotOutput("conductivity_plot", height = "500px"),
                           hr(),
                           plotOutput("concentration_plot", height = "500px")
                  ),
                  
                  tabPanel("Method",
                           # Show method based on current calculation
                           uiOutput("method_content")
                  )
                  
                  # Sampling tab will be added dynamically
      )
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  
  # Reactive values to store calculation results
  calc_results <- reactiveValues(
    Q = NULL,
    data = NULL,
    b = NULL,
    sum_cond = NULL,
    count_cond = NULL,
    total_excess = NULL,
    integral = NULL,
    area_under_curve = NULL,
    peak_excess = NULL,
    w_eff = NULL,
    mass_arabinose = NULL,
    mass_glucose = NULL,
    mass_rhodamine = NULL,
    temp_correction_factor = NULL,
    sampling_times = NULL,
    breakthrough_start_idx = NULL,
    breakthrough_end_idx = NULL,
    calculation_method = NULL  # Track which method was used: "salt" or "rhodamine"
  )
  
  # Parse conductivity data
  parse_conductivity <- reactive({
    text <- input$conductivity_data
    # Split by newlines, commas, spaces, or tabs
    values <- unlist(strsplit(text, "[,\\s\n\t]+"))
    # Remove empty strings
    values <- values[values != ""]
    # Convert to numeric
    as.numeric(values)
  })
  
  # Parse fluorescence data
  parse_fluorescence <- reactive({
    text <- input$fluorescence_data
    # Split by newlines, commas, spaces, or tabs
    values <- unlist(strsplit(text, "[,\\s\n\t]+"))
    # Remove empty strings
    values <- values[values != ""]
    # Convert to numeric
    as.numeric(values)
  })
  
  # Parse conductivity data for injections (independent from Q_salt)
  parse_conductivity_inj <- reactive({
    text <- input$conductivity_data_inj
    # Split by newlines, commas, spaces, or tabs
    values <- unlist(strsplit(text, "[,\\s\n\t]+"))
    # Remove empty strings
    values <- values[values != ""]
    # Convert to numeric
    as.numeric(values)
  })
  
  # Calculate discharge from salt when button is clicked
  observeEvent(input$calculate_salt, {
    # Get inputs
    M <- input$mass_salt
    background <- input$background_cond
    dt <- input$time_step
    b <- 1 / input$calib_value
    
    # Parse conductivity data
    conductivity <- parse_conductivity()
    
    # Validate data
    if (length(conductivity) == 0 || any(is.na(conductivity))) {
      showNotification("Error: Invalid conductivity data. Please check your input.", 
                       type = "error")
      return()
    }
    
    # Calculate discharge using Excel formula
    sum_cond <- sum(conductivity)
    count_cond <- length(conductivity)
    total_excess <- sum_cond - background * count_cond
    integral <- total_excess * b * dt
    
    if (integral <= 0) {
      showNotification("Error: Integral is zero or negative. Check your inputs.", 
                       type = "error")
      return()
    }
    
    Q <- M / integral
    
    # Create data frame with time series
    time_sec <- seq(0, (count_cond - 1) * dt, by = dt)
    concentration <- (conductivity - background) * b
    excess_conductivity <- conductivity - background
    
    data_df <- data.frame(
      Time_s = time_sec,
      Time_min = time_sec / 60,
      Conductivity_uS_cm = conductivity,
      Excess_Conductivity = excess_conductivity,
      Concentration_g_L = concentration
    )
    
    # Store basic results (Q_salt only calculates discharge, not tracer masses)
    calc_results$Q <- Q
    calc_results$data <- data_df
    calc_results$b <- b
    calc_results$sum_cond <- sum_cond
    calc_results$count_cond <- count_cond
    calc_results$total_excess <- total_excess
    calc_results$integral <- integral
    
    # Store breakthrough curve parameters for potential use in Injections tab
    excess_conductivity_vec <- conductivity - background
    area_under_curve <- sum(excess_conductivity_vec) * dt  # µS/cm * s
    peak_excess <- max(excess_conductivity_vec)  # µS/cm
    w_eff <- area_under_curve / peak_excess  # s
    
    calc_results$area_under_curve <- area_under_curve
    calc_results$peak_excess <- peak_excess
    calc_results$w_eff <- w_eff
    
    # Clear tracer mass results (not calculated in Q_salt)
    calc_results$mass_arabinose <- NULL
    calc_results$mass_glucose <- NULL
    calc_results$mass_rhodamine <- NULL
    calc_results$temp_correction_factor <- NULL
    
    # Clear sampling times (not calculated in Q_salt)
    calc_results$sampling_times <- NULL
    calc_results$breakthrough_start_idx <- NULL
    calc_results$breakthrough_end_idx <- NULL
    
    # Set calculation method
    calc_results$calculation_method <- "salt"
    
    showNotification("Discharge calculated successfully!", type = "message")
  })
  
  # Calculate discharge from Rhodamine WT when button is clicked
  observeEvent(input$calculate_rhodamine, {
    # Get inputs
    M <- input$mass_rhodamine_injected  # Mass of rhodamine injected (g)
    background <- input$background_fluorescence  # Background fluorescence
    dt <- input$time_step_rho  # Time step (s)
    
    # Parse fluorescence data
    fluorescence <- parse_fluorescence()
    
    # Validate data
    if (length(fluorescence) == 0 || any(is.na(fluorescence))) {
      showNotification("Error: Invalid fluorescence data. Please check your input.", 
                       type = "error")
      return()
    }
    
    # Calculate discharge using same formula as salt dilution
    # Q = M / (integral of excess concentration)
    sum_fluor <- sum(fluorescence)
    count_fluor <- length(fluorescence)
    total_excess <- sum_fluor - background * count_fluor
    
    # For rhodamine, the "concentration" is directly the fluorescence value (ppb)
    # Convert mass from g to µg: M_ug = M_g * 1e6
    # Integral = sum of excess fluorescence * dt (ppb·s)
    # Q = M_ug / integral (µg / (ppb·s)) = µg / (µg/L·s) = L/s
    
    M_ug <- M * 1e6  # Convert g to µg
    integral <- total_excess * dt  # ppb·s = µg/L·s
    
    if (integral <= 0) {
      showNotification("Error: Integral is zero or negative. Check your inputs.", 
                       type = "error")
      return()
    }
    
    Q <- M_ug / integral  # L/s
    
    # Create data frame with time series
    time_sec <- seq(0, (count_fluor - 1) * dt, by = dt)
    excess_fluorescence <- fluorescence - background
    
    data_df <- data.frame(
      Time_s = time_sec,
      Time_min = time_sec / 60,
      Fluorescence_ppb = fluorescence,
      Excess_Fluorescence = excess_fluorescence
    )
    
    # Store basic results (Q_rhoWT only calculates discharge, not tracer masses)
    calc_results$Q <- Q
    calc_results$data <- data_df
    calc_results$b <- NA  # Not applicable for rhodamine
    calc_results$sum_cond <- sum_fluor
    calc_results$count_cond <- count_fluor
    calc_results$total_excess <- total_excess
    calc_results$integral <- integral
    
    # Store breakthrough curve parameters
    area_under_curve <- sum(excess_fluorescence) * dt  # ppb·s
    peak_excess <- max(excess_fluorescence)  # ppb
    w_eff <- area_under_curve / peak_excess  # s
    
    calc_results$area_under_curve <- area_under_curve
    calc_results$peak_excess <- peak_excess
    calc_results$w_eff <- w_eff
    
    # Clear tracer mass results (not calculated in Q_rhoWT)
    calc_results$mass_arabinose <- NULL
    calc_results$mass_glucose <- NULL
    calc_results$mass_rhodamine <- NULL
    calc_results$temp_correction_factor <- NULL
    
    # Clear sampling times (not calculated in Q_rhoWT)
    calc_results$sampling_times <- NULL
    calc_results$breakthrough_start_idx <- NULL
    calc_results$breakthrough_end_idx <- NULL
    
    # Set calculation method
    calc_results$calculation_method <- "rhodamine"
    
    showNotification("Discharge calculated successfully from Rhodamine WT!", type = "message")
  })
  
  # Calculate tracer masses for Injections tab (independent calculation)
  observeEvent(input$calculate_injections, {
    # Get inputs from Injections tab
    M <- input$mass_salt_inj
    background <- input$background_cond_inj
    dt <- input$time_step_inj
    b <- 1 / input$calib_value
    
    # Parse conductivity data from Injections tab
    conductivity <- parse_conductivity_inj()
    
    # Validate data
    if (length(conductivity) == 0 || any(is.na(conductivity))) {
      showNotification("Error: Invalid conductivity data. Please check your input.", 
                       type = "error")
      return()
    }
    
    # Calculate discharge using salt dilution method
    sum_cond <- sum(conductivity)
    count_cond <- length(conductivity)
    total_excess <- sum_cond - background * count_cond
    integral <- total_excess * b * dt
    
    if (integral <= 0) {
      showNotification("Error: Integral is zero or negative. Check your inputs.", 
                       type = "error")
      return()
    }
    
    Q <- M / integral
    
    # Calculate effective width for tracer mass calculation
    excess_conductivity <- conductivity - background
    area_under_curve <- sum(excess_conductivity) * dt  # µS/cm * s
    peak_excess <- max(excess_conductivity)  # µS/cm
    w_eff <- area_under_curve / peak_excess  # s
    
    # Calculate required tracer masses
    # M = Q * C_target * W_eff
    # Q in L/s, C_target in µg/L (ppb), W_eff in s
    
    target_arab_ppb <- input$target_arabinose  # µg/L
    target_gluc_ppb <- input$target_glucose    # µg/L
    target_rhod_ppb <- input$target_rhodamine  # µg/L
    
    mass_arabinose_ug <- Q * target_arab_ppb * w_eff  # µg
    mass_glucose_ug <- Q * target_gluc_ppb * w_eff    # µg
    
    # Rhodamine WT with temperature correction
    T_ref <- 25  # Reference temperature (°C)
    T_measured <- input$water_temperature  # Measured water temperature (°C)
    n_rhodamine <- input$rhodamine_temp_coeff  # Temperature coefficient (°C⁻¹)
    
    # Temperature correction factor (how much fluorescence changes from 25°C to stream temp)
    temp_correction_factor <- exp(n_rhodamine * (T_measured - T_ref))
    
    # To get target_rhod_ppb at stream temperature, we need to inject mass that would 
    # give target_rhod_ppb / temp_correction_factor at 25°C reference
    target_rhod_at_ref <- target_rhod_ppb / temp_correction_factor
    mass_rhodamine_pure_ug <- Q * target_rhod_at_ref * w_eff  # µg of pure rhodamine
    
    # Account for rhodamine solution concentration
    rhodamine_conc_fraction <- input$rhodamine_concentration / 100  # Convert % to fraction
    mass_rhodamine_solution_ug <- mass_rhodamine_pure_ug / rhodamine_conc_fraction  # µg of solution needed
    
    mass_arabinose_g <- mass_arabinose_ug / 1e6  # g
    mass_glucose_g <- mass_glucose_ug / 1e6       # g
    mass_rhodamine_pure_g <- mass_rhodamine_pure_ug / 1e6  # g pure rhodamine
    mass_rhodamine_solution_g <- mass_rhodamine_solution_ug / 1e6  # g of solution
    
    mass_arabinose_mg <- mass_arabinose_ug / 1e3  # mg
    mass_glucose_mg <- mass_glucose_ug / 1e3       # mg
    mass_rhodamine_pure_mg <- mass_rhodamine_pure_ug / 1e3  # mg pure
    mass_rhodamine_solution_mg <- mass_rhodamine_solution_ug / 1e3  # mg solution
    
    # Store Q and intermediate calculation values
    calc_results$Q <- Q
    calc_results$b <- b
    calc_results$sum_cond <- sum_cond
    calc_results$count_cond <- count_cond
    calc_results$total_excess <- total_excess
    calc_results$integral <- integral
    calc_results$area_under_curve <- area_under_curve
    calc_results$peak_excess <- peak_excess
    calc_results$w_eff <- w_eff
    
    # Store tracer mass results
    calc_results$mass_arabinose <- list(ug = mass_arabinose_ug, mg = mass_arabinose_mg, g = mass_arabinose_g)
    calc_results$mass_glucose <- list(ug = mass_glucose_ug, mg = mass_glucose_mg, g = mass_glucose_g)
    calc_results$mass_rhodamine <- list(
      ug_pure = mass_rhodamine_pure_ug, 
      mg_pure = mass_rhodamine_pure_mg, 
      g_pure = mass_rhodamine_pure_g,
      ug_solution = mass_rhodamine_solution_ug,
      mg_solution = mass_rhodamine_solution_mg,
      g_solution = mass_rhodamine_solution_g,
      concentration_pct = input$rhodamine_concentration,
      temperature = T_measured,
      temp_coeff = n_rhodamine,
      temp_correction_factor = temp_correction_factor
    )
    calc_results$temp_correction_factor <- temp_correction_factor
    
    # Calculate sampling times for breakthrough curve with NON-UNIFORM spacing
    # Denser sampling around peak, sparser at beginning and end
    threshold <- background + 0.5  # Small threshold above background
    excess_indices <- which(conductivity > threshold)
    
    if (length(excess_indices) > 0) {
      breakthrough_start_idx <- min(excess_indices)
      breakthrough_end_idx <- max(excess_indices)
      peak_idx <- which.max(excess_conductivity)
      
      n_samples <- input$n_samples_breakthrough
      
      # Non-uniform sampling using beta distribution
      # Beta(2,2) gives more density in the middle, less at edges
      beta_values <- seq(0, 1, length.out = n_samples)
      # Transform to create non-uniform spacing (denser around 0.5 = peak)
      # Using a power function to create the desired distribution
      transformed <- beta_values^0.5  # Square root gives gradual increase
      
      # Map to indices between start and end
      sample_indices <- round(breakthrough_start_idx + transformed * (breakthrough_end_idx - breakthrough_start_idx))
      
      # Ensure peak is included
      if (!any(sample_indices == peak_idx)) {
        # Replace the middle sample with the peak
        mid_idx <- ceiling(n_samples / 2)
        sample_indices[mid_idx] <- peak_idx
      }
      
      # Remove duplicates and sort
      sample_indices <- sort(unique(sample_indices))
      
      # If we lost samples due to duplicates, add more around peak
      while (length(sample_indices) < n_samples) {
        # Find largest gap
        gaps <- diff(sample_indices)
        max_gap_idx <- which.max(gaps)
        # Insert sample in middle of largest gap
        new_idx <- round((sample_indices[max_gap_idx] + sample_indices[max_gap_idx + 1]) / 2)
        sample_indices <- sort(c(sample_indices, new_idx))
      }
      
      # Trim if we have too many
      if (length(sample_indices) > n_samples) {
        sample_indices <- sample_indices[1:n_samples]
      }
      
      sample_times_sec <- (sample_indices - 1) * dt  # Convert to seconds
      
      calc_results$sampling_times <- sample_times_sec
      calc_results$sampling_indices <- sample_indices
      calc_results$breakthrough_start_idx <- breakthrough_start_idx
      calc_results$breakthrough_end_idx <- breakthrough_end_idx
      calc_results$peak_idx <- peak_idx
    } else {
      calc_results$sampling_times <- NULL
      calc_results$sampling_indices <- NULL
      calc_results$breakthrough_start_idx <- NULL
      calc_results$breakthrough_end_idx <- NULL
      calc_results$peak_idx <- NULL
    }
    
    # Create data frame for injections (for plots)
    time_sec <- seq(0, (count_cond - 1) * dt, by = dt)
    concentration <- excess_conductivity * b
    
    data_df <- data.frame(
      Time_s = time_sec,
      Time_min = time_sec / 60,
      Conductivity_uS_cm = conductivity,
      Excess_Conductivity = excess_conductivity,
      Concentration_g_L = concentration
    )
    
    # Store data for plots (injections uses salt data)
    calc_results$data <- data_df
    calc_results$calculation_method <- "injections"
    
    showNotification("Tracer masses calculated successfully!", type = "message")
  })
  
  # Dynamic method content based on calculation method
  output$method_content <- renderUI({
    if (is.null(calc_results$calculation_method)) {
      # Default content when no calculation has been done
      HTML("
        <h3>Discharge calculation methods</h3>
        <p>Select a calculation method from the sidebar tabs to see detailed methodology:</p>
        <ul>
          <li><strong>Q_salt</strong> - Salt dilution method using conductivity</li>
          <li><strong>Q_rhoWT</strong> - Rhodamine WT method using fluorescence</li>
          <li><strong>Injections</strong> - Tracer mass calculation using salt dilution</li>
        </ul>
      ")
    } else if (calc_results$calculation_method == "salt" || calc_results$calculation_method == "injections") {
      # Salt dilution method
      HTML("
        <h3>Salt dilution method</h3>
        <p>The discharge is calculated using the <strong>salt dilution method</strong>:</p>
        <ol>
          <li>Inject a known mass of salt (M) into the stream</li>
          <li>Measure conductivity over time downstream</li>
          <li>Convert conductivity to concentration using calibration coefficient</li>
          <li>Calculate discharge using the formula below</li>
        </ol>
        
        <h4>Formula</h4>
        <pre>Q = M / ((SUM(conductivity) - background × COUNT(conductivity)) × b × dt)</pre>
        
        <p>Where:</p>
        <ul>
          <li><strong>Q</strong> = Discharge [L/s]</li>
          <li><strong>M</strong> = Mass of salt injected [g]</li>
          <li><strong>SUM(conductivity)</strong> = Sum of all conductivity measurements [µS/cm]</li>
          <li><strong>background</strong> = Background conductivity [µS/cm]</li>
          <li><strong>COUNT(conductivity)</strong> = Number of measurements</li>
          <li><strong>b</strong> = Calibration coefficient [(g/L)/(µS/cm)]</li>
          <li><strong>dt</strong> = Time step between measurements [s]</li>
        </ul>
        
        <h4>Physical interpretation</h4>
        <p>The method calculates:</p>
        <ol>
          <li><strong>Total excess conductivity</strong> = SUM(conductivity) - background × COUNT(conductivity)</li>
          <li><strong>Integral of excess concentration</strong> = Total excess conductivity × b × dt [g·s/L]</li>
          <li><strong>Discharge</strong> = Mass of salt / Integral [L/s]</li>
        </ol>
      ")
    } else if (calc_results$calculation_method == "rhodamine") {
      # Rhodamine WT method
      HTML("
        <h3>Rhodamine WT method</h3>
        <p>The discharge is calculated using <strong>Rhodamine WT fluorescent tracer</strong>:</p>
        <ol>
          <li>Inject a known mass of Rhodamine WT (M) into the stream</li>
          <li>Measure fluorescence over time downstream</li>
          <li>Apply temperature correction for fluorescence</li>
          <li>Calculate discharge using the formula below</li>
        </ol>
        
        <h4>Formula</h4>
        <pre>Q = M / ((SUM(fluorescence) - background × COUNT(fluorescence)) × dt)</pre>
        
        <p>Where:</p>
        <ul>
          <li><strong>Q</strong> = Discharge [L/s]</li>
          <li><strong>M</strong> = Mass of Rhodamine WT injected [µg]</li>
          <li><strong>SUM(fluorescence)</strong> = Sum of all fluorescence measurements [ppb]</li>
          <li><strong>background</strong> = Background fluorescence [ppb]</li>
          <li><strong>COUNT(fluorescence)</strong> = Number of measurements</li>
          <li><strong>dt</strong> = Time step between measurements [s]</li>
        </ul>
        
        <h4>Temperature correction</h4>
        <p>Rhodamine WT fluorescence is temperature-dependent:</p>
        <ul>
          <li>Fluorescence decreases ~2-3% per °C above 25°C</li>
          <li>Correction factor: exp(n × (T - 25°C))</li>
          <li>Default coefficient n = 0.026 °C⁻¹</li>
          <li>All calculations are referenced to 25°C</li>
        </ul>
        
        <h4>Physical interpretation</h4>
        <p>The method calculates:</p>
        <ol>
          <li><strong>Total excess fluorescence</strong> = SUM(fluorescence) - background × COUNT(fluorescence)</li>
          <li><strong>Integral of excess concentration</strong> = Total excess fluorescence × dt [ppb·s]</li>
          <li><strong>Discharge</strong> = Mass of rhodamine (µg) / Integral [L/s]</li>
        </ol>
      ")
    }
  })
  
  # Control visibility of tracer mass section
  output$show_tracer_masses <- reactive({
    !is.null(calc_results$mass_arabinose) && 
      !is.null(calc_results$mass_glucose) && 
      !is.null(calc_results$mass_rhodamine)
  })
  outputOptions(output, "show_tracer_masses", suspendWhenHidden = FALSE)
  
  # Track if Sampling tab exists
  sampling_tab_exists <- reactiveVal(FALSE)
  
  # Dynamically add/remove Sampling tab
  observe({
    if (!is.null(calc_results$sampling_times) && !sampling_tab_exists()) {
      # Add Sampling tab before Method tab
      insertTab(inputId = "tabs", 
                tabPanel("Sampling",
                         h3("Sampling frequency calculator"),
                         verbatimTextOutput("sampling_frequency"),
                         hr(),
                         h4("Mobile Field Timer"),
                         p("Choose one of these methods to load the schedule into the mobile timer app:"),
                         
                         h5("Method 1: QR Code (Recommended)"),
                         p("Scan this QR code with your phone's camera:"),
                         plotOutput("qr_code_plot", height = "300px", width = "300px"),
                         
                         hr(),
                         
                         h5("Method 2: Manual Copy-Paste"),
                         p("If camera doesn't work, copy this JSON data and paste it into the mobile app:"),
                         verbatimTextOutput("json_schedule_text"),
                         helpText("Tap 'Enter Schedule Manually' in the mobile app, then paste this text."),
                         
                         hr(),
                         
                         downloadButton("download_timer_html", "Download Mobile Timer App"),
                         hr(),
                         helpText("Red vertical bars on plots show recommended sampling times."),
                         helpText("Configure sampling strategy in the Settings tab (left sidebar).")
                ),
                target = "Method",
                position = "before")
      sampling_tab_exists(TRUE)
    } else if (is.null(calc_results$sampling_times) && sampling_tab_exists()) {
      # Remove Sampling tab
      removeTab(inputId = "tabs", target = "Sampling")
      sampling_tab_exists(FALSE)
    }
  })
  
  # Results summary output
  output$results_summary <- renderUI({
    if (is.null(calc_results$Q)) {
      return(p("Click 'Calculate Discharge' to see results."))
    }
    
    # Show discharge in bold for all methods (normal font size) in grey box
    div(
      style = "background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 4px; padding: 15px; font-family: 'Courier New', monospace;",
      p("═══════════════════════════════════════════════════════════════"),
      br(),
      p(strong(sprintf("DISCHARGE (Q) = %.2f L/s", calc_results$Q))),
      br(),
      p("═══════════════════════════════════════════════════════════════")
    )
  })
  
  # Tracer mass results output (only for Injections tab)
  output$tracer_mass_results <- renderUI({
    if (is.null(calc_results$Q)) {
      return(p("Calculate discharge using Q_salt tab first, then view tracer mass requirements here."))
    }
    
    # Only show tracer masses if we have the necessary calculations
    if (is.null(calc_results$mass_arabinose)) {
      return(p("Tracer mass calculations are only available when using the Injections workflow."))
    }
    
    div(
      p("═══════════════════════════════════════════════════════════════"),
      p("Based on salt slug breakthrough curve analysis:"),
      br(),
      p("Effective Width (W_eff):"),
      p(sprintf("  Area under curve          : %.2f µS·s/cm", calc_results$area_under_curve)),
      p(sprintf("  Peak excess conductivity  : %.2f µS/cm", calc_results$peak_excess)),
      p(sprintf("  W_eff = Area / Peak       : %.2f s (%.2f min)", calc_results$w_eff, calc_results$w_eff / 60)),
      br(),
      p("Formula: M = Q × C_target × W_eff"),
      br(),
      p(strong(sprintf("ARABINOSE (Target: %d ppb):", input$target_arabinose))),
      p(strong(sprintf("  Required mass = %.4f g", calc_results$mass_arabinose$g)), 
        style = "margin-left: 20px;"),
      br(),
      p(strong(sprintf("GLUCOSE (Target: %d ppb):", input$target_glucose))),
      p(strong(sprintf("  Required mass = %.4f g", calc_results$mass_glucose$g)), 
        style = "margin-left: 20px;"),
      br(),
      p(strong(sprintf("RHODAMINE WT (Target: %d ppb at %.1f°C stream temp):", input$target_rhodamine, input$water_temperature))),
      p(strong(sprintf("  → SOLUTION to add       = %.4f g", calc_results$mass_rhodamine$g_solution)), 
        style = "margin-left: 20px;"),
      br(),
      p("═══════════════════════════════════════════════════════════════"),
      p("Note: These masses should achieve the target peak concentrations"),
      p("if injected using the same method and at the same location as the"),
      p("salt slug, assuming similar hydraulic conditions."),
      br(),
      p("For rhodamine:"),
      p("  • Use the SOLUTION mass (accounts for concentration)"),
      p("  • Mass is temperature-corrected for stream conditions"),
      p("  • Target concentration achieved at actual stream temperature"),
      p("═══════════════════════════════════════════════════════════════")
    )
  })
  
  # Calculation details output
  output$calculation_details <- renderText({
    if (is.null(calc_results$Q)) {
      return("")
    }
    
    # Show details based on calculation method
    if (calc_results$calculation_method == "rhodamine") {
      # Rhodamine WT calculation details
      paste0(
        "Input Parameters:\n",
        "─────────────────────────────────────────────────────────────\n",
        "  Mass of Rhodamine WT (M)      : ", sprintf("%.1f", input$mass_rhodamine_injected), " g\n",
        "  Background fluorescence       : ", sprintf("%.2f", input$background_fluorescence), " ppb\n",
        "  Time step (dt)                : ", input$time_step_rho, " s\n",
        "  Water temperature             : ", sprintf("%.1f", input$water_temperature_rho), " °C\n",
        "  Number of measurements        : ", calc_results$count_cond, "\n\n",
        
        "Calculation Steps:\n",
        "─────────────────────────────────────────────────────────────\n",
        "  SUM(fluorescence)             : ", sprintf("%.2f", calc_results$sum_cond), " ppb\n",
        "  Background × COUNT            : ", sprintf("%.2f", input$background_fluorescence * calc_results$count_cond), " ppb\n",
        "  Total excess fluorescence     : ", sprintf("%.2f", calc_results$total_excess), " ppb\n",
        "  Mass injected (µg)            : ", sprintf("%.0f", input$mass_rhodamine_injected * 1e6), " µg\n",
        "  Integral (excess × dt)        : ", sprintf("%.6f", calc_results$integral), " ppb·s\n",
        "  Discharge (M / Integral)      : ", sprintf("%.2f", calc_results$Q), " L/s\n"
      )
    } else if (calc_results$calculation_method == "injections") {
      # Injections calculation details
      paste0(
        "Input Parameters:\n",
        "─────────────────────────────────────────────────────────────\n",
        "  Mass of salt (M)              : ", sprintf("%.1f", input$mass_salt_inj), " g\n",
        "  Background conductivity       : ", sprintf("%.1f", input$background_cond_inj), " µS/cm\n",
        "  Time step (dt)                : ", input$time_step_inj, " s\n",
        "  Calibration coefficient (b)   : ", sprintf("%.10f", calc_results$b), " (g/L)/(µS/cm)\n",
        "  Number of measurements        : ", calc_results$count_cond, "\n\n",
        
        "Calculation Steps:\n",
        "─────────────────────────────────────────────────────────────\n",
        "  SUM(conductivity)             : ", sprintf("%.2f", calc_results$sum_cond), " µS/cm\n",
        "  Background × COUNT            : ", sprintf("%.2f", input$background_cond_inj * calc_results$count_cond), " µS/cm\n",
        "  Total excess conductivity     : ", sprintf("%.2f", calc_results$total_excess), " µS/cm\n",
        "  Integral (excess × b × dt)    : ", sprintf("%.6f", calc_results$integral), " g·s/L\n",
        "  Discharge (M / Integral)      : ", sprintf("%.2f", calc_results$Q), " L/s\n"
      )
    } else {
      # Q_salt calculation details
      paste0(
        "Input Parameters:\n",
        "─────────────────────────────────────────────────────────────\n",
        "  Mass of salt (M)              : ", sprintf("%.1f", input$mass_salt), " g\n",
        "  Background conductivity       : ", sprintf("%.1f", input$background_cond), " µS/cm\n",
        "  Time step (dt)                : ", input$time_step, " s\n",
        "  Calibration coefficient (b)   : ", sprintf("%.10f", calc_results$b), " (g/L)/(µS/cm)\n",
        "  Number of measurements        : ", calc_results$count_cond, "\n\n",
        
        "Calculation Steps:\n",
        "─────────────────────────────────────────────────────────────\n",
        "  SUM(conductivity)             : ", sprintf("%.2f", calc_results$sum_cond), " µS/cm\n",
        "  Background × COUNT            : ", sprintf("%.2f", input$background_cond * calc_results$count_cond), " µS/cm\n",
        "  Total excess conductivity     : ", sprintf("%.2f", calc_results$total_excess), " µS/cm\n",
        "  Integral (excess × b × dt)    : ", sprintf("%.6f", calc_results$integral), " g·s/L\n",
        "  Discharge (M / Integral)      : ", sprintf("%.2f", calc_results$Q), " L/s\n"
      )
    }
  })
  
  # Sampling frequency output
  output$sampling_frequency <- renderText({
    if (is.null(calc_results$sampling_times)) {
      return("Calculate tracer masses using Injections tab to see sampling recommendations.")
    }
    
    n_samples <- input$n_samples_breakthrough
    # Use appropriate time step based on calculation method
    dt <- if (calc_results$calculation_method == "injections") {
      input$time_step_inj
    } else {
      input$time_step
    }
    
    # Calculate breakthrough duration
    breakthrough_duration_sec <- (calc_results$breakthrough_end_idx - calc_results$breakthrough_start_idx) * dt
    breakthrough_duration_min <- breakthrough_duration_sec / 60
    
    # Calculate sampling interval
    sampling_interval_sec <- breakthrough_duration_sec / (n_samples - 1)
    sampling_interval_min <- sampling_interval_sec / 60
    
    # Format sampling times
    sample_times_min <- calc_results$sampling_times / 60
    
    paste0(
      "═══════════════════════════════════════════════════════════════\n",
      "SAMPLING STRATEGY FOR BREAKTHROUGH CURVE\n",
      "═══════════════════════════════════════════════════════════════\n\n",
      "Breakthrough curve duration:\n",
      "  Start at                  : ", sprintf("%.1f", calc_results$sampling_times[1] / 60), " min (", 
      sprintf("%.0f", calc_results$sampling_times[1]), " s)\n",
      "  End at                    : ", sprintf("%.1f", calc_results$sampling_times[n_samples] / 60), " min (", 
      sprintf("%.0f", calc_results$sampling_times[n_samples]), " s)\n",
      "  Total duration            : ", sprintf("%.1f", breakthrough_duration_min), " min (", 
      sprintf("%.0f", breakthrough_duration_sec), " s)\n\n",
      
      "Sampling frequency:\n",
      "  Number of samples         : ", n_samples, "\n",
      "  Interval between samples  : ", sprintf("%.1f", sampling_interval_min), " min (", 
      sprintf("%.0f", sampling_interval_sec), " s)\n\n",
      
      "Recommended sampling times (", n_samples, " samples):\n",
      paste0("  Sample ", sprintf("%2d", 1:n_samples), ": ", 
             sprintf("%6.1f", sample_times_min), " min (", 
             sprintf("%5.0f", calc_results$sampling_times), " s)\n", collapse = ""),
      "\n",
      "═══════════════════════════════════════════════════════════════\n",
      "Note: These times are shown as red vertical bars on the plot.\n",
      "Sample 1 should be a few seconds after conductivity starts rising.\n",
      "One sample should capture the peak.\n",
      "Last sample should be a few seconds before returning to background.\n",
      "═══════════════════════════════════════════════════════════════\n"
    )
  })
  
  # Data table output
  output$data_table <- renderDT({
    if (is.null(calc_results$data)) {
      return(NULL)
    }
    
    # Get column names that exist in the data
    numeric_cols <- names(calc_results$data)[sapply(calc_results$data, is.numeric)]
    
    datatable(calc_results$data, 
              options = list(pageLength = 20, scrollX = TRUE),
              rownames = FALSE) %>%
      formatRound(columns = numeric_cols, digits = 3)
  })
  
  # Conductivity/Fluorescence plot (adapts based on calculation method)
  output$conductivity_plot <- renderPlot({
    if (is.null(calc_results$data)) {
      return(NULL)
    }
    
    # Check which method was used
    if (calc_results$calculation_method == "rhodamine") {
      # Plot fluorescence data
      p <- ggplot(calc_results$data, aes(x = Time_min, y = Fluorescence_ppb)) +
        geom_line(color = "purple", size = 1) +
        geom_point(color = "darkviolet", size = 2) +
        geom_hline(yintercept = input$background_fluorescence, 
                   linetype = "dashed", color = "gray50", size = 0.8) +
        annotate("text", x = max(calc_results$data$Time_min) * 0.8, 
                 y = input$background_fluorescence + max(calc_results$data$Fluorescence_ppb) * 0.05, 
                 label = paste("Background =", input$background_fluorescence, "ppb"), 
                 color = "gray50", size = 3.5)
      
      # Add sampling time vertical bars if available
      if (!is.null(calc_results$sampling_times)) {
        sampling_times_min <- calc_results$sampling_times / 60
        p <- p + geom_vline(xintercept = sampling_times_min, 
                            color = "red", 
                            linetype = "solid", 
                            size = 0.8, 
                            alpha = 0.6)
      }
      
      p <- p +
        labs(title = "Fluorescence vs time",
             x = "Time (minutes)",
             y = "Fluorescence (ppb)") +
        theme_minimal(base_size = 14) +
        theme(plot.title = element_text(hjust = 0.5, face = "bold"))
      
    } else {
      # Plot conductivity data (salt method or injections)
      # Use appropriate background value based on method
      bg_value <- if (calc_results$calculation_method == "injections") {
        input$background_cond_inj
      } else {
        input$background_cond
      }
      
      p <- ggplot(calc_results$data, aes(x = Time_min, y = Conductivity_uS_cm)) +
        geom_line(color = "blue", size = 1) +
        geom_point(color = "darkblue", size = 2) +
        geom_hline(yintercept = bg_value, 
                   linetype = "dashed", color = "gray50", size = 0.8) +
        annotate("text", x = max(calc_results$data$Time_min) * 0.8, 
                 y = bg_value * 1.02, 
                 label = paste("Background =", bg_value, "µS/cm"), 
                 color = "gray50", size = 3.5)
      
      # Add sampling time vertical bars if available
      if (!is.null(calc_results$sampling_times)) {
        sampling_times_min <- calc_results$sampling_times / 60
        p <- p + geom_vline(xintercept = sampling_times_min, 
                            color = "red", 
                            linetype = "solid", 
                            size = 0.8, 
                            alpha = 0.6)
      }
      
      p <- p +
        labs(title = "Conductivity vs time",
             x = "Time (minutes)",
             y = "Conductivity (µS/cm)") +
        theme_minimal(base_size = 14) +
        theme(plot.title = element_text(hjust = 0.5, face = "bold"))
    }
    
    p
  })
  
  # Concentration/Excess plot (adapts based on calculation method)
  output$concentration_plot <- renderPlot({
    if (is.null(calc_results$data)) {
      return(NULL)
    }
    
    # Check which method was used
    if (calc_results$calculation_method == "rhodamine") {
      # Plot excess fluorescence
      p <- ggplot(calc_results$data, aes(x = Time_min, y = Excess_Fluorescence)) +
        geom_line(color = "darkorchid", size = 1) +
        geom_point(color = "darkorchid", size = 2) +
        geom_hline(yintercept = 0, linetype = "dashed", color = "gray50")
      
      # Add sampling time vertical bars if available
      if (!is.null(calc_results$sampling_times)) {
        sampling_times_min <- calc_results$sampling_times / 60
        p <- p + geom_vline(xintercept = sampling_times_min, 
                            color = "red", 
                            linetype = "solid", 
                            size = 0.8, 
                            alpha = 0.6)
      }
      
      p <- p +
        labs(title = "Excess fluorescence vs time",
             x = "Time (minutes)",
             y = "Excess Fluorescence (ppb)") +
        theme_minimal(base_size = 14) +
        theme(plot.title = element_text(hjust = 0.5, face = "bold"))
      
    } else {
      # Plot concentration (salt method)
      p <- ggplot(calc_results$data, aes(x = Time_min, y = Concentration_g_L)) +
        geom_line(color = "darkgreen", size = 1) +
        geom_point(color = "darkgreen", size = 2) +
        geom_hline(yintercept = 0, linetype = "dashed", color = "gray50")
      
      # Add sampling time vertical bars if available
      if (!is.null(calc_results$sampling_times)) {
        sampling_times_min <- calc_results$sampling_times / 60
        p <- p + geom_vline(xintercept = sampling_times_min, 
                            color = "red", 
                            linetype = "solid", 
                            size = 0.8, 
                            alpha = 0.6)
      }
      
      p <- p +
        labs(title = "Concentration vs time",
             x = "Time (minutes)",
             y = "Excess Concentration (g/L)") +
        theme_minimal(base_size = 14) +
        theme(plot.title = element_text(hjust = 0.5, face = "bold"))
    }
    
    p
  })
  
  # Download report
  output$download_report <- downloadHandler(
    filename = function() {
      paste0("discharge_calculation_", format(Sys.time(), "%Y%m%d_%H%M%S"), ".csv")
    },
    content = function(file) {
      if (is.null(calc_results$data)) {
        showNotification("No data to download. Please calculate first.", type = "warning")
        return()
      }
      
      # Create summary header
      header <- data.frame(
        Parameter = c("Mass of Salt (g)", "Background Conductivity (µS/cm)", 
                      "Time Step (s)", "Calibration Coefficient b", "Number of Measurements",
                      "Discharge Q (L/s)", "Discharge Q (L/min)", "Discharge Q (m³/s)", "",
                      "Effective Width W_eff (s)", "Peak Excess Conductivity (µS/cm)", 
                      "Area Under Curve (µS·s/cm)", "",
                      "Target Arabinose (ppb)", "Required Arabinose Mass (g)", "",
                      "Target Glucose (ppb)", "Required Glucose Mass (g)", "",
                      "Target Rhodamine WT (ppb)", "Water Temperature (°C)", 
                      "Rhodamine Temperature Coefficient (°C⁻¹)", "Temperature Correction Factor",
                      "Rhodamine Solution Concentration (%)", 
                      "Required Pure Rhodamine Mass (g)", "Required Rhodamine SOLUTION Mass (g)", ""),
        Value = c(input$mass_salt, input$background_cond,
                  input$time_step, sprintf("%.10f", calc_results$b), calc_results$count_cond,
                  sprintf("%.6f", calc_results$Q), sprintf("%.6f", calc_results$Q * 60),
                  sprintf("%.8f", calc_results$Q / 1000), "",
                  sprintf("%.2f", calc_results$w_eff), sprintf("%.2f", calc_results$peak_excess),
                  sprintf("%.2f", calc_results$area_under_curve), "",
                  input$target_arabinose, sprintf("%.6f", calc_results$mass_arabinose$g), "",
                  input$target_glucose, sprintf("%.6f", calc_results$mass_glucose$g), "",
                  input$target_rhodamine, sprintf("%.1f", calc_results$mass_rhodamine$temperature),
                  sprintf("%.3f", calc_results$mass_rhodamine$temp_coeff),
                  sprintf("%.6f", calc_results$mass_rhodamine$temp_correction_factor),
                  sprintf("%.2f", calc_results$mass_rhodamine$concentration_pct),
                  sprintf("%.6f", calc_results$mass_rhodamine$g_pure),
                  sprintf("%.6f", calc_results$mass_rhodamine$g_solution), "")
      )
      
      # Write to CSV
      write.csv(header, file, row.names = FALSE)
      write.table("", file, append = TRUE, col.names = FALSE, row.names = FALSE)
      write.table("Time Series Data:", file, append = TRUE, col.names = FALSE, row.names = FALSE)
      write.table(calc_results$data, file, append = TRUE, sep = ",", row.names = FALSE)
    }
  )
  
  # Generate QR code with sampling schedule
  output$qr_code_plot <- renderPlot({
    if (is.null(calc_results$sampling_times)) {
      return(NULL)
    }
    
    # Create JSON data for QR code
    qr_data <- list(
      site = "Field Sampling",
      total_samples = length(calc_results$sampling_times),
      sampling_times = as.numeric(calc_results$sampling_times),
      start_time = as.numeric(calc_results$sampling_times[1]),
      end_time = as.numeric(calc_results$sampling_times[length(calc_results$sampling_times)]),
      timestamp = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
    )
    
    # Convert to JSON string
    qr_string <- jsonlite::toJSON(qr_data, auto_unbox = TRUE)
    
    # Generate QR code
    qr <- qr_code(qr_string)
    
    # Plot QR code
    plot(qr)
  })
  
  # Display JSON schedule text for manual copy-paste
  output$json_schedule_text <- renderText({
    if (is.null(calc_results$sampling_times)) {
      return("")
    }
    
    # Create JSON data (same as QR code)
    qr_data <- list(
      site = "Field Sampling",
      total_samples = length(calc_results$sampling_times),
      sampling_times = as.numeric(calc_results$sampling_times),
      start_time = as.numeric(calc_results$sampling_times[1]),
      end_time = as.numeric(calc_results$sampling_times[length(calc_results$sampling_times)]),
      timestamp = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
    )
    
    # Convert to JSON string (pretty printed for readability)
    jsonlite::toJSON(qr_data, auto_unbox = TRUE, pretty = FALSE)
  })
  
  # Download mobile timer HTML app
  output$download_timer_html <- downloadHandler(
    filename = function() {
      "field_timer.html"
    },
    content = function(file) {
      # Copy the field_timer.html file
      timer_path <- file.path(getwd(), "field_timer.html")
      if (file.exists(timer_path)) {
        file.copy(timer_path, file)
      } else {
        showNotification("field_timer.html not found. Please ensure it's in the app directory.", type = "error")
      }
    }
  )
}

# Run the application
shinyApp(ui = ui, server = server)
