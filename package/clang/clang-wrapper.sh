only_compile=0

output_file=""
args=" "

if [ $# -lt 2 ]; then
  echo "Usage: clang [-emit-obj] -o <output-file> <input-files>"
  exit 1
fi

while [ $# -gt 1 ]; do
  arg=$1
  shift
  if [ $arg = "-emit-obj" ]; then
    only_compile=1
  elif [ $arg = "-o" ]; then
    arg_file=$1
    output_file=$(realpath $arg_file)
    shift
  else
    if [ -f "$arg" ]; then
      arg=$(realpath $arg)
    fi
    if [ $args == " " ]; then
      args="$arg"
    else
      args="$args $arg"
    fi
  fi
done

if [ $only_compile -eq 1 ]; then
  clangc -cc1 -triple wasm32-unknown-wasi -isysroot /usr -internal-isystem /usr/include -emit-obj -o $output_file $args
else
  object_file=$output_file.o
  clangc -cc1 -triple wasm32-unknown-wasi -isysroot /usr -internal-isystem /usr/include -emit-obj -o $object_file $args
  wasm-ld -L/usr/lib/wasm32-wasi /usr/lib/wasm32-wasi/crt1.o -lc -o $output_file $object_file
  rm $object_file
fi
