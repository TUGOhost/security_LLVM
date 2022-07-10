; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-- | FileCheck %s

; Select of constants: control flow / conditional moves can always be replaced by logic+math (but may not be worth it?).
; Test the zeroext/signext variants of each pattern to see if that makes a difference.

; select Cond, 0, 1 --> zext (!Cond)

define i32 @select_0_or_1(i1 %cond) {
; CHECK-LABEL: select_0_or_1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn w8, w0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 0, i32 1
  ret i32 %sel
}

define i32 @select_0_or_1_zeroext(i1 zeroext %cond) {
; CHECK-LABEL: select_0_or_1_zeroext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    eor w0, w0, #0x1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 0, i32 1
  ret i32 %sel
}

define i32 @select_0_or_1_signext(i1 signext %cond) {
; CHECK-LABEL: select_0_or_1_signext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn w8, w0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 0, i32 1
  ret i32 %sel
}

; select Cond, 1, 0 --> zext (Cond)

define i32 @select_1_or_0(i1 %cond) {
; CHECK-LABEL: select_1_or_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 1, i32 0
  ret i32 %sel
}

define i32 @select_1_or_0_zeroext(i1 zeroext %cond) {
; CHECK-LABEL: select_1_or_0_zeroext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 1, i32 0
  ret i32 %sel
}

define i32 @select_1_or_0_signext(i1 signext %cond) {
; CHECK-LABEL: select_1_or_0_signext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 1, i32 0
  ret i32 %sel
}

; select Cond, 0, -1 --> sext (!Cond)

define i32 @select_0_or_neg1(i1 %cond) {
; CHECK-LABEL: select_0_or_neg1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0x1
; CHECK-NEXT:    sub w0, w8, #1 // =1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 0, i32 -1
  ret i32 %sel
}

define i32 @select_0_or_neg1_zeroext(i1 zeroext %cond) {
; CHECK-LABEL: select_0_or_neg1_zeroext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub w0, w0, #1 // =1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 0, i32 -1
  ret i32 %sel
}

define i32 @select_0_or_neg1_signext(i1 signext %cond) {
; CHECK-LABEL: select_0_or_neg1_signext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvn w0, w0
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 0, i32 -1
  ret i32 %sel
}

; select Cond, -1, 0 --> sext (Cond)

define i32 @select_neg1_or_0(i1 %cond) {
; CHECK-LABEL: select_neg1_or_0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sbfx w0, w0, #0, #1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 -1, i32 0
  ret i32 %sel
}

define i32 @select_neg1_or_0_zeroext(i1 zeroext %cond) {
; CHECK-LABEL: select_neg1_or_0_zeroext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sbfx w0, w0, #0, #1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 -1, i32 0
  ret i32 %sel
}

define i32 @select_neg1_or_0_signext(i1 signext %cond) {
; CHECK-LABEL: select_neg1_or_0_signext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 -1, i32 0
  ret i32 %sel
}

; select Cond, C+1, C --> add (zext Cond), C

define i32 @select_Cplus1_C(i1 %cond) {
; CHECK-LABEL: select_Cplus1_C:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 42, i32 41
  ret i32 %sel
}

define i32 @select_Cplus1_C_zeroext(i1 zeroext %cond) {
; CHECK-LABEL: select_Cplus1_C_zeroext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 42, i32 41
  ret i32 %sel
}

define i32 @select_Cplus1_C_signext(i1 signext %cond) {
; CHECK-LABEL: select_Cplus1_C_signext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 42, i32 41
  ret i32 %sel
}

; select Cond, C, C+1 --> add (sext Cond), C

define i32 @select_C_Cplus1(i1 %cond) {
; CHECK-LABEL: select_C_Cplus1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, eq
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 41, i32 42
  ret i32 %sel
}

define i32 @select_C_Cplus1_zeroext(i1 zeroext %cond) {
; CHECK-LABEL: select_C_Cplus1_zeroext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, eq
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 41, i32 42
  ret i32 %sel
}

