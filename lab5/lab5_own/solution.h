#ifndef SOLUTION_H
#define SOLUTION_H

#endif // SOLUTION_H

#include <iostream>
#include <vector>
#include <algorithm>
#include <string.h>

extern int str1(const char *x, int a, char *y);

void print1(char n);

class Solution{
private:
    std :: vector<std :: string> vct;
    int biggest_len;
    int str_index;
public:
    void init();
    void input_check();
    void answer_output();
    std :: string process_string(std :: string str, int size);
    void start();

};
