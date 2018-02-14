#!/bin/sh

CXX="clang"

CXX_FLAGS=""
ENTRY="src/main.c"
OUTPUT="build/app"

CTIME_EXEC="utils/ctime"
CTIME_SOURCE="utils/ctime.c"
CTIME_TIMING_FILE=".build.ctm"

# build ctime
if [ ! -f "$CTIME_EXEC" ]; then
  $CXX -O2 -Wno-unused-result "$CTIME_SOURCE" -o "$CTIME_EXEC"
fi

# ctime start
$CTIME_EXEC -begin "$CTIME_TIMING_FILE"

mkdir -p build
$CXX $CXX_FLAGS $ENTRY -o $OUTPUT

# ctime end
LAST_ERROR=$?
$CTIME_EXEC -end "$CTIME_TIMING_FILE" $LAST_ERROR

