!> \file text.f90  Procedures to manipulate text/strings


!  Copyright 2002-2011 AstroFloyd - astrofloyd.org
!   
!  This file is part of the libSUFR package, 
!  see: http://libsufr.sourceforge.net/
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
!> \brief  Procedures to manipulate text/strings

module SUFR_text
  implicit none
  save
  
contains
  
  
  !*********************************************************************************************************************************
  !> \brief  Make a string lower case
  !!
  !! \param str  String (I/O)
  
  subroutine lowercase(str)
    implicit none
    character, intent(inout) :: str*(*)
    integer :: i,ch
    do i=1,len_trim(str)
       ch = ichar(str(i:i))
       if(ch.ge.65.and.ch.le.91) ch = ch + 32
       str(i:i) = char(ch)
    end do
  end subroutine lowercase
  !*********************************************************************************************************************************
  
  
  
  !*********************************************************************************************************************************
  !> \brief Make a string upper case
  !!
  !! \param str  String (I/O)
  
  subroutine uppercase(str)
    implicit none
    character, intent(inout) :: str*(*)
    integer :: i,ch
    
    do i=1,len_trim(str)
       ch = ichar(str(i:i))
       if(ch.ge.97.and.ch.le.123) ch = ch - 32
       str(i:i) = char(ch)
    end do
    
  end subroutine uppercase
  !*********************************************************************************************************************************
  
  
  
  !*********************************************************************************************************************************
  !> \brief Make a string lower case with an upper-case initial
  !!
  !! \param str  String (I/O)
  
  subroutine uppercaseinitial(str)
    implicit none
    character, intent(inout) :: str*(*)
    integer :: i,ic
    
    ! Capitalise first letter:
    ic = ichar(str(1:1))
    if(ic.ge.97.and.ic.le.122) str(1:1) = char(ic-32)
    
    ! Make the rest of the letters lower case:
    do i=2,len_trim(str)
       ic = ichar(str(i:i))
       if(ic.ge.65.and.ic.le.90) str(i:i) = char(ic+32)
    end do
    
  end subroutine uppercaseinitial
  !*********************************************************************************************************************************
  
  
  
  !*********************************************************************************************************************************
  !> \brief  Search and replace occurences of a substring in a string
  !!
  !! \param string   Original string to replace in
  !! \param str_in   Search string
  !! \param str_out  Replacement string
  
  subroutine replace_substring(string, str_in, str_out)
    character, intent(inout) :: string*(*)
    character, intent(in) :: str_in*(*),str_out*(*)
    integer :: is,l
    
    l = len_trim(str_in)
    is = huge(is)
    do
       is = index(string, str_in, back=.false.)
       if(is.le.0) exit
       string = string(1:is-1)//trim(str_out)//trim(string(is+l:))
    end do
    
  end subroutine replace_substring
  !*********************************************************************************************************************************
  
  
  
  
  
end module SUFR_text
!***********************************************************************************************************************************

