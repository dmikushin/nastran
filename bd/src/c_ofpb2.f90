!*==/home/marcusmae/nasa/nastran/SPAGged/C_OFPB2.f90  created by SPAG 8.01RF at 14:46 on  2 Dec 2023
MODULE C_OFPB2
   INTEGER, DIMENSION(1200) :: C
!OF2PBD
!
!     C ARRAY FOR COMPLEX STRESSES SORT1
!
!
!                 IX,L1,L2,L3,L4,L5         , IX,L1,L2,L3,L4,L5
!
!                 REAL/IMAG  L3=125         , MAG/PHASE  L3=126
!                     (L1 IS SET FOR FREQ ALWASYS = 104)
!
   DATA C/473 , 104 , 136 , 125 , 0 , 165 , 483 , 104 , 136 , 126 , 0 , 165 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 ,    &
      & 473 , 104 , 144 , 125 , 0 , 165 , 483 , 104 , 144 , 126 , 0 , 165 , 473 , 104 , 137 , 125 , 0 , 166 , 483 , 104 , 137 ,     &
      & 126 , 0 , 166 , 473 , 104 , 145 , 125 , 0 , 166 , 483 , 104 , 145 , 126 , 0 , 166 , 515 , 104 , 139 , 125 , 0 , 168 , 540 , &
      & 104 , 139 , 126 , 0 , 168 , 515 , 104 , 138 , 125 , 0 , 168 , 540 , 104 , 138 , 126 , 0 , 168 , 515 , 104 , 143 , 125 , 0 , &
      & 168 , 540 , 104 , 143 , 126 , 0 , 168 , 448 , 104 , 142 , 125 , 0 , 169 , 461 , 104 , 142 , 126 , 0 , 169 , 473 , 104 ,     &
      & 131 , 125 , 0 , 165 , 483 , 104 , 131 , 126 , 0 , 165 , 493 , 104 , 128 , 125 , 0 , 171 , 504 , 104 , 128 , 126 , 0 , 171 , &
      & 493 , 104 , 129 , 125 , 0 , 171 , 504 , 104 , 129 , 126 , 0 , 171 , 493 , 104 , 130 , 125 , 0 , 171 , 504 , 104 , 130 ,     &
      & 126 , 0 , 171 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 515 , 104 , 133 , 125 , 0 , 168 , 540 , 104 , 133 , 126 , &
      & 0 , 168 , 448 , 104 , 132 , 125 , 0 , 169 , 461 , 104 , 132 , 126 , 0 , 169 , 515 , 104 , 140 , 125 , 0 , 168 , 540 , 104 , &
      & 140 , 126 , 0 , 168 , 515 , 104 , 135 , 125 , 0 , 168 , 540 , 104 , 135 , 126 , 0 , 168 , 515 , 104 , 134 , 125 , 0 , 168 , &
      & 540 , 104 , 134 , 126 , 0 , 168 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , &
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 ,&
      & 0 , 0 , 0 , 0 , -1 , 0 , 0 , 565 , 104 , 127 , 125 , 0 , 164 , 595 , 104 , 127 , 126 , 0 , 164 , 0 , 0 , 0 , -1 , 0 , 0 ,   &
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 ,&
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 1162 , 104 , 222 , 125 , 0 , 219 , 1197 , 104 , 222 , 126 , 0 , 219 ,     &
      & 1162 , 104 , 224 , 125 , 0 , 219 , 1197 , 104 , 224 , 126 , 0 , 219, &
      & 1162 , 104 , 226 , 125 , 0 , 219 , 1197 , 104 , 226 , 126 , 0 , 219 , 1162 , 104 , 228 , 125 , 0 , 219 , 1197 , 104 ,   &
      & 228 , 126 , 0 , 219 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 ,   &
      & 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 0 , 0 , 0 , -1 , 0 , 0 , 1468 , 104 , 236 , 125 ,&
      & 0 , 250 , 1480 , 104 , 236 , 126 , 0 , 250 , 1254 , 104 , 237 , 125 , 0 , 241 , 1276 , 104 , 237 , 126 , 0 , 241 , 4154 ,   &
      & 104 , 238 , 125 , 0 , 451 , 4180 , 104 , 238 , 126 , 0 , 451 , 668 , 104 , 239 , 125 , 0 , 247 , 683 , 104 , 239 , 126 , 0 ,&
      & 247 , 1396 , 104 , 240 , 125 , 0 , 244 , 1412 , 104 , 240 , 126 , 0 , 244 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 1254 , 104 , 266 , 125 , 0 , 264 , 1276 , 104 , 266 , 126 , 0 , 264 , 1254 , 104 , 267 , 125 , 0 , 264 , 1276 , 104 , 267 , &
      & 126 , 0 , 264 , 1254 , 104 , 268 , 125 , 0 , 264 , 1276 , 104 , 268 , 126 , 0 , 264 , 1254 , 104 , 269 , 125 , 0 , 264 ,    &
      & 1276 , 104 , 269 , 126 , 0 , 264 , 1254 , 104 , 270 , 125 , 0 , 264 , 1276 , 104 , 270 , 126 , 0 , 264 , 1254 , 104 , 288 , &
      & 125 , 0 , 264 , 1276 , 104 , 288 , 126 , 0 , 264 , 1254 , 104 , 289 , 125 , 0 , 264 , 1276 , 104 , 289 , 126 , 0 , 264 ,    &
      & 1254 , 104 , 290 , 125 , 0 , 264 , 1276 , 104 , 290 , 126 , 0 , 264 , &
      & 1254 , 104 , 291 , 125 , 0 , 264 , 1276 , 104 , 291 , 126 , 0 , 264 , 448 , 104 , 305 , 125 , 0 , 169 , 461 , 104 ,     &
      & 305 , 126 , 0 , 169 , 448 , 104 , 307 , 125 , 0 , 324 , 461 , 104 , 307 , 126 , 0 , 324 , 515 , 104 , 448 , 125 , 0 , 449 , &
      & 540 , 104 , 448 , 126 , 0 , 449 , 1852 , 104 , 331 , 125 , 329 , 332 , 1852 , 104 , 331 , 126 , 329 , 332 , 1852 , 104 ,    &
      & 331 , 125 , 329 , 332 , 1852 , 104 , 331 , 126 , 329 , 332 , 1921 , 104 , 331 , 125 , 329 , 332 , 1921 , 104 , 331 , 126 ,  &
      & 329 , 332 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 2657 , 104 ,    &
      & 393 , 125 , 0 , 348 , 2657 , 104 , 393 , 126 , 0 , 348 , 2756 , 104 , 395 , 125 , 0 , 348 , 2756 , 104 , 395 , 126 , 0 ,    &
      & 348 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 448 , 104 , 454 , 125 , 0 , 169 , 461 , 104 , 454 , 126 , 0 , 169 ,   &
      & 515 , 104 , 456 , 125 , 0 , 168 , 540 , 104 , 456 , 126 , 0 , 168 , 515 , 104 , 458 , 125 , 0 , 168 , 540 , 104 , 458 ,     &
      & 126 , 0 , 168 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 3313 , 104 , 412 , 125 , 0 , 413 ,      &
      & 3313 , 104 , 412 , 126 , 0 , 413 , &
      & 3906 , 104 , 426 , 125 , 0 , 164 , 3601 , 104 , 426 , 126 , 0 , 164 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ,   &
      & 515 , 104 , 466 , 125 , 0 , 449 , 540 , 104 , 466 , 126 , 0 , 449 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , &
      & 0 , 0 , 0 , 0/
END MODULE c_ofpb2
