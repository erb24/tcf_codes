#!/bin/bash

BD=$PWD
  for i in `seq 160 198`
  do
	cp -v tcf_DUMMY.f95 tcf_${i}.f95
	sed "s#DUMMY#${i}#g" tcf_DUMMY.pbs > ./tcf_${i}.pbs
	sbatch tcf_${i}.pbs
	
  done
  cd $BD

exit
