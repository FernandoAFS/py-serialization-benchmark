
bench:
    pytest --benchmark-json=bench-res.json bench/test_create.py 

protoc:
    protoc --proto_path=proto/ --python_out=bench/ proto/case.proto

pyrobuf:
    pyrobuf proto/case.proto --install
