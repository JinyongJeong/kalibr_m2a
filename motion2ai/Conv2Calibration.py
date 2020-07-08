#!/usr/bin/python

import sys
import yaml
import json
from collections import OrderedDict

print("Input file name: " + str(sys.argv[1]))
print("Output file name: " + str(sys.argv[2]))

with open(sys.argv[1]) as file:
    list = yaml.load(file, Loader=yaml.FullLoader)
    print(list)
    width=list["cam0"]["resolution"][0]
    height=list["cam0"]["resolution"][1]
    #print(width)
    #print(height)
    intrinsic=list["cam0"]["intrinsics"]
    dist_coeff=list["cam0"]["distortion_coeffs"]
    #print(intrinsic)
    #print(dist_coeff)

    camera0 = OrderedDict([('imageWidth', width), ('imageHeight', height),
            ('intrinsicMatrix', [intrinsic[0], 0, intrinsic[2], 0, intrinsic[1], intrinsic[3], 0, 0, 1]), 
            ('equidistant', [dist_coeff[0], dist_coeff[1], dist_coeff[2], dist_coeff[3]])])

    jsonData = OrderedDict()
    jsonData["camera0"]=camera0
    
    with open(sys.argv[2],"w") as json_file:
        json.dump(jsonData, json_file, indent=1, sort_keys=False)


