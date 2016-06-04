//
// MATLAB Compiler: 6.2 (R2016a)
// Date: Wed Jan 04 20:29:02 2017
// Arguments: "-B" "macro_default" "-W" "cpplib:libMCCR" "-T" "link:lib" "-d"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\libMCCR\for_testing" "-v"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\CV_Dim.m"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\libMCCR_test.m"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\libMCCR_train.m" 
//

#ifndef __libMCCR_h
#define __libMCCR_h 1

#if defined(__cplusplus) && !defined(mclmcrrt_h) && defined(__linux__)
#  pragma implementation "mclmcrrt.h"
#endif
#include "mclmcrrt.h"
#include "mclcppclass.h"
#ifdef __cplusplus
extern "C" {
#endif

#if defined(__SUNPRO_CC)
/* Solaris shared libraries use __global, rather than mapfiles
 * to define the API exported from a shared library. __global is
 * only necessary when building the library -- files including
 * this header file to use the library do not need the __global
 * declaration; hence the EXPORTING_<library> logic.
 */

#ifdef EXPORTING_libMCCR
#define PUBLIC_libMCCR_C_API __global
#else
#define PUBLIC_libMCCR_C_API /* No import statement needed. */
#endif

#define LIB_libMCCR_C_API PUBLIC_libMCCR_C_API

#elif defined(_HPUX_SOURCE)

#ifdef EXPORTING_libMCCR
#define PUBLIC_libMCCR_C_API __declspec(dllexport)
#else
#define PUBLIC_libMCCR_C_API __declspec(dllimport)
#endif

#define LIB_libMCCR_C_API PUBLIC_libMCCR_C_API


#else

#define LIB_libMCCR_C_API

#endif

/* This symbol is defined in shared libraries. Define it here
 * (to nothing) in case this isn't a shared library. 
 */
#ifndef LIB_libMCCR_C_API 
#define LIB_libMCCR_C_API /* No special import/export declaration */
#endif

extern LIB_libMCCR_C_API 
bool MW_CALL_CONV libMCCRInitializeWithHandlers(
       mclOutputHandlerFcn error_handler, 
       mclOutputHandlerFcn print_handler);

extern LIB_libMCCR_C_API 
bool MW_CALL_CONV libMCCRInitialize(void);

extern LIB_libMCCR_C_API 
void MW_CALL_CONV libMCCRTerminate(void);



extern LIB_libMCCR_C_API 
void MW_CALL_CONV libMCCRPrintStackTrace(void);

extern LIB_libMCCR_C_API 
bool MW_CALL_CONV mlxCV_Dim(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);

extern LIB_libMCCR_C_API 
bool MW_CALL_CONV mlxLibMCCR_test(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);

extern LIB_libMCCR_C_API 
bool MW_CALL_CONV mlxLibMCCR_train(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);


#ifdef __cplusplus
}
#endif

#ifdef __cplusplus

/* On Windows, use __declspec to control the exported API */
#if defined(_MSC_VER) || defined(__BORLANDC__)

#ifdef EXPORTING_libMCCR
#define PUBLIC_libMCCR_CPP_API __declspec(dllexport)
#else
#define PUBLIC_libMCCR_CPP_API __declspec(dllimport)
#endif

#define LIB_libMCCR_CPP_API PUBLIC_libMCCR_CPP_API

#else

#if !defined(LIB_libMCCR_CPP_API)
#if defined(LIB_libMCCR_C_API)
#define LIB_libMCCR_CPP_API LIB_libMCCR_C_API
#else
#define LIB_libMCCR_CPP_API /* empty! */ 
#endif
#endif

#endif

extern LIB_libMCCR_CPP_API void MW_CALL_CONV CV_Dim(int nargout, mwArray& opt_dim, const mwArray& Labeled, const mwArray& Unlabeled, const mwArray& Group, const mwArray& Method, const mwArray& update_times, const mwArray& cv);

extern LIB_libMCCR_CPP_API void MW_CALL_CONV libMCCR_test(int nargout, mwArray& PredictY, const mwArray& TestX, const mwArray& model);

extern LIB_libMCCR_CPP_API void MW_CALL_CONV libMCCR_train(int nargout, mwArray& model, const mwArray& Labeled, const mwArray& Unlabeled, const mwArray& Group, const mwArray& Method, const mwArray& nDim, const mwArray& update_times);

#endif
#endif