define i32 @select_C_Cplus1_signext(i1 signext %cond) {
; CHECK-LABEL: select_C_Cplus1_signext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #41
; CHECK-NEXT:    cinc w0, w8, eq
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 41, i32 42
  ret i32 %sel
}

; In general, select of 2 constants could be:
; select Cond, C1, C2 --> add (mul (zext Cond), C1-C2), C2 --> add (and (sext Cond), C1-C2), C2

define i32 @select_C1_C2(i1 %cond) {
; CHECK-LABEL: select_C1_C2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #42
; CHECK-NEXT:    mov w9, #421
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 421, i32 42
  ret i32 %sel
}

define i32 @select_C1_C2_zeroext(i1 zeroext %cond) {
; CHECK-LABEL: select_C1_C2_zeroext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w0, #0 // =0
; CHECK-NEXT:    mov w8, #42
; CHECK-NEXT:    mov w9, #421
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 421, i32 42
  ret i32 %sel
}

define i32 @select_C1_C2_signext(i1 signext %cond) {
; CHECK-LABEL: select_C1_C2_signext:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #42
; CHECK-NEXT:    mov w9, #421
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i32 421, i32 42
  ret i32 %sel
}

; A binary operator with constant after the select should always get folded into the select.

define i8 @sel_constants_add_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_add_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #28
; CHECK-NEXT:    csinc w0, w8, wzr, eq
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = add i8 %sel, 5
  ret i8 %bo
}

define i8 @sel_constants_sub_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_sub_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #18
; CHECK-NEXT:    mov w9, #-9
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = sub i8 %sel, 5
  ret i8 %bo
}

define i8 @sel_constants_sub_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: sel_constants_sub_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #2
; CHECK-NEXT:    mov w9, #9
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 3
  %bo = sub i8 5, %sel
  ret i8 %bo
}

define i8 @sel_constants_mul_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_mul_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #115
; CHECK-NEXT:    mov w9, #-20
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = mul i8 %sel, 5
  ret i8 %bo
}

define i8 @sel_constants_sdiv_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_sdiv_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    csel w0, wzr, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = sdiv i8 %sel, 5
  ret i8 %bo
}

define i8 @sdiv_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: sdiv_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #5
; CHECK-NEXT:    csel w0, wzr, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 121, i8 23
  %bo = sdiv i8 120, %sel
  ret i8 %bo
}

define i8 @sel_constants_udiv_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_udiv_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    mov w9, #50
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = udiv i8 %sel, 5
  ret i8 %bo
}

define i8 @udiv_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: udiv_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #5
; CHECK-NEXT:    csel w0, wzr, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = udiv i8 120, %sel
  ret i8 %bo
}

define i8 @sel_constants_srem_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_srem_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #-4
; CHECK-NEXT:    cinv w0, w8, eq
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = srem i8 %sel, 5
  ret i8 %bo
}

define i8 @srem_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: srem_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #5
; CHECK-NEXT:    mov w9, #120
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 121, i8 23
  %bo = srem i8 120, %sel
  ret i8 %bo
}

define i8 @sel_constants_urem_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_urem_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #2
; CHECK-NEXT:    cinc w0, w8, eq
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = urem i8 %sel, 5
  ret i8 %bo
}

define i8 @urem_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: urem_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #5
; CHECK-NEXT:    mov w9, #120
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = urem i8 120, %sel
  ret i8 %bo
}

define i8 @sel_constants_and_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_and_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #4
; CHECK-NEXT:    cinc w0, w8, eq
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = and i8 %sel, 5
  ret i8 %bo
}

define i8 @sel_constants_or_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_or_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #23
; CHECK-NEXT:    mov w9, #-3
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = or i8 %sel, 5
  ret i8 %bo
}

define i8 @sel_constants_xor_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_xor_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #18
; CHECK-NEXT:    mov w9, #-7
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = xor i8 %sel, 5
  ret i8 %bo
}

