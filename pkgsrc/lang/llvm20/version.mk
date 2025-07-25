# $NetBSD: version.mk,v 1.17 2024/07/06 15:45:06 adam Exp $
# used by devel/lld
# used by devel/lldb
# used by devel/polly
# used by lang/clang
# used by lang/clang-tools-extra
# used by lang/compiler-rt
# used by lang/flang
# used by lang/libcxx
# used by lang/libcxxabi
# used by lang/libunwind
# used by lang/mlir
# used by lang/wasi-compiler-rt
# used by lang/wasi-libcxx
# used by parallel/openmp

## Also change LLVM_VERSION in isolatedversion.mk
LLVM_VERSION=	20.1.6
MASTER_SITES=	${MASTER_SITE_GITHUB:=llvm/}
GITHUB_PROJECT=	llvm-project
GITHUB_RELEASE=	llvmorg-${PKGVERSION_NOREV}
EXTRACT_SUFX=	.tar.xz

LLVM_MAJOR_VERSION=	${LLVM_VERSION:tu:C/\\.[[:digit:]\.]*//}

## Different prefix to allow lang/llvmXX to live with lang/llvm
LLVM_ISOLATED_PREFIX_BASENAME=	llvm${LLVM_MAJOR_VERSION}
LLVM_ISOLATED_PREFIX=			${PREFIX}/${LLVM_ISOLATED_PREFIX_BASENAME}

# As of v15.0.0 llvm requires cmake source code to build
CMAKE_DIST=	cmake-${LLVM_VERSION}.src
RUNTIMES_DIST=	runtimes-${LLVM_VERSION}.src
EXTRA_DIST+=	${CMAKE_DIST}${EXTRACT_SUFX} ${RUNTIMES_DIST}${EXTRACT_SUFX}
SITES.${CMAKE_DIST}${EXTRACT_SUFX}=	\
		${MASTER_SITES:=${GITHUB_PROJECT}/releases/download/${GITHUB_RELEASE}/}
SITES.${RUNTIMES_DIST}${EXTRACT_SUFX}=	\
		${MASTER_SITES:=${GITHUB_PROJECT}/releases/download/${GITHUB_RELEASE}/}
DISTFILES=	${DEFAULT_DISTFILES} ${EXTRA_DIST}

.PHONY: llvm-cmake-modules
post-extract: llvm-cmake-modules
llvm-cmake-modules:
	${LN} -f -s ${WRKDIR}/${CMAKE_DIST} ${WRKDIR}/cmake
	${LN} -f -s ${WRKDIR}/${RUNTIMES_DIST} ${WRKDIR}/runtimes
