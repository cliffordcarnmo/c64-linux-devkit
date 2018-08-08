cd src/acme/src/ && make && cd ../../../
cd src/pucrunch && make && cd ../../
cd src/genosine && make && cd ../../

mkdir bin
mv src/acme/src/acme bin/
mv src/pucrunch/pucrunch bin/
mv src/genosine/genosine bin/

sudo cp -rv c64/* /usr/lib/vice/
ln -s /usr/bin/x64 bin/x64

