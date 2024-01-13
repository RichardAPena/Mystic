# Define the function to read and process the text file
def filter_by_x(file_path, specified_x):
    y_values = []

    try:
        # Open the file in read mode
        with open(file_path, 'r') as file:
            # Read each line from the file
            for line in file:
                # Process each line
                line = line.strip()  # Remove leading and trailing whitespaces
                if line.startswith(f"data \"{specified_x}\""):
                    # Extract Y value from the line
                    y_value = line.split('"')[3]  # Assuming "data "X" "Y"" format
                    y_values.append(y_value)

    except FileNotFoundError:
        print(f"File not found: {file_path}")

    return y_values

# Input the path to your text file and the specified X value
file_path = 'Spell_Target.txt'
specified_x = 'PrepareEffect'  # Replace with the desired X value

# Call the function and store the result in a variable
result_list = filter_by_x(file_path, specified_x)
result_list = set(result_list)

# Output the resulting list
# print(result_list)
# print('lol')

for _ in result_list:
    print(_)