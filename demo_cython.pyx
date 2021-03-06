"""
Fast Johnson-Lindenstrauss Transform (FJLT)

http://people.inf.ethz.ch/kgabriel/software.html
"""


import numpy as np
cimport numpy as np
from fjlt.SubsampledRandomizedFourrierTransform1d cimport SubsampledRandomizedFourrierTransform1d
from fjlt.SubsampledRandomizedFourrierTransform1d import SubsampledRandomizedFourrierTransform1d

def demo_cython():
    cdef int d=1000
    cdef int k=d#int(np.sqrt(d)+1)
    cdef np.ndarray[double, ndim=1] x = np.random.randn(d) *13 +4
    cdef SubsampledRandomizedFourrierTransform1d srft = SubsampledRandomizedFourrierTransform1d(k, 'demo_wisdom'.encode())
    cdef np.ndarray[double, ndim=1] y
    cdef np.ndarray[double, ndim=1] z
    srft.fit(x)
    y = srft.transform(x)
    z = srft.inverse_transform(y)

    print 'cython demo:'
    print np.mean(np.abs(z-x))
    
    print np.linalg.norm(x-z)/np.sqrt(d)
    
    print np.linalg.norm(x), np.linalg.norm(y), np.linalg.norm(z)