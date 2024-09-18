import numpy as np

def Score_math_each_student(Score):
    Score_math_each = Score[:, 2]
    print(f'모든 학생의 수학 점수: {Score_math_each}')
def Score_total_by_students(Score):
    Score_total_by_student = np.sum(Score, axis=1)
    print(f'각 학생의 과목의 총합 점수: {Score_total_by_student}')

def Score_odd_student(Score):
    odd = np.arange(Score.shape[0]) % 2 == 0
    print(f'홀수번째 학생들 불린 인덱싱으로 접근 : {odd}')

    odd_score = np.flip(Score[odd], axis=1)
    print(f'홀수번 학생들의 점수: \n{odd_score}')

def Score_max_by_subjects(Score):
    Score_max_by_subject = np.max(Score, axis=0)
    print(f'각 과목에서의 최대 점수: {Score_max_by_subject}')

def Score_eng_under_90(Score):
    Score_eng = Score[:, 1]
    print(f'영어 과목이 90점 미만인 학생들의 점수: {Score_eng[Score_eng < 90]}')

def Score_mean_by_subjects(Score):
    Score_mean_by_subject = np.mean(Score, axis=0)
    print(f'국어, 영어, 수학, 과학의 평균 점수 {Score_mean_by_subject}')

def main():
    Score = np.random.randint(100, size= (10, 4))
    print(Score) # 랜덤 생성 점수 확인
    Score_math_each_student(Score) # 문제1
    Score_total_by_students(Score) # 문제2
    Score_odd_student(Score) # 문제3
    Score_max_by_subjects(Score) # 문제4
    Score_eng_under_90(Score) # 문제5
    Score_mean_by_subjects(Score) # 문제6

main()