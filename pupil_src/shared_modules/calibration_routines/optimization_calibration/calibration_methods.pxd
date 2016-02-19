
'''
(*)~----------------------------------------------------------------------------------
 Pupil - eye tracking platform
 Copyright (C) 2012-2016  Pupil Labs

 Distributed under the terms of the GNU Lesser General Public License (LGPL v3.0).
 License details are in the file license.txt, distributed as part of this software.
----------------------------------------------------------------------------------~(*)
'''
from libcpp.vector cimport vector

cdef extern from '<Eigen/Eigen>' namespace 'Eigen':
    cdef cppclass Matrix21d "Eigen::Matrix<double,2,1>": # eigen defaults to column major layout
        Matrix21d() except +
        double * data()
        double& operator[](size_t)

    cdef cppclass Matrix31d "Eigen::Matrix<double,3,1>": # eigen defaults to column major layout
        Matrix31d() except +
        Matrix31d(double x, double y, double z)
        double * data()
        double& operator[](size_t)
        bint isZero()

    cdef cppclass Matrix4d "Eigen::Matrix<double,4,4>": # eigen defaults to column major layout
        Matrix4d() except +
        double& operator()(size_t,size_t)

cdef extern from 'common.h':

    #typdefs
    ctypedef Matrix31d Vector3
    ctypedef Matrix21d Vector2


cdef extern from '<opencv2/core.hpp>' namespace 'cv':

  cdef cppclass Point3_[T]:
    Point3_() except +
    Point3_(T _x, T _y, T _z) except +

  ctypedef Point3_[double] Point3d;



cdef extern from 'pointLineCalibration.h':


    bint pointLineCalibration( Vector3 spherePosition,const vector[Vector3]& points,const vector[Vector3]& lines,  double[4]& orientation ,
                                 double[3]& translation, bint fixTranslation,
                                 Vector3 translationLowerBound, Vector3 translationUpperBound  )

cdef extern from 'lineLineCalibration.h':

    bint lineLineCalibration( Vector3 spherePosition,const vector[Vector3]& refDirections,const vector[Vector3]& gazeDirections,  double[4]& orientation ,
                                 double[3]& translation, bint fixTranslation,
                                 Vector3 translationLowerBound, Vector3 translationUpperBound  )

cdef extern from 'fivePointAlgoCalibration.h':

    bint fivePointAlgoCalibration( Vector3 spherePosition,const vector[Point3d]& refDirections,const vector[Point3d]& gazeDirections,  double[4]& orientation ,
                                 double[3]& translation, bint fixTranslation,
                                 Vector3 translationLowerBound, Vector3 translationUpperBound  )
