import json

import case_pb2
import case_proto
import msgpack
import pytest
from faker import Faker

faker = Faker()

ns = [(100000)]
# ns = [(10)]


def rand_dict_factory():
    return {
        "a": faker.random_int(),
        "b": faker.random_int(),
        "c": faker.random_number(),
        "d": faker.random_number(),
        "e": faker.name(),
        "f": faker.text(),
    }


def rand_n_dict_factory(n: int):
    return [rand_dict_factory() for _ in range(n)]


def rand_n_msg_factory(n: int):
    caseList = case_pb2.CaseList()

    for _ in range(n):
        case = caseList.cases.add()
        case.a = faker.random_int()
        case.b = faker.random_int()
        case.c = faker.random_number()
        case.d = faker.random_number()
        case.e = faker.name()
        case.f = faker.text()

    return caseList

def rand_n_msg_factory_pyrobuf(n: int):
    caseList = case_proto.CaseList()

    for _ in range(n):
        case = caseList.cases.add()
        case.a = faker.random_int()
        case.b = faker.random_int()
        case.c = faker.random_number()
        case.d = faker.random_number()
        case.e = faker.name()
        case.f = faker.text()

    return caseList



@pytest.mark.parametrize("N", ns)
def test_serialize_json(benchmark, N):
    "Just try to create a single test struct"

    dicts = rand_n_dict_factory(N)
    benchmark(lambda: json.dumps(dicts))


@pytest.mark.parametrize("N", ns)
def test_deserialize_json(benchmark, N):
    "Just try to create a single test struct"
    dicts = rand_n_dict_factory(N)
    json_deser = json.dumps(dicts)
    benchmark(lambda: json.loads(json_deser))


@pytest.mark.parametrize("N", ns)
def test_serialize_msgpack(benchmark, N):
    "Just try to create a single test struct"
    dicts = rand_n_dict_factory(N)
    benchmark(lambda: msgpack.dumps(dicts))


@pytest.mark.parametrize("N", ns)
def test_deserialize_msgpack(benchmark, N):
    "Just try to create a single test struct"
    dicts = rand_n_dict_factory(N)
    json_deser = msgpack.dumps(dicts)
    benchmark(lambda: msgpack.loads(json_deser))


@pytest.mark.parametrize("N", ns)
def test_serialize_pb(benchmark, N):
    "Just try to create a single test struct"
    msg = rand_n_msg_factory(N)
    benchmark(msg.SerializeToString)


@pytest.mark.parametrize("N", ns)
def test_deserialize_pb(benchmark, N):
    "Just try to create a single test struct"
    msg = rand_n_msg_factory(N)
    serial = msg.SerializeToString()
    def deserial():
        cases = case_pb2.CaseList()
        cases.ParseFromString(serial)
    benchmark(deserial)


@pytest.mark.parametrize("N", ns)
def test_serialize_pyrobuf(benchmark, N):
    msg = rand_n_msg_factory_pyrobuf(N)
    benchmark(msg.SerializeToString)


@pytest.mark.parametrize("N", ns)
def test_deserialize_pyrobuf(benchmark, N):
    msg = rand_n_msg_factory_pyrobuf(N)
    serial = msg.SerializeToString()
    def deserial():
        cases = case_proto.CaseList()
        cases.ParseFromString(serial)
    benchmark(deserial)
