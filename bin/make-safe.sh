# Synapsis: replace all code files with sandboxed versions of themselves!

set -e # see: https://stackoverflow.com/questions/2870992/automatic-exit-from-bash-shell-script-on-error
#set -x # turn verbosity to eleven, if things go wrong

SCRIPT_DIR=$(dirname $BASH_SOURCE)
#echo "NODE_PATH=$NODE_PATH"

# get all unprocessed js files
files=$(ls . | grep '\.js$' | grep -v '\.spec\.js$' | grep -v '\.safe\.js$' | grep -v '\.config\.js$')

TMP_DIR="./_sandbox"
[ -d $TMP_DIR ] || mkdir $TMP_DIR # create local tmp dir if not already exists

# process all files
for file in "${files[@]}"
do
  echo "transpiling & sandboxing $file..."
  npx babel --presets=@babel/preset-env --source-maps -o $TMP_DIR/$file.es5.js $file `# transpile with babel` && \
  mv $file $TMP_DIR/$file.orig `# move to _sandbox/*.orig` && \
  cp $SCRIPT_DIR/../jsVmTemplate.js $file `# replace file with sandboxed runner`
done