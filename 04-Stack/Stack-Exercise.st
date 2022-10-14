!classDefinition: #LimiteError category: 'Stack-Exercise'!
Error subclass: #LimiteError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!LimiteError methodsFor: 'error desciption' stamp: 'alm 10/13/2022 21:57:30'!
messageText
	^'El límite debe ser entero positivo'.! !


!classDefinition: #PrefixError category: 'Stack-Exercise'!
Error subclass: #PrefixError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixError methodsFor: 'error description' stamp: 'SM 10/10/2022 21:24:16'!
messageText
 ^'prefix cannot be empty nor include spaces'.! !


!classDefinition: #StackError category: 'Stack-Exercise'!
Error subclass: #StackError
	instanceVariableNames: 'pila'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackError methodsFor: 'error description' stamp: 'alm 10/10/2022 19:07:15'!
messageText
	^'stack is empty!!!!!!'! !


!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:18'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:23'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:26'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:30'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:36'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:41'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/11/2022 21:19:21'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError|
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/11/2022 21:19:29'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/11/2022 21:19:36'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #OOStackTestForLimits category: 'Stack-Exercise'!
TestCase subclass: #OOStackTestForLimits
	instanceVariableNames: 'stack e1 e2 e3 e4'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTestForLimits methodsFor: 'assertions' stamp: 'alm 10/13/2022 22:01:53'!
assertInvalidLimitRaisesError: aLimit

	^ self should: [OOStack with: aLimit.]
		raise: LimiteError
		withExceptionDo: [:anError | self assert: 'El límite debe ser entero positivo' equals: anError messageText]! !


!OOStackTestForLimits methodsFor: 'tests' stamp: 'alm 10/13/2022 22:10:15'!
test01StackWithLimitOf3CannotPushA4thElement
	
	stack:=OOStack with: 3.	
	stack push: 'hola1'.
	stack push: 'hola2'.
	stack push: 'hola3'.	
	stack push: 'hola4'.
		
	self assert: stack size  equals: 3.
! !

!OOStackTestForLimits methodsFor: 'tests' stamp: 'alm 10/13/2022 22:10:06'!
test02StackWithLimitOf3CannotPushA4thElement
	
	stack:=OOStack with: 3.
	stack push: 'hola1'.
	stack push: 'hola2'.
	stack push: 'hola3'.
	stack push: 'hola4'.
			
	self assert: stack pop  equals: 'hola3'.
! !

!OOStackTestForLimits methodsFor: 'tests' stamp: 'alm 10/13/2022 22:02:13'!
test03StackWithNegativeLimitRaisesLimiteError
	
	self assertInvalidLimitRaisesError: -2! !

!OOStackTestForLimits methodsFor: 'tests' stamp: 'alm 10/13/2022 22:02:06'!
test04StackWithZeroLimitRaisesLimiteError
	
	self assertInvalidLimitRaisesError: 0
! !

!OOStackTestForLimits methodsFor: 'tests' stamp: 'alm 10/13/2022 22:01:36'!
test05StackWithFractionLimitRaisesLimiteError
	
	self assertInvalidLimitRaisesError: 3/2
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder stack foundElementsStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'alm 10/13/2022 19:00:43'!
setUp
	stack := OOStack new.
	stack push: 'calabozo'.
	stack push: 'calamar'.
	stack push: 'Calabaza'.
	stack push: 'calamidad'.
	stack push: 'fiuba'.
	stack push: 'Calavera'.
	stack push: 'Calabresa'.
	stack push: 'casa'.
	sentenceFinder:= SentenceFinderByPrefix new.! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 19:34:05'!
test01FindPrefixInStackReturnsANewStackWithTheMatchedStrings
	
	self setUp.
	
	foundElementsStack := sentenceFinder find: 'Cala' in: stack. 
	
	self assert: foundElementsStack size equals: 3.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 19:01:39'!
test02FindPrefixInStackKeepsOriginalStackUnmodified
	
	self setUp.
	
	sentenceFinder find: 'Cala' in: stack.
	
	self assert: stack pop equals: 'casa'.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 22:20:43'!
test03CantUseEmptyStringAsPrefix
	self setUp.
	self assertInvalidPrefixRaisesError: ''! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 22:21:13'!
test04CantUseStringWithSpacesAsPrefix
	self setUp.
	self assertInvalidPrefixRaisesError: 'Cala baza'! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 19:34:05'!
test05FindPrefixInStackReturnsAnEmptyStackWhenNoMatchesAreFound
	
	self setUp.
	
	foundElementsStack := sentenceFinder find: 'Bote' in: stack. 
	
	self assert: foundElementsStack size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 19:34:05'!
test06FindPrefixInStackReturnsANewStackWithTheMatchedStrings
	
	self setUp.
	
	foundElementsStack := sentenceFinder find: 'fi' in: stack. 
	
	self assert: foundElementsStack size equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 22:29:35'!
