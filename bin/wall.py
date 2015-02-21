#!/usr/bin/env python3
import os
import random

root = ''.join([os.environ['HOME'],'/Wallpapers/'])
walls = []
for relpath, dirs, files in os.walk(root):
	walls += [os.path.join(relpath, file) for file in files]
print(random.choice(walls))
