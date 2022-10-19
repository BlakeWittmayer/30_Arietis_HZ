      PROGRAM BinHab
!C***************************************************
!C    
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
      COMMON / TRAN1 / AL1,TE1,RS1,AM1
      COMMON / TRAN2 / AL2,TE2,RS2,AM2
!C
      OPEN(05,FILE='IN.DAT',STATUS='OLD')
      OPEN(18,FILE='OUT.DAT',STATUS='NEW')
!C
      READ(05,*) A2P
      READ(05,*) EP
      READ(05,*) TE1
      READ(05,*) AL1
      READ(05,*) AM1
      READ(05,*) TE2
      READ(05,*) AL2
      READ(05,*) AM2
      READ(05,*) AMPL
!C
      READ(05,*) KNEW
      READ(05,*) IHZI
      READ(05,*) IHZO
!C
!C********************************
!C  INPUT PARAMETERS
!C********************************
!C**
!C**   A2P  ... SEMI-MAJOR AXIS OF STAR SYSTEM ; A2P = ABIN
!C**   EP   ... ECCENTRICITY OF STAR SYSTEM ; EP = EBIN
!C**   AL1  ... LUMINOSITY OF STAR1 = PRIMARY
!C**   AL2  ... LUMINOSITY OF STAR2 = SECONDARY
!C**   AMP  ... PLANETARY MASS
!C**   KNEW ... CLIMATE MODELS
!C**   ISP  = 1   ... EXPLORE P/PT-TYPE HABITABILITY
!C**   ISP  = 2   ... EXPLORE S/ST-TYPE HABITABILITY
!C**
!C********************************
!C  CONTROL AND OUTPUT PARAMETERS
!C********************************
!C**   ICASE =  1 ... NO      HABITABILITY
!C**   ICASE =  2 ... P-TYPE  HABITABILITY
!C**   ICASE = -2 ... PT-TYPE HABITABILITY
!C**   ICASE =  3 ... S-TYPE  HABITABILITY
!C**   ICASE = -3 ... ST-TYPE HABITABILITY
!C============================================
!C  PARAMETER SET-UP
!C============================================
!C
      AMU  = AM2 / (AM1+AM2)
      AP   = A2P / 2.0D0
      ADIS = AP
      DIS  = (AM1-AM2)/(AM1+AM2)
      ADISP = AP*(1.0D0+EP)
      ADISE = AP
      ADISM = AP*(1.0D0-EP)
      IHZO  = IHZO + 3
!C
      IF (KNEW.EQ.1) THEN
        ZL1I = ZLFCT(AL1,TE1,IHZI,AMPL)
        ZL1O = ZLFCT(AL1,TE1,IHZO,AMPL)
        ZL2I = ZLFCT(AL2,TE2,IHZI,AMPL)
        ZL2O = ZLFCT(AL2,TE2,IHZO,AMPL)
      ENDIF
!C
      IF (KNEW.EQ.2) THEN
        ZL1I = ZLFCTS(AL1,TE1,IHZI)
        ZL1O = ZLFCTS(AL1,TE1,IHZO)
        ZL2I = ZLFCTS(AL2,TE2,IHZI)
        ZL2O = ZLFCTS(AL2,TE2,IHZO)
      ENDIF
!C
      IF (KNEW.EQ.3) THEN
        ZL1I = ZLFCTU(AL1,TE1,IHZI)
        ZL1O = ZLFCTU(AL1,TE1,IHZO)
        ZL2I = ZLFCTU(AL2,TE2,IHZI)
        ZL2O = ZLFCTU(AL2,TE2,IHZO)
      ENDIF
!C
      HZIP = 0.0D0
      HZOP = 0.0D0
      HZIS = 0.0D0
      HZOS = 0.0D0
