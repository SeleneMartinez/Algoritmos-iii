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

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:43'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError|
			self assert: OOStackPopulated stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:46'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStackPopulated stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'SM 10/10/2022 20:17:49'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStackPopulated stackEmptyErrorDescription equals: anError messageText ]
		
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


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:17:11'!
initialize
	stack := OOStackEmpty new.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:18:23'!
isEmpty
	^stack isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:16:54'!
pop
|elementToReturn|
	elementToReturn:= stack pop.
	stack isEmpty ifTrue: [stack := OOStackEmpty new].
	^elementToReturn.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:21:13'!
push: anElement
	stack:= stack push: anElement.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:17:02'!
size
	^stack size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:19:44'!
stackEmptyErrorDescription
	^ 'stack is empty!!!!!!'.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:17:06'!
top
	^stack top.! !


!classDefinition: #OOStackEmpty category: 'Stack-Exercise'!
Object subclass: #OOStackEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmpty methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:18:37'!
isEmpty
	^true.! !

!OOStackEmpty methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 19:49:40'!
pop
	^StackError signal! !

!OOStackEmpty methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:26:08'!
push: anElement
	|populatedStack|
	populatedStack:= OOStackPopulated new.
	^ populatedStack push: anElement.
! !

!OOStackEmpty methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 20:19:19'!
size
	^0.! !

!OOStackEmpty methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 19:49:59'!
top
	^StackError signal! !


!classDefinition: #OOStackPopulated category: 'Stack-Exercise'!
Object subclass: #OOStackPopulated
	instanceVariableNames: 'pila'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackPopulated methodsFor: 'instance creation' stamp: 'alm 10/10/2022 19:00:37'!
initialize
	pila:= OrderedCollection new.! !


!OOStackPopulated methodsFor: 'testing' stamp: 'alm 10/10/2022 19:01:15'!
isEmpty
	^pila isEmpty.! !


!OOStackPopulated methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 19:50:17'!
pop
	^pila removeFirst.! !

!OOStackPopulated methodsFor: 'as yet unclassified' stamp: 'alm 10/10/2022 19:08:28'!
size
	^ pila size.! !

!OOStackPopulated methodsFor: 'as yet unclassified' stamp: 'SM 10/10/2022 19:50:24'!
top
	^pila at: 1.! !


!OOStackPopulated methodsFor: 'adding' stamp: 'SM 10/10/2022 20:25:57'!
push: anElement
	pila addFirst: anElement.
	^self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackPopulated class' category: 'Stack-Exercise'!
OOStackPopulated class
	instanceVariableNames: ''!

!OOStackPopulated class methodsFor: 'error descriptions' stamp: 'alm 10/10/2022 19:12:55'!
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
