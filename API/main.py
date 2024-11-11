import requests
import pandas as pd

# Function to get university data by country
def get_universities_by_country(country):
    url = f'http://universities.hipolabs.com/search?country={country}'
    response = requests.get(url)
    return response.json()

# Function to filter the universities data
def filter_universities_data(data):
    # Convert to DataFrame
    df = pd.DataFrame(data)
    
    # Filter out rows where 'state-province' is missing
    df = df[df['state-province'].notna()]
    
    # Select relevant columns
    df = df[['name', 'web_pages', 'country', 'domains', 'state-province']]
    
    return df

# Main function to execute the script
def main():
    # Ask user for country input
    country = input("Enter the country to search universities: ")
    
    # Get university data for the country
    universities_data = get_universities_by_country(country)
    
    if universities_data:
        # Filter data
        filtered_data = filter_universities_data(universities_data)
        
        # Display the filtered data in a table format
        print(filtered_data)
    else:
        print("No data found for the given country.")

# Run the script
if __name__ == "__main__":
    main()
