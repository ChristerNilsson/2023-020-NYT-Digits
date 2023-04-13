import _ from 'https://cdn.skypack.dev/lodash'
import {r4r,signal,range,br,div,input,button,abs} from '../js/utils.js'

Digits = (target,numbers) =>
	[solutions,setSolutions] = signal []
	solve = (t,n) =>
		for i in _.range 2000
			if solve1 t, _.cloneDeep n then break
	solve1 = (t,n) =>
		lines = []
		best = [1000,[]]
		while n.length >= 2
			n = _.shuffle n
			[a,b] = n.slice 0,2
			if a < b then [a,b] = [b,a]
			op = _.sample "+*-/"

			c = 0
			if op == '+' then c = a+b
			if op == '-' then c = a-b
			if b != 1
				if op == '*' then c=a*b
				if op == '/' and a %% b == 0 then c=a//b

			if c > 0
				lines.push "#{a} #{op} #{b} = #{c}"
				n.shift()
				n.shift()
				n.push c

				if abs(t-c) < best[0]
					best = [abs(t-c), lines.slice()]
					setSolutions best[1]
					if best[0] == 0 then return true

		false

	click = (t,n) => solve parseInt(t.value), n.value.split(' ').map (x) => parseInt x

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
		Digits 156,'25 15 11 7 3 2'
		Digits 117,'1 3 9 27 81 35'
		Digits 15,'4 2 1 1'
