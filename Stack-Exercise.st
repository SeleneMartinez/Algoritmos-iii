!classDefinition: #PrefixError category: 'Stack-Exercise'!
Error subclass: #PrefixError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixError methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:24:16'!
messageText
 ^'prefix cannot be empty nor include spaces'.! !


!classDefinition: #StackError category: 'Stack-Exercise'!
Error subclass: #StackError
	instanceVariableNames: 'pila'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackError methodsFor: 'as yet unclassified' stamp: 'alm 10/10/2022 19:07:15'!
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


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:11:30'!
test01FindPrefixInSTackReturnsANewSTackWithTheMatchedStrings
	|sentenceFinder stack stackPrefix|
	stack := OOStack new.
	stack push: 'calabozo'.
	stack push: 'calamar'.
	stack push: 'Calabaza'.
	stack push: 'calamidad'.
	stack push: 'fiuba'.
	stack push: 'Calavera'.
	stack push: 'Calabresa'.
	stack push: 'casa'.
	sentenceFinder:= SentenceFinderByPrefix new.
	stackPrefix := sentenceFinder find: 'Cala' in: stack. 
	
	self assert: stackPrefix size equals: 3.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:09:31'!
test02FindPrefixInStackKeepsOriginalStackUnmodified
	|sentenceFinder stack|
	stack := OOStack new.
	stack push: 'calabozo'.
	stack push: 'calamar'.
	stack push: 'Calabaza'.
	stack push: 'calamidad'.
	stack push: 'fiuba'.
	stack push: 'Calavera'.
	stack push: 'Calabresa'.
	stack push: 'casa'.
	sentenceFinder:= SentenceFinderByPrefix new.
	sentenceFinder find: 'Cala' in: stack.
	
	self assert: stack pop equals: 'casa'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:25:31'!
test03CantUseEmptyStringAsPrefix
	|sentenceFinder stack|
	stack := OOStack new.
	stack push: 'calabozo'.
	stack push: 'calamar'.
	stack push: 'Calabaza'.
	stack push: 'calamidad'.
	stack push: 'fiuba'.
	stack push: 'Calavera'.
	stack push: 'Calabresa'.
	stack push: 'casa'.
	sentenceFinder:= SentenceFinderByPrefix new.
	self
		should: [ 	sentenceFinder find: '' in: stack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError|
			self assert: 'prefix cannot be empty nor include spaces' equals: anError messageText ]
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:26:34'!
test04CantUseStringWithSpacesAsPrefix
	|sentenceFinder stack|
	stack := OOStack new.
	stack push: 'calabozo'.
	stack push: 'calamar'.
	stack push: 'Calabaza'.
	stack push: 'calamidad'.
	stack push: 'fiuba'.
	stack push: 'Calavera'.
	stack push: 'Calabresa'.
	stack push: 'casa'.
	sentenceFinder:= SentenceFinderByPrefix new.
	self
		should: [ 	sentenceFinder find: 'Cala baza' in: stack. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError|
			self assert: 'prefix cannot be empty nor include spaces' equals: anError messageText ]
	! !


!classDefinition: #Apilable category: 'Stack-Exercise'!
Object subclass: #Apilable
	instanceVariableNames: 'string elementoDeAbajo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Apilable methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:07:26'!
bajarTope
	self subclassResponsibility.! !

!Apilable methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:12:12'!
darValue
	self subclassResponsibility.! !

!Apilable methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 20:58:24'!
esBase
	self subclassResponsibility.! !

!Apilable methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 20:54:03'!
serTopeDe: topeViejo
	self subclassResponsibility.	! !


!classDefinition: #Base category: 'Stack-Exercise'!
Apilable subclass: #Base
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Base methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:08:16'!
bajarTope
	^StackError signal.! !

!Base methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:11:56'!
darValue
	^StackError signal.! !

!Base methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 20:57:50'!
esBase
	^true.! !

!Base methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:28:19'!
obtenerPosicion
	^0.! !

!Base methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:27:31'!
posicion
	^0.! !

!Base methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 20:54:28'!
serTopeDe: topeViejo
		! !


!classDefinition: #Elemento category: 'Stack-Exercise'!
Apilable subclass: #Elemento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Elemento methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:07:36'!
bajarTope
	^elementoDeAbajo.! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:09:33'!
darValue
	^string! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 20:58:08'!
esBase
	^false.! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:28:44'!
obtenerPosicion
	^ elementoDeAbajo obtenerPosicion + 1.! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 20:54:15'!
serTopeDe: topeViejo
	elementoDeAbajo:= topeViejo
	! !

!Elemento methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:03:59'!
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
	instanceVariableNames: 'tope size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:14:46'!
initialize
	tope := Base new.
	size:= 0.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 20:57:11'!
isEmpty
	^tope esBase.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:16:14'!
pop
|elementToReturn|
	elementToReturn:= tope.
	tope:= tope bajarTope.
	size:= size - 1.
	^elementToReturn darValue.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:17:07'!
push: anElement
	|nuevoElemento|
	nuevoElemento:= Elemento with: anElement.
	nuevoElemento serTopeDe: tope.
	size := size + 1.
	tope := nuevoElemento.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:29:04'!
size
	^tope obtenerPosicion.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:19:44'!
stackEmptyErrorDescription
	^ 'stack is empty!!!!!!'.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:12:31'!
top
	^tope darValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'as yet unclassified' stamp: 'SM 10/11/2022 21:18:52'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:21:42'!
find: prefix in: stack
	|stackElement stackAlternative stackPrefix|
	self prefixValid: prefix.
	stackPrefix:= OOStack new.
	stackAlternative:= OOStack new.
	[stack isEmpty not] whileTrue: [
	stackElement := stack pop.
	(stackElement is: prefix substringAt: 1) ifTrue: [stackPrefix push: stackElement ].
	stackAlternative push: stackElement.].
	self reorganize: stackAlternative in: stack.
	^stackPrefix.! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:31:34'!
prefixValid: aPrefix
	(aPrefix isEmpty or: (aPrefix includesSubString: ' ')) ifTrue: [PrefixError signal].
! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 21:06:40'!
reorganize: alternativeStack in: originalStack
	[alternativeStack isEmpty not] whileTrue: [
		originalStack push: alternativeStack pop].
! !
