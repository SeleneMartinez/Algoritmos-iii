!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
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


!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/7/2022 18:57:01'!
test08transferenceIncreasesBalanceOfDepositAccountOnTransferenceValue

	| depositAccount extractionAccount |
	
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	Deposit register: 10 * peso on: extractionAccount.
	
	Transference register: 10 * peso from: extractionAccount to: depositAccount.
	
	self assert: 10 * peso equals: depositAccount balance
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/7/2022 18:57:01'!
test09transferenceDecreasesBalanceOfExtractionAccountOnTransferenceValue

	| depositAccount extractionAccount |
	
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	Deposit register: 10 * peso on: extractionAccount.
	
	Transference register: 10 * peso from: extractionAccount to: depositAccount.
	
	self assert: 0 * peso equals: extractionAccount balance
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/7/2022 19:14:08'!
test10depositAccountKnowsItsTransferenceCounterpart

	| depositAccount extractionAccount transference |
	
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	Deposit register: 10 * peso on: extractionAccount.
	
	transference := Transference register: 10 * peso from: extractionAccount to: depositAccount.
	
	self assert: extractionAccount equals: (depositAccount counterpartFor: transference)
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/7/2022 19:26:03'!
test11extractionAccountKnowsItsTransferenceCounterpart

	| depositAccount extractionAccount transference |
	
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	Deposit register: 10 * peso on: extractionAccount.
	
	transference := Transference register: 10 * peso from: extractionAccount to: depositAccount.
	
	self assert: depositAccount equals: (extractionAccount counterpartFor: transference)
! !

!ReceptiveAccountTest methodsFor: 'transferenceTests' stamp: 'alm 11/7/2022 19:35:08'!
test12transferenceValueMustBePositive

	| depositAccount extractionAccount transference |
	
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	Deposit register: 10 * peso on: extractionAccount.
	
	transference := Transference register: 10 * peso from: extractionAccount to: depositAccount.
	
	self assert: 10 * peso equals: transference value.
! !


!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/7/2022 19:46:14'!
test13BalanceOfPortfolioIsBalanceOfItsAccounts

	|  account1 portfolio |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 * peso on: account1.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	
	self assert: 100 * peso equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/7/2022 19:45:40'!
test14BalanceOfPortfolioIsSumOfBalanceOfItsAccounts

	|  account1 account2 portfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 * peso on: account1.
	Deposit register: 200 * peso on: account2.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: 300 * peso equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/7/2022 19:52:47'!
test15BalanceOfPortfolioIsZeroIfEmpty

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: 0 * peso equals: portfolio balance.
! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/7/2022 20:16:39'!
test16PortfolioKnowsRegisteredTransactionOfItsAccounts

	|  account1 account2 portfolio deposit |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account1.
	Deposit register: 200 * peso on: account2.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: (portfolio hasRegistered: deposit).! !

!ReceptiveAccountTest methodsFor: 'portfolioTests' stamp: 'alm 11/7/2022 20:31:15'!
test17PortfolioKnowsTheTransactionsOfItsAccounts

	|  account1 account2 portfolio deposit |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account1.
	Deposit register: 200 * peso on: account2.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	
	self assert: 2 equals: (portfolio transactions size).
	self assert: (portfolio transactions includes: deposit).
! !


!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'SM 11/8/2022 22:59:46'!
test19AddingAnAccountMoreThanOnceToAPortfolioJustIncludesItOnce
	|  account  portfolio  |
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	Deposit register: 100 *  peso on: account.
	portfolio add: account.
	portfolio add: account.
	
	self assert: 1 equals: portfolio transactions size.! !

!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'SM 11/8/2022 23:07:53'!
test20AddingAPortfolioToAnotherPortfolioThatContainsTheSameAccountDoesNotAddIt
	|  account  portfolio  anotherPortfolio|
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	Deposit register: 100 *  peso on: account.
	portfolio add: account.
	anotherPortfolio add: account.
	portfolio add: anotherPortfolio.
	
	self assert: 1 equals: portfolio transactions size.! !

!ReceptiveAccountTest methodsFor: 'extraTests' stamp: 'SM 11/8/2022 23:13:47'!
test21
	|  account  portfolio  anotherPortfolio|
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	Deposit register: 100 *  peso on: account.
	portfolio add: account.
	portfolio add: anotherPortfolio.
	anotherPortfolio add: account.
	
	self assert: 0 equals: anotherPortfolio transactions size.! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

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

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'alm 11/7/2022 18:26:07'!
balanceValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'alm 11/7/2022 18:24:32'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'alm 11/7/2022 18:26:12'!
balanceValue

	^ value *  (-1 )! !

!Withdraw methodsFor: 'value' stamp: 'alm 11/7/2022 18:26:19'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'alm 11/7/2022 19:49:18'!
initialize
	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'SM 11/8/2022 23:09:22'!
add: anAccountOrPortfolio
	(accounts noneSatisfy: [:account| anAccountOrPortfolio = account]) ifTrue: [accounts add: anAccountOrPortfolio].
	"accounts add: anAccount."! !

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


!Portfolio methodsFor: 'as yet unclassified' stamp: 'SM 11/8/2022 23:08:28'!
= anAccountOrPortfolio
	^accounts anySatisfy:[:account| anAccountOrPortfolio = account ].! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
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


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'amount_CHANGE_ME extractionAccount_CHANGE_ME depositAccount_CHANGE_ME transfAmount transfExtractionAccount transfDepositAccount'
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
