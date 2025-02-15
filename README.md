

# Python serialization benchmark.

Small serialize deserialize benchmarks


## Methodology:

Generate a number of messages with `Faker`.

The structure is:

```
{
    a: int
    b: int
    c: float
    d: float
    e: str
    f: str
}
```

## Results:

Mean time to serialize/deserialize 100000 messages.

| name     |   deserialize |   serialize |
|:---------|--------------:|------------:|
| json     |     0.266848  |   0.228243  |
| msgpack  |     0.185197  |   0.112128  |
| protobuf |     0.0149847 |   0.0547258 |

