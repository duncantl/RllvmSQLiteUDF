; ModuleID = 'fib.c'
source_filename = "fib.c"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.11.0"

%struct.sqlite3_api_routines = type { i8* (%struct.sqlite3_context*, i32)*, i32 (%struct.sqlite3_context*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, double)*, i32 (%struct.sqlite3_stmt*, i32, i32)*, i32 (%struct.sqlite3_stmt*, i32, i64)*, i32 (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_stmt*, i8*)*, i8* (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i32, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, %struct.Mem*)*, i32 (%struct.sqlite3*, i32 (i8*, i32)*, i8*)*, i32 (%struct.sqlite3*, i32)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*, i8*, void (i8*, %struct.sqlite3*, i32, i8*)*)*, i32 (%struct.sqlite3*, i8*, void (i8*, %struct.sqlite3*, i32, i8*)*)*, i8* (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, double (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, i64 (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3_stmt*, i32)*, i32 (%struct.sqlite3_stmt*, i32)*, %struct.Mem* (%struct.sqlite3_stmt*, i32)*, i8* (%struct.sqlite3*, i32 (i8*)*, i8*)*, i32 (i8*)*, i32 (i8*)*, i32 (%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*)*, i32 (%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*)*, i32 (%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.Mem**)*, void (%struct.sqlite3_context*, i32, %struct.Mem**)*, void (%struct.sqlite3_context*)*)*, i32 (%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.Mem**)*, void (%struct.sqlite3_context*, i32, %struct.Mem**)*, void (%struct.sqlite3_context*)*)*, i32 (%struct.sqlite3*, i8*, %struct.sqlite3_module*, i8*)*, i32 (%struct.sqlite3_stmt*)*, %struct.sqlite3* (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3*, i8*)*, i32 (i32)*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3*)*, i8* (%struct.sqlite3*)*, i32 (%struct.sqlite3*, i8*, i32 (i8*, i32, i8**, i8**)*, i8*, i8**)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_stmt*)*, void (i8*)*, void (i8**)*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3_context*, i32)*, i32 (%struct.sqlite3*, i8*, i8***, i32*, i32*, i8**)*, i32 ()*, void (%struct.sqlite3*)*, i64 (%struct.sqlite3*)*, i8* ()*, i32 ()*, i8* (i32)*, i8* (i8*, ...)*, i32 (i8*, %struct.sqlite3**)*, i32 (i8*, %struct.sqlite3**)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i8* (%struct.sqlite3*, void (i8*, i8*, i64)*, i8*)*, void (%struct.sqlite3*, i32, i32 (i8*)*, i8*)*, i8* (i8*, i32)*, i32 (%struct.sqlite3_stmt*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, double)*, void (%struct.sqlite3_context*, i8*, i32)*, void (%struct.sqlite3_context*, i8*, i32)*, void (%struct.sqlite3_context*, i32)*, void (%struct.sqlite3_context*, i64)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i32, void (i8*)*)*, void (%struct.sqlite3_context*, %struct.Mem*)*, i8* (%struct.sqlite3*, void (i8*)*, i8*)*, i32 (%struct.sqlite3*, i32 (i8*, i32, i8*, i8*, i8*, i8*)*, i8*)*, void (%struct.sqlite3_context*, i32, i8*, void (i8*)*)*, i8* (i32, i8*, i8*, ...)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3*, i8*, i8*, i8*, i8**, i8**, i32*, i32*, i32*)*, void ()*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3*, void (i8*, i8*)*, i8*)*, i32 (%struct.sqlite3_stmt*, %struct.sqlite3_stmt*)*, i8* (%struct.sqlite3*, void (i8*, i32, i8*, i8*, i64)*, i8*)*, i8* (%struct.sqlite3_context*)*, i8* (%struct.Mem*)*, i32 (%struct.Mem*)*, i32 (%struct.Mem*)*, double (%struct.Mem*)*, i32 (%struct.Mem*)*, i64 (%struct.Mem*)*, i32 (%struct.Mem*)*, i8* (%struct.Mem*)*, i8* (%struct.Mem*)*, i8* (%struct.Mem*)*, i8* (%struct.Mem*)*, i32 (%struct.Mem*)*, i8* (i8*, %struct.__va_list_tag*)*, i32 (%struct.sqlite3*, i8*, i32)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3*, i8*, i32, %struct.sqlite3_stmt**, i8**)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3*, i8*, %struct.sqlite3_module*, i8*, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, i32)*, i32 (%struct.sqlite3_blob*)*, i32 (%struct.sqlite3_blob*)*, i32 (%struct.sqlite3*, i8*, i8*, i8*, i64, i32, %struct.sqlite3_blob**)*, i32 (%struct.sqlite3_blob*, i8*, i32, i32)*, i32 (%struct.sqlite3_blob*, i8*, i32, i32)*, i32 (%struct.sqlite3*, i8*, i32, i8*, i32 (i8*, i32, i8*, i32, i8*)*, void (i8*)*)*, i32 (%struct.sqlite3*, i8*, i32, i8*)*, i64 (i32)*, i64 ()*, %struct.sqlite3_mutex* (i32)*, void (%struct.sqlite3_mutex*)*, void (%struct.sqlite3_mutex*)*, void (%struct.sqlite3_mutex*)*, i32 (%struct.sqlite3_mutex*)*, i32 (i8*, %struct.sqlite3**, i32, i8*)*, i32 (i32)*, void (%struct.sqlite3_context*)*, void (%struct.sqlite3_context*)*, i32 (i32)*, void (i32)*, %struct.sqlite3_vfs* (i8*)*, i32 (%struct.sqlite3_vfs*, i32)*, i32 (%struct.sqlite3_vfs*)*, i32 ()*, void (%struct.sqlite3_context*, i32)*, void (%struct.sqlite3_context*, i32)*, i32 (i32, ...)*, void (i32, i8*)*, %struct.sqlite3* (%struct.sqlite3_context*)*, i32 (%struct.sqlite3*, i32)*, i32 (%struct.sqlite3*, i32, i32)*, %struct.sqlite3_stmt* (%struct.sqlite3*, %struct.sqlite3_stmt*)*, i8* (%struct.sqlite3_stmt*)*, i32 (i32, i32*, i32*, i32)*, i32 (%struct.sqlite3_backup*)*, %struct.sqlite3_backup* (%struct.sqlite3*, i8*, %struct.sqlite3*, i8*)*, i32 (%struct.sqlite3_backup*)*, i32 (%struct.sqlite3_backup*)*, i32 (%struct.sqlite3_backup*, i32)*, i8* (i32)*, i32 (i8*)*, i32 (%struct.sqlite3*, i8*, i32, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.Mem**)*, void (%struct.sqlite3_context*, i32, %struct.Mem**)*, void (%struct.sqlite3_context*)*, void (i8*)*)*, i32 (%struct.sqlite3*, i32, ...)*, %struct.sqlite3_mutex* (%struct.sqlite3*)*, i32 (%struct.sqlite3*, i32, i32*, i32*, i32)*, i32 (%struct.sqlite3*)*, void (i32, i8*, ...)*, i64 (i64)*, i8* ()*, i32 (%struct.sqlite3_stmt*, i32, i32)*, i32 (i8*, i8*, i32)*, i32 (%struct.sqlite3*, void (i8**, i32)*, i8*)*, i32 (%struct.sqlite3*, i32)*, i32 (%struct.sqlite3*, i8*)*, i8* (%struct.sqlite3*, i32 (i8*, %struct.sqlite3*, i8*, i32)*, i8*)*, i32 (%struct.sqlite3_blob*, i64)*, i32 (%struct.sqlite3*, i32, ...)*, i32 (%struct.sqlite3*)*, i32 (%struct.sqlite3*)*, i8* (%struct.sqlite3*, i8*)*, i32 (%struct.sqlite3*, i8*)*, i32 (%struct.sqlite3*)*, i8* (i32)*, i32 (%struct.sqlite3_stmt*)*, i32 (%struct.sqlite3_stmt*)*, i32 (i8*, i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i8*, i64)*, i8* (i8*, i8*)*, i8* (i32, i8*, i8*, %struct.__va_list_tag*)*, i32 (%struct.sqlite3*, i8*, i32, i32*, i32*)*, i32 (void ()*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i64, void (i8*)*)*, i32 (%struct.sqlite3_stmt*, i32, i8*, i64, void (i8*)*, i8)*, i32 (void ()*)*, i32 (%struct.sqlite3*, i8*, i8*, i8**)*, i8* (i64)*, i64 (i8*)*, i8* (i8*, i64)*, void ()*, void (%struct.sqlite3_context*, i8*, i64, void (i8*)*)*, void (%struct.sqlite3_context*, i8*, i64, void (i8*)*, i8)*, i32 (i8*, i8*)* }
%struct.sqlite3_context = type opaque
%struct.sqlite3_stmt = type opaque
%struct.Mem = type opaque
%struct.sqlite3 = type opaque
%struct.sqlite3_module = type { i32, i32 (%struct.sqlite3*, i8*, i32, i8**, %struct.sqlite3_vtab**, i8**)*, i32 (%struct.sqlite3*, i8*, i32, i8**, %struct.sqlite3_vtab**, i8**)*, i32 (%struct.sqlite3_vtab*, %struct.sqlite3_index_info*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*, %struct.sqlite3_vtab_cursor**)*, i32 (%struct.sqlite3_vtab_cursor*)*, i32 (%struct.sqlite3_vtab_cursor*, i32, i8*, i32, %struct.Mem**)*, i32 (%struct.sqlite3_vtab_cursor*)*, i32 (%struct.sqlite3_vtab_cursor*)*, i32 (%struct.sqlite3_vtab_cursor*, %struct.sqlite3_context*, i32)*, i32 (%struct.sqlite3_vtab_cursor*, i64*)*, i32 (%struct.sqlite3_vtab*, i32, %struct.Mem**, i64*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*)*, i32 (%struct.sqlite3_vtab*, i32, i8*, void (%struct.sqlite3_context*, i32, %struct.Mem**)**, i8**)*, i32 (%struct.sqlite3_vtab*, i8*)*, i32 (%struct.sqlite3_vtab*, i32)*, i32 (%struct.sqlite3_vtab*, i32)*, i32 (%struct.sqlite3_vtab*, i32)* }
%struct.sqlite3_vtab = type { %struct.sqlite3_module*, i32, i8* }
%struct.sqlite3_index_info = type { i32, %struct.sqlite3_index_constraint*, i32, %struct.sqlite3_index_orderby*, %struct.sqlite3_index_constraint_usage*, i32, i8*, i32, i32, double, i64 }
%struct.sqlite3_index_constraint = type { i32, i8, i8, i32 }
%struct.sqlite3_index_orderby = type { i32, i8 }
%struct.sqlite3_index_constraint_usage = type { i32, i8 }
%struct.sqlite3_vtab_cursor = type { %struct.sqlite3_vtab* }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.sqlite3_blob = type opaque
%struct.sqlite3_mutex = type opaque
%struct.sqlite3_vfs = type { i32, i32, i32, %struct.sqlite3_vfs*, i8*, i8*, i32 (%struct.sqlite3_vfs*, i8*, %struct.sqlite3_file*, i32, i32*)*, i32 (%struct.sqlite3_vfs*, i8*, i32)*, i32 (%struct.sqlite3_vfs*, i8*, i32, i32*)*, i32 (%struct.sqlite3_vfs*, i8*, i32, i8*)*, i8* (%struct.sqlite3_vfs*, i8*)*, void (%struct.sqlite3_vfs*, i32, i8*)*, void ()* (%struct.sqlite3_vfs*, i8*, i8*)*, void (%struct.sqlite3_vfs*, i8*)*, i32 (%struct.sqlite3_vfs*, i32, i8*)*, i32 (%struct.sqlite3_vfs*, i32)*, i32 (%struct.sqlite3_vfs*, double*)*, i32 (%struct.sqlite3_vfs*, i32, i8*)*, i32 (%struct.sqlite3_vfs*, i64*)*, i32 (%struct.sqlite3_vfs*, i8*, void ()*)*, void ()* (%struct.sqlite3_vfs*, i8*)*, i8* (%struct.sqlite3_vfs*, i8*)* }
%struct.sqlite3_file = type { %struct.sqlite3_io_methods* }
%struct.sqlite3_io_methods = type { i32, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i8*, i32, i64)*, i32 (%struct.sqlite3_file*, i8*, i32, i64)*, i32 (%struct.sqlite3_file*, i64)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i64*)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i32*)*, i32 (%struct.sqlite3_file*, i32, i8*)*, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i32, i32, i32, i8**)*, i32 (%struct.sqlite3_file*, i32, i32, i32)*, void (%struct.sqlite3_file*)*, i32 (%struct.sqlite3_file*, i32)*, i32 (%struct.sqlite3_file*, i64, i32, i8**)*, i32 (%struct.sqlite3_file*, i64, i8*)* }
%struct.sqlite3_backup = type opaque
%struct.SEXPREC = type opaque

