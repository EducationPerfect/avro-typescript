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

for d in ${AVRO_FOLDER}/*/; do
  count=$(ls -1 ${AVRO_FOLDER}${d#$AVRO_FOLDER}*.avsc 2>/dev/null | wc -l)

  if [ $count != 0 ]
  then
  mkdir -p ${OUTPUT_PATH}/src/${d#$AVRO_FOLDER}
  avro-ts ${AVRO_FOLDER}${d#$AVRO_FOLDER}*.avsc --output-dir ${OUTPUT_PATH}/src/${d#$AVRO_FOLDER}
  fi
done

for f in ${OUTPUT_PATH}/src/**/*.avsc.ts; do mv "$f" "$(echo "$f" | sed s/\.avsc\./\./)"; done

cat /package.json.tpl | envsubst > ${OUTPUT_PATH}/package.json
cp /tsconfig.json ${OUTPUT_PATH}/tsconfig.json

cd $OUTPUT_PATH
npm install
npx tsc

cp package.json dist/package.json
cd dist
npx npm-packlist-cli