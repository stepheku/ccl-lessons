import os
import os.path
import pandas as pd

xlsx_in_dir = []

for file_name in os.listdir('.'):
    if file_name.endswith('xlsx'):
        xlsx_in_dir.append(file_name)

def spit_out_csv(input_file):
    df = pd.read_excel(input_file)
    output_df = df[['SA_MEDICATION_PRSNL', 
                    'DRUG', 
                    'PT']].groupby(['SA_MEDICATION_PRSNL', 'DRUG']).agg('count')
    output_file_name = input_file + '_output.csv'
    output_df.to_csv(output_file_name)

for file_name in xlsx_in_dir:
    spit_out_csv(file_name)
