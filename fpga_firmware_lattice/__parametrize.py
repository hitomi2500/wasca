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
    os.makedirs(tmp_folder + '/picorv_bootstrap', exist_ok=True)
    os.makedirs(tmp_folder + '/picorv_firmware', exist_ok=True)
    os.makedirs(tmp_folder + '/fatfs', exist_ok=True)
    os.makedirs(tmp_folder+ '/hdl', exist_ok=True)
    os.makedirs(tmp_folder+ '/hdl/sd', exist_ok=True)
    #copy verilog files
    for file_path in glob.glob(os.path.join('./hdl/', '*.v')):
        shutil.copy(file_path, tmp_folder+'/hdl/')
    for file_path in glob.glob(os.path.join('./hdl/sd/', '*.v')):
        shutil.copy(file_path, tmp_folder+'/hdl/sd/')
    for file_path in glob.glob(os.path.join('./hdl/', '*.lpf')):
        shutil.copy(file_path, tmp_folder+'/hdl/')
    #copy c/h sources
    for file_path in glob.glob(os.path.join('./picorv_bootstrap/', '*.c')):
        shutil.copy(file_path, tmp_folder+'/picorv_bootstrap/')
    for file_path in glob.glob(os.path.join('./picorv_firmware/', '*.c')):
        shutil.copy(file_path, tmp_folder+'/picorv_firmware/')
    for file_path in glob.glob(os.path.join('./fatfs/', '*.c')):
        shutil.copy(file_path, tmp_folder+'/fatfs/')
    for file_path in glob.glob(os.path.join('./picorv_bootstrap/', '*.h')):
        shutil.copy(file_path, tmp_folder+'/picorv_bootstrap/')
    for file_path in glob.glob(os.path.join('./picorv_firmware/', '*.h')):
        shutil.copy(file_path, tmp_folder+'/picorv_firmware/')
    for file_path in glob.glob(os.path.join('./fatfs/', '*.h')):
        shutil.copy(file_path, tmp_folder+'/fatfs/')
    for file_path in glob.glob(os.path.join('./picorv_bootstrap/', '*.lds')):
        shutil.copy(file_path, tmp_folder+'/picorv_bootstrap/')
    for file_path in glob.glob(os.path.join('./picorv_firmware/', '*.lds')):
        shutil.copy(file_path, tmp_folder+'/picorv_firmware/')
    for file_path in glob.glob(os.path.join('./picorv_bootstrap/', '*.S')):
        shutil.copy(file_path, tmp_folder+'/picorv_bootstrap/')
    for file_path in glob.glob(os.path.join('./picorv_firmware/', '*.S')):
        shutil.copy(file_path, tmp_folder+'/picorv_firmware/')
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
    for file_path in glob.glob(os.path.join('./picorv_bootstrap/', 'wasca-fallback.ss')):
        shutil.copy(file_path, tmp_folder+'/picorv_bootstrap/')
    for file_path in glob.glob(os.path.join('./picorv_firmware/', 'wasca-fallback.ss')):
        shutil.copy(file_path, tmp_folder+'/picorv_firmware/')
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
            if '(PASS at 143.76' in line:
                i=100500 #skipping remaining cycles
    i+=1
    