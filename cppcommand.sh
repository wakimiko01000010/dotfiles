function a() {
    OUTFILE=$(ls -t *.out | sed q);
    ./$OUTFILE;
    echo $OUTFILE
}

function g() {
    CPPFILE=$(ls -t *.cpp | sed q);
    FILENAME=${CPPFILE%*.cpp};
    g++ -o $FILENAME.out -std=c++14 $CPPFILE
    echo $CPPFILE
}

function c() {
    CFILE=$(ls -t *.c | sed q);
    FILENAME=${CFILE%*.c};
    gcc -o $FILENAME.out $CFILE
    echo $CFILE
}
