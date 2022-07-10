; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -verify-machineinstrs %s -o - | FileCheck %s

define void @to_4(float* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: to_4:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #256
; CHECK-NEXT:    adr r2, .LCPI0_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB0_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0], #16
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1], #8
; CHECK-NEXT:    le lr, .LBB0_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI0_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds float, float* %x, i32 %index
  %1 = bitcast float* %0 to <4 x float>*
  %wide.load = load <4 x float>, <4 x float>* %1, align 4
  %2 = fmul <4 x float> %wide.load, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %3 = fptrunc <4 x float> %2 to <4 x half>
  %4 = getelementptr inbounds half, half* %y, i32 %index
  %5 = bitcast half* %4 to <4 x half>*
  store <4 x half> %3, <4 x half>* %5, align 2
  %index.next = add i32 %index, 4
  %6 = icmp eq i32 %index.next, 1024
  br i1 %6, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @to_8(float* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: to_8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #128
; CHECK-NEXT:    adr r2, .LCPI1_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB1_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0, #16]
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #8]
; CHECK-NEXT:    vldrw.u32 q1, [r0], #32
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1], #16
; CHECK-NEXT:    le lr, .LBB1_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds float, float* %x, i32 %index
  %1 = bitcast float* %0 to <8 x float>*
  %wide.load = load <8 x float>, <8 x float>* %1, align 4
  %2 = fmul <8 x float> %wide.load, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %3 = fptrunc <8 x float> %2 to <8 x half>
  %4 = getelementptr inbounds half, half* %y, i32 %index
  %5 = bitcast half* %4 to <8 x half>*
  store <8 x half> %3, <8 x half>* %5, align 2
  %index.next = add i32 %index, 8
  %6 = icmp eq i32 %index.next, 1024
  br i1 %6, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @to_16(float* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: to_16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #64
; CHECK-NEXT:    adr r2, .LCPI2_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB2_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrw.u32 q1, [r0, #48]
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #24]
; CHECK-NEXT:    vldrw.u32 q1, [r0, #32]
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #16]
; CHECK-NEXT:    vldrw.u32 q1, [r0, #16]
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #8]
; CHECK-NEXT:    vldrw.u32 q1, [r0], #64
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1], #32
; CHECK-NEXT:    le lr, .LBB2_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI2_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds float, float* %x, i32 %index
  %1 = bitcast float* %0 to <16 x float>*
  %wide.load = load <16 x float>, <16 x float>* %1, align 4
  %2 = fmul <16 x float> %wide.load, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %3 = fptrunc <16 x float> %2 to <16 x half>
  %4 = getelementptr inbounds half, half* %y, i32 %index
  %5 = bitcast half* %4 to <16 x half>*
  store <16 x half> %3, <16 x half>* %5, align 2
  %index.next = add i32 %index, 16
  %6 = icmp eq i32 %index.next, 1024
  br i1 %6, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @from_4(half* nocapture readonly %x, float* noalias nocapture %y) {
; CHECK-LABEL: from_4:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #256
; CHECK-NEXT:    adr r2, .LCPI3_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB3_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u32 q1, [r0], #8
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vstrb.8 q1, [r1], #16
; CHECK-NEXT:    le lr, .LBB3_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI3_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <4 x half>*
  %wide.load = load <4 x half>, <4 x half>* %1, align 2
  %2 = fpext <4 x half> %wide.load to <4 x float>
  %3 = fmul <4 x float> %2, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %4 = getelementptr inbounds float, float* %y, i32 %index
  %5 = bitcast float* %4 to <4 x float>*
  store <4 x float> %3, <4 x float>* %5, align 4
  %index.next = add i32 %index, 4
  %6 = icmp eq i32 %index.next, 1024
  br i1 %6, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @from_8(half* nocapture readonly %x, float* noalias nocapture %y) {
; CHECK-LABEL: from_8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #128
; CHECK-NEXT:    adr r2, .LCPI4_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB4_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u32 q1, [r0, #8]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vstrw.32 q1, [r1, #16]
; CHECK-NEXT:    vldrh.u32 q1, [r0], #16
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vstrw.32 q1, [r1], #32
; CHECK-NEXT:    le lr, .LBB4_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI4_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <8 x half>*
  %wide.load = load <8 x half>, <8 x half>* %1, align 2
  %2 = fpext <8 x half> %wide.load to <8 x float>
  %3 = fmul <8 x float> %2, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %4 = getelementptr inbounds float, float* %y, i32 %index
  %5 = bitcast float* %4 to <8 x float>*
  store <8 x float> %3, <8 x float>* %5, align 4
  %index.next = add i32 %index, 8
  %6 = icmp eq i32 %index.next, 1024
  br i1 %6, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @from_16(half* nocapture readonly %x, float* noalias nocapture %y) {
; CHECK-LABEL: from_16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #64
; CHECK-NEXT:    adr r2, .LCPI5_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB5_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u32 q1, [r0, #24]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vstrw.32 q1, [r1, #48]
; CHECK-NEXT:    vldrh.u32 q1, [r0, #16]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vstrw.32 q1, [r1, #32]
; CHECK-NEXT:    vldrh.u32 q1, [r0, #8]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vstrw.32 q1, [r1, #16]
; CHECK-NEXT:    vldrh.u32 q1, [r0], #32
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vstrw.32 q1, [r1], #64
; CHECK-NEXT:    le lr, .LBB5_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI5_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <16 x half>*
  %wide.load = load <16 x half>, <16 x half>* %1, align 2
  %2 = fpext <16 x half> %wide.load to <16 x float>
  %3 = fmul <16 x float> %2, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %4 = getelementptr inbounds float, float* %y, i32 %index
  %5 = bitcast float* %4 to <16 x float>*
  store <16 x float> %3, <16 x float>* %5, align 4
  %index.next = add i32 %index, 16
  %6 = icmp eq i32 %index.next, 1024
  br i1 %6, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @both_4(half* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: both_4:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #256
; CHECK-NEXT:    adr r2, .LCPI6_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB6_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u32 q1, [r0], #8
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1], #8
; CHECK-NEXT:    le lr, .LBB6_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI6_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <4 x half>*
  %wide.load = load <4 x half>, <4 x half>* %1, align 2
  %2 = fpext <4 x half> %wide.load to <4 x float>
  %3 = fmul <4 x float> %2, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %4 = fptrunc <4 x float> %3 to <4 x half>
  %5 = getelementptr inbounds half, half* %y, i32 %index
  %6 = bitcast half* %5 to <4 x half>*
  store <4 x half> %4, <4 x half>* %6, align 2
  %index.next = add i32 %index, 4
  %7 = icmp eq i32 %index.next, 1024
  br i1 %7, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @both_8(half* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: both_8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #128
; CHECK-NEXT:    adr r2, .LCPI7_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB7_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u32 q1, [r0, #8]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #8]
; CHECK-NEXT:    vldrh.u32 q1, [r0], #16
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1], #16
; CHECK-NEXT:    le lr, .LBB7_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI7_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <8 x half>*
  %wide.load = load <8 x half>, <8 x half>* %1, align 2
  %2 = fpext <8 x half> %wide.load to <8 x float>
  %3 = fmul <8 x float> %2, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %4 = fptrunc <8 x float> %3 to <8 x half>
  %5 = getelementptr inbounds half, half* %y, i32 %index
  %6 = bitcast half* %5 to <8 x half>*
  store <8 x half> %4, <8 x half>* %6, align 2
  %index.next = add i32 %index, 8
  %7 = icmp eq i32 %index.next, 1024
  br i1 %7, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @both_16(half* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: both_16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #64
; CHECK-NEXT:    adr r2, .LCPI8_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB8_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u32 q1, [r0, #24]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #24]
; CHECK-NEXT:    vldrh.u32 q1, [r0, #16]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #16]
; CHECK-NEXT:    vldrh.u32 q1, [r0, #8]
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1, #8]
; CHECK-NEXT:    vldrh.u32 q1, [r0], #32
; CHECK-NEXT:    vcvtb.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q1, q1
; CHECK-NEXT:    vstrh.32 q1, [r1], #32
; CHECK-NEXT:    le lr, .LBB8_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI8_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <16 x half>*
  %wide.load = load <16 x half>, <16 x half>* %1, align 2
  %2 = fpext <16 x half> %wide.load to <16 x float>
  %3 = fmul <16 x float> %2, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %4 = fptrunc <16 x float> %3 to <16 x half>
  %5 = getelementptr inbounds half, half* %y, i32 %index
  %6 = bitcast half* %5 to <16 x half>*
  store <16 x half> %4, <16 x half>* %6, align 2
  %index.next = add i32 %index, 16
  %7 = icmp eq i32 %index.next, 1024
  br i1 %7, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @both_8_I(half* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: both_8_I:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #128
; CHECK-NEXT:    adr r2, .LCPI9_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB9_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u16 q1, [r0], #16
; CHECK-NEXT:    vcvtb.f32.f16 q2, q1
; CHECK-NEXT:    vcvtt.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q2, q2, q0
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q2, q2
; CHECK-NEXT:    vcvtt.f16.f32 q2, q1
; CHECK-NEXT:    vstrb.8 q2, [r1], #16
; CHECK-NEXT:    le lr, .LBB9_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI9_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <8 x half>*
  %wide.load = load <8 x half>, <8 x half>* %1, align 2
  %2 = shufflevector <8 x half> %wide.load, <8 x half> %wide.load, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  %3 = shufflevector <8 x half> %wide.load, <8 x half> %wide.load, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  %4 = fpext <4 x half> %2 to <4 x float>
  %5 = fpext <4 x half> %3 to <4 x float>
  %6 = fmul <4 x float> %4, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %7 = fmul <4 x float> %5, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %8 = shufflevector <4 x float> %6, <4 x float> %7, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %9 = fptrunc <8 x float> %8 to <8 x half>
  %10 = getelementptr inbounds half, half* %y, i32 %index
  %11 = bitcast half* %10 to <8 x half>*
  store <8 x half> %9, <8 x half>* %11, align 2
  %index.next = add i32 %index, 8
  %12 = icmp eq i32 %index.next, 1024
  br i1 %12, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}

define void @both_16_I(half* nocapture readonly %x, half* noalias nocapture %y) {
; CHECK-LABEL: both_16_I:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r7, lr}
; CHECK-NEXT:    push {r7, lr}
; CHECK-NEXT:    mov.w lr, #128
; CHECK-NEXT:    adr r2, .LCPI10_0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    vldrw.u32 q0, [r2]
; CHECK-NEXT:  .LBB10_1: @ %vector.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    vldrh.u16 q1, [r0]
; CHECK-NEXT:    vcvtb.f32.f16 q2, q1
; CHECK-NEXT:    vcvtt.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q2, q2, q0
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q2, q2
; CHECK-NEXT:    vcvtt.f16.f32 q2, q1
; CHECK-NEXT:    vldrh.u16 q1, [r0, #16]!
; CHECK-NEXT:    vstrh.16 q2, [r1]
; CHECK-NEXT:    vcvtb.f32.f16 q2, q1
; CHECK-NEXT:    vcvtt.f32.f16 q1, q1
; CHECK-NEXT:    vmul.f32 q2, q2, q0
; CHECK-NEXT:    vmul.f32 q1, q1, q0
; CHECK-NEXT:    vcvtb.f16.f32 q2, q2
; CHECK-NEXT:    vcvtt.f16.f32 q2, q1
; CHECK-NEXT:    vstrb.8 q2, [r1, #16]!
; CHECK-NEXT:    le lr, .LBB10_1
; CHECK-NEXT:  @ %bb.2: @ %for.cond.cleanup
; CHECK-NEXT:    pop {r7, pc}
; CHECK-NEXT:    .p2align 4
; CHECK-NEXT:  @ %bb.3:
; CHECK-NEXT:  .LCPI10_0:
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
; CHECK-NEXT:    .long 0x40066666 @ float 2.0999999
entry:
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i32 [ 0, %entry ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds half, half* %x, i32 %index
  %1 = bitcast half* %0 to <16 x half>*
  %wide.load = load <16 x half>, <16 x half>* %1, align 2
  %2 = shufflevector <16 x half> %wide.load, <16 x half> %wide.load, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  %3 = shufflevector <16 x half> %wide.load, <16 x half> %wide.load, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  %4 = fpext <8 x half> %2 to <8 x float>
  %5 = fpext <8 x half> %3 to <8 x float>
  %6 = fmul <8 x float> %4, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %7 = fmul <8 x float> %5, <float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000, float 0x4000CCCCC0000000>
  %8 = shufflevector <8 x float> %6, <8 x float> %7, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %9 = fptrunc <16 x float> %8 to <16 x half>
  %10 = getelementptr inbounds half, half* %y, i32 %index
  %11 = bitcast half* %10 to <16 x half>*
  store <16 x half> %9, <16 x half>* %11, align 2
  %index.next = add i32 %index, 8
  %12 = icmp eq i32 %index.next, 1024
  br i1 %12, label %for.cond.cleanup, label %vector.body

for.cond.cleanup:                                 ; preds = %vector.body
  ret void
}