test07FindPrefixInStackReturnsANewStackWithTheCaseSensitiveMatchedStrings
	
	self setUp.
	
	foundElementsStack := sentenceFinder find: 'Fi' in: stack. 
	
	self assert: foundElementsStack size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 22:37:07'!
test08FindPrefixInStackOnlyReturnsMatchIfPrefixIsAtTheStartOfTheString
	
	self setUp.
	
	foundElementsStack := sentenceFinder find: 'uba' in: stack. 
	
	self assert: foundElementsStack size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 22:38:37'!
test09PrefixEqualToTheWholeStringIsAMatch
	
	self setUp.
	
	foundElementsStack := sentenceFinder find: 'fiuba' in: stack. 
	
	self assert: foundElementsStack size equals: 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'alm 10/13/2022 22:41:19'!
test10FindPrefixInEmptyStackReturnsEmptyStack
	
	self setUp.
	
	foundElementsStack := sentenceFinder find: 'Fi' in: OOStack new. 
	
	self assert: foundElementsStack size equals: 0.! !


!SentenceFinderByPrefixTest methodsFor: 'assertions' stamp: 'alm 10/13/2022 22:20:43'!
assertInvalidPrefixRaisesError: aPrefix

	^ self
		should: [ 	sentenceFinder find: aPrefix in: stack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError|
			self assert: 'prefix cannot be empty nor include spaces' equals: anError messageText ]! !


!classDefinition: #Apilable category: 'Stack-Exercise'!
Object subclass: #Apilable
	instanceVariableNames: 'string elementoDeAbajo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Apilable methodsFor: 'accessing' stamp: 'SM 10/11/2022 21:12:12'!
darValue
	self subclassResponsibility.! !

!Apilable methodsFor: 'accessing' stamp: 'alm 10/13/2022 20:13:46'!
obtenerPosicion
	self subclassResponsibility.! !


!Apilable methodsFor: 'testing' stamp: 'SM 10/11/2022 20:58:24'!
esBase
	self subclassResponsibility.! !


!Apilable methodsFor: 'operations' stamp: 'SM 10/11/2022 21:07:26'!
bajarTope
	self subclassResponsibility.! !


!classDefinition: #Base category: 'Stack-Exercise'!
Apilable subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'operations' stamp: 'SM 10/11/2022 21:08:16'!
bajarTope
	^StackError signal.! !


!Base methodsFor: 'accessing' stamp: 'SM 10/11/2022 21:11:56'!
darValue
	^StackError signal.! !

!Base methodsFor: 'accessing' stamp: 'SM 10/11/2022 21:28:19'!
obtenerPosicion
	^0.! !


!Base methodsFor: 'testing' stamp: 'SM 10/11/2022 20:57:50'!
esBase
	^true.! !


!classDefinition: #Elemento category: 'Stack-Exercise'!
Apilable subclass: #Elemento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Elemento methodsFor: 'operations' stamp: 'SM 10/11/2022 21:07:36'!
bajarTope
	^elementoDeAbajo.! !

!Elemento methodsFor: 'operations' stamp: 'SM 10/11/2022 20:54:15'!
serTopeDe: topeViejo
	elementoDeAbajo:= topeViejo
	! !


!Elemento methodsFor: 'accessing' stamp: 'SM 10/11/2022 21:09:33'!
darValue
	^string! !

!Elemento methodsFor: 'accessing' stamp: 'SM 10/11/2022 21:28:44'!
obtenerPosicion
	^ elementoDeAbajo obtenerPosicion + 1.! !


!Elemento methodsFor: 'testing' stamp: 'SM 10/11/2022 20:58:08'!
esBase
	^false.! !


!Elemento methodsFor: 'instance creation' stamp: 'SM 10/11/2022 21:03:59'!
withString: aString
	string := aString.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Elemento class' category: 'Stack-Exercise'!
Elemento class
	instanceVariableNames: ''!

!Elemento class methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:03:29'!
with: aString
	^(Elemento new) withString: aString.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'tope size limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'instance creation' stamp: 'alm 10/13/2022 21:34:37'!
initialize
	size:= 0.
	tope := TopeSinLimite new.! !

!OOStack methodsFor: 'instance creation' stamp: 'alm 10/13/2022 21:35:23'!
withLimit: aLimit
	tope := TopeConLimite withLimit: aLimit.! !


!OOStack methodsFor: 'testing' stamp: 'alm 10/13/2022 20:37:03'!
isEmpty
	^tope isEmpty.! !


!OOStack methodsFor: 'accessing' stamp: 'SM 10/11/2022 21:29:04'!
size
	^tope obtenerPosicion.! !


!OOStack methodsFor: 'error description' stamp: 'SM 10/10/2022 20:19:44'!
stackEmptyErrorDescription
	^ 'stack is empty!!!!!!'.! !


!OOStack methodsFor: 'operations' stamp: 'alm 10/13/2022 20:51:32'!
pop
	^ tope popTope.! !

!OOStack methodsFor: 'operations' stamp: 'alm 10/13/2022 21:40:30'!
push: anElement
	|nuevoElemento|
	nuevoElemento:= Elemento with: anElement.
	tope := tope subirTopeA: nuevoElemento.! !

