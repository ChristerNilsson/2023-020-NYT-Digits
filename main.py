import time

def ass(a,b):
	if a==b: return
	print('assert failed')
	print('  ',a)
	print('  ',b)

def update (lst,i,j,c): return lst[:i] + lst[i+1:j] + lst[j+1:] + [c]
ass(update([1,2,3,4,5],0,1,6), [3,4,5,6])

def operation (a,op,b):
	c = 0
	if op == '+': c = a + b
	if op == '-': c = a - b
	if b != 1:
		if op == '*' : c = a * b
		if op == '/' and a % b == 0 : c = a // b
	return c

def solve (target, numbers):
	global solution
	def solve1 (target, lst, level, lines):
		global solution
		n = len(lst)
		for i in range(n-1):
			for j in range(i+1,n):
				for op in "*+-/":
					a = lst[i]
					b = lst[j]
					if a < b: [a,b] = [b,a]
					c = operation(a,op,b)
					if c > 0:
						lines1 = lines + [f"{a} {op} {b} = {c}"]
						lst1 = update(lst,i,j,c)
						if c == target:
							solution = lines1
						else:
							if level > 1 : solve1(target,lst1,level-1,lines1)

	solution = []
	start = time.time()
	for level in range(1,6):
		solve1(target,numbers,level,[])
		if len(solution) != 0: break
	print(numbers,'=>',target,'  (',round(time.time() - start,3),'sek )')
	for sol in solution: print('  ',sol)
	
solve(12,[1,2,3,4,5])
solve(11,[1,2,3,4,5])
solve(133,[4,5,8,11,15,20])
solve(218,[4,5,7,9,11,20])
solve(388,[3,5,9,20,23,25])
solve(462,[3,5,9,10,20,25])