@sqlite3_api = internal unnamed_addr global %struct.sqlite3_api_routines* null, align 8
@.str = private unnamed_addr constant [19 x i8] c"sqlite3_api %p %p\0A\00", align 1
@R_NilValue = external local_unnamed_addr global %struct.SEXPREC*, align 8
@.str.1 = private unnamed_addr constant [21 x i8] c"in sqlite3_fib_init\0A\00", align 1

; Function Attrs: nounwind readnone ssp uwtable
define i32 @fib2(i32) local_unnamed_addr #0 {
  %2 = icmp slt i32 %0, 2
  br i1 %2, label %9, label %3

; <label>:3:                                      ; preds = %1
  %4 = add nsw i32 %0, -1
  %5 = tail call i32 @fib2(i32 %4)
  %6 = add nsw i32 %0, -2
  %7 = tail call i32 @fib2(i32 %6)
  %8 = add nsw i32 %7, %5
  ret i32 %8

; <label>:9:                                      ; preds = %1
  ret i32 %0
}

; Function Attrs: nounwind ssp uwtable
define void @sqlFib3(%struct.sqlite3_context*, i32, %struct.Mem** nocapture readonly) local_unnamed_addr #1 {
  %4 = load %struct.sqlite3_api_routines*, %struct.sqlite3_api_routines** @sqlite3_api, align 8, !tbaa !2
  %5 = getelementptr inbounds %struct.sqlite3_api_routines, %struct.sqlite3_api_routines* %4, i64 0, i32 106
  %6 = load i32 (%struct.Mem*)*, i32 (%struct.Mem*)** %5, align 8, !tbaa !6
  %7 = load %struct.Mem*, %struct.Mem** %2, align 8, !tbaa !2
  %8 = tail call i32 %6(%struct.Mem* %7) #3
  %9 = tail call i32 @fib2(i32 %8)
  %10 = load %struct.sqlite3_api_routines*, %struct.sqlite3_api_routines** @sqlite3_api, align 8, !tbaa !2
  %11 = getelementptr inbounds %struct.sqlite3_api_routines, %struct.sqlite3_api_routines* %10, i64 0, i32 82
  %12 = load void (%struct.sqlite3_context*, i32)*, void (%struct.sqlite3_context*, i32)** %11, align 8, !tbaa !8
  tail call void %12(%struct.sqlite3_context* %0, i32 %9) #3
  ret void
}

