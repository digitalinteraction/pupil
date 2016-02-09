'''
(*)~----------------------------------------------------------------------------------
 Pupil - eye tracking platform
 Copyright (C) 2012-2016  Pupil Labs

 Distributed under the terms of the GNU Lesser General Public License (LGPL v3.0).
 License details are in the file license.txt, distributed as part of this software.
----------------------------------------------------------------------------------~(*)
'''

from libcpp.vector cimport vector

cimport calibration_methods
from calibration_methods cimport *
import numpy as np

def point_line_calibration( sphere_position, ref_points_3D, gaze_directions_3D , initial_orientation , initial_translation ):


    cdef vector[Vector3] cpp_ref_points
    cdef vector[Vector3] cpp_gaze_directions
    for p in ref_points_3D:
        cpp_ref_points.push_back(Vector3(p[0],p[1],p[2]))

    for p in gaze_directions_3D:
        cpp_gaze_directions.push_back(Vector3(p[0],p[1],p[2]))

    cdef Vector3 cpp_sphere_position
    cpp_sphere_position = Vector3(sphere_position[0],sphere_position[1],sphere_position[2])

    cdef double cpp_orientation[4] #quaternion
    cdef double cpp_translation[3]
    cpp_orientation[:] = initial_orientation
    cpp_translation[:] = initial_translation

    ## optimized values are written to cpp_orientation and cpp_translation
    cdef bint success  = pointLineCalibration(cpp_sphere_position, cpp_ref_points , cpp_gaze_directions , &cpp_orientation[0], &cpp_translation[0])


    return success, cpp_orientation, cpp_translation