!C
!C**********************************
!C   EXPLORE P/PT-TYPE HABITABILITY
!C**********************************
!C
      DO 301 JJ = 1,2
        ALAC = 1.0D-3
        IF (JJ.EQ.1) THEN
          EQI = 0
          ZLIM = 0.5D0*(ZL1I+ZL2I)
          ZLID = DABS(ZL1I-ZL2I)
          IF (ZLID.LT.ALAC) THEN
            ZL1I = ZLIM
            ZL2I = ZLIM
            EQI = 1
          ENDIF
        ENDIF
        IF (JJ.EQ.2) THEN
          EQO = 0
          ZLOM = 0.5D0*(ZL1O+ZL2O)
          ZLOD = DABS(ZL1O-ZL2O)
          IF (ZLOD.LT.ALAC) THEN
            ZL1O = ZLOM
            ZL2O = ZLOM
            EQO = 1
          ENDIF
        ENDIF
!C
!C============================================
!C   EQUAL-STAR BINARY SYSTEMS
!C============================================
!C**
      IF ((EQI.EQ.1.AND.JJ.EQ.1).OR.(EQO.EQ.1.AND.JJ.EQ.2)) THEN
!C**
      ALI  = ZL1I
      ALO  = ZL1O
!C
      IF (JJ.EQ.1) THEN
       AL   = ALI
       ADIS = ADISP
      ENDIF
!C
      IF (JJ.EQ.2) THEN
       AL   = ALO
       ADIS = ADISP
      ENDIF
!C
      DUM = AL**2.0D0+4.0D0*ADIS**2.0D0*AL
!C
      IF (JJ.EQ.1)
     .  ZMIN = DSQRT(ADIS**2.0D0+AL+DSQRT(DUM))
!C
      IF (JJ.EQ.2) THEN
        HELP1 = -ADIS**2.0D0+2.0D0*AL
        IF (HELP1.LT.0.0D0) HELP1 = 0.0D0
        ZMAX = DSQRT(HELP1)
      ENDIF
!C
      ZSTABP = 2.0D0 * ADISE * ZSTFCT(AMU,EP,1)
!C
      HZIP = ZMIN
      HZOP = ZMAX
!C**
      ENDIF
!C**
!C============================================
!C   NONEQUAL-STAR BINARY SYSTEMS
!C============================================
!C**
      IF ((EQI.EQ.0.AND.JJ.EQ.1).OR.(EQO.EQ.0.AND.JJ.EQ.2)) THEN
!C**
      AL1I = ZL1I
      AL1O = ZL1O
      AL2I = ZL2I
      AL2O = ZL2O
!C
      IF (JJ.EQ.1) THEN
       AL1  = AL1I
       AL2  = AL2I
       ADIS = ADISP
      ENDIF
!C
      IF (JJ.EQ.2) THEN
       AL1  = AL1O
       AL2  = AL2O
       ADIS = ADISP
      ENDIF
!C
      DO 302 J = 1,181
!C
      I = J - 1
!C
      IF (I.EQ. 90) GOTO 404
!C
      PI    = 3.141592653589793D0
      PHI   = (PI / 1.8D2) * DBLE(I)
      COSPHI = DCOS(PHI)
      SINPHI = DSIN(PHI)
!C---
      A2     = 2.0D0*ADIS**2.0D0*(1.0D0-2.0D0*COSPHI**2.0D0)-
     .          (AL1+AL2) 
      A1     = 2.0D0*ADIS*COSPHI*(AL1-AL2)
      A0     = ADIS**4.0D0-ADIS**2.0D0*(AL1+AL2)
!C---
      A2H    = -A2
      A1H    = -4.0D0*A0
      A0H    = 4.0D0*A2*A0-A1**2.0D0
!C
      R      = (1.0D0/6.0D0)*A2H*A1H-(1.0D0/2.0D0)*A0H-
     .         (1.0D0/2.7D1)*A2H**3.0D0
      Q      = (1.0D0/3.0D0)*A1H-(1.0D0/9.0D0)*A2H**2.0D0
!C
      HELP0  = Q**3.0D0+R**2.0D0
!C
      IDUM = 0
      IF (HELP0.LT.0.0D0) THEN
        IDUM = 1
        GOTO 302
      ENDIF
!C
      VRO1    = R+DSQRT(HELP0)
!C
      IF (VRO1.GE.0.0D0) XVAL1 = VRO1**(1.0D0/3.0D0)
      IF (VRO1.LT.0.0D0) XVAL1 = -1.0D0*(DABS(VRO1)**(1.0D0/3.0D0))
