TARGET=FluffyHead
OBJECTS_DIR=obj
# as I want to support 4.8 and 5 this will set a flag for some of the mac stuff
# mainly in the types.h file for the setMacVisual which is native in Qt5
isEqual(QT_MAJOR_VERSION, 5) {
	cache()
        DEFINES +=QT5BUILD

}



MOC_DIR=moc
CONFIG-=app_bundle
QT+=gui opengl core
SOURCES += src/main.cpp \
           src/MainWindow.cpp \
           src/GLWindow.cpp \
        src/AbstractRK4Integrator.cpp \
    src/Utils.cpp \
    src/Scene.cpp \
    src/Mesh.cpp \
    src/RenderObject.cpp \
    src/AABB.cpp \
    src/Hair.cpp \
    src/VoxelGrid.cpp \
    src/ElasticRod.cpp

INCLUDEPATH+=./include
HEADERS += include/MainWindow.h \
           include/GLWindow.h \
            include/AbstractRK4Integrator.h \
    include/Particle.h \
    include/Utils.h \
    include/Scene.h \
    include/Mesh.h \
    include/RenderObject.h \
    include/Config.h \
    include/AABB.h \
    include/Hair.h \
    include/TransformTool.h \
    include/HairyObject.h \
    include/IServant.h \
    include/VoxelGrid.h \
    include/ElasticRod.h


FORMS += \
    ui/MainWindow.ui

OTHER_FILES+= shaders/Phong.fs \
              shaders/Phong.vs \
    shaders/PhongVertex.glsl \
    shaders/PhongFragment.glsl \
    shaders/ColourFrag.glsl \
    shaders/ColourVert.glsl \
    shaders/ColourGeom.glsl



INCLUDEPATH +=./include

DESTDIR=./
CONFIG += console
CONFIG -= app_bundle
# use this to suppress some warning from boost
unix:QMAKE_CXXFLAGS_WARN_ON += "-Wno-unused-parameter"

unix:QMAKE_CXXFLAGS+= -msse -msse2 -msse3
macx:QMAKE_CXXFLAGS+= -arch x86_64
macx:INCLUDEPATH+=/usr/local/include/
linux-g++:QMAKE_CXXFLAGS +=  -march=native
linux-g++-64:QMAKE_CXXFLAGS +=  -march=native
# define the _DEBUG flag for the graphics lib
DEFINES +=NGL_DEBUG

unix:LIBS += -L/usr/local/lib
# add the ngl lib
unix:LIBS +=  -L/$(HOME)/NGL/lib -l NGL

# now if we are under unix and not on a Mac (i.e. linux) define GLEW
linux-*{
		linux-*:QMAKE_CXXFLAGS +=  -march=native
		linux-*:DEFINES+=GL42
		DEFINES += LINUX
}
DEPENDPATH+=include
# if we are on a mac define DARWIN
macx:DEFINES += DARWIN
# this is where to look for includes
INCLUDEPATH += $$(HOME)/NGL/include/

win32: {
				PRE_TARGETDEPS+=C:/NGL/lib/NGL.lib
				INCLUDEPATH+=-I c:/boost
				DEFINES+=GL42
				DEFINES += WIN32
				DEFINES+=_WIN32
				DEFINES+=_USE_MATH_DEFINES
				LIBS += -LC:/NGL/lib/ -lNGL
				DEFINES+=NO_DLL
}

