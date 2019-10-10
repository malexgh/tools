import os
import sys
import subprocess

def search_adbs(root_search):
    found_files=[]
    for root, _, files in os.walk(root_search):
        for name in files:
            if name == 'adb.exe':
                #print(os.path.join(root, name))
                found_files.append(os.path.join(root, name)+'\n')
    return found_files

def write_found_files(found_files):
    f= open("found_adbs.txt","w+")
    f.writelines(found_files)
    f.close()

def read_found_files():
    f= open("found_adbs.txt","r")
    lines=f.readlines()
    f.close()
    return lines

def check_adbs(found_files):
    for fn in found_files:
        name=fn[0:-1] #remove \n
        #print(fn,name)
        if os.path.exists(name):
            p=subprocess.run([name,'version'], universal_newlines=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            print(p.stdout)
            #print(p.stderr)
            #print(p.returncode)

def main():
    if len(sys.argv)==2:
        root_search=sys.argv[1]
        print('Searching...')
        found_files=search_adbs(root_search)
        write_found_files(found_files)
    else:
        print('Reading file...')
        found_files=read_found_files()
    check_adbs(found_files)

main()
