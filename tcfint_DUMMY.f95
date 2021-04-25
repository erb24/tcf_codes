        program inputreader
        integer nfrs,n,step
        CHARACTER(len=32) :: arg
        open(unit=5,file="protname.txt",status='old')
        read(5,*)
        read(5,*)n
        read(5,*)nfrs
        close(5)
        nfrs = nfrs - 1
        CALL getarg(1,arg)
        read (arg, '(I10)') step
        WRITE(*,*)"STEP: ",step
        nfrs = INT(nfrs/step)
        write(*,*)n,nfrs
!       nfrs=500 !testing!
        call umatrix(n,nfrs,step)

	End program inputreader

        subroutine umatrix(n,nfrs,step)
        integer i,j,k,l,m,imin,jmin,a,nca,n,nfrs,step,counter
        real, dimension(nfrs) :: lx,ly,lz,lavmsq
        real, dimension(0:nfrs) :: dipcorr
        real, dimension(0:nfrs) :: avdipcorr
        DOUBLE PRECISION :: init
        character(32)protname
        character(16)aa,ii
        open(unit=5,file="protname.txt",status='old')
        read(5,'(A)')protname
        close(5)
        protname=adjustl(protname)
        lx=0.0
        ly=0.0
        lz=0.0
        lavmsq=0.0

        l = dummy
        i=l
        WRITE(ii,*)i
        ii=adjustl(ii)

        !read from trajectory
        open(unit=13,file='l_traj_'//TRIM(ii),status='old')
        DO k = 1, nfrs
          read(13,*)lx(k), ly(k), lz(k)
        END DO
        close(13)

        !Introduce the stepping function
        lx = lx(::step)
        ly = ly(::step)
        lz = lz(::step)

	dipcorr=0.0
	avdipcorr=0.0
	!calculate tcf of bond autocorrelation
	do j=0,nfrs/4
	    if(mod(j,1000).eq.0)write(*,*)"tcf frame:",j
	    do k=1,nfrs-j
	      dipcorr(j)=dipcorr(j)+((lx(k)*lx(j+k)+ly(k)*ly(j+k)+lz(k)*lz(j+k)))
	    end do
	    dipcorr(j)=dipcorr(j)/real(nfrs-j)
	    !dipcorr(l,j)=dipcorr(l,j)/dipcorr(l,0)
	end do !end j time loop

	i=l
	  WRITE(ii,*)i
	  ii=adjustl(ii)
	  init = dipcorr(0)
	  OPEN(unit=24,file='m1CAsimint_'//trim(ii),status='unknown')
	  DO k=0,nfrs/4
	    WRITE(24,*)step*2*k,dipcorr(k)/init !dipcorr(i,0)
	  END DO
	  CLOSE(24)

	end subroutine

