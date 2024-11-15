
ny = read.csv('new_york_city.csv')
wash = read.csv('washington.csv')
chi = read.csv('chicago.csv')

head(ny)

head(wash)

head(chi)

# Calculate the total number of routes for each city
ny_total_routes <- nrow(ny)
wash_total_routes <- nrow(wash)
chi_total_routes <- nrow(chi)

# Display the results
cat("Total routes in New York:", ny_total_routes, "\n")
cat("Total routes in Washington:", wash_total_routes, "\n")
cat("Total routes in Chicago:", chi_total_routes, "\n")

# Load necessary library
library(ggplot2)

# Create a data frame for the totals
route_totals <- data.frame(
  City = c("New York", "Washington", "Chicago"),
  Total_Routes = c(54770, 89051, 8630)
)

# Create a bar plot to compare total routes
ggplot(route_totals, aes(x = City, y = Total_Routes, fill = City)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Routes by City", x = "City", y = "Total Routes") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("New York" = "steelblue", "Washington" = "forestgreen", "Chicago" = "orange"))


# Calculate average trip duration for each city
ny_avg_duration <- mean(ny$Trip.Duration, na.rm = TRUE)
wash_avg_duration <- mean(wash$Trip.Duration, na.rm = TRUE)
chi_avg_duration <- mean(chi$Trip.Duration, na.rm = TRUE)

# Display the results
cat("Average Trip Duration in New York:", ny_avg_duration, "seconds\n")
cat("Average Trip Duration in Washington:", wash_avg_duration, "seconds\n")
cat("Average Trip Duration in Chicago:", chi_avg_duration, "seconds\n")

# Create a data frame for average trip durations
trip_duration_data <- data.frame(
  City = c("New York", "Washington", "Chicago"),
  Avg_Trip_Duration = c(ny_avg_duration, wash_avg_duration, chi_avg_duration)
)

# Create a bar plot
ggplot(trip_duration_data, aes(x = City, y = Avg_Trip_Duration, fill = City)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Trip Duration by City", x = "City", y = "Average Trip Duration (seconds)") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_fill_manual(values = c("New York" = "steelblue", "Washington" = "forestgreen", "Chicago" = "orange"))

# Set the price charged per hour 
price_per_hour <- 2.50  # Example price per hour

# Convert average trip durations from seconds to hours
ny_avg_duration_hours <- ny_avg_duration / 3600
wash_avg_duration_hours <- wash_avg_duration / 3600
chi_avg_duration_hours <- chi_avg_duration / 3600

# Calculate estimated revenue for each city
ny_revenue <- ny_avg_duration_hours * 54770 * price_per_hour
wash_revenue <- wash_avg_duration_hours * 89051 * price_per_hour
chi_revenue <- chi_avg_duration_hours * 8630 * price_per_hour

# Display the results
cat("Estimated Revenue in New York: $", round(ny_revenue, 2), "\n")
cat("Estimated Revenue in Washington: $", round(wash_revenue, 2), "\n")
cat("Estimated Revenue in Chicago: $", round(chi_revenue, 2), "\n")

# Count the number of rentals by Gender
gender_counts <- ny %>%
  group_by(Gender) %>%
  summarise(Total_Rentals = n())

# Display the results for Gender
cat("Total Rentals by Gender in New York:\n")
print(gender_counts)

# Current year for age calculation
current_year <- 2024

# Create a new column for Age
ny <- ny %>%
  mutate(Age = current_year - Birth.Year)

# Calculate average age of renters by Gender
average_age_by_gender <- ny %>%
  group_by(Gender) %>%
  summarise(Average_Age = mean(Age, na.rm = TRUE))

# Display the average age results
cat("\nAverage Age of Renters by Gender in New York:\n")
print(average_age_by_gender)

# Filter for male renters only
ny_men <- ny %>% filter(Gender == "Male")

# Create age groups for male renters
ny_men <- ny_men %>%
  mutate(Age_Group = case_when(
    Age < 18 ~ "Under 18",
    Age >= 18 & Age < 25 ~ "18-24",
    Age >= 25 & Age < 35 ~ "25-34",
    Age >= 35 & Age < 45 ~ "35-44",
    Age >= 45 & Age < 55 ~ "45-54",
    Age >= 55 & Age < 65 ~ "55-64",
    Age >= 65 ~ "65+",
    TRUE ~ "Unknown"
  ))

# Count the number of rentals by Age Group for males
age_group_counts_men <- ny_men %>%
  group_by(Age_Group) %>%
  summarise(Total_Rentals = n()) %>%
  arrange(desc(Total_Rentals))

# Display the results for Male Age Groups
cat("\nTotal Rentals by Age Group for Males in New York:\n")
print(age_group_counts_men)

# Create a bar chart for total rentals by age group
ggplot(age_group_counts_men, aes(x = Age_Group, y = Total_Rentals, fill = Age_Group)) +
  geom_bar(stat = "identity") +
  labs(title = "Total Rentals by Age Group for Males in New York",
       x = "Age Group",
       y = "Total Rentals") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Adjust x-axis text for better readability

# Convert Start.Time to Date-Time format
ny$Start.Time <- as.POSIXct(ny$Start.Time)

# Find month and year 
ny <- ny %>%
  mutate(Month = format(Start.Time, "%b"),  # Abbreviated month name
         Year = format(Start.Time, "%Y"))   # Full year

# Count the number of rentals by month and year
monthly_rentals <- ny %>%
  group_by(Year, Month) %>%
  summarise(Total_Rentals = n()) %>%
  ungroup()

# Display the results
print(monthly_rentals)

# Plot monthly rentals with a line graph
ggplot(monthly_rentals, aes(x = Month, y = Total_Rentals, group = Year, color = Year)) +
  geom_line(size = 1) +  # Line thickness
  geom_point(size = 2) + # Points on the line for each month
  labs(title = "Monthly Rental Trends in New York",
       x = "Month",
       y = "Total Rentals") +
  theme_minimal() +
  scale_x_discrete(limits = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotate x-axis labels for better readability

system('python -m nbconvert Explore_bikeshare_data.ipynb')
