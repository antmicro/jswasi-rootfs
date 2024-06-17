#!/usr/bin/wash

test ! -f /usr/local/bin/duk && echo "downloading duk..." && wget -O /usr/local/bin/duk https://registry-cdn.wapm.io/contents/_/duktape/0.0.3/build/duk.wasm
test ! -f /usr/local/bin/cowsay && echo "downloading cowsay..." && wget -O /usr/local/bin/cowsay https://registry-cdn.wapm.io/contents/_/cowsay/0.2.0/target/wasm32-wasi/release/cowsay.wasm
test ! -f /usr/local/bin/qjs && echo "downloading qjs..." && wget -O /usr/local/bin/qjs https://registry-cdn.wapm.io/contents/adamz/quickjs/0.20210327.0/build/qjs.wasm
test ! -f /usr/local/bin/viu && echo "downloading viu..." && wget -O /usr/local/bin/viu https://registry-cdn.wapm.io/contents/_/viu/0.2.3/target/wasm32-wasi/release/viu.wasm
test ! -f /usr/local/bin/rustpython && echo "downloading rustpython..." && wget -O /usr/local/bin/rustpython https://registry-cdn.wapm.io/contents/_/rustpython/0.1.3/target/wasm32-wasi/release/rustpython.wasm
test ! -f /usr/local/bin/grep && echo "downloading grep..." && wget -O /usr/local/bin/grep https://registry-cdn.wapm.io/contents/liftm/rg/12.1.1-1/rg.wasm
test ! -f /usr/local/bin/find && echo "downloading find..." && wget -O /usr/local/bin/find https://registry-cdn.wapm.io/contents/liftm/fd/8.2.1-1/fd.wasm
test ! -f /usr/local/bin/du && echo "downloading du..." && wget -O /usr/local/bin/du https://registry-cdn.wapm.io/contents/liftm/dust-wasi/0.5.4-3/dust.wasm
test ! -f /usr/local/bin/llc && echo "downloading llc..." && wget -O /usr/local/bin/llc https://registry-cdn.wapm.io/contents/rapidlua/llc/0.0.4/llc.wasm
test ! -f /usr/local/bin/rsign2 && echo "downloading rsign2..." && wget -O /usr/local/bin/rsign2 https://registry-cdn.wapm.io/contents/jedisct1/rsign2/0.6.1/rsign.wasm
test ! -f /usr/local/bin/ruby && echo "downloading ruby..." && wget -O /usr/local/bin/ruby https://registry-cdn.wapm.io/contents/katei/ruby/0.1.2/dist/ruby.wasm
test ! -f /usr/local/bin/syscalls_test && echo "downloading syscalls test..." && wget -O /usr/local/bin/syscalls_test resources/syscalls_test

cd $HOME
wash
