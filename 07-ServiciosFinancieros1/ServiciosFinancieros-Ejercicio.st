!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: 'extractionAccount depositAccount transference accountA portfolioA portfolioB accountADeposit account1 account2 depositOnAccount1 portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'receptiveAccountTests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'receptiveAccountTests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'receptiveAccountTests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'receptiveAccountTests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'receptiveAccountTests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'receptiveAccountTests' stamp: 'alm 11/7/2022 18:15:23'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'receptiveAccountTests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/9/2022 18:10:46'!
setUpTransference
	
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	Deposit register: 10 * peso on: extractionAccount.
	
	transference := Transference register: 10 * peso from: extractionAccount to: depositAccount.
	! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/9/2022 18:11:58'!
test08transferenceIncreasesBalanceOfDepositAccountOnTransferenceValue

	self setUpTransference.
	
	self assert: 10 * peso equals: depositAccount balance
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/9/2022 18:11:50'!
test09transferenceDecreasesBalanceOfExtractionAccountOnTransferenceValue

	self setUpTransference.
	
	self assert: 0 * peso equals: extractionAccount balance
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/9/2022 18:11:40'!
test10depositAccountKnowsItsTransferenceCounterpart

	self setUpTransference.
	
	self assert: extractionAccount equals: (depositAccount counterpartFor: transference)
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/9/2022 18:11:32'!
test11extractionAccountKnowsItsTransferenceCounterpart

	self setUpTransference.
	
	self assert: depositAccount equals: (extractionAccount counterpartFor: transference)
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/9/2022 18:11:12'!
test12transferenceValueMustBePositive

	self setUpTransference.
	
	self assert: 10 * peso equals: transference value.
! !


!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/9/2022 18:41:13'!
createPortfolioContainingTwoAccountsWithaTotalBalanceOf300
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	depositOnAccount1 := Deposit register: 100 * peso on: account1.
	Deposit register: 200 * peso on: account2.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/9/2022 18:44:46'!
test13BalanceOfPortfolioIsBalanceOfItsAccounts

	|  anAccount aPortfolio |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: anAccount.
	
	self assert: 100 * peso equals: aPortfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/9/2022 18:42:22'!
test14BalanceOfPortfolioIsSumOfBalanceOfItsAccounts

	self createPortfolioContainingTwoAccountsWithaTotalBalanceOf300.
	
	self assert: 300 * peso equals: portfolio balance.! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/9/2022 18:43:46'!
test15BalanceOfPortfolioIsZeroIfEmpty

	| portfolioVacio |
	
	portfolioVacio := Portfolio new.
	
	self assert: 0 * peso equals: portfolioVacio balance.
! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/9/2022 18:42:44'!
test16PortfolioKnowsRegisteredTransactionOfItsAccounts

	self createPortfolioContainingTwoAccountsWithaTotalBalanceOf300.	
	
	self assert: (portfolio hasRegistered: depositOnAccount1).! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/9/2022 18:43:06'!
test17PortfolioKnowsTheTransactionsOfItsAccounts
	
	self createPortfolioContainingTwoAccountsWithaTotalBalanceOf300.
	
	self assert: 2 equals: (portfolio transactions size).
	self assert: (portfolio transactions includes: depositOnAccount1).
! !


!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'alm 11/9/2022 18:36:52'!
setUpPortfoliosForContainCaseTests

	accountA := ReceptiveAccount new.
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	accountADeposit := Deposit register: 100 *  peso on: accountA.! !

!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'alm 11/9/2022 18:36:52'!
test19addingAnAccountMoreThanOnceToAPortfolioJustAddsItOnce
"Caso 1 del enunciado"

	self setUpPortfoliosForContainCaseTests.
	
	portfolioA add: accountA.
	portfolioA add: accountA.
	
	self assert: 1 equals: portfolioA transactions size.! !

!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'alm 11/9/2022 18:36:53'!
test20addingAPortfolioToAnotherPortfolioThatContainsTheSameAccountDoesNotAddIt
"Caso 5 del enunciado"

	self setUpPortfoliosForContainCaseTests.
	
	portfolioA add: accountA.
	portfolioB add: accountA.
	portfolioA add: portfolioB.
	
	self assert: 1 equals: portfolioA transactions size.	! !

!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'alm 11/9/2022 18:36:53'!
test21addingAnAccountToAPortfolioDoesNotAddItIfThatPortfolioIsContainedInAnotherThatAlreadyContainsTheAccount
"Caso 4 del enunciado"
	
	self setUpPortfoliosForContainCaseTests.
	
	portfolioA add: accountA.
	portfolioA add: portfolioB.
	portfolioB add: accountA.
	
	self assert: 0 equals: portfolioB transactions size.! !

!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'alm 11/9/2022 18:36:53'!
test22addingAnAccountToAPortfolioThatContainsAPortfolioThatContainsTheSameAccountDoesNotAddIt
"Caso 2 del enunciado"
	
	self setUpPortfoliosForContainCaseTests.
	
	portfolioA add: accountA.
	portfolioB add: portfolioA.
	portfolioB add: accountA.
	
	self assert: 1 equals: portfolioB transactions size.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'alm 11/7/2022 18:27:17'!
balanceValue 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'alm 11/7/2022 18:27:49'!
value 

	^ value ! !


!AccountTransaction methodsFor: 'initialization' stamp: 'alm 11/9/2022 18:01:57'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'alm 11/9/2022 18:15:12'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'value' stamp: 'alm 11/7/2022 18:26:07'!
balanceValue

	^ value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'alm 11/7/2022 18:26:12'!
balanceValue

	^ value *  (-1 )! !


!classDefinition: #NullParent category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #NullParent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!
!NullParent commentStamp: '<historical>' prior: 0!
"Null"!


!NullParent methodsFor: 'comparing' stamp: 'SM 11/8/2022 23:47:54'!
contains: anAccount
	^false.! !


!classDefinition: #PortfolioContent category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #PortfolioContent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioContent methodsFor: 'main protocol' stamp: 'alm 11/11/2022 04:17:50'!
balance
	self subclassResponsibility.! !

!PortfolioContent methodsFor: 'main protocol' stamp: 'alm 11/11/2022 04:18:27'!
transactions
	self subclassResponsibility.! !


!PortfolioContent methodsFor: 'comparing' stamp: 'alm 11/11/2022 04:17:27'!
contains: anAccountOrPortfolio
	self subclassResponsibility. "anAccountOrPortfolio es aPortfolioContent"! !


!PortfolioContent methodsFor: 'private' stamp: 'alm 11/11/2022 04:16:35'!
addParent: aParent
	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
PortfolioContent subclass: #Portfolio
	instanceVariableNames: 'accounts parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'alm 11/11/2022 04:23:46'!
initialize
	accounts := OrderedCollection new.
	parent:= NullParent new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'alm 11/9/2022 17:56:49'!
add: anAccountOrPortfolio

	(self isAlreadyContainedInStructure: anAccountOrPortfolio ) ifFalse: [self addToStructure: anAccountOrPortfolio.].! !

!Portfolio methodsFor: 'main protocol' stamp: 'alm 11/7/2022 19:53:28'!
balance
	^ accounts sum: [:anAccount | anAccount balance] ifEmpty: [^0].! !

!Portfolio methodsFor: 'main protocol' stamp: 'alm 11/7/2022 20:11:18'!
hasRegistered: aTransaction
	^ accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].
	! !

!Portfolio methodsFor: 'main protocol' stamp: 'alm 11/7/2022 20:29:57'!
transactions
	| transactions |
	transactions := OrderedCollection new.
	
	accounts do: [:anAccount | transactions addAll: anAccount transactions].
	^ transactions.! !


!Portfolio methodsFor: 'private' stamp: 'alm 11/9/2022 18:13:00'!
addParent: aParent
	parent:= aParent.! !

!Portfolio methodsFor: 'private' stamp: 'alm 11/9/2022 18:12:46'!
addToStructure: anAccountOrPortfolio

	accounts add: anAccountOrPortfolio. anAccountOrPortfolio addParent: self! !

!Portfolio methodsFor: 'private' stamp: 'alm 11/9/2022 18:13:00'!
isAlreadyContainedInStructure: anAccountOrPortfolio

	^ (self contains: anAccountOrPortfolio) or: (parent contains: anAccountOrPortfolio)! !


!Portfolio methodsFor: 'comparing' stamp: 'alm 11/9/2022 17:47:04'!
contains: anAccountOrPortfolio
	^accounts anySatisfy: [:account| (anAccountOrPortfolio contains: account) or: (account contains: anAccountOrPortfolio).]
	"(primera parte del or para el test20, segunda parte para test22)."! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
PortfolioContent subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'alm 11/7/2022 18:25:58'!
balance

	^transactions sum: [ :aTransaction | aTransaction balanceValue ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'alm 11/7/2022 19:09:07'!
counterpartFor: aTransference 
	^ aTransference counterpartOf: self! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'alm 11/9/2022 18:13:21'!
addParent: aParent
	^ self.! !


!ReceptiveAccount methodsFor: 'comparing' stamp: 'alm 11/9/2022 16:43:25'!
contains: anAccountOrPortfolio
	^ self = anAccountOrPortfolio ! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'transfAmount transfExtractionAccount transfDepositAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'alm 11/7/2022 19:11:43'!
initializeFor: amount from: extractionAccount to: depositAccount 
	transfAmount := amount.
	transfExtractionAccount := extractionAccount.
	transfDepositAccount := depositAccount.
	
	Withdraw register: amount on: extractionAccount.
	Deposit register: amount on: depositAccount.
	
	! !


!Transference methodsFor: 'value' stamp: 'alm 11/7/2022 19:37:10'!
value
	^ transfAmount 
	
	! !


!Transference methodsFor: 'main protocol' stamp: 'alm 11/7/2022 19:17:00'!
counterpartOf: anAccount
	(anAccount = transfDepositAccount ) ifTrue: [^ transfExtractionAccount ].
	(anAccount = transfExtractionAccount ) ifTrue: [^ transfDepositAccount ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'instance creation' stamp: 'alm 11/7/2022 18:44:33'!
register: amount from: extractionAccount to: depositAccount 

	^ self new initializeFor: amount from: extractionAccount to: depositAccount ! !
