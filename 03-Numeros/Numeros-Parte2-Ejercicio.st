!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'SM 10/3/2022 20:25:38'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #InterfazOperacionesCruzadasEnteroFraccion category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #InterfazOperacionesCruzadasEnteroFraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!InterfazOperacionesCruzadasEnteroFraccion methodsFor: 'arithmetic operation' stamp: 'alm 10/3/2022 22:56:43'!
multiplicarEntero: anEntero conFraccion: aFraccion 
	^ Fraccion with: anEntero * aFraccion numerator over: aFraccion denominator.! !

!InterfazOperacionesCruzadasEnteroFraccion methodsFor: 'arithmetic operation' stamp: 'alm 10/4/2022 02:28:04'!
sumarEntero: anEntero conFraccion: aFraccion
		| newDenominator newNumerator |
		newDenominator := aFraccion denominator .
		newNumerator := aFraccion numerator + aFraccion denominator * anEntero.
		^ Fraccion with:		newNumerator over: newDenominator! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'alm 10/4/2022 03:14:53'!
inverse
	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value interfazOpCruzadasEnteroFraccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'SM 10/2/2022 20:21:20'!
* aMultiplier	
	^ aMultiplier multiplicarEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'SM 10/2/2022 20:21:27'!
+ anAdder 

	^ anAdder sumarEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'alm 10/4/2022 03:15:22'!
- aSubtrahend
	^ aSubtrahend negated + self.
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'alm 10/4/2022 03:15:31'!
/ aDivisor
	^ aDivisor inverse * self. "<-- obs: esto podr�a incluso ir en Numero"! !

!Entero methodsFor: 'arithmetic operations' stamp: 'alm 10/3/2022 22:28:58'!
fibonacci
	
	^self subclassResponsibility.
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'alm 10/4/2022 00:21:42'!
inverse
	^Fraccion with: (Entero with: 1) over: self.! !


!Entero methodsFor: 'comparing' stamp: 'SM 10/2/2022 20:29:12'!
= anObject
	^ anObject soyIgualAlEntero: self.! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'alm 10/4/2022 03:04:52'!
initializeWith: aValue
	value := aValue.
	interfazOpCruzadasEnteroFraccion := InterfazOperacionesCruzadasEnteroFraccion new.! !


!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'SM 10/3/2022 20:21:43'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'SM 10/3/2022 20:21:08'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'arithmetic operations - dd' stamp: 'SM 10/3/2022 20:23:53'!
multiplicarEntero: anEntero
	^Entero with: value * anEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'alm 10/4/2022 03:04:52'!
multiplicarFraccion: aFraccion
	^ interfazOpCruzadasEnteroFraccion multiplicarEntero: self conFraccion: aFraccion.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'alm 10/4/2022 02:43:10'!
sumarEntero: anEntero
	^ Entero with: value + anEntero integerValue.! !

!Entero methodsFor: 'arithmetic operations - dd' stamp: 'alm 10/4/2022 03:04:52'!
sumarFraccion: aFraccion
	^ interfazOpCruzadasEnteroFraccion sumarEntero: self conFraccion: aFraccion.! !


!Entero methodsFor: 'comparing - dd' stamp: 'SM 10/2/2022 20:28:04'!
soyIgualALaFraccion: aFraccion
	^false.! !

!Entero methodsFor: 'comparing - dd' stamp: 'SM 10/2/2022 20:26:13'!
soyIgualAlEntero: anEntero
	^value = anEntero integerValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'SM 10/3/2022 20:05:38'!
newInitializeWith: aValue
	^self new initializeWith: aValue.! !

!Entero class methodsFor: 'instance creation' stamp: 'SM 10/3/2022 20:38:25'!
with: aValue 
	|subclass|
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	"^self new initializeWith: aValue"
	subclass:= (self subclasses detect: [:aSubclass | aSubclass estaEnTuRango: aValue]).
	^ subclass newInitializeWith: aValue.! !


!Entero class methodsFor: 'private' stamp: 'SM 10/3/2022 20:38:25'!
estaEnTuRango: aValue
	^self subclassResponsibility.! !


!classDefinition: #EnteroCeroOUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroCeroOUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroCeroOUno methodsFor: 'arithmetic operations' stamp: 'SM 10/3/2022 20:26:56'!
fibonacci
	^Entero with: 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroCeroOUno class' category: 'Numeros-Parte2-Ejercicio'!
EnteroCeroOUno class
	instanceVariableNames: ''!

!EnteroCeroOUno class methodsFor: 'private' stamp: 'SM 10/3/2022 20:32:13'!
esUnoOCero: aValue
 ^ (aValue = 0) or: (aValue = 1).! !

!EnteroCeroOUno class methodsFor: 'private' stamp: 'SM 10/3/2022 20:39:58'!
estaEnTuRango: aValue
	^ self esUnoOCero: aValue.! !


!classDefinition: #EnteroMenorACero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroMenorACero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroMenorACero methodsFor: 'arithmetic operations' stamp: 'SM 10/3/2022 19:56:37'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroMenorACero class' category: 'Numeros-Parte2-Ejercicio'!
EnteroMenorACero class
	instanceVariableNames: ''!

!EnteroMenorACero class methodsFor: 'private' stamp: 'SM 10/3/2022 19:52:17'!
esEnteroNegativo: aValue
	^ aValue < 0.! !

!EnteroMenorACero class methodsFor: 'private' stamp: 'SM 10/3/2022 20:39:19'!
estaEnTuRango: aValue
	^ self esEnteroNegativo: aValue.! !


!classDefinition: #EnteroPositivoMayorAUno category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #EnteroPositivoMayorAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!EnteroPositivoMayorAUno methodsFor: 'arithmetic operations' stamp: 'SM 10/3/2022 20:31:27'!
fibonacci
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EnteroPositivoMayorAUno class' category: 'Numeros-Parte2-Ejercicio'!
EnteroPositivoMayorAUno class
	instanceVariableNames: ''!

!EnteroPositivoMayorAUno class methodsFor: 'private' stamp: 'SM 10/3/2022 20:33:17'!
esEnteroPositivoMayorAUno: aValue
	^ (aValue>1).! !

!EnteroPositivoMayorAUno class methodsFor: 'private' stamp: 'SM 10/3/2022 20:39:49'!
estaEnTuRango: aValue
	^ self esEnteroPositivoMayorAUno: aValue.! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator interfazOpCruzadasEnteroFraccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'alm 10/3/2022 22:30:46'!
* aMultiplier
	^ aMultiplier multiplicarFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'SM 10/2/2022 20:21:51'!
+ anAdder 
	^ anAdder sumarFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'alm 10/4/2022 03:16:35'!
- aSubtrahend
	^ (self negated + aSubtrahend ) negated.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'alm 10/4/2022 03:16:47'!
/ aDivisor
	^ aDivisor inverse * self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'alm 10/4/2022 00:22:09'!
inverse
	^Fraccion with: denominator over: numerator.! !


!Fraccion methodsFor: 'comparing' stamp: 'SM 10/2/2022 20:29:03'!
= anObject
	^ anObject soyIgualALaFraccion: self.! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'alm 10/4/2022 03:05:12'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator.
	interfazOpCruzadasEnteroFraccion := InterfazOperacionesCruzadasEnteroFraccion new.! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'comparing - dd' stamp: 'SM 10/2/2022 20:28:12'!
soyIgualALaFraccion: aFraccion
	^(numerator * aFraccion denominator) = (denominator * aFraccion numerator).! !

!Fraccion methodsFor: 'comparing - dd' stamp: 'SM 10/2/2022 20:26:34'!
soyIgualAlEntero: anEntero
	^false.! !


!Fraccion methodsFor: 'arithmetic operations - dd' stamp: 'alm 10/4/2022 03:05:12'!
multiplicarEntero: anEntero
	^ interfazOpCruzadasEnteroFraccion multiplicarEntero: anEntero conFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations - dd' stamp: 'alm 10/4/2022 02:44:11'!
multiplicarFraccion: aFraccion
	^ (numerator * aFraccion numerator) / (denominator * aFraccion denominator)! !

!Fraccion methodsFor: 'arithmetic operations - dd' stamp: 'alm 10/4/2022 03:05:12'!
sumarEntero: anEntero
	^ interfazOpCruzadasEnteroFraccion sumarEntero: anEntero conFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations - dd' stamp: 'alm 10/4/2022 02:44:48'!
sumarFraccion: aFraccion
	| newDenominator newNumerator |
	newNumerator := (numerator * aFraccion denominator) + (denominator * aFraccion numerator).
	newDenominator := denominator * aFraccion denominator.
	^newNumerator / newDenominator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
