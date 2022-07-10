; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=thumbv7-unknown-none-gnueabi | FileCheck %s --check-prefixes=THUMBV7

define { i128, i8 } @muloti_test(i128 %l, i128 %r) unnamed_addr #0 {
; THUMBV7-LABEL: muloti_test:
; THUMBV7:       @ %bb.0: @ %start
; THUMBV7-NEXT:    .save {r4, r5, r6, r7, r8, r9, r10, r11, lr}
; THUMBV7-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11, lr}
; THUMBV7-NEXT:    .pad #44
; THUMBV7-NEXT:    sub sp, #44
; THUMBV7-NEXT:    str r0, [sp, #40] @ 4-byte Spill
; THUMBV7-NEXT:    movs r0, #0
; THUMBV7-NEXT:    ldrd r4, r7, [sp, #88]
; THUMBV7-NEXT:    mov r5, r3
; THUMBV7-NEXT:    strd r0, r0, [sp, #8]
; THUMBV7-NEXT:    mov r1, r3
; THUMBV7-NEXT:    mov r6, r2
; THUMBV7-NEXT:    mov r0, r2
; THUMBV7-NEXT:    movs r2, #0
; THUMBV7-NEXT:    movs r3, #0
; THUMBV7-NEXT:    strd r4, r7, [sp]
; THUMBV7-NEXT:    bl __multi3
; THUMBV7-NEXT:    strd r1, r0, [sp, #32] @ 8-byte Folded Spill
; THUMBV7-NEXT:    strd r3, r2, [sp, #24] @ 8-byte Folded Spill
; THUMBV7-NEXT:    ldrd r2, r0, [sp, #96]
; THUMBV7-NEXT:    ldr.w r9, [sp, #80]
; THUMBV7-NEXT:    umull lr, r0, r0, r6
; THUMBV7-NEXT:    ldr.w r11, [sp, #84]
; THUMBV7-NEXT:    umull r3, r1, r5, r2
; THUMBV7-NEXT:    umull r2, r12, r2, r6
; THUMBV7-NEXT:    add r3, lr
; THUMBV7-NEXT:    umull r8, r10, r7, r9
; THUMBV7-NEXT:    str r2, [sp, #20] @ 4-byte Spill
; THUMBV7-NEXT:    adds.w lr, r12, r3
; THUMBV7-NEXT:    umull r6, r9, r9, r4
; THUMBV7-NEXT:    mov.w r3, #0
; THUMBV7-NEXT:    adc r12, r3, #0
; THUMBV7-NEXT:    umull r2, r4, r11, r4
; THUMBV7-NEXT:    add r2, r8
; THUMBV7-NEXT:    mov.w r8, #0
; THUMBV7-NEXT:    adds.w r2, r2, r9
; THUMBV7-NEXT:    adc r9, r3, #0
; THUMBV7-NEXT:    ldr r3, [sp, #20] @ 4-byte Reload
; THUMBV7-NEXT:    adds r3, r3, r6
; THUMBV7-NEXT:    ldr r6, [sp, #28] @ 4-byte Reload
; THUMBV7-NEXT:    adc.w r2, r2, lr
; THUMBV7-NEXT:    adds r3, r3, r6
; THUMBV7-NEXT:    ldr r6, [sp, #24] @ 4-byte Reload
; THUMBV7-NEXT:    adcs r2, r6
; THUMBV7-NEXT:    ldrd r6, lr, [sp, #36] @ 8-byte Folded Reload
; THUMBV7-NEXT:    str.w r6, [lr]
; THUMBV7-NEXT:    adc r8, r8, #0
; THUMBV7-NEXT:    ldr r6, [sp, #32] @ 4-byte Reload
; THUMBV7-NEXT:    cmp r5, #0
; THUMBV7-NEXT:    strd r6, r3, [lr, #4]
; THUMBV7-NEXT:    str.w r2, [lr, #12]
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r5, #1
; THUMBV7-NEXT:    ldr r2, [sp, #100]
; THUMBV7-NEXT:    cmp r2, #0
; THUMBV7-NEXT:    mov r3, r2
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r3, #1
; THUMBV7-NEXT:    cmp r0, #0
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r0, #1
; THUMBV7-NEXT:    cmp r1, #0
; THUMBV7-NEXT:    and.w r3, r3, r5
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r1, #1
; THUMBV7-NEXT:    orrs r0, r3
; THUMBV7-NEXT:    cmp r7, #0
; THUMBV7-NEXT:    orr.w r0, r0, r1
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r7, #1
; THUMBV7-NEXT:    cmp.w r11, #0
; THUMBV7-NEXT:    mov r1, r11
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r1, #1
; THUMBV7-NEXT:    cmp r4, #0
; THUMBV7-NEXT:    ldr r3, [sp, #96]
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r4, #1
; THUMBV7-NEXT:    cmp.w r10, #0
; THUMBV7-NEXT:    and.w r1, r1, r7
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne.w r10, #1
; THUMBV7-NEXT:    orrs r3, r2
; THUMBV7-NEXT:    ldr r2, [sp, #80]
; THUMBV7-NEXT:    orr.w r1, r1, r4
; THUMBV7-NEXT:    orr.w r1, r1, r10
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r3, #1
; THUMBV7-NEXT:    orrs.w r7, r2, r11
; THUMBV7-NEXT:    orr.w r1, r1, r9
; THUMBV7-NEXT:    it ne
; THUMBV7-NEXT:    movne r7, #1
; THUMBV7-NEXT:    ands r3, r7
; THUMBV7-NEXT:    orr.w r0, r0, r12
; THUMBV7-NEXT:    orrs r1, r3
; THUMBV7-NEXT:    orrs r0, r1
; THUMBV7-NEXT:    orr.w r0, r0, r8
; THUMBV7-NEXT:    and r0, r0, #1
; THUMBV7-NEXT:    strb.w r0, [lr, #16]
; THUMBV7-NEXT:    add sp, #44
; THUMBV7-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11, pc}
start:
  %0 = tail call { i128, i1 } @llvm.umul.with.overflow.i128(i128 %l, i128 %r) #2
  %1 = extractvalue { i128, i1 } %0, 0
  %2 = extractvalue { i128, i1 } %0, 1
  %3 = zext i1 %2 to i8
  %4 = insertvalue { i128, i8 } undef, i128 %1, 0
  %5 = insertvalue { i128, i8 } %4, i8 %3, 1
  ret { i128, i8 } %5
}

; Function Attrs: nounwind readnone speculatable
declare { i128, i1 } @llvm.umul.with.overflow.i128(i128, i128) #1

attributes #0 = { nounwind readnone uwtable }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind }