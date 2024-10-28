#requires send2trash
#sudo dnf install -y python3-pip 
#pip install --upgrade send2trash

import os
import hashlib
from datetime import datetime
from send2trash import send2trash

def get_file_hash(file_path):
    with open(file_path, 'rb') as f:
        return hashlib.md5(f.read()).hexdigest()

def find_files(base_dir):
    files_dict = {}
    for root, _, files in os.walk(base_dir):
        for file in files:
            file_path = os.path.join(root, file)
            file_size = os.path.getsize(file_path)
            file_hash = get_file_hash(file_path)
            file_key = (file, file_size, file_hash)

            if file_key in files_dict:
                files_dict[file_key].append(file_path)
            else:
                files_dict[file_key] = [file_path]

    return files_dict

def query_delete(files):
    files.sort(key=lambda x: os.path.getmtime(x), reverse=True)
    for file in files[1:]:
        print(f"\nFile: {file}")
        print(f"Directory: {os.path.dirname(file)}")
        print(f"Size: {os.path.getsize(file)} bytes")
        print(f"Last Modified: {datetime.fromtimestamp(os.path.getmtime(file))}")
        answer = input("Do you want to move this file to the trash? (y/n): ").strip().lower()
        if answer == 'y':
            send2trash(file)
            print(f"Moved to trash: {file}")

if __name__ == "__main__":
    base_dir = input("Enter the path of the directory to scan: ").strip()
    files_dict = find_files(base_dir)
    
    for files in files_dict.values():
        if len(files) > 1:
            query_delete(files)

    print("Done.")
