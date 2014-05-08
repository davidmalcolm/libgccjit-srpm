ORIGINAL_DIR=$(pwd)
cd ../gcc-git-jit-clean/src/
OTHER_HEAD=$(git rev-parse HEAD)
git archive \
    --format=tar.gz \
    --prefix=gcc-$OTHER_HEAD/ \
    $OTHER_HEAD \
    --output=$ORIGINAL_DIR/gcc-$OTHER_HEAD.tar.gz
