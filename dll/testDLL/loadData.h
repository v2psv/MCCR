//
// MATLAB Compiler: 6.2 (R2016a)
// Date: Mon Jan 02 22:33:13 2017
// Arguments: "-B" "macro_default" "-W" "cpplib:loadData" "-T" "link:lib" "-d"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\loadData\for_testing" "-v"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\calPerformance.m"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\loadData.m"
// "C:\Users\QiZhou\Desktop\MCCR_new\Utility\SplitData.m" 
//

#ifndef __loadData_h
#define __loadData_h 1

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

#ifdef EXPORTING_loadData
#define PUBLIC_loadData_C_API __global
#else
#define PUBLIC_loadData_C_API /* No import statement needed. */
#endif

#define LIB_loadData_C_API PUBLIC_loadData_C_API

#elif defined(_HPUX_SOURCE)

#ifdef EXPORTING_loadData
#define PUBLIC_loadData_C_API __declspec(dllexport)
#else
#define PUBLIC_loadData_C_API __declspec(dllimport)
#endif

#define LIB_loadData_C_API PUBLIC_loadData_C_API


#else

#define LIB_loadData_C_API

#endif

/* This symbol is defined in shared libraries. Define it here
 * (to nothing) in case this isn't a shared library. 
 */
#ifndef LIB_loadData_C_API 
#define LIB_loadData_C_API /* No special import/export declaration */
#endif

extern LIB_loadData_C_API 
bool MW_CALL_CONV loadDataInitializeWithHandlers(
       mclOutputHandlerFcn error_handler, 
       mclOutputHandlerFcn print_handler);

extern LIB_loadData_C_API 
bool MW_CALL_CONV loadDataInitialize(void);

extern LIB_loadData_C_API 
void MW_CALL_CONV loadDataTerminate(void);



extern LIB_loadData_C_API 
void MW_CALL_CONV loadDataPrintStackTrace(void);

extern LIB_loadData_C_API 
bool MW_CALL_CONV mlxCalPerformance(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);

extern LIB_loadData_C_API 
bool MW_CALL_CONV mlxLoadData(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);

extern LIB_loadData_C_API 
bool MW_CALL_CONV mlxSplitData(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]);


#ifdef __cplusplus
}
#endif

#ifdef __cplusplus

/* On Windows, use __declspec to control the exported API */
#if defined(_MSC_VER) || defined(__BORLANDC__)

#ifdef EXPORTING_loadData
#define PUBLIC_loadData_CPP_API __declspec(dllexport)
#else
#define PUBLIC_loadData_CPP_API __declspec(dllimport)
#endif

#define LIB_loadData_CPP_API PUBLIC_loadData_CPP_API

#else

#if !defined(LIB_loadData_CPP_API)
#if defined(LIB_loadData_C_API)
#define LIB_loadData_CPP_API LIB_loadData_C_API
#else
#define LIB_loadData_CPP_API /* empty! */ 
#endif
#endif

#endif

extern LIB_loadData_CPP_API void MW_CALL_CONV calPerformance(const mwArray& PredictY, const mwArray& TestY);

extern LIB_loadData_CPP_API void MW_CALL_CONV loadData(int nargout, mwArray& data, const mwArray& dataset);

extern LIB_loadData_CPP_API void MW_CALL_CONV SplitData(int nargout, mwArray& Train, mwArray& TestX, mwArray& TestY, mwArray& Labeled, mwArray& Unlabeled, mwArray& Group, const mwArray& Data, const mwArray& nTrain, const mwArray& nTest, const mwArray& nLabel, const mwArray& nUnlabel);

#endif
#endif