; Function Attrs: nounwind ssp uwtable
define void @sqlTen(%struct.sqlite3_context*, i32, %struct.Mem** nocapture readnone) local_unnamed_addr #1 {
  %4 = load %struct.sqlite3_api_routines*, %struct.sqlite3_api_routines** @sqlite3_api, align 8, !tbaa !2
  %5 = getelementptr inbounds %struct.sqlite3_api_routines, %struct.sqlite3_api_routines* %4, i64 0, i32 106
  %6 = load i32 (%struct.Mem*)*, i32 (%struct.Mem*)** %5, align 8, !tbaa !6
  tail call void (i8*, ...) @Rprintf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0), %struct.sqlite3_api_routines* %4, i32 (%struct.Mem*)* %6) #3
  %7 = load %struct.sqlite3_api_routines*, %struct.sqlite3_api_routines** @sqlite3_api, align 8, !tbaa !2
  %8 = getelementptr inbounds %struct.sqlite3_api_routines, %struct.sqlite3_api_routines* %7, i64 0, i32 82
  %9 = load void (%struct.sqlite3_context*, i32)*, void (%struct.sqlite3_context*, i32)** %8, align 8, !tbaa !8
  tail call void %9(%struct.sqlite3_context* %0, i32 10) #3
  ret void
}

