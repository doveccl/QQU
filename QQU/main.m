#import <stdio.h>
#import <stdlib.h>
#import <string.h>
#import <unistd.h>

#define LIBENV "DYLD_INSERT_LIBRARIES"
#define LIBPATH "../Resources/"
#define LIBNAME "libQQUnrecall.dylib"

#define HOOK "export " LIBENV "=%s" LIBPATH LIBNAME
#define RUN "/Applications/QQ.app/Contents/MacOS/QQ"

#define CMD HOOK " && " RUN

#define M 1024

char path[M], buff[M];
unsigned long len, i;

int main(int argc, char **argv) {
    strcpy(path, argv[0]);
    len = strlen(path);
    for (i = len - 1; i; i--) {
        if (path[i] == '/')
            break ;
        path[i] = 0;
    }
    sprintf(buff, CMD, path);

    pid_t pid = fork();
    if (pid == 0) system(buff);
    return 0;
}