!OOStack methodsFor: 'operations' stamp: 'SM 10/11/2022 21:12:31'!
top
	^tope darValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:18:52'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'.! !

!OOStack class methodsFor: 'as yet unclassified' stamp: 'alm 10/13/2022 20:08:49'!
with: aLimit
	^ OOStack new withLimit: aLimit.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'foundElementsStack alternativeStack prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'alm 10/13/2022 19:51:04'!
find: aPrefix in: stack
	self setUp: aPrefix.
	
	self prefixValid.
	[stack isEmpty not] whileTrue: [self findMatchedElementsIn: stack].
	
	self reorganize: stack.
	^foundElementsStack.! !


!SentenceFinderByPrefix methodsFor: 'setup' stamp: 'alm 10/13/2022 19:44:55'!
setUp: aPrefix
	prefix := aPrefix.
	foundElementsStack:= OOStack new.
	alternativeStack:= OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'private - sorting' stamp: 'alm 10/13/2022 19:40:52'!
reorganize: originalStack
	[alternativeStack isEmpty not] whileTrue: [
		originalStack push: alternativeStack pop].
! !


!SentenceFinderByPrefix methodsFor: 'private - enumerating' stamp: 'alm 10/13/2022 19:52:10'!
findMatchedElementsIn: stack
	|stackElement|
	stackElement := stack pop.
	(self elementMatchesPrefix: stackElement) ifTrue: [foundElementsStack push: stackElement ].
	alternativeStack push: stackElement.! !


!SentenceFinderByPrefix methodsFor: 'private - comparing' stamp: 'alm 10/13/2022 19:52:19'!
elementMatchesPrefix: stackElement
	^ stackElement is: prefix substringAt: 1! !

!SentenceFinderByPrefix methodsFor: 'private - comparing' stamp: 'alm 10/13/2022 19:47:18'!
prefixValid
	(prefix isEmpty or: (prefix includesSubString: ' ')) ifTrue: [PrefixError signal].
! !


!classDefinition: #Tope category: 'Stack-Exercise'!
Object subclass: #Tope
	instanceVariableNames: 'elementoDelTope limite'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Tope methodsFor: 'operations' stamp: 'alm 10/13/2022 20:50:58'!
popTope
	| topeADevolver |
	topeADevolver := elementoDelTope.
	elementoDelTope := topeADevolver bajarTope.
	^topeADevolver darValue.! !

!Tope methodsFor: 'operations' stamp: 'alm 10/13/2022 22:26:30'!
subirTopeA: nuevoElemento 
	^ self subclassResponsibility.! !


!Tope methodsFor: 'accessing' stamp: 'alm 10/13/2022 20:46:23'!
darValue
	^elementoDelTope darValue.! !

!Tope methodsFor: 'accessing' stamp: 'alm 10/13/2022 20:48:31'!
obtenerPosicion
	^ elementoDelTope obtenerPosicion.! !


!Tope methodsFor: 'testing' stamp: 'alm 10/13/2022 20:46:23'!
isEmpty
	^elementoDelTope esBase.! !


!Tope methodsFor: 'instance creation' stamp: 'alm 10/13/2022 20:46:23'!
initialize
	elementoDelTope := Base new.
	! !


!Tope methodsFor: 'private' stamp: 'alm 10/13/2022 21:31:11'!
actualizarTopeA: nuevoElemento
	nuevoElemento serTopeDe: elementoDelTope.
	elementoDelTope := nuevoElemento.
	^ self.! !


!classDefinition: #TopeConLimite category: 'Stack-Exercise'!
Tope subclass: #TopeConLimite
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!TopeConLimite methodsFor: 'instance creation' stamp: 'alm 10/13/2022 21:53:17'!
withLimit: aLimit
	(aLimit strictlyPositive and: aLimit isInteger) ifFalse: [LimiteError signal].
	limite := aLimit.! !


!TopeConLimite methodsFor: 'private' stamp: 'alm 10/13/2022 21:45:52'!
limiteDeElementosNoSuperado

	^ elementoDelTope obtenerPosicion < limite! !


!TopeConLimite methodsFor: 'operations' stamp: 'alm 10/13/2022 21:45:52'!
subirTopeA: nuevoElemento 
	(self limiteDeElementosNoSuperado) ifTrue: [ ^ self actualizarTopeA: nuevoElemento ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TopeConLimite class' category: 'Stack-Exercise'!
TopeConLimite class
	instanceVariableNames: ''!

!TopeConLimite class methodsFor: 'as yet unclassified' stamp: 'alm 10/13/2022 21:37:45'!
withLimit: aLimit
	^ TopeConLimite new withLimit: aLimit.
	! !


!classDefinition: #TopeSinLimite category: 'Stack-Exercise'!
Tope subclass: #TopeSinLimite
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!TopeSinLimite methodsFor: 'operations' stamp: 'alm 10/13/2022 21:42:02'!
subirTopeA: nuevoElemento 
	^ self actualizarTopeA: nuevoElemento.! !
