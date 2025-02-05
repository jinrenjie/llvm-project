; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop(simple-loop-unswitch)' -S %s | FileCheck %s

declare void @some_func()

define i32 @need_freeze_of_individual_or_conditions1(i1 %cond1, i1 %cond2, i1 %cond3, i1 %cond4) {
; CHECK-LABEL: @need_freeze_of_individual_or_conditions1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = and i1 [[COND4:%.*]], [[COND1:%.*]]
; CHECK-NEXT:    [[DOTFR:%.*]] = freeze i1 [[TMP0]]
; CHECK-NEXT:    br i1 [[DOTFR]], label [[ENTRY_SPLIT:%.*]], label [[EXIT_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    [[TMP1:%.*]] = and i1 [[COND2:%.*]], [[COND3:%.*]]
; CHECK-NEXT:    [[DOTFR2:%.*]] = freeze i1 [[TMP1]]
; CHECK-NEXT:    br i1 [[DOTFR2]], label [[ENTRY_SPLIT_SPLIT:%.*]], label [[EXIT_SPLIT1:%.*]]
; CHECK:       entry.split.split:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[OR:%.*]] = or i1 true, true
; CHECK-NEXT:    [[AND1:%.*]] = and i1 [[OR]], true
; CHECK-NEXT:    [[AND2:%.*]] = select i1 [[AND1]], i1 true, i1 false
; CHECK-NEXT:    br i1 [[AND2]], label [[LOOP_LATCH:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @some_func()
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    br label [[EXIT_SPLIT1]]
; CHECK:       exit.split1:
; CHECK-NEXT:    br label [[EXIT_SPLIT]]
; CHECK:       exit.split:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %or = or i1 %cond2, %cond3
  %and1 = and i1 %or, %cond1
  %and2 = select i1 %and1, i1 %cond4, i1 false
  br i1 %and2, label %loop.latch, label %exit

loop.latch:
  call void @some_func()
  br label %loop.header

exit:
  ret i32 0
}

define i32 @need_freeze_of_individual_or_conditions2(i1 noundef %cond1, i1 %cond2, i1 %cond3, i1 %cond4) {
; CHECK-LABEL: @need_freeze_of_individual_or_conditions2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = and i1 [[COND4:%.*]], [[COND1:%.*]]
; CHECK-NEXT:    [[DOTFR:%.*]] = freeze i1 [[TMP0]]
; CHECK-NEXT:    br i1 [[DOTFR]], label [[ENTRY_SPLIT:%.*]], label [[EXIT_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    [[TMP1:%.*]] = and i1 [[COND2:%.*]], [[COND3:%.*]]
; CHECK-NEXT:    [[DOTFR2:%.*]] = freeze i1 [[TMP1]]
; CHECK-NEXT:    br i1 [[DOTFR2]], label [[ENTRY_SPLIT_SPLIT:%.*]], label [[EXIT_SPLIT1:%.*]]
; CHECK:       entry.split.split:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[OR:%.*]] = or i1 true, true
; CHECK-NEXT:    [[AND1:%.*]] = and i1 [[OR]], true
; CHECK-NEXT:    [[AND2:%.*]] = select i1 [[AND1]], i1 true, i1 false
; CHECK-NEXT:    br i1 [[AND2]], label [[LOOP_LATCH:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @some_func()
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    br label [[EXIT_SPLIT1]]
; CHECK:       exit.split1:
; CHECK-NEXT:    br label [[EXIT_SPLIT]]
; CHECK:       exit.split:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %or = or i1 %cond2, %cond3
  %and1 = and i1 %or, %cond1
  %and2 = select i1 %and1, i1 %cond4, i1 false
  br i1 %and2, label %loop.latch, label %exit

loop.latch:
  call void @some_func()
  br label %loop.header

exit:
  ret i32 0
}

define i32 @need_freeze_of_individual_or_conditions3(i1 %cond1, i1 %cond2, i1 %cond3, i1 noundef %cond4) {
; CHECK-LABEL: @need_freeze_of_individual_or_conditions3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = and i1 [[COND4:%.*]], [[COND1:%.*]]
; CHECK-NEXT:    [[DOTFR:%.*]] = freeze i1 [[TMP0]]
; CHECK-NEXT:    br i1 [[DOTFR]], label [[ENTRY_SPLIT:%.*]], label [[EXIT_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    [[TMP1:%.*]] = and i1 [[COND2:%.*]], [[COND3:%.*]]
; CHECK-NEXT:    [[DOTFR2:%.*]] = freeze i1 [[TMP1]]
; CHECK-NEXT:    br i1 [[DOTFR2]], label [[ENTRY_SPLIT_SPLIT:%.*]], label [[EXIT_SPLIT1:%.*]]
; CHECK:       entry.split.split:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[OR:%.*]] = or i1 true, true
; CHECK-NEXT:    [[AND1:%.*]] = and i1 [[OR]], true
; CHECK-NEXT:    [[AND2:%.*]] = select i1 [[AND1]], i1 true, i1 false
; CHECK-NEXT:    br i1 [[AND2]], label [[LOOP_LATCH:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    call void @some_func()
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    br label [[EXIT_SPLIT1]]
; CHECK:       exit.split1:
; CHECK-NEXT:    br label [[EXIT_SPLIT]]
; CHECK:       exit.split:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %or = or i1 %cond2, %cond3
  %and1 = and i1 %or, %cond1
  %and2 = select i1 %and1, i1 %cond4, i1 false
  br i1 %and2, label %loop.latch, label %exit

loop.latch:
  call void @some_func()
  br label %loop.header

exit:
  ret i32 0
}

define i32 @need_freeze_of_individual_and_conditions1(i1 %cond1, i1 %cond4) {
; CHECK-LABEL: @need_freeze_of_individual_and_conditions1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = or i1 [[COND4:%.*]], [[COND1:%.*]]
; CHECK-NEXT:    [[DOTFR:%.*]] = freeze i1 [[TMP0]]
; CHECK-NEXT:    br i1 [[DOTFR]], label [[EXIT_SPLIT:%.*]], label [[ENTRY_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[COND_OR1:%.*]] = or i1 undef, false
; CHECK-NEXT:    [[COND_OR6:%.*]] = select i1 [[COND_OR1]], i1 true, i1 false
; CHECK-NEXT:    br i1 [[COND_OR6]], label [[EXIT:%.*]], label [[LOOP_LATCH:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    br label [[EXIT_SPLIT]]
; CHECK:       exit.split:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %cond_or1 = or i1 undef, %cond1
  %cond_or6 = select i1 %cond_or1, i1 true, i1 %cond4
  br i1 %cond_or6, label %exit, label %loop.latch

loop.latch:
  br label %loop.header

exit:
  ret i32 0
}

define i32 @need_freeze_of_individual_and_conditions2(i1 noundef %cond1, i1 %cond4) {
; CHECK-LABEL: @need_freeze_of_individual_and_conditions2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = or i1 [[COND4:%.*]], [[COND1:%.*]]
; CHECK-NEXT:    [[DOTFR:%.*]] = freeze i1 [[TMP0]]
; CHECK-NEXT:    br i1 [[DOTFR]], label [[EXIT_SPLIT:%.*]], label [[ENTRY_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[COND_OR1:%.*]] = or i1 undef, false
; CHECK-NEXT:    [[COND_OR6:%.*]] = select i1 [[COND_OR1]], i1 true, i1 false
; CHECK-NEXT:    br i1 [[COND_OR6]], label [[EXIT:%.*]], label [[LOOP_LATCH:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    br label [[EXIT_SPLIT]]
; CHECK:       exit.split:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %cond_or1 = or i1 undef, %cond1
  %cond_or6 = select i1 %cond_or1, i1 true, i1 %cond4
  br i1 %cond_or6, label %exit, label %loop.latch

loop.latch:
  br label %loop.header

exit:
  ret i32 0
}

define i32 @need_freeze_of_individual_and_conditions3(i1 %cond1, i1 noundef %cond4) {
; CHECK-LABEL: @need_freeze_of_individual_and_conditions3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = or i1 [[COND4:%.*]], [[COND1:%.*]]
; CHECK-NEXT:    [[DOTFR:%.*]] = freeze i1 [[TMP0]]
; CHECK-NEXT:    br i1 [[DOTFR]], label [[EXIT_SPLIT:%.*]], label [[ENTRY_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[COND_OR1:%.*]] = or i1 undef, false
; CHECK-NEXT:    [[COND_OR6:%.*]] = select i1 [[COND_OR1]], i1 true, i1 false
; CHECK-NEXT:    br i1 [[COND_OR6]], label [[EXIT:%.*]], label [[LOOP_LATCH:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    br label [[EXIT_SPLIT]]
; CHECK:       exit.split:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %cond_or1 = or i1 undef, %cond1
  %cond_or6 = select i1 %cond_or1, i1 true, i1 %cond4
  br i1 %cond_or6, label %exit, label %loop.latch

loop.latch:
  br label %loop.header

exit:
  ret i32 0
}

define i32 @need_freeze_of_individual_and_conditions4(i1 noundef %cond1, i1 noundef %cond4) {
; CHECK-LABEL: @need_freeze_of_individual_and_conditions4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = or i1 [[COND4:%.*]], [[COND1:%.*]]
; CHECK-NEXT:    br i1 [[TMP0]], label [[EXIT_SPLIT:%.*]], label [[ENTRY_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[COND_OR1:%.*]] = or i1 undef, false
; CHECK-NEXT:    [[COND_OR6:%.*]] = select i1 [[COND_OR1]], i1 true, i1 false
; CHECK-NEXT:    br i1 [[COND_OR6]], label [[EXIT:%.*]], label [[LOOP_LATCH:%.*]]
; CHECK:       loop.latch:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    br label [[EXIT_SPLIT]]
; CHECK:       exit.split:
; CHECK-NEXT:    ret i32 0
;
entry:
  br label %loop.header

loop.header:
  %cond_or1 = or i1 undef, %cond1
  %cond_or6 = select i1 %cond_or1, i1 true, i1 %cond4
  br i1 %cond_or6, label %exit, label %loop.latch

loop.latch:
  br label %loop.header

exit:
  ret i32 0
}
