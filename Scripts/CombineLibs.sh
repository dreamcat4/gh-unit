#!/bin/sh

FLAVOR=""
GHUNIT_VERSION=`cat ../XcodeConfig/Shared.xcconfig | grep "GHUNIT_VERSION =" | cut -d '=' -f 2 | tr -d " "`

NAME=libGHUnitIOS
OUTPUT_DIR=${BUILD_DIR}/Combined${BUILD_STYLE}${FLAVOR}
OUTPUT_FILE=${NAME}${FLAVOR}.a
ZIP_DIR=${BUILD_DIR}/Zip

if [ ! -d ${OUTPUT_DIR} ]; then
	mkdir ${OUTPUT_DIR}
fi

# Combine lib files
lipo -create "${BUILD_DIR}/${BUILD_STYLE}-iphoneos/${NAME}Device${FLAVOR}.a" "${BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/${NAME}Simulator${FLAVOR}.a" -output ${OUTPUT_DIR}/${OUTPUT_FILE}

# Copy to direcory for zipping 
mkdir ${ZIP_DIR}
cp ${OUTPUT_DIR}/${OUTPUT_FILE} ${ZIP_DIR}
cp ${BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/*.h ${ZIP_DIR}
cp ${BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/*.m ${ZIP_DIR}
#cp ${BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/*.sh ${ZIP_DIR}
cp ${BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/Makefile ${ZIP_DIR}

cd ${ZIP_DIR}
zip -m ${NAME}${FLAVOR}-${GHUNIT_VERSION}.zip *
mv ${NAME}${FLAVOR}-${GHUNIT_VERSION}.zip ..
rm -rf ${ZIP_DIR}
