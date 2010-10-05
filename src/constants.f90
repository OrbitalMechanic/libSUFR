!>  \file constants.f90
!!  
!!  This file contains routines to define and share constants
!<   

!  Copyright 2002-2010 AstroFloyd - astrofloyd.org
!   
!  This file is part of the libAF package.
!   
!  This is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published
!  by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
!  
!  This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
!  
!  You should have received a copy of the GNU General Public License along with this code.  If not, see 
!  <http://www.gnu.org/licenses/>.




!***********************************************************************************************************************************
!> \brief Mathematical constants
module AF_constants_math
  use AF_kinds
  implicit none
  save
  
  real(double) :: pi,pi2,pio2,pio4,r2d,d2r,r2h,h2r,d2as,as2d,am2r,r2am,r2as,as2r
  
end module AF_constants_math
!***********************************************************************************************************************************


!***********************************************************************************************************************************
!> Astronomical constants and satellite data
module AF_constants_astro
  use AF_kinds
  implicit none
  save
  
  !Astronomical constants:
  real(double) :: siday,planr(0:9),pland(0:9),earthr
  real(double) :: au,km,rsun,msun,jd1875,jd2000,eps2000
  
  !Satellite data for planets 4-8:
  real(double) :: satrad(4:8,30),satdiam(4:8,30)
  
end module AF_constants_astro
!***********************************************************************************************************************************


!***********************************************************************************************************************************
!> Planet names and their abbreviations in English and Dutch
module AF_constants_planetnames
  implicit none
  save
  
  character :: enpname(-1:19)*7,enpnames(-1:19)*7,enpnamel(-1:19)*8,enpnamelb(-1:19)*8,enpnamess(-1:19)*4
  character :: nlpname(-1:19)*9,nlpnames(-1:19)*9,nlpnamel(-1:19)*9,nlpnamelb(-1:19)*9,nlpnamess(-1:19)*4
  
end module AF_constants_planetnames
!***********************************************************************************************************************************


!***********************************************************************************************************************************
!> Names of lunar phases in English and Dutch
module AF_constants_moonphases
  implicit none
  save
  
  character :: enphases(0:3)*13,nlphases(0:3)*16
  
end module AF_constants_moonphases
!***********************************************************************************************************************************


!***********************************************************************************************************************************
!> Names of months, days and time zones in English and Dutch
module AF_constants_calendar
  implicit none
  save
  
  !Month names:
  character :: enmonths(12)*9,enmonthsm(12)*9,enmnts(12)*3
  character :: nlmonths(12)*9,nlmonthsb(12)*9,nlmnts(12)*3,nlmntsb(12)*3
  
  !Day names:
  character :: endays(0:6)*9,ends(0:6)*2,endys(0:6)*3
  character :: nldays(0:6)*9,nlds(0:6)*2
  
  !Time-zone namess:
  character :: nltimezones(0:1)*10
  
  !Length of the months:
  integer :: mlen(12)
  
end module AF_constants_calendar
!***********************************************************************************************************************************


!***********************************************************************************************************************************
!> Current date/time constants
module AF_constants_datetime
  use AF_kinds
  implicit none
  save
  
  integer :: currentyear,currentmonth,currentday,currenthour,currentminute,currentsecond,currentdow
  real(double) :: currentjd
  
  character :: currentyearstr*4,currentdatestr*10,currenttimestr*8,currenttimezonestr*9
  character :: currentdowstrnl*9,currentdatestrnl*39
  
end module AF_constants_datetime
!***********************************************************************************************************************************




!***********************************************************************************************************************************
!> Character constants (e.g. Greek letters)
module AF_constants_characters
  implicit none
  save
  
  character :: engrchar(24)*7,htmlgrchar(24)*9 !Greek letters
  
end module AF_constants_characters
!***********************************************************************************************************************************



!***********************************************************************************************************************************
!> Constants that describe cursor movement
module AF_constants_cursor
  implicit none
  save
  
  character :: cursorup*4, cursordown*4, cursorright*4, cursorleft*4
  
end module AF_constants_cursor
!***********************************************************************************************************************************




!***********************************************************************************************************************************
!> Constants that describe the working environment
module AF_constants_environment
  implicit none
  save
  
  character :: homedir*99, workdir*99, programname*99
  
end module AF_constants_environment
!***********************************************************************************************************************************






