!*==/home/marcusmae/nasa/nastran/SPAGged/C_OFPB5.f90  created by SPAG 8.01RF at 14:46 on  2 Dec 2023
MODULE C_OFPB5
   INTEGER, DIMENSION(600) :: C
!OF5PBD
!
!     C ARRAY FOR REAL FORCES SORT 1
!
   DATA C/43 , 0 , 36 , -1 , 7 , 8 , 11 , 0 , 37 , -1 , 9 , 10 , 43 , 0 , 54 , -1 , 7 , 8 , 1521 , 0 , 38 , -1 , 0 , 312 , 43 , 0 ,&
      & 39 , -1 , 13 , 12 , 65 , 0 , 51 , -1 , 14 , 15 , 65 , 0 , 40 , -1 , 14 , 15 , 65 , 0 , 53 , -1 , 14 , 15 , 0 , 0 , 0 , -1 , &
      & 0 , 0 , 43 , 0 , 46 , -1 , 7 , 8 , 54 , 0 , 41 , -1 , 16 , 17 , 54 , 0 , 42 , -1 , 16 , 17 , 54 , 0 , 43 , -1 , 16 , 17 ,   &
      & 54 , 0 , 44 , -1 , 16 , 17 , 65 , 0 , 48 , -1 , 14 , 15 , 0 , 0 , 0 , -1 , 0 , 0 , 65 , 0 , 52 , -1 , 14 , 15 , 65 , 0 ,    &
      & 50 , -1 , 14 , 15 , 65 , 0 , 49 , -1 , 14 , 15 , 0 , 0 , 0 , -1 , 0 , 0 , &
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 11 , 0 , 47 , -1 , 9 , 10 , 1127 , 0 , 205 , &
      & -1 , 0 , 207 , 236 , 0 , 83 , -1 , 84 , 85 , 255 , 0 , 86 , -1 , 84 , 85 , 279 , 0 , 87 , -1 , 88 , 89 , 0 , 0 , 0 , -1 ,   &
      & 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , &
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1242 , 0 , 259 , -1 , 0 , 265 , 1242 , 0 , 260 , -1 , 0 , 265 , 1242 ,  &
      & 0 , 261 , -1 , 0 , 265 , 1242 , 0 , 262 , -1 , 0 , 265 , 1242 , 0 , 263 , -1 , 0 , 265 , 1242 , 0 , 284 , -1 , 0 , 265 ,    &
      & 1242 , 0 , 285 , -1 , 0 , 265 , 1242 , 0 , 286 , -1 , 0 , 265 , &
      & 1242 , 0 , 287 , -1 , 0 , 265 , 0 , 0 , 0 , -1 , 0 , 0 , 1521 , 0 , 310 , -1 , 0 , 312 , 4061 , 0 , 440 , 441 , 442 ,   &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1961 , 0 , 339 , -1 , 340 , 341 , 2028 , 0 ,    &
      & 342 , -1 , 340 , 341 , 2181 , 0 , 349 , -1 , 0 , 350 , 2214 , 0 , 352 , -1 , 0 , 350 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,  &
      & 0 , 0 , 0 , 2371 , 0 , 357 , -1 , 359 , 360 , 2371 , 0 , 342 , -1 , 359 , 360 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 3581 , 0 , 416 , 417 , 418 , 419 , 3939 , 0 , 432 , -1 , 0 , 434 , 4061 , 0 , 463 , 441 , 442 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1939 ,  &
      & 0 , 333 , -1 , 334 , 335/
END MODULE c_ofpb5