!C
      VRO2    = R-DSQRT(HELP0)
!C
      IF (VRO2.GE.0.0D0) XVAL2 = VRO2**(1.0D0/3.0D0)
      IF (VRO2.LT.0.0D0) XVAL2 = -1.0D0*(DABS(VRO2)**(1.0D0/3.0D0))
!C
      Y1     = (-1.0D0/3.0D0)*A2H + XVAL1 + XVAL2
!C
      HELP1 = -A2+Y1
!C
      IDUM = 0
      IF (HELP1.LE.0.0D0) THEN
        IDUM = 1
        GOTO 302
      ENDIF
!C
      C     = DSQRT(HELP1)
!C
      IF (C.GT.0.0D0)
     . HELP2 = -C**2.0D0-2.0D0*A2+2.0D0*A1/C
      IF (C.EQ.0.0D0)
     . HELP2 = DSQRT(-2.0D0*A2+2.0D0*DSQRT(Y1**2.0D0-4.0D0*A0))
!C
      D     = DSQRT(HELP2)
!C
      IF (C.GT.0.0D0)
     . HELP3 = -C**2.0D0-2.0D0*A2-2.0D0*A1/C
      IF (C.EQ.0.0D0)
     . HELP3 = DSQRT(-2.0D0*A2-2.0D0*DSQRT(Y1**2.0D0-4.0D0*A0))
!C
      E     = DSQRT(HELP3)
!C
      Z1    =  -0.5D0*C - 0.5D0*D
      Z2    =  -0.5D0*C + 0.5D0*D
      Z3    =   0.5D0*C - 0.5D0*E
      Z4    =   0.5D0*C + 0.5D0*E
!C
      COR = ADIS * DIS
  404 IF (JJ.EQ.1) THEN
        IF (I.EQ.90) THEN
          ZINC = SQRT((AL1+AL2)-ADIS**2.0D0)
        ELSE
          IF (HELP2.LT.0.0D0) THEN
            ZINC = Z4
          ELSE
            ZINC = Z2
          ENDIF
        ENDIF
        ZMIN = DSQRT((ZINC*COSPHI+COR)**2.0D0+(ZINC*SINPHI)**2.0D0)
        IF (I.EQ.0) ZIN = 0.0D0
      ENDIF
      IF (JJ.EQ.2) THEN
        IF (I.EQ.90) THEN
          ZOUTC = SQRT((AL1+AL2)-ADIS**2.0D0)
        ELSE
          IF (HELP2.LT.0.0D0) THEN
            ZOUTC = Z4
          ELSE
            ZOUTC = Z2
          ENDIF
        ENDIF
        ZMAX = DSQRT((ZOUTC*COSPHI+COR)**2.0D0+(ZOUTC*SINPHI)**2.0D0)
        IF (I.EQ.0)  ZOUT = ZMAX
      ENDIF
      IF (ZIN.LT.ZMIN) ZIN = ZMIN
      IF (ZOUT.GT.ZMAX) ZOUT = ZMAX
!C
  302 CONTINUE
!C
      ZSTABP = 2.0D0 * ADISE * ZSTFCT(AMU,EP,1)
!C
      HZIP = ZIN
      HZOP = ZOUT
!C**
      ENDIF
!C**
  301 CONTINUE
!C
!C**********************************
!C   EXPLORE S/ST-TYPE HABITABILITY
!C**********************************
!C
      DO 351 JJ = 1,2
        ALAC = 1.0D-3
        IF (JJ.EQ.1) THEN
          EQI = 0
          ZLIM = 0.5D0*(ZL1I+ZL2I)
          ZLID = DABS(ZL1I-ZL2I)
          IF (ZLID.LT.ALAC) THEN
            ZL1I = ZLIM
            ZL2I = ZLIM
            EQI = 1
          ENDIF
        ENDIF
        IF (JJ.EQ.2) THEN
          EQO = 0
          ZLOM = 0.5D0*(ZL1O+ZL2O)
          ZLOD = DABS(ZL1O-ZL2O)
          IF (ZLOD.LT.ALAC) THEN
            ZL1O = ZLOM
            ZL2O = ZLOM
            EQO = 1
          ENDIF
        ENDIF
