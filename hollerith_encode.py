#!/usr/bin/env python3
"""
Camfort does not like Hollerith constants, so we hide them
using integer encoding before Camfort processing,
and decode back afterwards.
"""
import os
import json

# Read file with all Hollerith constants.
# The file was generated by the following script:
# grep "4H...." * -R -o -h | sort | uniq >hollerith
# grep "3H..." * -R -o -h | sort | uniq >>hollerith
# grep "2H.." * -R -o -h | sort | uniq >>hollerith
# grep "1H." * -R -o -h | sort | uniq >>hollerith
hollerith = []
with open('hollerith', "r") as file:
    for line in file:
        hollerith.append(line.rstrip('\n'))

# Read all Fortran 90 source files into a single string
def read_fortran_files(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".f90"):
                file_path = os.path.join(root, file)
                with open(file_path, "r") as f:
                    yield f.read()

fortran_code = "\n".join(read_fortran_files("."))

# Find a maximum 4-byte integer that is not yet used in any Fortran source file
# (start search from the largest integer).
class find_max_number_not_in_string:
    def __init__(self, text):
        # Convert the string to a set of integers
        self.numbers = set(map(ord, text))

        # Start from the maximum 4-byte number
        self.max_number = 2**32 - 1

    def next(self):
        # Iterate from the maximum number downwards
        for num in range(self.max_number, -1, -1):
            # Check if the number is not in the set
            if num not in self.numbers:
                self.max_number = num - 1
                return num

        # No number available
        raise Exception('Ran out of free integers, aborting')

replacements = find_max_number_not_in_string(fortran_code)

mapping = {}

# For each Hollerith constant:
for i, h in enumerate(hollerith):
    # Find a maximum 4-byte integer that is not yet used in any Fortran source file
    num = replacements.next()

    # Record a Hollerith-integer mapping entry into a json file
    mapping[num] = h
    print(f'{i + 1} of {len(hollerith)}: mapping[{num}] = "{h}"')

# Replace all occurences of the currently considered Hollerith constant
# in the Fortran sources with this integer value
def replace_in_fortran_files(directory, mapping):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if not file.endswith(".f90"):
                continue

            file_path = os.path.join(root, file)
            print(f'Updating file {file_path}...')

            with open(file_path, 'r') as file:
                file_contents = file.read()

            for num, h in mapping.items():
                old_string = h
                new_string = str(num)
                file_contents = file_contents.replace(old_string, new_string)

            with open(file_path, 'w') as file:
                file.write(file_contents)

replace_in_fortran_files(".", mapping)


# Save a Hollerith-integer dict into a json file
with open('hollerith.json', "w") as json_file:
    json.dump(mapping, json_file)
