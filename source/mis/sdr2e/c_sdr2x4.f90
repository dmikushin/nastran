!*==/home/marcusmae/nasa/nastran/SPAGged/C_SDR2X4.f90  created by SPAG 8.01RF at 14:47 on  2 Dec 2023
MODULE C_SDR2X4
   INTEGER :: Acc, All, Any, Branch, Buf1, Buf2, Buf3, Buf4, Buf5, Displ, Eldef, End, File, Force, Icstm, Isopl,    &
            & Ivec, Ivecn, Knset, Ktype, Kwdcc, Kwdedt, Kwdest, Kwdgpt, Loads, Mset, Ncstm, Nharms, Nrigds, Nrings,   &
            & Spcf, Stress, Strspt, Symflg, Tloads, Vel
   LOGICAL :: Axic, Ddrmm
   INTEGER, DIMENSION(2) :: Bk0, Bk1, Cei, Ds0, Ds1, Frq, Nam, Rei, Sta, Trn
   REAL :: Deform, Temp
   INTEGER, DIMENSION(8) :: Dtype
   INTEGER, DIMENSION(7) :: Icb, Mcb, Ocb
   INTEGER, DIMENSION(22) :: Pla
END MODULE C_SDR2X4