!C
!C============================================
!C   EQUAL-STAR BINARY SYSTEMS
!C============================================
!C**
      IF ((EQI.EQ.1.AND.JJ.EQ.1).OR.(EQO.EQ.1.AND.JJ.EQ.2)) THEN
!C**
      ALI  = ZL1I
      ALO  = ZL1O
!C
      IF (JJ.EQ.1) THEN
       AL   = ALI
       ADIS = ADISM
      ENDIF
!C
      IF (JJ.EQ.2) THEN
       AL   = ALO
       ADIS = ADISP
      ENDIF
!C
      DUM = AL**2.0D0+4.0D0*ADIS**2.0D0*AL
!C
      IF (JJ.EQ.1) THEN
        IDUM  = 0
        HELP2 = ADIS**2.0D0+AL-DSQRT(DUM)
        IF (HELP2.LT.0.0D0) THEN
          IDUM  = 1
          HELP2 = 0.0D0
        ENDIF
        Z2   = (-1.0D0)*DSQRT(HELP2)
        ZMIN = DABS(Z2+ADIS)
      ENDIF
!C
      IF (JJ.EQ.2) THEN
        Z1   = (-1.0D0)*DSQRT(ADIS**2.0D0+AL+DSQRT(DUM))
        ZMAX = DABS(Z1+ADIS)
      ENDIF
!C
      ZSTABS = 2.0D0 * ADISE * ZSTFCT(AMU,EP,2)
!C
      HZIS = ZMIN
      HZOS = ZMAX
!C**
      ENDIF
!C**
!C============================================
!C   NONEQUAL-STAR BINARY SYSTEMS
!C============================================
!C**
      IF ((EQI.EQ.0.AND.JJ.EQ.1).OR.(EQO.EQ.0.AND.JJ.EQ.2)) THEN
!C**
      AL1I = ZL1I
      AL1O = ZL1O
      AL2I = ZL2I
      AL2O = ZL2O
!C
      IF (JJ.EQ.1) THEN
       AL1  = AL1I
       AL2  = AL2I
       ADIS = ADISM
      ENDIF
!C
      IF (JJ.EQ.2) THEN
       AL1  = AL1O
       AL2  = AL2O
       ADIS = ADISP
      ENDIF
!C
      IDUM   = 0
!C
      PHI    = 0.0D0
      COSPHI = DCOS(PHI)
!C---
      A2     = 2.0D0*ADIS**2.0D0*(1.0D0-2.0D0*COSPHI**2.0D0)-
     .          (AL1+AL2) 
      A1     = 2.0D0*ADIS*COSPHI*(AL1-AL2)
      A0     = ADIS**4.0D0-ADIS**2.0D0*(AL1+AL2)
!C---
      A2H    = -A2
      A1H    = -4.0D0*A0
      A0H    = 4.0D0*A2*A0-A1**2.0D0
!C
      R      = (1.0D0/6.0D0)*A2H*A1H-(1.0D0/2.0D0)*A0H-
     .         (1.0D0/2.7D1)*A2H**3.0D0
      Q      = (1.0D0/3.0D0)*A1H-(1.0D0/9.0D0)*A2H**2.0D0
!C
      HELP0  = Q**3.0D0+R**2.0D0
!C
      IF (DABS(HELP0).LT.1.0D-12) HELP0 = 0.0D0 
!C
      IF (HELP0.LT.0.0D0) THEN
        DELP0 = DABS(HELP0)
        DELPS = DSQRT(DELP0)
        XI    = DATAN(DELPS/R)/3.0D0
        Y1    = (-1.0D0/3.0D0)*A2H+
     .             2.0D0*(R**2.0D0+DELPS**2.0D0)**(1.0D0/6.0D0)*
     .             DCOS(XI)
      ENDIF
      IF (HELP0.GE.0.0D0) THEN
        VRO1    = R+DSQRT(HELP0)      
        IF (VRO1.GE.0.0D0) XVAL1 = VRO1**(1.0D0/3.0D0)
        IF (VRO1.LT.0.0D0) XVAL1 = -1.0D0*(DABS(VRO1)**(1.0D0/3.0D0))
