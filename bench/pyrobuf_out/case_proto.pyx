from libc.stdint cimport *
from libc.string cimport *

from pyrobuf_list cimport *
from pyrobuf_util cimport *

import base64
import json
import warnings

class DecodeError(Exception):
    pass

cdef class Case:

    def __cinit__(self):
        self._listener = noop_listener

    

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = [
                          'a',
                          'b',
                          'c',
                          'd',
                          'e',
                          'f',]
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = []
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _a__reset(self):
        self._a = 0
        self.__field_bitmap0 &= ~1
    cpdef _b__reset(self):
        self._b = 0
        self.__field_bitmap0 &= ~2
    cpdef _c__reset(self):
        self._c = 0
        self.__field_bitmap0 &= ~4
    cpdef _d__reset(self):
        self._d = 0
        self.__field_bitmap0 &= ~8
    cpdef _e__reset(self):
        self._e = ""
        self.__field_bitmap0 &= ~16
    cpdef _f__reset(self):
        self._f = ""
        self.__field_bitmap0 &= ~32

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._a__reset()
        self._b__reset()
        self._c__reset()
        self._d__reset()
        self._e__reset()
        self._f__reset()
        return

    
    @property
    def a(self):
        return self._a

    @a.setter
    def a(self, value):
        self.__field_bitmap0 |= 1
        self._a = value
        self._Modified()
    
    @property
    def b(self):
        return self._b

    @b.setter
    def b(self, value):
        self.__field_bitmap0 |= 2
        self._b = value
        self._Modified()
    
    @property
    def c(self):
        return self._c

    @c.setter
    def c(self, value):
        self.__field_bitmap0 |= 4
        self._c = value
        self._Modified()
    
    @property
    def d(self):
        return self._d

    @d.setter
    def d(self, value):
        self.__field_bitmap0 |= 8
        self._d = value
        self._Modified()
    
    @property
    def e(self):
        return self._e

    @e.setter
    def e(self, value):
        self.__field_bitmap0 |= 16
        if isinstance(value, bytes):
            self._e = value.decode('utf-8')
        elif isinstance(value, str):
            self._e = value
        else:
            raise TypeError("%r has type %s, but expected one of: (%s, %s)" % (value, type(value), bytes, str))
        self._Modified()
    
    @property
    def f(self):
        return self._f

    @f.setter
    def f(self, value):
        self.__field_bitmap0 |= 32
        if isinstance(value, bytes):
            self._f = value.decode('utf-8')
        elif isinstance(value, str):
            self._f = value
        else:
            raise TypeError("%r has type %s, but expected one of: (%s, %s)" % (value, type(value), bytes, str))
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        cdef int64_t field_size
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # a
            if key == 8:
                self.__field_bitmap0 |= 1
                self._a = get_varint32(memory, &current_offset)
            # b
            elif key == 16:
                self.__field_bitmap0 |= 2
                self._b = get_varint32(memory, &current_offset)
            # c
            elif key == 29:
                self.__field_bitmap0 |= 4
                self._c = (<float *>&memory[current_offset])[0]
                current_offset += sizeof(float)
            # d
            elif key == 37:
                self.__field_bitmap0 |= 8
                self._d = (<float *>&memory[current_offset])[0]
                current_offset += sizeof(float)
            # e
            elif key == 42:
                self.__field_bitmap0 |= 16
                field_size = get_varint64(memory, &current_offset)
                self._e = str(memory[current_offset:current_offset + field_size], 'utf-8')
                current_offset += <int>field_size
            # f
            elif key == 50:
                self.__field_bitmap0 |= 32
                field_size = get_varint64(memory, &current_offset)
                self._f = str(memory[current_offset:current_offset + field_size], 'utf-8')
                current_offset += <int>field_size
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'a':
            self._a__reset()
        elif field_name == 'b':
            self._b__reset()
        elif field_name == 'c':
            self._c__reset()
        elif field_name == 'd':
            self._d__reset()
        elif field_name == 'e':
            self._e__reset()
        elif field_name == 'f':
            self._f__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, Case other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (Case): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        if field_name == 'a':
            return self.__field_bitmap0 & 1 == 1
        if field_name == 'b':
            return self.__field_bitmap0 & 2 == 2
        if field_name == 'c':
            return self.__field_bitmap0 & 4 == 4
        if field_name == 'd':
            return self.__field_bitmap0 & 8 == 8
        if field_name == 'e':
            return self.__field_bitmap0 & 16 == 16
        if field_name == 'f':
            return self.__field_bitmap0 & 32 == 32
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """

    
        if self.__field_bitmap0 & 1 != 1:
            return False
        if self.__field_bitmap0 & 2 != 2:
            return False
        if self.__field_bitmap0 & 4 != 4:
            return False
        if self.__field_bitmap0 & 8 != 8:
            return False
        if self.__field_bitmap0 & 16 != 16:
            return False
        if self.__field_bitmap0 & 32 != 32:
            return False

        return True

    cpdef void MergeFrom(self, Case other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """

        if self is other_msg:
            return

    
        if other_msg.__field_bitmap0 & 1 == 1:
            self._a = other_msg._a
            self.__field_bitmap0 |= 1
        if other_msg.__field_bitmap0 & 2 == 2:
            self._b = other_msg._b
            self.__field_bitmap0 |= 2
        if other_msg.__field_bitmap0 & 4 == 4:
            self._c = other_msg._c
            self.__field_bitmap0 |= 4
        if other_msg.__field_bitmap0 & 8 == 8:
            self._d = other_msg._d
            self.__field_bitmap0 |= 8
        if other_msg.__field_bitmap0 & 16 == 16:
            self._e = other_msg._e
            self.__field_bitmap0 |= 16
        if other_msg.__field_bitmap0 & 32 == 32:
            self._f = other_msg._f
            self.__field_bitmap0 |= 32

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        # a
        if self.__field_bitmap0 & 1 == 1:
            set_varint64(8, buf)
            set_varint32(self._a, buf)
        # b
        if self.__field_bitmap0 & 2 == 2:
            set_varint64(16, buf)
            set_varint32(self._b, buf)
        # c
        if self.__field_bitmap0 & 4 == 4:
            set_varint64(29, buf)
            buf += (<unsigned char *>&self._c)[:sizeof(float)]
        # d
        if self.__field_bitmap0 & 8 == 8:
            set_varint64(37, buf)
            buf += (<unsigned char *>&self._d)[:sizeof(float)]
        # e
        cdef bytes e_bytes
        if self.__field_bitmap0 & 16 == 16:
            set_varint64(42, buf)
            e_bytes = self._e.encode('utf-8')
            set_varint64(len(e_bytes), buf)
            buf += e_bytes
        # f
        cdef bytes f_bytes
        if self.__field_bitmap0 & 32 == 32:
            set_varint64(50, buf)
            f_bytes = self._f.encode('utf-8')
            set_varint64(len(f_bytes), buf)
            buf += f_bytes

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """

    
        if self.__field_bitmap0 & 1 != 1:
            raise Exception("required field 'a' not initialized and does not have default")
        if self.__field_bitmap0 & 2 != 2:
            raise Exception("required field 'b' not initialized and does not have default")
        if self.__field_bitmap0 & 4 != 4:
            raise Exception("required field 'c' not initialized and does not have default")
        if self.__field_bitmap0 & 8 != 8:
            raise Exception("required field 'd' not initialized and does not have default")
        if self.__field_bitmap0 & 16 != 16:
            raise Exception("required field 'e' not initialized and does not have default")
        if self.__field_bitmap0 & 32 != 32:
            raise Exception("required field 'f' not initialized and does not have default")

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            self.a = d["a"]
        except KeyError:
            pass
        try:
            self.b = d["b"]
        except KeyError:
            pass
        try:
            self.c = d["c"]
        except KeyError:
            pass
        try:
            self.d = d["d"]
        except KeyError:
            pass
        try:
            self.e = d["e"]
        except KeyError:
            pass
        try:
            self.f = d["f"]
        except KeyError:
            pass

        self._Modified()
        if self.__field_bitmap0 & 1 != 1:
            raise Exception("required field 'a' not initialized and does not have default")
        if self.__field_bitmap0 & 2 != 2:
            raise Exception("required field 'b' not initialized and does not have default")
        if self.__field_bitmap0 & 4 != 4:
            raise Exception("required field 'c' not initialized and does not have default")
        if self.__field_bitmap0 & 8 != 8:
            raise Exception("required field 'd' not initialized and does not have default")
        if self.__field_bitmap0 & 16 != 16:
            raise Exception("required field 'e' not initialized and does not have default")
        if self.__field_bitmap0 & 32 != 32:
            raise Exception("required field 'f' not initialized and does not have default")

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if self.__field_bitmap0 & 1 != 1:
            raise Exception("required field 'a' not initialized and does not have default")
        if self.__field_bitmap0 & 2 != 2:
            raise Exception("required field 'b' not initialized and does not have default")
        if self.__field_bitmap0 & 4 != 4:
            raise Exception("required field 'c' not initialized and does not have default")
        if self.__field_bitmap0 & 8 != 8:
            raise Exception("required field 'd' not initialized and does not have default")
        if self.__field_bitmap0 & 16 != 16:
            raise Exception("required field 'e' not initialized and does not have default")
        if self.__field_bitmap0 & 32 != 32:
            raise Exception("required field 'f' not initialized and does not have default")
        if self.__field_bitmap0 & 1 == 1:
            out["a"] = self.a
        if self.__field_bitmap0 & 2 == 2:
            out["b"] = self.b
        if self.__field_bitmap0 & 4 == 4:
            out["c"] = self.c
        if self.__field_bitmap0 & 8 == 8:
            out["d"] = self.d
        if self.__field_bitmap0 & 16 == 16:
            out["e"] = self.e
        if self.__field_bitmap0 & 32 == 32:
            out["f"] = self.f

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if self.__field_bitmap0 & 1 == 1:
            out["a"] = self.a
        if self.__field_bitmap0 & 2 == 2:
            out["b"] = self.b
        if self.__field_bitmap0 & 4 == 4:
            out["c"] = self.c
        if self.__field_bitmap0 & 8 == 8:
            out["d"] = self.d
        if self.__field_bitmap0 & 16 == 16:
            out["e"] = self.e
        if self.__field_bitmap0 & 32 == 32:
            out["f"] = self.f

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'a', self.a
        yield 'b', self.b
        yield 'c', self.c
        yield 'd', self.d
        yield 'e', self.e
        yield 'f', self.f

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'a'
        yield 'b'
        yield 'c'
        yield 'd'
        yield 'e'
        yield 'f'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.a
        yield self.b
        yield self.c
        yield self.d
        yield self.e
        yield self.f

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.a = value
        yield setter
        def setter(value):
            self.b = value
        yield setter
        def setter(value):
            self.c = value
        yield setter
        def setter(value):
            self.d = value
        yield setter
        def setter(value):
            self.e = value
        yield setter
        def setter(value):
            self.f = value
        yield setter

    


cdef class CaseList:

    def __cinit__(self):
        self._listener = noop_listener

    def __dealloc__(self):
        # Remove any references to self from child messages or repeated fields
        if self._cases is not None:
            self._cases._listener = noop_listener

    def __init__(self, **kwargs):
        self.reset()
        if kwargs:
            for field_name, field_value in kwargs.items():
                try:
                    if field_name in ('cases',):
                        getattr(self, field_name).extend(field_value)
                    else:
                        setattr(self, field_name, field_value)
                except AttributeError:
                    raise ValueError('Protocol message has no "%s" field.' % (field_name,))
        return

    def __str__(self):
        fields = []
        components = ['{0}: {1}'.format(field, getattr(self, field)) for field in fields]
        messages = [
                            'cases',]
        for message in messages:
            components.append('{0}: {{'.format(message))
            for line in str(getattr(self, message)).split('\n'):
                components.append('  {0}'.format(line))
            components.append('}')
        return '\n'.join(components)

    
    cpdef _cases__reset(self):
        if self._cases is not None:
            self._cases._listener = noop_listener
        self._cases = TypedList.__new__(TypedList)
        self._cases._list_type = Case
        self._cases._listener = self._Modified

    cpdef void reset(self):
        # reset values and populate defaults
    
        self._cases__reset()
        return

    
    @property
    def cases(self):
        # lazy init sub messages
        if self._cases is None:
            self._cases = Case.__new__(Case)
            self._cases.reset()
            self._cases._listener = self._Modified
            self._listener()
        return self._cases

    @cases.setter
    def cases(self, value):
        if self._cases is not None:
            self._cases._listener = noop_listener
        self._cases = TypedList.__new__(TypedList)
        self._cases._list_type = Case
        self._cases._listener = self._Modified
        for val in value:
            list.append(self._cases, val)
        self._Modified()
    

    cdef int _protobuf_deserialize(self, const unsigned char *memory, int size, bint cache):
        cdef int current_offset = 0
        cdef int64_t key
        cdef int64_t field_size
        cdef Case cases_elt
        while current_offset < size:
            key = get_varint64(memory, &current_offset)
            # cases
            if key == 10:
                cases_elt = Case.__new__(Case)
                cases_elt.reset()
                field_size = get_varint64(memory, &current_offset)
                if cache:
                    cases_elt._cached_serialization = bytes(memory[current_offset:current_offset+field_size])
                current_offset += cases_elt._protobuf_deserialize(memory+current_offset, <int>field_size, cache)
                list.append(self._cases, cases_elt)
            # Unknown field - need to skip proper number of bytes
            else:
                assert skip_generic(memory, &current_offset, size, key & 0x7)

        self._is_present_in_parent = True

        return current_offset

    cpdef void Clear(self):
        """Clears all data that was set in the message."""
        self.reset()
        self._Modified()

    cpdef void ClearField(self, field_name):
        """Clears the contents of a given field."""
        self._clearfield(field_name)
        self._Modified()

    cdef void _clearfield(self, field_name):
        if field_name == 'cases':
            self._cases__reset()
        else:
            raise ValueError('Protocol message has no "%s" field.' % field_name)

    cpdef void CopyFrom(self, CaseList other_msg):
        """
        Copies the content of the specified message into the current message.

        Params:
            other_msg (CaseList): Message to copy into the current one.
        """
        if self is other_msg:
            return
        self.reset()
        self.MergeFrom(other_msg)

    cpdef bint HasField(self, field_name) except -1:
        """
        Checks if a certain field is set for the message.

        Params:
            field_name (str): The name of the field to check.
        """
        raise ValueError('Protocol message has no singular "%s" field.' % field_name)

    cpdef bint IsInitialized(self):
        """
        Checks if the message is initialized.

        Returns:
            bool: True if the message is initialized (i.e. all of its required
                fields are set).
        """
        cdef int i
        cdef Case cases_msg

    
        for i in range(len(self._cases)):
            cases_msg = <Case>self._cases[i]
            if not cases_msg.IsInitialized():
                return False

        return True

    cpdef void MergeFrom(self, CaseList other_msg):
        """
        Merges the contents of the specified message into the current message.

        Params:
            other_msg: Message to merge into the current message.
        """
        cdef int i
        cdef Case cases_elt

        if self is other_msg:
            return

    
        for i in range(len(other_msg._cases)):
            cases_elt = Case()
            cases_elt.MergeFrom(other_msg._cases[i])
            list.append(self._cases, cases_elt)

        self._Modified()

    cpdef int MergeFromString(self, data, size=None) except -1:
        """
        Merges serialized protocol buffer data into this message.

        Params:
            data (bytes): a string of binary data.
            size (int): optional - the length of the data string

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        buf = self._protobuf_deserialize(data, length, False)

        if buf != length:
            raise DecodeError("Truncated message: got %s expected %s" % (buf, size))

        self._Modified()

        return buf

    cpdef int ParseFromString(self, data, size=None, bint reset=True, bint cache=False) except -1:
        """
        Populate the message class from a string of protobuf encoded binary data.

        Params:
            data (bytes): a string of binary data
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
            cache (bool): optional - whether to cache serialized data

        Returns:
            int: the number of bytes processed during serialization
        """
        cdef int buf
        cdef int length

        length = size if size is not None else len(data)

        if reset:
            self.reset()

        buf = self._protobuf_deserialize(data, length, cache)

        if buf != length:
            raise DecodeError("Truncated message")

        self._Modified()

        if cache:
            self._cached_serialization = data

        return buf

    @classmethod
    def FromString(cls, s):
        message = cls()
        message.MergeFromString(s)
        return message

    cdef void _protobuf_serialize(self, bytearray buf, bint cache):
        cdef ssize_t length
        # cases
        cdef Case cases_elt
        cdef bytearray cases_elt_buf
        for cases_elt in self._cases:
            set_varint64(10, buf)
            if cases_elt._cached_serialization is not None:
                set_varint64(len(cases_elt._cached_serialization), buf)
                buf += cases_elt._cached_serialization
            else:
                cases_elt_buf = bytearray()
                cases_elt._protobuf_serialize(cases_elt_buf, cache)
                set_varint64(len(cases_elt_buf), buf)
                buf += cases_elt_buf
                if cache:
                    cases_elt._cached_serialization = bytes(cases_elt_buf)

    cpdef void _Modified(self):
        self._is_present_in_parent = True
        self._listener()
        self._cached_serialization = None

    

    cpdef bytes SerializeToString(self, bint cache=False):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        cdef int i
        cdef Case cases_msg

    
        for i in range(len(self._cases)):
            cases_msg = <Case>self._cases[i]
            if not cases_msg.IsInitialized():
                raise Exception("Message CaseList is missing required field: cases[%d]" % i)

        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, cache)
        cdef bytes out = bytes(buf)

        if cache:
            self._cached_serialization = out

        return out

    cpdef bytes SerializePartialToString(self):
        """
        Serialize the message class into a string of protobuf encoded binary data.

        Returns:
            bytes: a byte string of binary data
        """
        if self._cached_serialization is not None:
            return self._cached_serialization

        cdef bytearray buf = bytearray()
        self._protobuf_serialize(buf, False)
        return bytes(buf)

    def SetInParent(self):
        """
        Mark this an present in the parent.
        """
        self._Modified()

    def ParseFromJson(self, data, size=None, reset=True):
        """
        Populate the message class from a json string.

        Params:
            data (str): a json string
            size (int): optional - the length of the data string
            reset (bool): optional - whether to reset to default values before serializing
        """
        if size is None:
            size = len(data)
        d = json.loads(data[:size])
        self.ParseFromDict(d, reset)

    def SerializeToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializeToDict()
        return json.dumps(d, **kwargs)

    def SerializePartialToJson(self, **kwargs):
        """
        Serialize the message class into a json string.

        Returns:
            str: a json formatted string
        """
        d = self.SerializePartialToDict()
        return json.dumps(d, **kwargs)

    def ParseFromDict(self, d, reset=True):
        """
        Populate the message class from a Python dictionary.

        Params:
            d (dict): a Python dictionary representing the message
            reset (bool): optional - whether to reset to default values before serializing
        """
        if reset:
            self.reset()

        assert type(d) == dict
        try:
            for cases_dict in d["cases"]:
                cases_elt = Case()
                cases_elt.ParseFromDict(cases_dict)
                self.cases.append(cases_elt)
        except KeyError:
            pass

        self._Modified()

        return

    def SerializeToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if len(self.cases) > 0:
            out["cases"] = [m.SerializeToDict() for m in self.cases]

        return out

    def SerializePartialToDict(self):
        """
        Translate the message into a Python dictionary.

        Returns:
            dict: a Python dictionary representing the message
        """
        out = {}
        if len(self.cases) > 0:
            out["cases"] = [m.SerializePartialToDict() for m in self.cases]

        return out

    def Items(self):
        """
        Iterator over the field names and values of the message.

        Returns:
            iterator
        """
        yield 'cases', self.cases

    def Fields(self):
        """
        Iterator over the field names of the message.

        Returns:
            iterator
        """
        yield 'cases'

    def Values(self):
        """
        Iterator over the values of the message.

        Returns:
            iterator
        """
        yield self.cases

    

    def Setters(self):
        """
        Iterator over functions to set the fields in a message.

        Returns:
            iterator
        """
        def setter(value):
            self.cases = value
        yield setter

    