declare void @Rprintf(i8*, ...) local_unnamed_addr #2

; Function Attrs: nounwind ssp uwtable
define %struct.SEXPREC* @R_setSQLite3API(%struct.SEXPREC*) local_unnamed_addr #1 {
  %2 = tail call i8* @R_ExternalPtrAddr(%struct.SEXPREC* %0) #3
  store i8* %2, i8** bitcast (%struct.sqlite3_api_routines** @sqlite3_api to i8**), align 8, !tbaa !2
  %3 = load %struct.SEXPREC*, %struct.SEXPREC** @R_NilValue, align 8, !tbaa !2
  ret %struct.SEXPREC* %3
}

declare i8* @R_ExternalPtrAddr(%struct.SEXPREC*) local_unnamed_addr #2

; Function Attrs: nounwind ssp uwtable
define %struct.SEXPREC* @R_getSQLite3API() local_unnamed_addr #1 {
  %1 = load i8*, i8** bitcast (%struct.sqlite3_api_routines** @sqlite3_api to i8**), align 8, !tbaa !2
  %2 = load %struct.SEXPREC*, %struct.SEXPREC** @R_NilValue, align 8, !tbaa !2
  %3 = tail call %struct.SEXPREC* @R_MakeExternalPtr(i8* %1, %struct.SEXPREC* %2, %struct.SEXPREC* %2) #3
  ret %struct.SEXPREC* %3
}