!C
        VRO2    = R-DSQRT(HELP0)
        IF (VRO2.GE.0.0D0) XVAL2 = VRO2**(1.0D0/3.0D0)
        IF (VRO2.LT.0.0D0) XVAL2 = -1.0D0*(DABS(VRO2)**(1.0D0/3.0D0))
!C
	Y1 = (-1.0D0/3.0D0)*A2H+XVAL1+XVAL2
      ENDIF
!C
      HELP1 = -A2+Y1
!C
      IF (DABS(HELP1).LT.1.0D-12) HELP1 = 0.0D0
!C
      C     = DSQRT(HELP1)
!C
      IF (C.GT.0.0D0)
     . HELP2 = -C**2.0D0-2.0D0*A2+2.0D0*A1/C
      IF (C.EQ.0.0D0)
     . HELP2 = DSQRT(-2.0D0*A2+2.0D0*DSQRT(Y1**2.0D0-4.0D0*A0))
!C
      IF (DABS(HELP2).LT.1.0D-12) HELP2 = 0.0D0
!C
      D     = DSQRT(HELP2)
!C
      IF (C.GT.0.0D0)
     . HELP3 = -C**2.0D0-2.0D0*A2-2.0D0*A1/C
      IF (C.EQ.0.0D0)
     . HELP3 = DSQRT(-2.0D0*A2-2.0D0*DSQRT(Y1**2.0D0-4.0D0*A0))
!C
      IF (DABS(HELP3).LT.1.0D-12) HELP3 = 0.0D0
!C
      E     = DSQRT(HELP3)
!C---
      Z1    =  -0.5D0*C - 0.5D0*D
      Z2    =  -0.5D0*C + 0.5D0*D
      Z3    =   0.5D0*C - 0.5D0*E
      Z4    =   0.5D0*C + 0.5D0*E
!C---
      IF (JJ.EQ.1) ZMIN = DABS(Z2+ADIS)
      IF (JJ.EQ.2) THEN
        IF (HELP2.LT.0.0D0) THEN
          ZMAX = DABS(Z3+ADIS)
        ELSE
          ZMAX = DABS(Z1+ADIS)
        ENDIF
      ENDIF
!C
      ZSTABS = 2.0D0 * ADISE * ZSTFCT(AMU,EP,2)
!C
      HZIS = ZMIN
      HZOS = ZMAX
!C**
      ENDIF
!C**
  351 CONTINUE
!C
!C============================================
!C   OUTPUT
!C   ICASE1 for P, ICASE2 for S 
!C============================================
!C
  997 FORMAT(1P1E10.4)
  998 FORMAT(I2)
      ICASE = 0
      ICASE1 = 0
      ICASE2 = 0
!C
      IF (HZIP.NE.0) THEN
        IF (HZIP.GE.HZOP.OR.ZSTABP.GE.HZOP) THEN
          ICASE1 = 1
	ELSE IF (ZSTABP.LE.HZIP) THEN
	  ICASE1 = 2
	  ICASE = 2
        ELSE
          ICASE1 = -2
	  ICASE = 2
        ENDIF
      ENDIF
      IF (HZIS.NE.0) THEN
        IF (HZIS.GE.HZOS.OR.ZSTABS.LE.HZIS) THEN
          ICASE2 = 1
        ELSE IF (ZSTABS.GE.HZOS) THEN
          ICASE2 = 3
          ICASE = 3
        ELSE
	  ICASE2 = -3
          ICASE = 3
        ENDIF
      ENDIF
      IF (ICASE1.EQ.1.AND.ICASE2.EQ.1) ICASE = 1
!C
      IF (ICASE.EQ.1) THEN
        WRITE(18,997) 0.0D0
        WRITE(18,997) 0.0D0
        WRITE(18,997) 0.0D0
        WRITE(18,998) 1
      ELSE IF (ICASE.EQ.2) THEN
        WRITE(18,997) HZIP
        WRITE(18,997) HZOP
        WRITE(18,997) ZSTABP
        WRITE(18,998) ICASE1
      ELSE
        WRITE(18,997) HZIS
        WRITE(18,997) HZOS
        WRITE(18,997) ZSTABS
        WRITE(18,998) ICASE2
      ENDIF
