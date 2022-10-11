#!/bin/sh -l

set -e

SRC=./src

for i in "$@"; do
  case $i in
    -n=*|--package-name=*)
      export PACKAGE_NAME="${i#*=}"
      shift
      ;;
    -v=*|--package-version=*)
      export PACKAGE_VERSION="${i#*=}"
      shift
      ;;
    -p=*|--avro-dir-path=*)
      AVRO_FOLDER="${i#*=}"
      shift
      ;;
    -o=*|--output-path=*)
      OUTPUT_PATH="${i#*=}"
      shift
      ;;
    -c=*|--company=*)
      export COMPANY="${i#*=}"
      shift
      ;;
    -a=*|--authors=*)
      export AUTHORS="${i#*=}"
      shift
      ;;
    *)
      ;;
  esac
done

echo "[Inputs]:"
echo "  - Package name    = $PACKAGE_NAME"
echo "  - Package version = $PACKAGE_VERSION"
echo "  - Avro folder     = $AVRO_FOLDER"
echo "  - Output path     = $OUTPUT_PATH"
echo "  - Company         = $COMPANY"
echo "  - Authors         = $AUTHORS"

echo "Clean up..."
rm -rf ./src

mkdir -p ${OUTPUT_PATH}/src
avro-ts ${AVRO_FOLDER}/**/*.avsc --output-dir ${OUTPUT_PATH}/src

for f in ${OUTPUT_PATH}/src/*.avsc.ts; do mv "$f" "$(echo "$f" | sed s/\.avsc\./\./)"; done

cat /package.json.tpl | envsubst > ${OUTPUT_PATH}/package.json
cp /tsconfig.json ${OUTPUT_PATH}/tsconfig.json

cd $OUTPUT_PATH
npm install
npx tsc
npx npm-packlist-cli