declare %struct.SEXPREC* @R_MakeExternalPtr(i8*, %struct.SEXPREC*, %struct.SEXPREC*) local_unnamed_addr #2

; Function Attrs: nounwind ssp uwtable
define i32 @sqlite3_fib_init(%struct.sqlite3* nocapture readnone, i8** nocapture readnone, %struct.sqlite3_api_routines*) local_unnamed_addr #1 {
  tail call void (i8*, ...) @Rprintf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0)) #3
  store %struct.sqlite3_api_routines* %2, %struct.sqlite3_api_routines** @sqlite3_api, align 8, !tbaa !2
  ret i32 0
}

attributes #0 = { nounwind readnone ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind ssp uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="core2" "target-features"="+cx16,+fxsr,+mmx,+sse,+sse2,+sse3,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"PIC Level", i32 2}
!1 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!7, !3, i64 848}
!7 = !{!"sqlite3_api_routines", !3, i64 0, !3, i64 8, !3, i64 16, !3, i64 24, !3, i64 32, !3, i64 40, !3, i64 48, !3, i64 56, !3, i64 64, !3, i64 72, !3, i64 80, !3, i64 88, !3, i64 96, !3, i64 104, !3, i64 112, !3, i64 120, !3, i64 128, !3, i64 136, !3, i64 144, !3, i64 152, !3, i64 160, !3, i64 168, !3, i64 176, !3, i64 184, !3, i64 192, !3, i64 200, !3, i64 208, !3, i64 216, !3, i64 224, !3, i64 232, !3, i64 240, !3, i64 248, !3, i64 256, !3, i64 264, !3, i64 272, !3, i64 280, !3, i64 288, !3, i64 296, !3, i64 304, !3, i64 312, !3, i64 320, !3, i64 328, !3, i64 336, !3, i64 344, !3, i64 352, !3, i64 360, !3, i64 368, !3, i64 376, !3, i64 384, !3, i64 392, !3, i64 400, !3, i64 408, !3, i64 416, !3, i64 424, !3, i64 432, !3, i64 440, !3, i64 448, !3, i64 456, !3, i64 464, !3, i64 472, !3, i64 480, !3, i64 488, !3, i64 496, !3, i64 504, !3, i64 512, !3, i64 520, !3, i64 528, !3, i64 536, !3, i64 544, !3, i64 552, !3, i64 560, !3, i64 568, !3, i64 576, !3, i64 584, !3, i64 592, !3, i64 600, !3, i64 608, !3, i64 616, !3, i64 624, !3, i64 632, !3, i64 640, !3, i64 648, !3, i64 656, !3, i64 664, !3, i64 672, !3, i64 680, !3, i64 688, !3, i64 696, !3, i64 704, !3, i64 712, !3, i64 720, !3, i64 728, !3, i64 736, !3, i64 744, !3, i64 752, !3, i64 760, !3, i64 768, !3, i64 776, !3, i64 784, !3, i64 792, !3, i64 800, !3, i64 808, !3, i64 816, !3, i64 824, !3, i64 832, !3, i64 840, !3, i64 848, !3, i64 856, !3, i64 864, !3, i64 872, !3, i64 880, !3, i64 888, !3, i64 896, !3, i64 904, !3, i64 912, !3, i64 920, !3, i64 928, !3, i64 936, !3, i64 944, !3, i64 952, !3, i64 960, !3, i64 968, !3, i64 976, !3, i64 984, !3, i64 992, !3, i64 1000, !3, i64 1008, !3, i64 1016, !3, i64 1024, !3, i64 1032, !3, i64 1040, !3, i64 1048, !3, i64 1056, !3, i64 1064, !3, i64 1072, !3, i64 1080, !3, i64 1088, !3, i64 1096, !3, i64 1104, !3, i64 1112, !3, i64 1120, !3, i64 1128, !3, i64 1136, !3, i64 1144, !3, i64 1152, !3, i64 1160, !3, i64 1168, !3, i64 1176, !3, i64 1184, !3, i64 1192, !3, i64 1200, !3, i64 1208, !3, i64 1216, !3, i64 1224, !3, i64 1232, !3, i64 1240, !3, i64 1248, !3, i64 1256, !3, i64 1264, !3, i64 1272, !3, i64 1280, !3, i64 1288, !3, i64 1296, !3, i64 1304, !3, i64 1312, !3, i64 1320, !3, i64 1328, !3, i64 1336, !3, i64 1344, !3, i64 1352, !3, i64 1360, !3, i64 1368, !3, i64 1376, !3, i64 1384, !3, i64 1392, !3, i64 1400, !3, i64 1408, !3, i64 1416, !3, i64 1424, !3, i64 1432, !3, i64 1440, !3, i64 1448, !3, i64 1456, !3, i64 1464, !3, i64 1472, !3, i64 1480, !3, i64 1488, !3, i64 1496, !3, i64 1504, !3, i64 1512, !3, i64 1520, !3, i64 1528, !3, i64 1536, !3, i64 1544, !3, i64 1552, !3, i64 1560, !3, i64 1568, !3, i64 1576, !3, i64 1584, !3, i64 1592, !3, i64 1600, !3, i64 1608, !3, i64 1616, !3, i64 1624}
!8 = !{!7, !3, i64 656}