!C
      CLOSE(05)
      CLOSE(18)
!C
      STOP
      END
!C
      DOUBLE PRECISION FUNCTION ZSTFCT(AMU,EBIN,IC)
!C***************************************************
!C*     COMPUTATION OF ORBITAL STABILITY LIMITS
!C*       P-TYPE:  IC = 1
!C*       S-TYPE:  IC = 2
!C*
!C*    OLD: ZSTAB = ( 1.60D0  + 4.12D0*AMU ) * ADIS
!C*    OLD: ZSTAB = ( 0.464D0 - 0.38D0*AMU ) * ADIS
!C*
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
      IF (IC.EQ.1) THEN
        ZSTFCT = 1.60D0
     .            + 5.10D0*EBIN
     .            - 2.22D0*EBIN**2.0D0
     .            + 4.12D0*AMU
     .            - 4.27D0*EBIN*AMU
     .            - 5.09D0*AMU**2.0D0
     .            + 4.61D0*EBIN**2.0D0*AMU**2.0D0
      ENDIF
!C
      IF (IC.EQ.2) THEN
        ZSTFCT = 0.464D0
     .            - 0.380D0*AMU
     .            - 0.631D0*EBIN
     .            + 0.586D0*AMU*EBIN
     .            + 0.150D0*EBIN**2.0D0
     .            - 0.198D0*AMU*EBIN**2.0D0
      ENDIF
!C
      RETURN
      END
!C
      DOUBLE PRECISION FUNCTION ZLFCT(AL,TE,IHZ,AMPL)
!C***************************************************
!C*     COMPUTATION OF RECAST LUMINOSITIES - ZL (Kop14)
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
      DUM    = SEFFSK(TE,IHZ,AMPL)
!C
      ZLFCT = AL / DUM
!C
      RETURN
      END
!C
      DOUBLE PRECISION FUNCTION SEFFSK(TE,LHZ,AMPL)
!C***************************************************
!C*   COMPUTATION OF STELLAR FLUX (Kop14)
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
!C**  LHZ = 1  Recent Venus    
!C**  LHZ = 2  Runaway Greenhouse
!C**  LHZ = 3  Moist Greenhouse    (not in ApJL)
!C**  LHZ = 4  Maximum Greenhouse
!C**  LHZ = 5  Early Mars
!C
!C**  IPLA = 0  Mars-type Planet
!C**  IPLA = 1  Earth-type Planet
!C**  IPLA = 2  Super-Earth-type Planet
!C
      DIMENSION X(3)
      DIMENSION VF(3)
      DIMENSION AA(3,3)
      DIMENSION BB(3)
      DIMENSION S(3)
!C
      TESUN  = 5.780D+3
      TS     = TE - TESUN
!C
      X(1) = DLOG10(0.1D0)
      X(2) = DLOG10(1.0D0)
      X(3) = DLOG10(5.0D0)
!C	  
      XNEW = DLOG10(AMPL)
!C
      A1 =  1.209D-04
      B1 =  1.404D-08
      C1 = -7.418D-12
      D1 = -1.713D-15
      VF(1) = ((((D1*TS)+C1)*TS+B1)*TS+A1)*TS + 0.990D0
!C
      A2 =  1.332D-04
      B2 =  1.580D-08
      C2 = -8.308D-12
      D2 = -1.931D-15
      VF(2) = ((((D2*TS)+C2)*TS+B2)*TS+A2)*TS + 1.107D0
!C
      A3 =  1.433D-04
      B3 =  1.707D-08
      C3 = -8.968D-12
      D3 = -2.084D-15
      VF(3) = ((((D3*TS)+C3)*TS+B3)*TS+A3)*TS + 1.188D0
