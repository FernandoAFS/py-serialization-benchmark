from libc.stdint cimport *
from libc.string cimport *
from cpython.ref cimport PyObject

from pyrobuf_list cimport *
from pyrobuf_util cimport *

import json

cdef class Case:


    cdef int32_t _a
    cpdef _a__reset(self)
    cdef int32_t _b
    cpdef _b__reset(self)
    cdef float _c
    cpdef _c__reset(self)
    cdef float _d
    cpdef _d__reset(self)
    cdef str _e
    cpdef _e__reset(self)
    cdef str _f
    cpdef _f__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, Case other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, Case other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)

cdef class CaseList:


    cdef TypedList _cases
    cpdef _cases__reset(self)


    cdef uint64_t __field_bitmap0

    cdef public bint _is_present_in_parent
    cdef bytes _cached_serialization

    cdef object _listener

    cpdef void reset(self)

    cpdef void Clear(self)
    cpdef void ClearField(self, field_name)
    cpdef void CopyFrom(self, CaseList other_msg)
    cpdef bint HasField(self, field_name) except -1
    cpdef bint IsInitialized(self)
    cpdef void MergeFrom(self, CaseList other_msg)
    cpdef int MergeFromString(self, data, size=*) except -1
    cpdef int ParseFromString(self, data, size=*, bint reset=*, bint cache=*) except -1
    cpdef bytes SerializeToString(self, bint cache=*)
    cpdef bytes SerializePartialToString(self)

    cdef void _clearfield(self, field_name)
    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache)

    cdef void _protobuf_serialize(self, bytearray buf, bint cache)

    cpdef void _Modified(self)