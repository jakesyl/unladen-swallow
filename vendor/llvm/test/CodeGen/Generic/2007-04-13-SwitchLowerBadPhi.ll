; RUN: llvm-as < %s | llc -fast
; PR 1323

; ModuleID = 'test.bc'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64"
target triple = "i686-apple-darwin8"
	%struct.comp = type { i8*, i32, i8*, [3 x i8], i32 }

define void @regbranch() {
cond_next240.i:
	br i1 false, label %cond_true251.i, label %cond_next272.i

cond_true251.i:		; preds = %cond_next240.i
	switch i8 0, label %cond_next272.i [
		 i8 42, label %bb268.i
		 i8 43, label %bb268.i
		 i8 63, label %bb268.i
	]

bb268.i:		; preds = %cond_true251.i, %cond_true251.i, %cond_true251.i
	br label %cond_next272.i

cond_next272.i:		; preds = %bb268.i, %cond_true251.i, %cond_next240.i
	%len.2.i = phi i32 [ 0, %bb268.i ], [ 0, %cond_next240.i ], [ 0, %cond_true251.i ]		; <i32> [#uses=1]
	%tmp278.i = icmp eq i32 %len.2.i, 1		; <i1> [#uses=0]
	ret void
}