!C
      IF (LHZ.EQ.2) THEN
        AA(1,1) = 2.0D0/(X(2)-X(1))
        AA(1,2) = 1.0D0/(X(2)-X(1))
        AA(1,3) = 0.0D0
        AA(2,1) = 1.0D0/(X(2)-X(1))
        AA(2,2) = 2.0D0*(1.0D0/(X(2)-X(1))+1.0D0/(X(3)-X(2)))
        AA(2,3) = 1.0D0/(X(3)-X(2))
        AA(3,1) = 0.0D0
        AA(3,2) = 1.0D0/(X(3)-X(2))
        AA(3,3) = 2.0D0/(X(3)-X(2))
        BB(1) = 3.0D0*(VF(2)-VF(1))/(X(2)-X(1))**2.0D0
        BB(2) = 3.0D0*((VF(2)-VF(1))/((X(2)-X(1))**2.0D0)
     .           +(VF(3)-VF(2))/((X(3)-X(2))**2.0D0))
        BB(3) = 3.0D0*(VF(3)-VF(2))/(X(3)-X(2))**2.0D0
        DO 701 I1 = 2,3
          RAT = AA(I1,I1-1)/AA(I1-1,I1-1)
          DO 702 I2 = I1,3
            AA(I1,I2) = AA(I1,I2)-AA(I1-1,I2)*RAT
  702     CONTINUE
          BB(I1) = BB(I1)-RAT*BB(I1-1)
  701   CONTINUE
        S = BB 		
        DO 703 I3 = 1,3
          DO 704 I4 = 1,I3-1
            S(4-I3) = S(4-I3)-AA(4-I3,4-I4)*S(4-I4)
  704     CONTINUE
          S(4-I3) = S(4-I3)/AA(4-I3,4-I3)
  703   CONTINUE
        ALPHA1 =  S(1)*(X(2)-X(1))-(VF(2)-VF(1))
        BETA1  = -S(2)*(X(2)-X(1))+(VF(2)-VF(1))
        ALPHA2 =  S(2)*(X(3)-X(2))-(VF(3)-VF(2))
        BETA2  = -S(3)*(X(3)-X(2))+(VF(3)-VF(2))
        IF (XNEW.GE.X(1).AND.XNEW.LT.X(2)) THEN
          TNEW = (XNEW-X(1))/(X(2)-X(1))
          SEFFSK = (1-TNEW)*VF(1)+TNEW*VF(2)+TNEW*(1-TNEW)
     .             *(ALPHA1*(1-TNEW)+BETA1*TNEW)
        ENDIF
        IF (XNEW.GE.X(2).AND.XNEW.LE.X(3)) THEN
          TNEW = (XNEW-X(2))/(X(3)-X(2))
          SEFFSK = (1-TNEW)*VF(2)+TNEW*VF(3)+TNEW*(1-TNEW)
     .             *(ALPHA2*(1-TNEW)+BETA2*TNEW)
        ENDIF
      ELSE
        IF (LHZ.EQ.1) THEN
          A0  =  2.136D-04
          B0  =  2.533D-08
          C0  = -1.332D-11
          D0  = -3.097D-15
		  E0  =  1.776D0
        ENDIF
!C
        IF (LHZ.EQ.3) THEN
          A0  =  8.1884D-05
          B0  =  1.9394D-09
          C0  = -4.3618D-12
          D0  = -6.8260D-16
		  E0  =  1.0146D0
        ENDIF
!C
        IF (LHZ.EQ.4) THEN
          A0  =  6.171D-05
          B0  =  1.698D-09
          C0  = -3.198D-12
          D0  = -5.575D-16
		  E0  =  0.356D0
        ENDIF
!C
        IF (LHZ.EQ.5) THEN
          A0  =  5.547D-05
          B0  =  1.526D-09
          C0  = -2.874D-12 
          D0  = -5.011D-16
		  E0  =  0.318D0
        ENDIF
!C
        SEFFSK = ((((D0*TS)+C0)*TS+B0)*TS+A0)*TS+E0
!C
      ENDIF
!C
      RETURN
      END
!C
      DOUBLE PRECISION FUNCTION ZLFCTS(AL,TE,IHZ)