!***********************************************************************************************************************************
!> Provides all constants in the library, and routines to define them
module AF_constants
  use AF_constants_math
  use AF_constants_astro
  use AF_constants_planetnames
  use AF_constants_moonphases
  use AF_constants_calendar
  use AF_constants_datetime
  use AF_constants_characters
  use AF_constants_cursor
  use AF_constants_environment
  
  use AF_kinds
  
  implicit none
  save
  
  
  
contains
  
  
  !***********************************************************************************************************************************
  !> Define the values of all the constants used in this package
  subroutine set_constants
    implicit none
    
    !Get the kinds of the most accurate integer and real for the current compiler/system:
    call max_accuracy_kinds(intkindmax,realkindmax)  
    
    !Set the mathematical constants:
    call set_constants_math()
    
    !Set the astronomical constants:
    call set_constants_astro()
    call set_constants_planetnames()
    call set_constants_moonphases()
    
    !Set calendar stuff:
    call set_constants_calendar()
    call set_constants_currentdate()
    
    !Characters:
    call set_constants_characters()  !Greek characters
    call set_constants_cursor()      !Cursor movement
    
    !Cetera:
    call set_constants_environment()
    
  end subroutine set_constants
  !*********************************************************************************************************************************
  
  !*********************************************************************************************************************************
  !> Define the values of the mathematical constants
  subroutine set_constants_math
    use AF_constants_math
    implicit none
    
    ! Mathematical constants:
    pi   = 4*atan(1.d0)  !pi
    pi2  = 8*atan(1.d0)  !2pi
    pio2 = 2*atan(1.d0)  !pi/2
    pio4 = atan(1.d0)    !pi/4
    
    r2d = 180.d0/pi
    d2r = pi/180.d0
    r2h = 12.d0/pi
    h2r = pi/12.d0
    
    d2as = 3600.d0
    as2d = 1/3600.d0
    r2am = 180.d0*60.d0/pi
    am2r = pi/(180.d0*60.d0)
    r2as = 180.d0*3600.d0/pi
    as2r = pi/(180.d0*3600.d0)
  end subroutine set_constants_math
  !*********************************************************************************************************************************
  
  
  !*********************************************************************************************************************************
  !> Define the values of astronomical constants
  subroutine set_constants_astro
    use AF_constants_astro
    implicit none
    
    ! Astronomical constants:
    au = 1.4959787d13        !A.U. in cgs
    km = 1.d5                !kilometer in cgs
    rsun = 6.9599d10         !Solar radius in cgs
    msun = 1.9891d33         !Solar mass in cgs
    siday = 0.997269663d0    !Siderial day in days
    
    jd1875 = 2405890.d0      !JD at 1875.0 (when constellation boundaries were defined)
    jd2000 = 2451545.d0      !JD at J2000.0
    eps2000 = 0.409092804d0  !Obliquity of the ecliptic at J2000.0
    
    pland = (/3476.206d5, 4879.d5, 12198.d5, 1.39198d11, 6794.d5, 142984.d5, 120536.d5, 51118.d5, 49528.d5, &
         2390.d5/)      ! Equatorial diameter (cm)
    planr = pland/2.d0  ! Equatorial radii (cm)
    
    earthr = 6378.14d5  !Eq. radius of the Earth in cm
    
    !Satellites:
    satrad(5,1:4) = (/1821.6,1560.8,2631.2,2410.3/)*1.d5  !Galilean moons, cm
    satdiam = 2*satrad
    
  end subroutine set_constants_astro
  !*********************************************************************************************************************************
  
  
  !*********************************************************************************************************************************
  !> Define the planet names
  subroutine set_constants_planetnames
    use AF_constants_planetnames
    implicit none
    
    !Planet names:
    !en:
    enpname(-1:11)   = (/'Antisol','Moon   ','Mercury','Venus  ','Sun    ','Mars   ','Jupiter','Saturn ','Uranus ','Neptune', &
         'Pluto  ','       ','Comet  '/)
    enpnames(-1:11)  = (/'antisol','moon   ','mercury','venus  ','sun    ','mars   ','jupiter','saturn ','uranus ','neptune', &
         'pluto  ','       ','Comet  '/)
    enpnamel(-1:11)  = (/'Antisol ','the Moon','Mercury ','Venus   ','the Sun ','Mars    ','Jupiter ','Saturn  ','Uranus  ', &
         'Neptune ','Pluto   ','        ','Comet   '/)
    enpnamelb(-1:11)  = (/'Antisol ','The Moon','Mercury ','Venus   ','The Sun ','Mars    ','Jupiter ','Saturn  ','Uranus  ', &
         'Neptune ','Pluto   ','        ','Comet   '/)
    enpnamess(-1:11) = (/'A.S.','Moon','Mer.','Ven.','Sun ','Mars','Jup.','Sat.','Ura.','Nep.','Plu.','    ','Com.'/)
    
    !nl:
    nlpname(-1:11)   = (/'Antizon  ','Maan     ','Mercurius','Venus    ','Zon      ','Mars     ','Jupiter  ','Saturnus ', &
         'Uranus   ','Neptunus ','Pluto    ','         ','Komeet   '/)
    nlpnames(-1:11)  = (/'antizon  ','maan     ','mercurius','venus    ','zon      ','mars     ','jupiter  ','saturnus ', &
         'uranus   ','neptunus ','pluto    ','         ','komeet   '/)
    nlpnamel(-1:11)  = (/'Antizon  ','de Maan  ','Mercurius','Venus    ','de Zon   ','Mars     ','Jupiter  ','Saturnus ', &
         'Uranus   ','Neptunus ','Pluto    ','         ','Komeet   '/)
    nlpnamelb(-1:11)  = (/'Antizon  ','De Maan  ','Mercurius','Venus    ','De Zon   ','Mars     ','Jupiter  ','Saturnus ', &
         'Uranus   ','Neptunus ','Pluto    ','         ','Komeet   '/)
    nlpnamess(-1:11) = (/'A.Z.','Maan','Mer.','Ven.','Zon ','Mars','Jup.','Sat.','Ura.','Nep.','Plu.','    ','Kom.'/)
    
  end subroutine set_constants_planetnames
  !*********************************************************************************************************************************
  
  
  !*********************************************************************************************************************************
  !> Define the names of the lunar phases
  subroutine set_constants_moonphases
    use AF_constants_moonphases
    implicit none
    
    enphases = (/'New Moon     ','First Quarter','Full Moon    ','Last Quarter '/)
    nlphases = (/'Nieuwe Maan     ','Eerste Kwartier ','Volle Maan      ','Laatste Kwartier'/)
    
  end subroutine set_constants_moonphases
  !*********************************************************************************************************************************
    
  
  !*********************************************************************************************************************************
  !> Define the names of months, days and timezones;  define month lengths
  subroutine set_constants_calendar
    use AF_constants_calendar
    implicit none
    
    !Months:
    !en:
    enmonths  = (/'January  ','February ','March    ','April    ','May      ','June     ','July     ','August   ','September', &
         'October  ','November ','December '/)
    enmonthsm = (/'january  ','february ','march    ','april    ','may      ','june     ','july     ','august   ','september', &
         'october  ','november ','december '/)
    enmnts    = (/'jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec'/)
    
    !nl:
    nlmonths  = (/'januari  ','februari ','maart    ','april    ','mei      ','juni     ','juli     ','augustus ','september', &
         'oktober  ','november ','december '/)
    nlmonthsb = (/'Januari  ','Februari ','Maart    ','April    ','Mei      ','Juni     ','Juli     ','Augustus ','September', &
         'Oktober  ','November ','December '/)
    nlmnts    = (/'jan','feb','mrt','apr','mei','jun','jul','aug','sep','okt','nov','dec'/)
    nlmntsb   = (/'Jan','Feb','Mrt','Apr','Mei','Jun','Jul','Aug','Sep','Okt','Nov','Dec'/)
    
    !Days:
    endays = (/'Sunday   ','Monday   ','Tuesday  ','Wednesday','Thursday ','Friday   ','Saturday '/)
    endys  = (/'Sun','Mon','Tue','Wed','Thu','Fri','Sat'/)
    ends   = (/'su','mo','tu','we','th','fr','sa'/)
    
    nldays = (/'zondag   ','maandag  ','dinsdag  ','woensdag ','donderdag','vrijdag  ','zaterdag '/)
    nlds   = (/'zo','ma','di','wo','do','vr','za'/)
    
    
    !Time zones:
    nltimezones = (/'wintertijd','zomertijd '/)
    
    
    !Length of the months (for non-leap year)
    mlen = (/31,28,31,30,31,30,31,31,30,31,30,31/)
    
  end subroutine set_constants_calendar
  !*********************************************************************************************************************************
  
  
  
  !*********************************************************************************************************************************
  !> Define the values of variables that describe the current date and time
  subroutine set_constants_currentdate()
    use AF_constants_datetime
    use AF_constants_calendar
    use AF_date_and_time
    
    implicit none
    integer :: dt(8)
    real(double) :: tz
    character :: tmpstr*99,tzstr*9,signstr
    
    !Date/time:
    call date_and_time(tmpstr,tmpstr,tmpstr,dt)
    currentyear = dt(1)
    currentmonth = dt(2)
    currentday = dt(3)
    currenthour = dt(5)
    currentminute = dt(6)
    currentsecond = dt(7)
    
    !Time zone:
    tz = abs(dble(dt(4))/60.d0)
    write(tzstr,'(F5.2)')tz
    if(nint(tz).lt.10) write(tzstr,'(A1,F4.2)')'0',tz
    signstr = '-'
    if(dt(4).ge.0) signstr = '+'
    write(currenttimezonestr,'(A)')'UTC'//signstr//trim(tzstr)
    if(dt(4).lt.0.d0) tz = -tz
    
    !JD, dow:
    currentjd = ymdhms2jd(currentyear,currentmonth,currentday,currenthour,currentminute,dble(currentsecond))
    currentdow = dow_ut(currentjd + tz/24.d0)
    currentdowstrnl = nldays(currentdow)
    
    write(currentyearstr,'(I4)')currentyear
    write(currentdatestr,'(I2.2,A1,I2.2,A1,I4.4)')currentday,'/',currentmonth,'/',currentyear
    write(currentdatestrnl,'(A,I3,1x,A,I5)')trim(currentdowstrnl),currentday,trim(nlmonths(currentmonth)),currentyear
    write(currenttimestr,'(I2.2,A1,I2.2,A1,I2.2)')currenthour,':',currentminute,':',currentsecond
    
  end subroutine set_constants_currentdate
  !*********************************************************************************************************************************
  
  
  !*********************************************************************************************************************************
  !> Define the values of character constants - e.g., Greek letters
  subroutine set_constants_characters()
    use AF_constants_characters
    implicit none
    integer :: i
    
    !Characters:
    engrchar = [character(len=7) :: 'alpha','beta','gamma','delta','epsilon','zeta','eta','theta','iota','kappa','lambda','mu', &
         'nu','xi','omicron','pi','rho','sigma','tau','upsilon','phi','chi','psi','omega']
    
    do i=1,24
       htmlgrchar(i) = '&'//trim(engrchar(i))//';     '
    end do
    
  end subroutine set_constants_characters
  !*********************************************************************************************************************************
  
  
  !*********************************************************************************************************************************
  !> Define the values of constants for cursor movement
  subroutine set_constants_cursor()
    use AF_constants_cursor
    implicit none
    
    ! Cursor movement:
    cursorup = char(27)//'[2A' !Print this to go up one line (on screen) (need 2 lines, since print gives a hard return by default)
    cursordown = char(27)//'[1B' !Print this to go down one line (on screen)
    cursorright = char(27)//'[1C' !Makes the cursor move right one space
    cursorleft = char(27)//'[1D' !Makes the cursor move left one space
    
  end subroutine set_constants_cursor
  !*********************************************************************************************************************************
  
    
  !*********************************************************************************************************************************
  !> Define the values of constants that describe the working environment
  subroutine set_constants_environment()
    use AF_constants_environment
    implicit none
    integer :: i
    character :: tmpstr*99
    
    !Get info from environment variables:
    call get_environment_variable('HOME',homedir)   ! Set homedir = $HOME, will contain e.g. '/home/name'
    call get_environment_variable('PWD',workdir)    ! Set workdir = $PWD, will contain e.g. '/home/name/foo'
    i = index(workdir,trim(homedir),back=.false.)
    if(i.ne.0) workdir = workdir(1:i-1)//'~'//trim(workdir(i+len_trim(homedir):))  !Replace '/home/name' with '~'
    
    
    call get_command_argument(0,tmpstr)             ! Path + name of the program that is being executed
    i = index(tmpstr,'/',back=.true.)
    if(i.ne.0) programname = trim(tmpstr(i+1:))     ! The bit after the last slash should be the program name
    
  end subroutine set_constants_environment
  !*********************************************************************************************************************************
  
  
end module AF_constants
!***********************************************************************************************************************************



