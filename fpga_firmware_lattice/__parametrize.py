import shutil
import glob
import os
import subprocess


#delete prev run
i=1
while i<50:
    seed = i*12345678
    tmp_folder = 'temp_seed_'+str(seed)
    if os.path.isdir(tmp_folder):
        print ("Deleting ",tmp_folder)
        shutil.rmtree(tmp_folder)
    i+=1
i=1
while i<50:
    seed = i*12345678
    print ("SEED = ",str(seed))
    tmp_folder = 'temp_seed_'+str(seed)
    #create folder and subfolders
    os.makedirs(tmp_folder, exist_ok=True)
    os.makedirs(tmp_folder + '/fatfs', exist_ok=True)
    os.makedirs(tmp_folder+ '/sd', exist_ok=True)
    #copy verilog files
    for file_path in glob.glob(os.path.join('./', '*.v')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./sd/', '*.v')):
        shutil.copy(file_path, tmp_folder+'/sd/')
    for file_path in glob.glob(os.path.join('./', '*.lpf')):
        shutil.copy(file_path, tmp_folder)
    #copy c/h sources
    for file_path in glob.glob(os.path.join('./', '*.c')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./fatfs/', '*.c')):
        shutil.copy(file_path, tmp_folder+'/fatfs/')
    for file_path in glob.glob(os.path.join('./', '*.h')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./fatfs/', '*.h')):
        shutil.copy(file_path, tmp_folder+'/fatfs/')
    for file_path in glob.glob(os.path.join('./', '*.lds')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./', '*.S')):
        shutil.copy(file_path, tmp_folder)
    #copy build scripts
    for file_path in glob.glob(os.path.join('./', '__build.cmd')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./', '__build2.cmd')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./', '__run.cmd')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./', 'Makefile')):
        shutil.copy(file_path, tmp_folder)
    for file_path in glob.glob(os.path.join('./', 'makehex.py')):
        shutil.copy(file_path, tmp_folder)
    #copy binaries
    for file_path in glob.glob(os.path.join('./', 'wasca-fallback.ss')):
        shutil.copy(file_path, tmp_folder)
    #replace seed
    with open(tmp_folder+'/Makefile', 'r') as mf:
        mf_data = mf.read()
    new_mf_data = mf_data.replace('--seed 0', '--seed '+str(seed))
    with open(tmp_folder+'/Makefile', 'w') as mf:
        mf.write(new_mf_data)
    #launch the build
    with open(tmp_folder+'/log.txt', 'w') as f:
        subprocess.run(['__build.cmd'], stdout=f, stderr=f, text=True, cwd=tmp_folder)
    with open(tmp_folder+'/log.txt', "r") as file:
        for line in file:
            if 'Max frequency for clock' in line:
                print(line.strip()) 
            if '(PASS at ' in line:
                if not '(PASS at 50.00' in line:
                    i=100500 #skipping remaining cycles
    i+=1
    