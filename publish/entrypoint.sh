#!/bin/sh -l
set -e 

SRC=./src

for i in "$@"; do
  case $i in
    -k=*|--api-key=*)
      export EP_NPM_TOKEN="${i#*=}"
      shift
      ;;
    -a=*|--artifact-path=*)
      ARTIFACT_PATH="${i#*=}"
      shift
      ;;
    *)
      ;;
  esac
done

echo "[Inputs]:"
echo "ARTIFACT PATH = $ARTIFACT_PATH"
echo "API KEY  = ****"

cp /.npmrc ${ARTIFACT_PATH}/dist/.npmrc
cp ${ARTIFACT_PATH}/package.json ${ARTIFACT_PATH}/dist/package.json

echo "Publishing package..."
cd $ARTIFACT_PATH
npm publish
