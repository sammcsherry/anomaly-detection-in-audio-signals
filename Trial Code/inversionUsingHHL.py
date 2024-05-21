import numpy as np
import qiskit
from linear_solvers import NumPyLinearSolver, HHL
from qiskit.quantum_info import Statevector
from linear_solvers.matrices.tridiagonal_toeplitz import TridiagonalToeplitz
from scipy.sparse import diags
import time


#algorithm_globals.massive=True
qiskit.utils.algorithm_globals.massive=True

""" method 1
matrix = np.array([[1, -1/3], [-1/3, 1]])
vector = np.array([1, 0])
naive_hhl_solution = HHL().solve(matrix, vector)
classical_solution = NumPyLinearSolver().solve(matrix, vector/np.linalg.norm(vector))

tridi_matrix = TridiagonalToeplitz(1, 1, -1 / 3)
tridi_solution = HHL().solve(tridi_matrix, vector)
"""

NUM_QUBITS = int(input("Input number of qubits (<5, plz): "))
MATRIX_SIZE = 2 ** NUM_QUBITS
# entries of the tridiagonal Toeplitz symmetric matrix
# pylint: disable=invalid-name
a = 1
b = -1/3

matrix = diags([b, a, b],
               [-1, 0, 1],
               shape=(MATRIX_SIZE, MATRIX_SIZE)).toarray()

vector = np.array([1] + [0]*(MATRIX_SIZE - 1))
# run the algorithms
classical_solution = NumPyLinearSolver(
                        ).solve(matrix, vector / np.linalg.norm(vector))
startTime = time.time()
naive_hhl_solution = HHL().solve(matrix, vector)
endTime = time.time()
naiveTime = endTime - startTime


startTime = time.time()
tridi_matrix = TridiagonalToeplitz(NUM_QUBITS, a, b)
tridi_solution = HHL().solve(tridi_matrix, vector)
endTime = time.time()
tridiTime = endTime - startTime

print(classical_solution)
print(naive_hhl_solution)
print(tridi_solution)

print('classical Euclidean norm:', classical_solution.euclidean_norm)
print('naive Euclidean norm:', naive_hhl_solution.euclidean_norm)
print('tridiagonal Euclidean norm:', tridi_solution.euclidean_norm)
print(f"precentage difference between naive and tridi: {naive_hhl_solution.euclidean_norm / tridi_solution.euclidean_norm}")


naive_sv = Statevector(naive_hhl_solution.state).data
tridi_sv = Statevector(tridi_solution.state).data

# Extract vector components; 10000(bin) == 16 & 10001(bin) == 17
naive_full_vector = np.array([naive_sv[16], naive_sv[17]])
tridi_full_vector = np.array([tridi_sv[16], tridi_sv[17]])

print('naive raw solution vector:', naive_full_vector)
print('tridi raw solution vector:', tridi_full_vector)
#print(naive_sv)
#print("                        ")
#print(tridi_sv)
#print(naive_sv.shape)
#print(tridi_sv.shape)


print(f"Number of qubits: {NUM_QUBITS}, naive time: {naiveTime}, tridi time: {tridiTime}")
