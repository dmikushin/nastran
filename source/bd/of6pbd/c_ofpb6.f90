!*==/home/marcusmae/nasa/nastran/SPAGged/C_OFPB6.f90  created by SPAG 8.01RF at 14:46 on  2 Dec 2023
MODULE C_OFPB6
   INTEGER, DIMENSION(240) :: C1, C21, C41, C61, C81
!OF6PBD
!
!     C ARRAY FOR COMPLEX FORCES SORT 1
!
   DATA c1/473 , 104 , 156 , 125 , 0 , 167 , 483 , 104 , 156 , 126 , 0 , 167 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 ,    &
      & 473 , 104 , 162 , 125 , 0 , 167 , 483 , 104 , 162 , 126 , 0 , 167 , 1564 , 104 , 157 , 125 , 0 , 312 , 1643 , 104 , 157 ,   &
      & 126 , 0 , 312 , 473 , 104 , 163 , 125 , 174 , 173 , 483 , 104 , 163 , 126 , 174 , 173 , 668 , 104 , 159 , 125 , 14 , 15 ,   &
      & 683 , 104 , 159 , 126 , 14 , 15 , 668 , 104 , 158 , 125 , 14 , 15 , 683 , 104 , 158 , 126 , 14 , 15 , 668 , 104 , 161 ,     &
      & 125 , 14 , 15 , 683 , 104 , 161 , 126 , 14 , 15 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 473 , 104 , 152 , 125 , &
      & 0 , 167 , 483 , 104 , 152 , 126 , 0 , 167 , 493 , 104 , 148 , 125 , 0 , 170 , 504 , 104 , 148 , 126 , 0 , 170 , 493 , 104 , &
      & 149 , 125 , 0 , 170 , 504 , 104 , 149 , 126 , 0 , 170 , 493 , 104 , 150 , 125 , 0 , 170 , 504 , 104 , 150 , 126 , 0 , 170 , &
      & 493 , 104 , 151 , 125 , 0 , 170 , 504 , 104 , 151 , 126 , 0 , 170 , 668 , 104 , 153 , 125 , 14 , 15 , 683 , 104 , 153 ,     &
      & 126 , 14 , 15 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 668 , 104 , 160 , 125 , 14 , 15 , 683 , 104 , 160 , 126 , &
      & 14 , 15 , 668 , 104 , 155 , 125 , 14 , 15 , 683 , 104 , 155 , 126 , 14 , 15 , 668 , 104 , 154 , 125 , 14 , 15 , 683 , 104 , &
      & 154 , 126 , 14 , 15 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0/
   DATA c21/0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 626 , 104 , 146 , 125 , 9 , 10 , 647 , 104 , 146 , 126 , 9 , 10 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , &
      & 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 ,&
      & 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 ,&
      & 0 , 0 , -1 , 0 , 0/
   DATA c41/0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1254 , 104 , 271 , 125 ,&
      & 0 , 265 , 1276 , 104 , 271 , 126 , 0 , 265 , 1254 , 104 , 272 , 125 , 0 , 265 , 1276 , 104 , 272 , 126 , 0 , 265 , 1254 ,   &
      & 104 , 273 , 125 , 0 , 265 , 1276 , 104 , 273 , 126 , 0 , 265 , 1254 , 104 , 274 , 125 , 0 , 265 , 1276 , 104 , 274 , 126 ,  &
      & 0 , 265 , 1254 , 104 , 275 , 125 , 0 , 265 , 1276 , 104 , 275 , 126 , 0 , 265 , 1254 , 104 , 292 , 125 , 0 , 265 , 1276 ,   &
      & 104 , 292 , 126 , 0 , 265 , 1254 , 104 , 293 , 125 , 0 , 265 , 1276 , 104 , 293 , 126 , 0 , 265 , 1254 , 104 , 294 , 125 ,  &
      & 0 , 265 , 1276 , 104 , 294 , 126 , 0 , 265/
!    *           , 515,104,457,125,  0,168   , 540,104,457,126,  0,168
!    *           , 448,104,457,125,  0,169   , 461,104,457,126,  0,169
   DATA c61/1254 , 104 , 295 , 125 , 0 , 265 , 1276 , 104 , 295 , 126 , 0 , 265 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , &
      & 1564 , 104 , 311 , 126 , 0 , 312 , 1643 , 104 , 311 , 126 , 0 , 312 , 4229 , 104 , 460 , 125 , 441 , 442 , 4206 , 104 ,     &
      & 460 , 126 , 441 , 442 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 2587 , 104 , 392 , 125 , 0 , 350 , 2622 , 104 , 392 , 126 , 0 , 350 , 2664 , 104 , 394 , 125 , 0 , 350 ,    &
      & 2710 , 104 , 394 , 126 , 0 , 350 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 448 , 104 , 455 , 125 , 0 , 169 , 461 ,  &
      & 104 , 455 , 126 , 0 , 169 , 668 , 104 , 457 , 125 , 14 , 15 , 683 , 104 , 457 , 126 , 14 , 15 , 0 , 104 , 459 , 125 , 0 ,   &
      & 0 , 0 , 104 , 459 , 126 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,   &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0/
   DATA c81/3869 , 104 , 424 , 126 , 0 , 427 , 3832 , 104 , 424 , 125 , 0 , 427 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,   &
      & 4229 , 104 , 464 , 125 , 441 , 442 , 4206 , 104 , 464 , 126 , 441 , 442 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,   &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0/
END MODULE c_ofpb6