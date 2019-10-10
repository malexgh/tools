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

def write_found_adbs(found_files):
    try:
        #writer= open("found_adbs.txt","w+")
        with open('found_adbs.txt', 'w') as writer:
            writer.writelines(found_files)
            #f.close()
    except:
        print("Something went wrong writing the file")

def read_found_adbs():
    lines=[]
    try:
        #reader= open("found_adbs.txt","r")
        with open('found_adbs.txt', 'r') as reader:
            lines=reader.readlines()
            #reader.close() #needed?
    except:
        print("Something went wrong reading the file")
    return lines

def check_adbs(found_files):
    for fn in found_files:
        name=fn[0:-1] #remove \n
        #print(fn,name)
        try:
            p=subprocess.run([name,'version'], universal_newlines=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            print(p.stdout)
            #print(p.stderr)
            #print(p.returncode)
        except:
            print("Something went wrong executing the file")

def main():
    print('Reading file...')
    adbs=read_found_adbs()
    if len(sys.argv)==2:
        root_search=sys.argv[1]
        print('Searching...')
        found_files=search_adbs(root_search)
        for name in found_files:
            if name in adbs:
                print('Already There:', name)
            else:
                adbs.append(name)
        write_found_adbs(adbs)
    check_adbs(adbs)

main()
