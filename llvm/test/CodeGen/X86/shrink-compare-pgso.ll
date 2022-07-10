; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s

declare dso_local void @bar()

define dso_local void @test1(i32* nocapture %X) nounwind !prof !14 {
; CHECK-LABEL: test1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $47, (%rdi)
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %tmp1 = load i32, i32* %X, align 4
  %and = and i32 %tmp1, 255
  %cmp = icmp eq i32 %and, 47
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test2(i32 %X) nounwind !prof !14 {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $47, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %and = and i32 %X, 255
  %cmp = icmp eq i32 %and, 47
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test3(i32 %X) nounwind !prof !14 {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $-1, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %and = and i32 %X, 255
  %cmp = icmp eq i32 %and, 255
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

; PR16083
define i1 @test4(i64 %a, i32 %b) {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movb $1, %al
; CHECK-NEXT:    testl %esi, %esi
; CHECK-NEXT:    je .LBB3_1
; CHECK-NEXT:  # %bb.2: # %lor.end
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
; CHECK-NEXT:  .LBB3_1: # %lor.rhs
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
entry:
  %tobool = icmp ne i32 %b, 0
  br i1 %tobool, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %and = and i64 0, %a
  %tobool1 = icmp ne i64 %and, 0
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %entry
  %p = phi i1 [ true, %entry ], [ %tobool1, %lor.rhs ]
  ret i1 %p
}

@x = dso_local global { i8, i8, i8, i8, i8, i8, i8, i8 } { i8 1, i8 0, i8 0, i8 0, i8 1, i8 0, i8 0, i8 1 }, align 4

; PR16551
define dso_local void @test5(i32 %X) nounwind !prof !14 {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzbl x+{{.*}}(%rip), %eax
; CHECK-NEXT:    shll $16, %eax
; CHECK-NEXT:    movzwl x+{{.*}}(%rip), %ecx
; CHECK-NEXT:    orl %eax, %ecx
; CHECK-NEXT:    cmpl $1, %ecx
; CHECK-NEXT:    jne bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %bf.load = load i56, i56* bitcast ({ i8, i8, i8, i8, i8, i8, i8, i8 }* @x to i56*), align 4
  %bf.lshr = lshr i56 %bf.load, 32
  %bf.cast = trunc i56 %bf.lshr to i32
  %cmp = icmp ne i32 %bf.cast, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test2_1(i32 %X) nounwind !prof !14 {
; CHECK-LABEL: test2_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movzbl %dil, %eax
; CHECK-NEXT:    cmpl $256, %eax # imm = 0x100
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %and = and i32 %X, 255
  %cmp = icmp eq i32 %and, 256
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_1(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $1, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_47(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_47:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $47, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, 47
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_127(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_127:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $127, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, 127
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_neg1(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_neg1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $-1, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, -1
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_neg2(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_neg2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $-2, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, -2
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_neg127(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_neg127:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $-127, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, -127
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_neg128(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_neg128:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    cmpb $-128, %dil
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, -128
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

define dso_local void @test_sext_i8_icmp_255(i8 %x) nounwind !prof !14 {
; CHECK-LABEL: test_sext_i8_icmp_255:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movb $1, %al
; CHECK-NEXT:    testb %al, %al
; CHECK-NEXT:    je bar # TAILCALL
; CHECK-NEXT:  # %bb.1: # %if.end
; CHECK-NEXT:    retq
entry:
  %sext = sext i8 %x to i32
  %cmp = icmp eq i32 %sext, 255
  br i1 %cmp, label %if.then, label %if.end

if.then:
  tail call void @bar() nounwind
  br label %if.end

if.end:
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"ProfileSummary", !1}
!1 = !{!2, !3, !4, !5, !6, !7, !8, !9}
!2 = !{!"ProfileFormat", !"InstrProf"}
!3 = !{!"TotalCount", i64 10000}
!4 = !{!"MaxCount", i64 10}
!5 = !{!"MaxInternalCount", i64 1}
!6 = !{!"MaxFunctionCount", i64 1000}
!7 = !{!"NumCounts", i64 3}
!8 = !{!"NumFunctions", i64 3}
!9 = !{!"DetailedSummary", !10}
!10 = !{!11, !12, !13}
!11 = !{i32 10000, i64 100, i32 1}
!12 = !{i32 999000, i64 100, i32 1}
!13 = !{i32 999999, i64 1, i32 2}
!14 = !{!"function_entry_count", i64 0}
