!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:34:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	self setUpCustomerBook.
	self assert: (self timeController: [customerBook addCustomerNamed: 'John Lennon']) < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:35:34'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| paulMcCartney |
	self setUpCustomerBook.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.

	self assert: (self timeController: [customerBook removeCustomerNamed: paulMcCartney.]) < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:53:09'!
test03CanNotAddACustomerWithEmptyName 
	self setUpCustomerBook.
		self whenExecuting: [ customerBook addCustomerNamed: ''.] raises: Error andAsserts: [ :anError | self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:38:29'!
test04CanNotRemoveAnInvalidCustomer
	| johnLennon |
			
	self setUpCustomerBook.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self theOnlyCustomerIs: johnLennon AndWhenExecuting: [ customerBook removeCustomerNamed: 'Paul McCartney'.] raises: NotFound.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:41:01'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
	self setUpCustomerBook.
	self addAndSuspend: paulMcCartney.
	
	self numberOfActiveCustomersIs: 0 suspendedIs: 1 andTheTotalIs: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:43:57'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|
	self setUpCustomerBook.	
	paulMcCartney:= 'Paul McCartney'.
	self addAndSuspend: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	self numberOfActiveCustomersIs: 0 suspendedIs: 0 andTheTotalIs: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney ).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:42:05'!
test07CanNotSuspendAnInvalidCustomer
	
	| johnLennon |
			
	self setUpCustomerBook.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self theOnlyCustomerIs: johnLennon AndWhenExecuting: [ customerBook suspendCustomerNamed: 'Ringo Starr'.]  raises: CantSuspend.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'SM 9/25/2022 20:43:02'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| johnLennon |
			
	self setUpCustomerBook.
	johnLennon := 'John Lennon'.
	self addAndSuspend: johnLennon.
	
	self theOnlyCustomerIs: johnLennon AndWhenExecuting:	[ customerBook suspendCustomerNamed: johnLennon.]  raises: CantSuspend.
! !


!CustomerBookTest methodsFor: 'nil' stamp: 'SM 9/25/2022 19:13:45'!
timeController: aBlock
	| millisecondsAfterRunning millisecondsBeforeRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	^ millisecondsAfterRunning - millisecondsBeforeRunning.
! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'SM 9/25/2022 20:39:09'!
addAndSuspend: aName
	customerBook addCustomerNamed: aName.
	customerBook suspendCustomerNamed: aName.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'SM 9/25/2022 20:28:02'!
initialize
"customerBook:= CustomerBook new.
paulMcCartney:= 'Paul McCartney'.
johnLennon:= 'John Lennon'."! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'SM 9/25/2022 20:40:11'!
numberOfActiveCustomersIs: active suspendedIs: suspended andTheTotalIs: total
	self assert: active equals: customerBook numberOfActiveCustomers.
	self assert: suspended equals: customerBook numberOfSuspendedCustomers.
	self assert: total equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'SM 9/25/2022 20:33:16'!
setUpCustomerBook
customerBook := CustomerBook new.
! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'SM 9/25/2022 20:48:17'!
theOnlyCustomerIs: aName AndWhenExecuting: aBlock raises: anError

self whenExecuting: aBlock raises: anError andAsserts: [
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: aName) ]! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'SM 9/25/2022 20:46:44'!
whenExecuting: aBlock raises: anError andAsserts: anotherBlock
	[aBlock value. self fail ] on: anError 		do: [ :error | anotherBlock value].! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'SM 9/25/2022 18:42:50'!
addCustomerNamed: aName
"
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName "
		aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'SM 9/25/2022 18:44:46'!
numberOfCustomers
	
	"^active size + suspended size"
	^(self numberOfActiveCustomers  + self numberOfSuspendedCustomers )! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'SM 9/25/2022 18:58:19'!
removeCustomerNamed: aName 
 
	"1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	]."

active remove: aName ifAbsent: [ suspended remove: aName ifAbsent: [ ^NotFound signal]].
^aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'SM 9/25/2022 19:02:51'!
suspendCustomerNamed: aName 
	
	active remove: aName ifAbsent: [^CantSuspend signal].	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !


!classDefinition: #NameOfSubclass category: 'CodigoRepetido-Ejercicio'!
Object subclass: #NameOfSubclass
	instanceVariableNames: 'customerBook paulMcCartney johnLennon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!
