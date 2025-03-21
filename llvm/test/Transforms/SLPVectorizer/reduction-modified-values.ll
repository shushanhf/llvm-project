; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: %if x86-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s %}
; RUN: %if aarch64-registered-target %{ opt -S --passes=slp-vectorizer -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s %}

define i32 @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = shufflevector <4 x i32> zeroinitializer, <4 x i32> zeroinitializer, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
; CHECK-NEXT:    [[TMP1:%.*]] = or <4 x i32> [[TMP0]], zeroinitializer
; CHECK-NEXT:    [[RDX_OP:%.*]] = add <4 x i32> [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[OP_RDX:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[RDX_OP]])
; CHECK-NEXT:    ret i32 [[OP_RDX]]
;
bb:
  %0 = shufflevector <4 x i32> zeroinitializer, <4 x i32> zeroinitializer, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
  %1 = extractelement <4 x i32> %0, i32 3
  %2 = extractelement <4 x i32> %0, i32 2
  %3 = extractelement <4 x i32> %0, i32 1
  %4 = extractelement <4 x i32> %0, i32 0
  %inst514 = or i32 %4, 0
  %inst494 = or i32 %3, 0
  %inst474 = or i32 %2, 0
  %inst454 = or i32 %1, 0
  %inst458 = add i32 %1, %inst454
  %inst477 = add i32 %inst458, %2
  %inst478 = add i32 %inst477, %inst474
  %inst497 = add i32 %inst478, %3
  %inst498 = add i32 %inst497, %inst494
  %inst517 = add i32 %inst498, %4
  %inst518 = add i32 %inst517, %inst514
  ret i32 %inst518
}
