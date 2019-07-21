# Synapsis: download, sandbox and run an exercism JS solution


# die command very useful (I googled and copied this from somewhere)
die() { echo "$*" 1>&2 ; exit 1; }


set -e # see: https://stackoverflow.com/questions/2870992/automatic-exit-from-bash-shell-script-on-error
#set -x # turn verbosity to eleven, if things go wrong

# exercism command can either be a commandline argument, or user will be asked to provide it
if [ "$#" -eq 1 ]
then
  exercismCmd="$1"
else
  echo "Please enter the exercism command: "
  read exercismCmd
fi

# make sure it's the right command
[[ $exercismCmd =~ ^exercism\ download\ --uuid=[a-zA-Z0-9]+$ ]] || die "Invalid command - must look like: exercism download --uuid=..."

# get the current directory (NOTE: different from cwd)
SCRIPT_DIR=$(dirname $BASH_SOURCE)

# export NODE_PATH environment variable, so our scripts can find all necessary modules
export NODE_PATH=$SCRIPT_DIR/../node_modules

# (we currently do not use a TMP dir)
# TMP_DIR="$SCRIPT_DIR/_tmp"
# [ -d $TMP_DIR ] || mkdir $TMP_DIR # create local tmp dir if not already exists

#REF_FILE="TMP_DIR/$UUID"

# download the solution files and save target directory to variable
echo "Downloading..."
DIR=$($exercismCmd)
echo "Finished downloading: $DIR..."

# make sure, this actually worked
if [ -z "$DIR" ]
then
  die "could not execute command - no files found :( - $exercismCmd"
fi

safeTest() {
  echo "linting all files..."
  npm run lint # NOTE: tests will still run even if lint fails
  sh $SCRIPT_DIR/make-safe.sh `# replace all source files with sandbox runner` && \
    npm test
}

cd $DIR `# go to directory` && \
  npm install `# install dependencies` && \
  sed -i '' 's/xtest/test/' *.spec.js `# make sure, all test do run` && \
  safeTest