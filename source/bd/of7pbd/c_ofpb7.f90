!*==/home/marcusmae/nasa/nastran/SPAGged/C_OFPB7.f90  created by SPAG 8.01RF at 14:46 on  2 Dec 2023
MODULE C_OFPB7
   INTEGER, DIMENSION(600) :: C
!OF7PBD
!
!     C ARRAY FOR REAL FORCES SORT 2 - TIME
!
   DATA C/698 , 108 , 36 , -1 , 0 , 176 , 707 , 108 , 37 , -1 , 0 , 177 , 698 , 108 , 54 , -1 , 0 , 176 , 1542 , 108 , 38 , -1 ,   &
      & 0 , 314 , 698 , 108 , 39 , -1 , 0 , 179 , 719 , 108 , 51 , -1 , 0 , 180 , 719 , 108 , 40 , -1 , 0 , 180 , 719 , 108 , 53 ,  &
      & -1 , 0 , 180 , 0 , 0 , 0 , -1 , 0 , 0 , 698 , 108 , 46 , -1 , 0 , 176 , 728 , 108 , 41 , -1 , 0 , 181 , 728 , 108 , 42 ,    &
      & -1 , 0 , 181 , 728 , 108 , 43 , -1 , 0 , 181 , 728 , 108 , 44 , -1 , 0 , 181 , 719 , 108 , 48 , -1 , 0 , 180 , 0 , 0 , 0 ,  &
      & -1 , 0 , 0 , 719 , 108 , 52 , -1 , 0 , 180 , 719 , 108 , 50 , -1 , 0 , 180 , 719 , 108 , 49 , -1 , 0 , 180 , 0 , 0 , 0 ,    &
      & -1 , 0 , 0 , &
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 707 , 108 , 47 , -1 , 0 , 177 , 0 , 0 , 0 ,  &
      & -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 ,&
      & -1 , 0 , 0 , &
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1493 , 108 , 259 , -1 , 0 , 277 , 1493 , 108 , 260 , -1 , 0 , 277 ,     &
      & 1493 , 108 , 261 , -1 , 0 , 277 , 1493 , 108 , 262 , -1 , 0 , 277 , 1493 , 108 , 263 , -1 , 0 , 277 , 1493 , 108 , 284 ,    &
      & -1 , 0 , 277 , 1493 , 108 , 285 , -1 , 0 , 277 , 1493 , 108 , 286 , -1 , 0 , 277 , &
      & 1493 , 108 , 287 , -1 , 0 , 277 , 0 , 0 , 0 , -1 , 0 , 0 , 1542 , 108 , 310 , -1 , 0 , 314 , 4105 , 108 , 440 , 445 ,   &
      & 446 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,   &
      & 0 , 0 , 2983 , 108 , 349 , 0 , 0 , 400 , 3001 , 108 , 352 , 0 , 0 , 400 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,   &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 3655 , 108 , 416 , -1 , 421 , 422 , 3945 , 108 , 432 , -1 , 0 , 433 , 4105 , 108 , 463 , 445 , 446 , 0 , 0 , 0 , 0 , 0 ,&
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0/
END MODULE c_ofpb7
