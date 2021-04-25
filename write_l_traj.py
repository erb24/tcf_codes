#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np


# In[2]:


traj = np.load('../unformatted_traj.npy')


# In[17]:


nca = np.loadtxt('../LE4PD/nres_list.dat')
nfrs = traj.shape[1]
N = traj.shape[0] // 3
nmol = len(nca)
print(N, nfrs, nca, nmol)
nca_cumsum = np.cumsum(nca)

lx = np.zeros((N - nmol, nfrs))
ly = np.zeros((N - nmol, nfrs))
lz = np.zeros((N - nmol, nfrs))

rx = traj[::3, :]
ry = traj[1::3, :]
rz = traj[2::3, :]

#Define bond vectors
counter = 0
mol_counter = 0
i = 1
while i <= N:
    if i == nca_cumsum[mol_counter]:
        i += 1
        mol_counter += 1
        if mol_counter == nmol: break
    else:
        lx[counter,:] = rx[i,:] - rx[i-1,:] 
        ly[counter,:] = ry[i,:] - ry[i-1,:]
        lz[counter,:] = rz[i,:] - rz[i-1,:]
        counter += 1
        i += 1


# In[18]:


stride = 5
for i in range(traj.shape[0] // 3 - nmol):
    print(i)
    np.savetxt('../l_traj_' + str(i + 1), np.column_stack([lx[i,::stride], ly[i,::stride], lz[i,::stride]]))


# In[ ]:




