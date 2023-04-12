import _ from 'https://cdn.skypack.dev/lodash'
import {r4r,signal,range,br,div,input,button} from '../js/utils.js'

Digits = (target,numbers) =>
	[solutions,setSolutions] = signal []
	solve = (t,n) => 0 while not solve1 t, _.cloneDeep n
	solve1 = (t,n) =>
		lines = []
		while n.length >= 2
			[a,b] = _.sampleSize n,2
			if a < b then [a,b] = [b,a]
			op = _.sample "+*-/"

			c = 0
			if op == '+' then c = a+b
			if op == '-' then c = a-b
			if op == '*' and b!=1 then c=a*b
			if op == '/' and a %% b == 0 and b!=1 then c=a//b

			if c > 0
				lines.push "#{a} #{op} #{b} = #{c}"
				_.remove n, (item) => item in [a,b]
				n.push c

			if c == t
				setSolutions lines
				return true
			false

	click = (t,n) => solve parseInt(t.value), n.value.split(' ').map (x) => parseInt x

	div {},
		div {},
			n = input {size:'13', value:numbers}
			t = input {size:'3', value:target}
			button {onclick: () => click t,n},"Enter"
		=> for sol in solutions()
			div {}, sol
		br {}

r4r =>
	div {style:"text-align:center;font-size:2em"},
		Digits 156,'25 15 11 7 3 2'
		Digits 117,'1 3 9 27 81 35'
