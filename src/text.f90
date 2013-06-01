!> \file text.f90  Procedures to manipulate text/strings


!  Copyright 2002-2013 AstroFloyd - astrofloyd.org
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
  !! \param string    Original string to replace in
  !! \param str_srch  Search string
  !! \param str_repl  Replacement string
  
  subroutine replace_substring(string, str_srch, str_repl)
    implicit none
    character, intent(inout) :: string*(*)
    character, intent(in) :: str_srch*(*),str_repl*(*)
    integer :: is,lin
    
    lin = len(str_srch)
    is = huge(is)
    do
       is = index(string, str_srch, back=.false.)
       if(is.le.0) exit
       string = string(1:is-1)//str_repl//trim(string(is+lin:))
    end do
    
  end subroutine replace_substring
  !*********************************************************************************************************************************
  
  
  
  !*********************************************************************************************************************************
  !> \brief  Remove a substring from a string, if present
  !!
  !! \param string  String to remove the substring from
  !! \param substr  Substring to remove
  !! \param debug   Print debug info (T/F, optional)
  
  subroutine remove_substring(string,substr, debug)
    implicit none
    character, intent(inout) :: string*(*)
    character, intent(in) :: substr*(*)
    logical, intent(in), optional :: debug
    
    integer :: l,ls, i1
    character :: tstr*(len(string))
    logical :: print_debug
    
    print_debug = .false.
    if(present(debug)) print_debug = debug
    
    ls = len(substr)     ! Lenth of the substring to remove
    
    i1 = -1
    do while(i1.ne.0)  ! There may be multiple instances
       l = len_trim(string)
       
       i1 = index(string,substr,back=.false.)
       if(i1.gt.0) then
          tstr = string(1:i1-1)//string(i1+ls:l)
          if(print_debug) then
             print*,string(1:i1-1)
             print*,string(i1+ls:l)
             print*,string(i1:i1+ls),i1,l
             print*,trim(tstr)
          end if
          string = tstr
       end if
    end do
    
  end subroutine remove_substring
  !*********************************************************************************************************************************
  
  
  
  !*********************************************************************************************************************************
  !> \brief  Search and replace occurences of a string in a text file
  !!
  !! \param  file_in   Name of the text file to replace in
  !! \param  file_out  Name of the text file to store the result in
  !! \param  str_srch  Search string
  !! \param  str_repl  Replacement string
  !!
  !! \retval status    Exit status: 0-ok, 1/2: could not open I/O file, 11/12: character array string too small
  
  subroutine replace_string_in_textfile(file_in, file_out, str_srch, str_repl, status)
    use SUFR_system, only: error, find_free_io_unit
    
    implicit none
    character, intent(in) :: file_in*(*),file_out*(*), str_srch*(*),str_repl*(*)
    integer, intent(out) :: status
    integer :: io,ip,op
    character :: string*(999)
    
    status = 0
    
    ! Input file:
    call find_free_io_unit(ip)
    open(unit=ip, file=trim(file_in), status='old', action='read', iostat=io)
    if(io.ne.0) then
       call error('replace_string_in_textfile():  could not open file: '//trim(file_in), 0)
       status = 1
       return
    end if
    
    ! Output file:
    call find_free_io_unit(op)
    open(unit=op, file=trim(file_out), status='replace', action='write', iostat=io)
    if(io.ne.0) then
       call error('replace_string_in_textfile():  could not open file: '//trim(file_out), 0)
       status = 2
       return
    end if
       
    
    io = 0
    do while(io.eq.0)
       read(ip,'(A)', iostat=io) string
       
       if(len(string).eq.len_trim(string)) then
          call error('replace_string_in_textfile():  character array string too small', 0)
          status = 11
          return
       end if
       
       call replace_substring(string, str_srch, str_repl)
       
       if(len(string).eq.len_trim(string)) then
          call error('replace_string_in_textfile():  character array string too small', 0)
          status = 12
          return
       end if
       
       write(op,'(A)') trim(string)
    end do
    
    close(ip)
    close(op)
    
  end subroutine replace_string_in_textfile
  !*********************************************************************************************************************************
  
  
  
  
  
end module SUFR_text
!***********************************************************************************************************************************

