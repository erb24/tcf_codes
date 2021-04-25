#!/bin/bash 
for i in `seq 1 196`
do
  cp -v tcf_DUMMY.pbs tcf_${i}.pbs
  sed -i "s#DUMMY#${i}#g" tcf_${i}.pbs
  cp -v tcfint_DUMMY.f95 ./tcfint_${i}.f95
  sbatch tcf_${i}.pbs
done

exit
