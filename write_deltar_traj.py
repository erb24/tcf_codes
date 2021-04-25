#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import matplotlib.pyplot as plt


# In[3]:


traj = np.load('../unformatted_traj.npy')


# In[6]:


dtraj = traj - (traj.mean(1)).reshape(594, 1)


# In[14]:


last = 0
n = 0
for i in range(0, dtraj.shape[0], 3):
    print(last, i)
    np.savetxt('../deltar_traj_' + str(n + 1), dtraj[last:i + 3, ::5].T)
    n += 1
    last = i + 3


# In[ ]:




