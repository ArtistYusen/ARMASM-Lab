import numpy as np
import subprocess

def get_matrix(bt):
    matrix = []
    tmp = [i for i in bt.decode().split('\n') if i]
    for i in tmp:
        matrix.append([int(j) for j in i.split(' ') if j])
    return matrix

def test_case_1():
    rows, columns = 8, 8
    matrix_1, matrix_2 = [], []
    for i in range(1, 9):
        matrix_1.append(list(range(i, i + 8)))
    for i in range(1, 9):
        matrix_2.append([i for _ in range(8)])
    
    fname = "case_1.txt"
    with open(fname, 'w') as f:
        f.write(f"{rows} {columns}\n")
        for line in matrix_1:
            f.write(' '.join([str(i) for i in line])+'\n')
        f.write(f"{rows} {columns}\n")
        for line in matrix_2:
            f.write(' '.join([str(i) for i in line])+'\n')

    try:
        result = np.dot(matrix_1, matrix_2)
        ret = subprocess.check_output(["./matrix", fname])
        matrix = get_matrix(ret)
        return (result == matrix).all()
    except Exception as ex:
        print(f"\033[31m\033[1m[x] Failed: {ex}!\033[0m")

def test_case_2():
    rows1, columns1 = 4, 6
    rows2, columns2 = 6, 5
    matrix_1, matrix_2 = [], []
    for i in range(1, 5):
        matrix_1.append(list(range(i, i + 6)))
    for i in range(1, 7):
        matrix_2.append([i for _ in range(5)])
    
    fname = "case_2.txt"
    with open(fname, 'w') as f:
        f.write(f"{rows1} {columns1}\n")
        for line in matrix_1:
            f.write(' '.join([str(i) for i in line])+'\n')
        f.write(f"{rows2} {columns2}\n")
        for line in matrix_2:
            f.write(' '.join([str(i) for i in line])+'\n')

    try:
        result = np.dot(matrix_1, matrix_2)
        ret = subprocess.check_output(["./matrix", fname])
        matrix = get_matrix(ret)
        return (result == matrix).all()
    except Exception as ex:
        print(f"\033[31m\033[1m[x] Failed: {ex}!\033[0m")

def test_case_3():
    rows1, columns1 = 50, 85
    rows2, columns2 = 85, 64
    matrix_1, matrix_2 = [], []
    for i in range(1, rows1+1):
        matrix_1.append(list(range(i+5, i+5+columns1)))
    for i in range(1, rows2+1):
        matrix_2.append([i for _ in range(columns2)])
    
    fname = "case_3.txt"
    with open(fname, 'w') as f:
        f.write(f"{rows1} {columns1}\n")
        for line in matrix_1:
            f.write(' '.join([str(i) for i in line])+'\n')
        f.write(f"{rows2} {columns2}\n")
        for line in matrix_2:
            f.write(' '.join([str(i) for i in line])+'\n')

    try:
        result = np.dot(matrix_1, matrix_2)
        ret = subprocess.check_output(["./matrix", fname])
        matrix = get_matrix(ret)
        return (result == matrix).all()
    except Exception as ex:
        print(f"\033[31m\033[1m[x] Failed: {ex}!\033[0m")

def test_all():
    score = 0
    if test_case_1():
        score += 10
        print("\033[32m\033[1m[+] Test 1 succeed.\033[0m")
    else:
        print(f"\033[31m\033[1m[x] Wrong answer of matrix!\033[0m")
    
    if test_case_2():
        score += 10
        print("\033[32m\033[1m[+] Test 2 succeed.\033[0m")
    else:
        print(f"\033[31m\033[1m[x] Wrong answer of matrix!\033[0m")

    if test_case_3():
        score += 10
        print("\033[32m\033[1m[+] Test 3 succeed.\033[0m")
    else:
        print(f"\033[31m\033[1m[x] Wrong answer of matrix!\033[0m")
    
    return score

if __name__ == "__main__":
    score = test_all()
    print(f"\033[34m\033[1m[*] Final score is {score}.\033[0m\n")