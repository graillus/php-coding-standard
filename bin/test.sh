#!/usr/bin/env sh

mkdir -p tests/actual

for entry in tests/input/*
do
  echo "Processing $entry"
  target=${entry/input/actual}
  target_output=${target/.php/.out}
  vendor/bin/phpcs --standard=phpcs.xml.dist "$entry" | sed -e '/^Time:/d' > "$target_output"
  cat "$entry" | vendor/bin/phpcbf --standard=phpcs.xml.dist - > "$target"
done

diff tests/actual tests/expected
