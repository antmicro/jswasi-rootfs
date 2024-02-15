#!/usr/bin/wash
test ! -f /usr/bin/ox && echo "downloading ox..." && wget -O /usr/bin/ox resources/ox
test ! -f /home/ant/.config/ox/ox.ron && echo "downloading ox config..." && wget -O /home/ant/.config/ox/ox.ron resources/ox.ron
test ! -f /usr/bin/uutils && echo "downloading uutils..." && wget -O /usr/bin/uutils resources/uutils.async.wasm
test ! -f /usr/local/bin/syscalls_test && echo "downloading syscalls_test..." && wget -O /usr/local/bin/syscalls_test resources/syscalls_test
test ! -f /usr/local/bin/python && echo "downloading python..." && wget -O /usr/local/bin/python resources/python
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
test ! -f /usr/local/bin/clang && echo "downloading clang..." && wget -O /usr/local/bin/clang resources/clang
test ! -f /usr/local/bin/wasm-ld && echo "downloading wasm-ld..." && wget -O /usr/local/bin/wasm-ld resources/wasm-ld
test ! -f /usr/local/bin/wasibox && echo "downloading wasibox..." && wget -O /usr/local/bin/wasibox resources/wasibox.wasm
test ! -f /usr/local/bin/space-invaders && echo "downloading space-invaders..." && wget -O /usr/local/bin/space-invaders resources/space-invaders
if test ! -f /usr/local/bin/kibi; then
    echo "downloading kibi..."
    wget -O /usr/local/bin/kibi resources/kibi
    mkdir -p /home/ant/.config/kibi/
    wget -O /home/ant/.config/kibi/config.ini resources/config.ini
    mkdir -p /home/ant/.local/share/kibi/
    wget -O /home/ant/.local/share/kibi/syntax.d.zip resources/syntax.d.zip
    cd /home/ant/.local/share/kibi/
    unzip syntax.d.zip
    rm syntax.d.zip
fi

if test ! -d /lib/python3.10; then
    echo "downloading python libs..."
    wget -O /lib/python.tar.gz resources/python.tar.gz
    cd /lib
    tar -xvf python.tar.gz
    rm python.tar.gz
fi

if test ! -d /usr/lib || test ! -d /usr/local || test ! -d /usr/share; then
    echo "downloading clang sysroot..."
    wget -O /usr/wasi-sysroot.tar.gz resources/wasi-sysroot.tar.gz
    cd /usr
    tar -xvf wasi-sysroot.tar.gz
    rm wasi-sysroot.tar.gz
fi

if test ! -d /etc/space-invaders; then
    echo "downloading space-invaders config..."
    mkdir -p /etc/space-invaders
    wget -O /etc/space-invaders/config.ini resources/invaders_config.ini
fi

cd $HOME

wash
