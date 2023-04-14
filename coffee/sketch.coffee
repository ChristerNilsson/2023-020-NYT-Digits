import _ from 'https://cdn.skypack.dev/lodash'
import {ass,r4r,signal,range,br,div,input,button} from '../js/utils.js'

ass [], [7,8].slice 0,0
ass [7], [7,8].slice 0,1
ass [8], [7,8].slice 1,2
ass [7,8], [7,8].slice 0,2

update = (lst,i,j,c) =>
	lst1 = lst.slice 0,i
	lst2 = lst1.concat(lst.slice i+1,j)
	lst3 = lst2.concat(lst.slice j+1)
	lst3 = lst3.concat([c])
	ass lst3.length,lst.length-1
	lst3
ass [13,23], update [11,12,13],0,1,23
ass [11,25], update [11,12,13],1,2,25
ass [12,24], update [11,12,13],0,2,24
ass [13,14,23], update [11,12,13,14],0,1,23
ass [12,14,24], update [11,12,13,14],0,2,24
ass [12,13,25], update [11,12,13,14],0,3,25
ass [11,14,25], update [11,12,13,14],1,2,25
ass [11,13,26], update [11,12,13,14],1,3,26
ass [11,12,27], update [11,12,13,14],2,3,27
ass [15,55,150], update [15,25,6,55],1,2,150

Digits = (target,numbers) =>
	[solutions,setSolutions] = signal []
	click = (t,n) => solve parseInt(t.value), n.value.split(' ').map (x) => parseInt x
	solve = (target, numbers) =>
		solution = "0123456789"
		solve1 = (target, lst, level, lines) =>
			if level==0 then return
			n = lst.length
			for i in range n-1
				for j in range i+1,n
					a = lst[i]
					b = lst[j]
					if a < b then [a,b] = [b,a]
					for op in "*+-/"
						c = 0
						if op == '+' then c = a + b
						if op == '-' then c = a - b
						if b != 1
							if op == '*' then c = a * b
							if op == '/' and a %% b == 0 then c = a // b
						if c > 0
							lines1 = lines.concat ["#{a} #{op} #{b} = #{c}"]
							lst3 = update lst,i,j,c
							if c == target
								if solution.length > lines1.length then solution = lines1
							else
								solve1 target,lst3,level-1,lines1

		start = new Date()
		if numbers.length > 6
			solution = ["Maximum six numbers"]
		else
			for level in range 2,6
				solve1 target,numbers,level,[]
				if solution.length != 10 then break
			if solution.length==10 then solution = ["No solution"]
		setSolutions solution
		console.log new Date() - start

	div {},
		div {},
			n = input {size:13, value:numbers}
			t = input {size:3, value:target}
			button {onclick: () => click t,n},"solve"
		=> for sol in solutions()
			div {}, sol
		br {}

r4r =>
	div {style:"text-align:center;font-size:2em"},
		Digits 9,'1 2 3'
		Digits 133,'4 5 8 11 15 20'
		Digits 218,'4 5 7 9 11 20'
		Digits 388,'3 5 9 20 23 25'
		Digits 462,'3 5 9 10 20 25'
