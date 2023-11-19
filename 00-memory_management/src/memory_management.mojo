from memory.unsafe import Pointer
from time import now

struct HeapArray:
   var data: Pointer[Int]
   var size: Int

   fn __init__(inout self, size: Int, val: Int) -> None:
      # Memory Allocation !!!
      self.size = size
      self.data = Pointer[Int].alloc(self.size)
      for i in range(self.size):
         self.data.store(i, val)

   fn __copyinit__(inout self, existing: Self) -> None:
      # NOTE: By default a Vector does not implement the __copyinit__ method!
      self.size = existing.size
      self.data = Pointer[Int].alloc(self.size)
      for i in range(self.size):
         self.data.store(i, existing.data.load(i))
   
   fn __del__(owned self) -> None:
      self.data.free()

   fn get_heap_array_sum(self) -> Int:
      var total_sum = 0
      for i in range(self.size):
         total_sum += self.data.load(i)
      return total_sum
   
fn run_performance_test(num_times: Int, start_size: Int, end_size: Int, step_size: Int) -> None:
   print('num_elements total_sum time_ms')

   for size in range(start_size, end_size + 1, step_size):
      var array = HeapArray(size, 1)
      
      var start_time = now()
      var total_sum = 0
      for _ in range(num_times):
         total_sum = array.get_heap_array_sum()
      var end_time = now()

      var execution_time = (end_time - start_time) / num_times
      
      print(size, total_sum, execution_time/1000000)

fn main():
   let NUM_TIMES  = 100
   let START_SIZE = 0
   let END_SIZE   = 10_000_000
   let STEP_SIZE  = 100_000

   run_performance_test(
      num_times=NUM_TIMES, 
      start_size=START_SIZE, 
      end_size=END_SIZE, 
      step_size=STEP_SIZE
   )