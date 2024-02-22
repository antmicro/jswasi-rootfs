#!/usr/bin/wash
test ! -f /usr/bin/ox && echo "downloading ox..." && wget resources/ox.wasm /usr/bin/ox
test ! -f /home/ant/.config/ox/ox.ron && echo "downloading ox config..." && wget resources/ox.ron /home/ant/.config/ox/ox.ron
test ! -f /usr/bin/uutils && echo "downloading uutils..." && wget resources/uutils.async.wasm /usr/bin/uutils
test ! -f /usr/local/bin/syscalls_test && echo "downloading syscalls_test..." && wget resources/syscalls_test.wasm /usr/local/bin/syscalls_test
test ! -f /usr/local/bin/python && echo "downloading python..." && wget resources/python.wasm /usr/local/bin/python
test ! -f /usr/local/bin/duk && echo "downloading duk..." && wget https://registry-cdn.wapm.io/contents/_/duktape/0.0.3/build/duk.wasm /usr/local/bin/duk
test ! -f /usr/local/bin/cowsay && echo "downloading cowsay..." && wget https://registry-cdn.wapm.io/contents/_/cowsay/0.2.0/target/wasm32-wasi/release/cowsay.wasm /usr/local/bin/cowsay
test ! -f /usr/local/bin/qjs && echo "downloading qjs..." && wget https://registry-cdn.wapm.io/contents/adamz/quickjs/0.20210327.0/build/qjs.wasm /usr/local/bin/qjs
test ! -f /usr/local/bin/viu && echo "downloading viu..." && wget https://registry-cdn.wapm.io/contents/_/viu/0.2.3/target/wasm32-wasi/release/viu.wasm /usr/local/bin/viu
test ! -f /usr/local/bin/rustpython && echo "downloading rustpython..." && wget https://registry-cdn.wapm.io/contents/_/rustpython/0.1.3/target/wasm32-wasi/release/rustpython.wasm /usr/local/bin/rustpython
test ! -f /usr/local/bin/grep && echo "downloading grep..." && wget https://registry-cdn.wapm.io/contents/liftm/rg/12.1.1-1/rg.wasm /usr/local/bin/grep
test ! -f /usr/local/bin/find && echo "downloading find..." && wget https://registry-cdn.wapm.io/contents/liftm/fd/8.2.1-1/fd.wasm /usr/local/bin/find
test ! -f /usr/local/bin/du && echo "downloading du..." && wget https://registry-cdn.wapm.io/contents/liftm/dust-wasi/0.5.4-3/dust.wasm /usr/local/bin/du
test ! -f /usr/local/bin/llc && echo "downloading llc..." && wget https://registry-cdn.wapm.io/contents/rapidlua/llc/0.0.4/llc.wasm /usr/local/bin/llc
test ! -f /usr/local/bin/rsign2 && echo "downloading rsign2..." && wget https://registry-cdn.wapm.io/contents/jedisct1/rsign2/0.6.1/rsign.wasm /usr/local/bin/rsign2
test ! -f /usr/local/bin/ruby && echo "downloading ruby..." && wget https://registry-cdn.wapm.io/contents/katei/ruby/0.1.2/dist/ruby.wasm /usr/local/bin/ruby
test ! -f /usr/local/bin/clang && echo "downloading clang..." && wget https://registry-cdn.wapm.io/contents/_/clang/0.1.0/clang.wasm /usr/local/bin/clang
test ! -f /usr/local/bin/wasm-ld && echo "downloading wasm-ld..." && wget https://registry-cdn.wapm.io/contents/_/clang/0.1.0/wasm-ld.wasm /usr/local/bin/wasm-ld
test ! -f /usr/local/bin/wasibox && echo "downloading wasibox..." && wget resources/wasibox.wasm /usr/local/bin/wasibox
test ! -f /usr/local/bin/space-invaders && echo "downloading space-invaders..." && wget resources/space-invader.wasm /usr/local/bin/space-invaders
if test ! -f /usr/local/bin/kibi; then
    echo "downloading kibi..."
    wget resources/kibi.wasm /usr/local/bin/kibi
    mkdir -p /home/ant/.config/kibi/
    wget resources/config.ini /home/ant/.config/kibi/config.ini
    mkdir -p /home/ant/.local/share/kibi/
    wget resources/syntax.d.zip /home/ant/.local/share/kibi/syntax.d.zip
    cd /home/ant/.local/share/kibi/
    unzip syntax.d.zip
    rm syntax.d.zip
fi

if test ! -d /lib/python3.10; then
    echo "downloading python libs..."
    wget resources/python.tar.gz /lib/python.tar.gz
    cd /lib
    tar -xvf python.tar.gz
    rm python.tar.gz
fi

if test ! -d /usr/lib || test ! -d /usr/local || test ! -d /usr/share; then
    echo "downloading clang sysroot..."
    wget resources/wasi-sysroot.tar.gz /usr/wasi-sysroot.tar.gz
    cd /usr
    tar -xvf wasi-sysroot.tar.gz
    rm wasi-sysroot.tar.gz
fi

if test ! -d /etc/space-invaders; then
    echo "downloading space-invaders config..."
    mkdir -p /etc/space-invaders
    wget resources/invaders_config.ini /etc/space-invaders/config.ini
fi

cd $HOME

wash
