!classDefinition: #StackIsEmptyError category: 'StackPrimeraParte'!
Error subclass: #StackIsEmptyError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackIsEmptyError methodsFor: 'as yet unclassified' stamp: 'SM 10/7/2022 21:54:26'!
errorMessage
	^'stack is empty!!!!!!1!!!!uno'! !


!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: 'cat dog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:18:05'!
test01StackShouldBeEmptyWhenCreated
	| stack |
	self setUp.
	stack := Stack new.
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:22:32'!
test02StackShouldNotBeEmptyAfterPushingOneElement

	| stack |
	self setUp.
	stack := Stack new.
	stack push: cat.
	
	self deny: stack isEmpty! !

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:39:26'!
test03PopReturnsAndRemovesThePushedElement
	| stack |
	self setUp.
	stack := Stack new.
	stack push: cat.
	
	self assert: stack pop equals: cat.
	self assert: stack isEmpty.! !

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:32:00'!
test04PopReturnsAndRemovesLastPushedElement
	| stack |
	self setUp.
	stack := Stack new.
	stack push: cat.
	stack push: dog.
	self assert: stack pop equals: dog.
	self assert: stack pop equals: cat.! !

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:38:20'!
test05TopReturnsLastPushedElement
	| stack |
	self setUp.
	stack := Stack new.
	stack push: cat.
	stack push: dog.
	self assert: stack top equals: dog.
! !

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:38:36'!
test06TopReturnsLastPushedElementAndDoesNotRemoveIt
	|stack|
	self setUp.
	stack := Stack new.
	stack push: cat.
	stack push: dog.
	self assert: stack top equals: dog.
	self assert: stack pop equals: dog.! !

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:55:56'!
test07TryingToPopAnEmptyStackRaisesStackIsEmptyError
	|stack|
	self setUp.
	stack := Stack new.
	
	[stack pop] on: Error do: [:error| self assert: 'stack is empty!!!!!!1!!!!uno' equals: error errorMessage].! !

!StackTest methodsFor: 'testing' stamp: 'SM 10/7/2022 21:55:41'!
test08TryingToTopAnEmptyStackRaisesStackIsEmptyError
	|stack|
	self setUp.
	stack := Stack new.
	
	[stack top] on: Error do: [:error| self assert: 'stack is empty!!!!!!1!!!!uno' equals: error errorMessage].! !


!StackTest methodsFor: 'setUp' stamp: 'SM 10/7/2022 21:18:31'!
setUp
	cat:= 'cat'.
	dog:= 'dog'.! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'pila'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'instance creation' stamp: 'SM 10/7/2022 21:03:16'!
initialize
	pila:= OrderedCollection new.! !


!Stack methodsFor: 'adding' stamp: 'SM 10/7/2022 21:06:08'!
push: anElement
	pila addFirst: anElement.! !


!Stack methodsFor: 'testing' stamp: 'SM 10/7/2022 21:19:23'!
isEmpty
	^pila isEmpty.! !


!Stack methodsFor: 'as yet unclassified' stamp: 'SM 10/7/2022 21:45:35'!
pop
	pila isEmpty ifTrue: [^StackIsEmptyError signal]. ^pila removeFirst.! !

!Stack methodsFor: 'as yet unclassified' stamp: 'SM 10/7/2022 21:45:54'!
top
	pila isEmpty ifTrue: [^StackIsEmptyError signal]. ^pila at: 1.! !
