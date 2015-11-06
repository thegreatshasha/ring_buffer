from numpy import ndarray
import numpy as np
from collections import deque
import timeit

class RingBuffer():

    def __init__(self, shape, dtype=np.int):
        self.shape = shape
        self.size = self.shape[0]
        self.top = 0
        self.bottom = 0
        self.data = np.empty(shape=self.shape, dtype=dtype)
        self.length = 0

    #@profile
    def append(self, element):
        """ Overwrites the oldest element with """
        self.data[self.top] = element

        """ Increment the size """
        self.length = min(self.length + 1, self.size)
        
        """ Update the top n bottom indexes """
        self.top = (self.top + 1) % self.size
        if self.top == self.bottom:
            self.bottom = (self.top + 1) % (self.size - 1)

        #print (self.data, self.bottom, self.top, self.length)

    #@profile
    def pop(self):
        """ Decrement the size """
        if self.length:
            self.length = min(self.length - 1, self.size)
        else:
            raise AssertionError("Nothing to pop!")

        """ Returns the topmost element """
        top = self.data[self.top-1]
        
        """ Reduce the top index """
        self.top = (self.top -1) % self.size

        #print (self.data, self.bottom, self.top, self.length)
        return top

# rb = RingBuffer(5)
# rb.push(1)
# rb.push(2)
# rb.push(3)
# rb.push(4)
# rb.push(5)
# import pdb; pdb.set_trace()

# """ Some tests """
# rb.push(6)
# rb.push(7)
# rb.push(8)

# rb.pop()
# rb.pop()
# rb.pop()
# rb.pop()
# rb.pop()
#@profile

def buffer_test(buffer, size, item):
    #size = 10
    """ Some performance tests. Insert an item lots of times """
    #buffer = deque(maxlen=size)
    
    """ do 1000 pushes and 1000 pops """
    for i in xrange(size):
        buffer.append(item)
        #buffer.append([1,2,3]*1000)

    for i in xrange(size):
        buffer.pop()

def ring_buffer_test():
    size = 10000
    item = np.ones(shape=(1000,1))
    rb = RingBuffer(shape=(size,1000, 1))
    buffer_test(rb, size, item)

def dequeue_test():
    size = 10000
    item = np.ones(shape=(1000,1))
    """ Some performance tests. Compared with python queue """
    buffer = deque(maxlen=size)

    #zeta = np.array(buffer)

    buffer_test(buffer, size, item)

#timeit ringbuff_deque_test()
#import pdb; pdb.set_trace()
print "Ring buffer: %f" % timeit.timeit(ring_buffer_test, number=10)
print "Dequeue: %f" % timeit.timeit(dequeue_test, number=10)