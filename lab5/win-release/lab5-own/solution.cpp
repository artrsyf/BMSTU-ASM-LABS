#include <solution.h>

void print1(char *str){
    std::cout << str << '\n';
}

void Solution :: init(){
    int counter = 0;
    std:: string s;
    biggest_len = 0;
    str_index = 0;
    std :: cout << "Input few strings: " << '\n';
    while(getline(std :: cin, s) && s != "End string"){
        vct.push_back(s);
        if (s.size() > biggest_len){
            biggest_len = s.size();
            str_index = counter;
        }
        counter++;
    }
}

void Solution :: input_check(){
    std :: cout << '\n' << "Your input:" << "\n\n";
    for (const auto &i : vct){
        std :: cout << i << '\n';
    }
}

void Solution :: answer_output(){
    std :: cout << '\n' << "Answer:" << "\n\n";
    char *answer_row;
    char *input_string;
    for (std :: string i : vct){
        if (i.size() < biggest_len){
            input_string = new char[i.size()];
            strcpy(input_string, i.c_str());
            answer_row = new char[255];
            str1(input_string, biggest_len, answer_row);
        }
        else std :: cout << i << '\n';
    }
}

std :: string Solution :: process_string(std :: string str, int size){
    int space_count = count(str.begin(), str.end(), ' ');
    int added_size = size - str.size();
    int i, j;
    if (space_count == 0){
        for (i = 0; i < added_size; i++){
            str.insert(0, 1, ' ');
        }
    }
    else{
        int every_space_adding = added_size / space_count;
        int remain = added_size % space_count;
        for (i = 0; i < str.size(); i++){
             if (str[i] == ' '){
                 for (j = 0; j < every_space_adding + remain; j++)
                 str.insert(i++, 1, ' ');
                 remain = 0;
             }
        }
    }
    return str;
}

void Solution :: start(){
    this -> init();
    this -> input_check();
    this -> answer_output();
    std :: cout << std :: endl;
}
