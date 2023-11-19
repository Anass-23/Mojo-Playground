import time
from typing import List

NUM_TIMES  = 100
START_SIZE = 0
END_SIZE   = 10_000_000
STEP_SIZE  = 100_000

class HeapArray:
    def __init__(self, size: int, val: int) -> None:
        self.size: int = size
        self.data: List[int] = [val] * size

    def get_heap_array_sum(self) -> None:
        return sum(self.data)

def run_performance_test(num_times: int, start_size: int, end_size: int, step_size: int) -> None:
    print('num_elements total_sum time_ms')

    for size in range(start_size, end_size + 1, step_size):
        array = HeapArray(size, 1)

        start_time = time.time()
        for _ in range(num_times):
            total_sum = array.get_heap_array_sum()
        end_time = time.time()

        execution_time = (end_time - start_time) / num_times

        print(size, total_sum, execution_time * 1000)

run_performance_test(
    num_times=NUM_TIMES, 
    start_size=START_SIZE, 
    end_size=END_SIZE, 
    step_size=STEP_SIZE
)