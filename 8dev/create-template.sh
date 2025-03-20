#!/bin/sh

if [ -n "$BASH_SOURCE" ]; then
	THIS_FILE=${BASH_SOURCE}
elif [ -n "$ZSH_NAME" ]; then
	THIS_FILE=${0}
else
	THIS_FILE=$0
fi
THIS_DIR=$(dirname $THIS_FILE)
WSROOT=$(realpath $THIS_DIR/..)

TEMPLATE=$1
if [ -z "$TEMPLATE" ]; then
	echo "Usage: `basename $0` <template-name>" >&2
	exit 1
fi

TEMPLATE_DIR=$THIS_DIR/conf/templates/$TEMPLATE
if [ -d "$TEMPLATE_DIR" ]; then
	echo "Template '$TEMPLATE' already exists" >&2
	exit 1
fi

mkdir -p $TEMPLATE_DIR
for f in $WSROOT/poky/meta-poky/conf/templates/default/*; do
	ln -s `realpath --relative-to $TEMPLATE_DIR $f` $TEMPLATE_DIR/`basename $f`
done

echo "Template '$TEMPLATE' initialised at `realpath --relative-to . $TEMPLATE_DIR`"
