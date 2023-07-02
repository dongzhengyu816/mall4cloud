import os

def merge_sql_files(directory_path, output_file_path):
    sql_files = [f for f in os.listdir(directory_path) if f.endswith('.sql')]
    with open(output_file_path, 'w') as outfile:
        for sql_file in sql_files:
            file_path = os.path.join(directory_path, sql_file)
            with open(file_path, 'r') as infile:
                outfile.write(infile.read())
                outfile.write('\n')  # 在文件之间添加一个换行符

# 指定包含SQL文件的目录路径
directory_path = 'D:\PostGraduateProject\project\mall4cloud\db'

# 指定合并后的文件名和路径
output_file_path = 'D:\PostGraduateProject\project\mall4cloud\dboutput.sql'

# 调用函数合并SQL文件
merge_sql_files(directory_path, output_file_path)
