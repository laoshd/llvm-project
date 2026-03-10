! RUN: %python %S/test_errors.py %s %flang_fc1
! Check for semantic errors in split() subroutine calls
! Based on Fortran 2023 standard requirements

program test_split_errors
  implicit none

  character(20) :: string
  character(5) :: set
  integer :: pos
  logical :: back

  ! Valid declarations for testing
  integer :: int_scalar
  real :: real_scalar
  character(10) :: string_array(5)
  character(5) :: set_array(5)

  !========================================================================
  ! Valid calls (reference)
  !========================================================================

  call split(string, set, pos)
  call split(string, set, pos, back)
  call split("hello world", " ", pos)
  call split("hello world", " ", pos, .false.)

  !========================================================================
  ! Wrong types for STRING argument
  !========================================================================

  !ERROR: Actual argument for 'string=' has bad type 'INTEGER(4)'
  call split(int_scalar, set, pos)

  !ERROR: Actual argument for 'string=' has bad type 'REAL(4)'
  call split(real_scalar, set, pos)

  !========================================================================
  ! Wrong rank for STRING (must be scalar)
  !========================================================================

  !ERROR: 'string=' argument has unacceptable rank 1
  call split(string_array, set, pos)

  !========================================================================
  ! Wrong types for SET argument
  !========================================================================

  !ERROR: Actual argument for 'set=' has bad type 'INTEGER(4)'
  call split(string, int_scalar, pos)

  !ERROR: Actual argument for 'set=' has bad type 'REAL(4)'
  call split(string, real_scalar, pos)

  !========================================================================
  ! Wrong types for POS argument
  !========================================================================

  !ERROR: Actual argument for 'pos=' has bad type 'REAL(4)'
  call split(string, set, real_scalar)

  !========================================================================
  ! Wrong types for BACK argument
  !========================================================================

  !ERROR: Actual argument for 'back=' has bad type 'INTEGER(4)'
  call split(string, set, pos, int_scalar)

end program test_split_errors