define i8 @sel_constants_shl_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_shl_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #-32
; CHECK-NEXT:    mov w9, #-128
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = shl i8 %sel, 5
  ret i8 %bo
}

define i8 @shl_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: shl_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #8
; CHECK-NEXT:    mov w9, #4
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 2, i8 3
  %bo = shl i8 1, %sel
  ret i8 %bo
}

define i8 @sel_constants_lshr_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_lshr_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #7
; CHECK-NEXT:    csel w0, w8, wzr, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = lshr i8 %sel, 5
  ret i8 %bo
}

define i8 @lshr_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: lshr_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #8
; CHECK-NEXT:    mov w9, #16
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 2, i8 3
  %bo = lshr i8 64, %sel
  ret i8 %bo
}


define i8 @sel_constants_ashr_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_ashr_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sbfx w0, w0, #0, #1
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 -4, i8 23
  %bo = ashr i8 %sel, 5
  ret i8 %bo
}

define i8 @ashr_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: ashr_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    mov w8, #-16
; CHECK-NEXT:    mov w9, #-32
; CHECK-NEXT:    csel w0, w9, w8, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, i8 2, i8 3
  %bo = ashr i8 128, %sel
  ret i8 %bo
}

define double @sel_constants_fadd_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_fadd_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI42_0
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI42_0]
; CHECK-NEXT:    mov x8, #7378697629483820646
; CHECK-NEXT:    movk x8, #16444, lsl #48
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fcsel d0, d0, d1, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = fadd double %sel, 5.1
  ret double %bo
}

define double @sel_constants_fsub_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_fsub_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI43_0
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI43_0]
; CHECK-NEXT:    mov x8, #3689348814741910323
; CHECK-NEXT:    movk x8, #49186, lsl #48
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fcsel d0, d1, d0, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = fsub double %sel, 5.1
  ret double %bo
}

define double @fsub_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: fsub_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI44_0
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI44_0]
; CHECK-NEXT:    mov x8, #3689348814741910323
; CHECK-NEXT:    movk x8, #16418, lsl #48
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fcsel d0, d1, d0, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = fsub double 5.1, %sel
  ret double %bo
}

define double @sel_constants_fmul_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_fmul_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI45_0
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI45_0]
; CHECK-NEXT:    mov x8, #7378697629483820646
; CHECK-NEXT:    movk x8, #49204, lsl #48
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fcsel d0, d1, d0, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = fmul double %sel, 5.1
  ret double %bo
}

define double @sel_constants_fdiv_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_fdiv_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI46_0
; CHECK-NEXT:    adrp x9, .LCPI46_1
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI46_0]
; CHECK-NEXT:    ldr d1, [x9, :lo12:.LCPI46_1]
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fcsel d0, d1, d0, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = fdiv double %sel, 5.1
  ret double %bo
}

define double @fdiv_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: fdiv_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI47_0
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI47_0]
; CHECK-NEXT:    mov x8, #7378697629483820646
; CHECK-NEXT:    movk x8, #49140, lsl #48
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fcsel d0, d1, d0, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = fdiv double 5.1, %sel
  ret double %bo
}

define double @sel_constants_frem_constant(i1 %cond) {
; CHECK-LABEL: sel_constants_frem_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI48_0
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI48_0]
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fmov d1, #-4.00000000
; CHECK-NEXT:    fcsel d0, d1, d0, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = frem double %sel, 5.1
  ret double %bo
}

define double @frem_constant_sel_constants(i1 %cond) {
; CHECK-LABEL: frem_constant_sel_constants:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI49_0
; CHECK-NEXT:    ldr d0, [x8, :lo12:.LCPI49_0]
; CHECK-NEXT:    mov x8, #7378697629483820646
; CHECK-NEXT:    movk x8, #16404, lsl #48
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    fmov d1, x8
; CHECK-NEXT:    fcsel d0, d0, d1, ne
; CHECK-NEXT:    ret
  %sel = select i1 %cond, double -4.0, double 23.3
  %bo = frem double 5.1, %sel
  ret double %bo
}
