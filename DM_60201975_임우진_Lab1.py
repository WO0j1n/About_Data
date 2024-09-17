import random
import string

def list_concat(): # 문제 1-1
    Lst = [random.randint(1, 100) for i in range(20)]
    Lst_2 = [random.randint(1, 100) for i in range(20)]
    print(f'문제 1-1 : {Lst + Lst_2}')

def list_concat_exception(): # 문제 1-2
    Lst = [random.randint(1, 100) for i in range(20)]
    Lst_2 = [random.randint(1, 100) for i in range(20)]

    print(f'문제 1-2 : {set(Lst + Lst_2)}')

def make_answer(): # 문제 2 학생 정답 생성 함수
    students = []
    for i in range(8):
        students_answer = random.choices(string.ascii_uppercase[:5], k=10)
        students.append(students_answer)
    print(f'학생들의 답: {students}')
    return students


def make_label(): # 문제 2 정답 생성 함수
    label_list = random.choices(string.ascii_uppercase[:5], k=10)
    print(f'정답 레이블: {label_list}')
    return label_list

def main():

    list_concat() # 문제 1-1
    list_concat_exception() #문제 1-2
    print()

    print('문제 2번') # 문제 2
    students = make_answer()
    label_list = make_label()

    for index, s in enumerate(students):
        score = 0
        for answer, label in zip(s, label_list):
            if answer == label:
                score += 1
        print(f'{index} 번 학생 정답 문항의 개수는 {score} 입니다.')

if __name__ == '__main__':
    main()