!C***************************************************
!C*     COMPUTATION OF RECAST LUMINOSITIES - ZL (Sel07)
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
      LHZ  = IHZ
      DUM  = SEFFSKS(TE,LHZ)
!C
      ZLFCTS = AL / DUM
!C
      RETURN
      END
!C
      DOUBLE PRECISION FUNCTION SEFFSKS(TE,LHZ)
!C***************************************************
!C*   COMPUTATION OF STELLAR FLUX (Sel07)
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
!C**  LHZ = 1  Recent Venus    
!C**  LHZ = 2  Runaway Greenhouse
!C**  LHZ = 3  Moist Greenhouse    (not in ApJL)
!C**  LHZ = 4  First CO2 Condensation 
!C**  LHZ = 5  Maximum Greenhouse
!C**  LHZ = 6  Early Mars
!C**  LHZ = 7  Maximum Greenhouse (100% Cloud)
!C
      TEOSUN  = 5.700D+3
      TS     = TE - TEOSUN
!C
      AIN  =  2.7619D-5
      BIN  =  3.8095D-9
      AOUT =  1.3786D-4
      BOUT =  1.4286D-9
!C
      DUM = 0.0D0
!C
      IF (LHZ.EQ.1) SL  = 0.72D0
      IF (LHZ.EQ.2) SL  = 0.84D0
      IF (LHZ.EQ.3) SL  = 0.95D0
      IF (LHZ.EQ.4) SL  = 1.37D0
      IF (LHZ.EQ.5) SL  = 1.67D0
      IF (LHZ.EQ.6) SL  = 1.77D0
      IF (LHZ.EQ.7) SL  = 2.40D0
!C
      IF (LHZ.LE.3) DUM = (SL-AIN*TS-BIN*TS**2.0D0)**2.0D0
      IF (LHZ.GE.4) DUM = (SL-AOUT*TS-BOUT*TS**2.0D0)**2.0D0
!C
      SEFFSKS = 1 / DUM
!C
      RETURN
      END
!C
      DOUBLE PRECISION FUNCTION ZLFCTU(AL,TE,IHZ)
!C***************************************************
!C*     COMPUTATION OF RECAST LUMINOSITIES - ZL (Und03)
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
      LHZ  = IHZ
      DUM    = SEFFSKU(TE,LHZ)
!C
      ZLFCTU = AL / DUM
!C
      RETURN
      END
!C
      DOUBLE PRECISION FUNCTION SEFFSKU(TE,LHZ)
!C***************************************************
!C*   COMPUTATION OF STELLAR FLUX (Und03)
!C***************************************************
!C
      IMPLICIT DOUBLEPRECISION (A-H,O-Z)
!C
!C**  LHZ = 1  Recent Venus    
!C**  LHZ = 2  Runaway Greenhouse
!C**  LHZ = 3  Moist Greenhouse    (not in ApJL)
!C**  LHZ = 4  First CO2 Condensation 
!C**  LHZ = 5  Maximum Greenhouse
!C**  LHZ = 6  Early Mars
!C
      IF (LHZ.EQ.1) THEN
        A1  =  2.286D-08
        B1  = -1.349D-04
        C1  =  1.786D0
      ENDIF
!C
      IF (LHZ.EQ.2) THEN
        A1  =  4.190D-08
        B1  = -2.139D-04
        C1  =  1.268D0
      ENDIF
!C
      IF (LHZ.EQ.3) THEN
        A1  =  1.429D-08
        B1  = -8.429D-05
        C1  =  1.116D0
      ENDIF
!C
      IF (LHZ.EQ.4) THEN
        A1  =  5.238D-09
        B1  = -1.424D-05
        C1  =  4.410D-01
      ENDIF
!C
      IF (LHZ.EQ.5) THEN
        A1  =  6.190D-09
        B1  = -1.319D-05
        C1  =  2.341D-01
      ENDIF
!C
      IF (LHZ.EQ.6) THEN
        A1  =  5.714D-09
        B1  = -1.371D-05
        C1  =  2.125D-01
      ENDIF
!C
      DIF = ((A1*TE)+B1)*TE+C1
!C
      SEFFSKU = DIF
!C
      RETURN
      END