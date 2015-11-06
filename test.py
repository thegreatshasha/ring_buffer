from cython_wrapper import cythonloop, pythonloop, Amaterasu
import timeit

print "Python Loop: %f" % timeit.timeit(pythonloop, number=5)
print "Cython Loop: %f" % timeit.timeit(cythonloop, number=5)
import pdb; pdb.set_trace()