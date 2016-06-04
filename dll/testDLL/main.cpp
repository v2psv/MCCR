#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include "mat.h"
#include "stdafx.h"
using namespace std;


int main()
{
	// initialization
	mclmcrInitialize();
	if (!mclInitializeApplication(NULL, 0))
	{
		std::cerr << "could not initiallize the application properly" << std::endl;
		return -1;
	}
	if (!libMCCRInitialize() || !loadDataInitialize())
	{
		std::cerr << "could not initiallize the library properly" << std::endl;
		return -1;
	}

	try
	{
		int N_train = 513;
		int N_label = 13;
		int N_unlabel = N_train - N_label;
		int N_test = 1000;
		int N_cv = 5;
		int N_iter = 4;

		// create inputs and outputs array
		mwArray dataset("SiHT.mat");
		mwArray Method("GMCCR"); // GCCA, MCCR, GMCCR
		mwArray nTrain(1, 1, mxDOUBLE_CLASS, mxREAL);
		mwArray nTest(1, 1, mxDOUBLE_CLASS, mxREAL);
		mwArray nLabel(1, 1, mxDOUBLE_CLASS, mxREAL);
		mwArray nUnlabel(1, 1, mxDOUBLE_CLASS, mxREAL);
		mwArray cv(1, 1, mxDOUBLE_CLASS, mxREAL);
		mwArray CoIter(1, 1, mxDOUBLE_CLASS, mxREAL);
		mwArray opt_dim(1, 1, mxDOUBLE_CLASS, mxREAL);
		
		const char* fields1[] = {"X", "Y"};
		const char* fields2[] = {"Beta", "Wx", "Wy", "PCAMapping"};

		mwArray Data(1, 1, 2, fields1);
		mwArray Train(1, 1, 2, fields1);
		mwArray Labeled(1, 1, 2, fields1);
		mwArray Unlabeled(1, 1, 2, fields1);
		mwArray Group(1, 1, 2, fields1);
		mwArray model(1, 1, 4, fields2);
		mwArray TestX(N_test, 142, mxDOUBLE_CLASS, mxREAL);
		mwArray TestY(N_test, 1, mxDOUBLE_CLASS, mxREAL);
		mwArray predictY(N_test, 1, mxDOUBLE_CLASS, mxREAL);

		// initialize data
		cv.SetData(&N_cv, 1);
		CoIter.SetData(&N_iter, 1);
		nTrain.SetData(&N_train, 1);
		nTest.SetData(&N_test, 1);
		nLabel.SetData(&N_label, 1);
		nUnlabel .SetData(&N_unlabel, 1);

		printf("start\n");
		loadData(1, Data, dataset);
		for (int i = 0; i < 20; i++)
		{
			SplitData(6, Train, TestX, TestY, Labeled, Unlabeled, Group, Data, nTrain, nTest, nLabel, nUnlabel);
			CV_Dim(1, opt_dim, Labeled, Unlabeled, Group, Method, CoIter, cv); // cross validation
			libMCCR_train(1, model, Labeled, Unlabeled, Group, Method, opt_dim, CoIter); // training
			libMCCR_test(1, predictY, TestX, model); // testing
			calPerformance(predictY, TestY);
		}
	}
	catch (const mwException &e)
	{
		std::cerr << e.what() << std::endl;
		e.check_raise_error();
		return -2;
	}

	// termination
	libMCCRTerminate();
	loadDataTerminate();
	mclTerminateApplication();
	return 0;
}