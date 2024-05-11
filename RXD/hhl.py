#import qiskit
import sys
sys.path.append("C:\\Users\\sofia\\OneDrive\\Desktop\\quantum_linear_solvers\\")
#sys.path.append("C:\\Users\\sofia\\OneDrive\\Desktop\\qiskit_venv\\Lib\\site-packages\\linear_solvers\\")
from scipy.sparse import diags
#import numpy as np
import matplotlib.pyplot as plt

from linear_solvers import NumPyLinearSolver, HHL
from qiskit.quantum_info import Statevector


import numpy as np

#matrix = np.array([[1, -1/3], [-1/3, 1]])
#vector = np.array([1, 0])

# Matrix elements as a string
matrix_elements_str = """
548.58 5.3204e-14 -2.5096e-14 6.5878e-15 9.7876e-15 1.305e-14 2.1081e-14 -2.4093e-14
5.3204e-14 44.168 -8.9092e-15 -1.1921e-15 -5.2703e-15 2.0077e-15 -1.7568e-15 -1.3176e-15
-2.5096e-14 -8.9092e-15 16.85 2.6351e-15 -6.0231e-15 -5.0193e-16 -1.5058e-15 1.6313e-15
6.5878e-15 -1.1921e-15 2.6351e-15 14.607 1.4117e-14 -4.2037e-15 -1.2862e-15 1.647e-15
9.7876e-15 -5.2703e-15 -6.0231e-15 1.4117e-14 13.102 2.6351e-15 3.7645e-16 -1.294e-15
1.305e-14 2.0077e-15 -5.0193e-16 -4.2037e-15 2.6351e-15 10.661 -1.3803e-15 2.7606e-15
2.1081e-14 -1.7568e-15 -1.5058e-15 -1.2862e-15 3.7645e-16 -1.3803e-15 9.7198 -2.6822e-15
-2.4093e-14 -1.3176e-15 1.6313e-15 1.647e-15 -1.294e-15 2.7606e-15 -2.6822e-15 8.8713
"""

# Convert the string to a NumPy array
matrix = np.fromstring(matrix_elements_str, sep=' ').reshape(8, 8)


# Column array elements as a string
vector_str = """
0.93312
0.032856
-0.23657
0.14293
0.097748
0.15607
0.13266
0.01725
"""

vector = np.fromstring(vector_str, sep='\n')






naive_hhl_solution = HHL().solve(matrix, vector)
print(naive_hhl_solution.observable)
print(naive_hhl_solution)
naive_sv = Statevector(naive_hhl_solution.state).data
naive_full_vector = np.array([naive_sv[16], naive_sv[17]])
print('naive raw solution vector:', naive_full_vector)

"""
matrix = TridiagonalToeplitz(2, 1, 1 / 3, trotter_steps=2)
right_hand_side = [1.0, -2.1, 3.2, -4.3]
observable = MatrixFunctional(1, 1 / 2)
rhs = right_hand_side / np.linalg.norm(right_hand_side)
 
# Initial state circuit
num_qubits = matrix.num_state_qubits
qc = QuantumCircuit(num_qubits)
qc.isometry(rhs, list(range(num_qubits)), None)
 
hhl = HHL()
solution = hhl.solve(matrix, qc, observable)
approx_result = solution.observable
"""