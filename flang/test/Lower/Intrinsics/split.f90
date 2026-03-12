! RUN: %flang_fc1 -emit-hlfir %s -o - | FileCheck %s

! CHECK-LABEL: split_basic
subroutine split_basic()
  implicit none
  character(20) :: string
  character(5) :: set
  integer :: pos
  string = "one,two,three"
  set = ","
  pos = 0
  call split(string, set, pos)
  ! CHECK: %[[BACK:.*]] = arith.constant false
  ! CHECK: %[[POS:.*]] = fir.load %{{.*}} : !fir.ref<i32>
  ! CHECK: %[[POS_IDX:.*]] = fir.convert %[[POS]] : (i32) -> index
  ! CHECK: %[[STRING:.*]] = fir.convert %{{.*}} : (!fir.ref<!fir.char<1,20>>) -> !fir.ref<i8>
  ! CHECK: %[[SET:.*]] = fir.convert %{{.*}} : (!fir.ref<!fir.char<1,5>>) -> !fir.ref<i8>
  ! CHECK: %[[POS_I64:.*]] = fir.convert %[[POS_IDX]] : (index) -> i64
  ! CHECK: %[[RESULT:.*]] = fir.call @_FortranASplit1(%[[STRING]], %{{.*}}, %[[SET]], %{{.*}}, %[[POS_I64]], %[[BACK]]) {{.*}} : (!fir.ref<i8>, i64, !fir.ref<i8>, i64, i64, i1) -> i64
  ! CHECK: %[[RESULT_I32:.*]] = fir.convert %[[RESULT]] : (i64) -> i32
  ! CHECK: fir.store %[[RESULT_I32]] to %{{.*}} : !fir.ref<i32>
end subroutine split_basic
