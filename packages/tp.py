import os

def create(data_name:str, default_value=""):
    if os.path.exists(f"c:/npnp/plugins/data/{data_name}.dat") == False:
        with open(f"c:/npnp/plugins/data/{data_name}.dat",'w+') as f:
            f.write(default_value)

def get(data_name:str):
    if os.path.exists(f"c:/npnp/plugins/data/{data_name}.dat"):
        with open(f"c:/npnp/plugins/data/{data_name}.dat",'r') as f:
                return f.read()

def write(data_name:str,content=""):
    with open(f"c:/npnp/plugins/data/{data_name}.dat",'w+') as f:
        f.write(content)

def remove(data_name:str):
    if os.path.exists(f"c:/npnp/plugins/data/{data_name}.dat"):
        os.system(f"del c:\\npnp\\plugins\\data\\{data_name}.dat")
    
