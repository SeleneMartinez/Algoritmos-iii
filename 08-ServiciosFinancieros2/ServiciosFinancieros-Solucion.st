!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:13:29'!
newline

	^ String newLineString! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:13:17'!
test01
	| account accountSummary |
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	
	accountSummary := AccountSummary new.
	self assert: 'Depósito por 100 pesos',self newline, 'Balance = 100 pesos' equals: (accountSummary report: account).
	
	"account report." "'Depósito por 100 pesos'."
	
	"Balance = 100 pesos'".! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:13:17'!
test02
	| account accountSummary |
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 60 * peso on: account.
	
	accountSummary := AccountSummary new.
	
	self assert: 'Depósito por 100 pesos', self newline, 'Extracción por 60 pesos',self newline, 'Balance = 40 pesos' equals: (accountSummary report: account).
	"account report." "'Depósito por 100 pesos'."
! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:13:17'!
test03
	| destinationAccount originAccount accountSummary |
	
	originAccount := ReceptiveAccount new.	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 20*peso on: originAccount.
	Transfer amount: 20 * peso from: originAccount to: destinationAccount.

	accountSummary := AccountSummary new.
	
	self assert: 'Depósito por 20 pesos',self newline,'Salida por transferencia de 20 pesos', self newline, 'Balance = 0 pesos' equals: (accountSummary report: originAccount).
	"originAccount report."
	
	"Balance = 100 pesos'".! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:13:17'!
test04
	| destinationAccount originAccount accountSummary |
	
	originAccount := ReceptiveAccount new.	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 30*peso on: originAccount.
	Transfer amount: 30 * peso from: originAccount to: destinationAccount.
	
	accountSummary := AccountSummary new.
	
	self assert: 'Entrada por transferencia de 30 pesos',self newline, 'Balance = 30 pesos' equals: (accountSummary report: destinationAccount). "destinationAccount report."
	
	"Balance = 100 pesos'".! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:13:17'!
test05
"Transfer net"
	| destinationAccount originAccount transferNet |
	
	originAccount := ReceptiveAccount new.	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100*peso on: originAccount.
	Transfer amount: 30 * peso from: destinationAccount to: originAccount.
	Transfer amount: 20 * peso from: originAccount to: destinationAccount.
	
	transferNet := TransferNet new.
	self assert: 		'Entrada por transferencia de 30 pesos',self newline,
			'Salida por transferencia de 20 pesos', self newline,
			'Neto = 10 pesos' 
		equals: (transferNet report: originAccount).
		
		"originAccount reportTransferNet."! !


!classDefinition: #PortfolioDetailedTreePrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioDetailedTreePrinterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:07:42'!
test01
	
	| familyPortfolio myAccount portfolioDetailedTreePrinter |
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount..
	
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 50 * peso on: myAccount.
	
	portfolioDetailedTreePrinter := PortfolioDetailedTreePrinter new.
	
	self assert: 'Portfolio de la familia',(String newLineString),
			'   Cuenta mia',(String newLineString),
			'      Depósito por 100 pesos',(String newLineString),
			'      Extracción por 50 pesos',(String newLineString),
			'      Balance = 50 pesos',(String newLineString),
			'   Balance = 50 pesos'
		equals: (portfolioDetailedTreePrinter report: familyPortfolio).! !

!PortfolioDetailedTreePrinterTest methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:08:39'!
test02
	
	| angiesAccount childrenPortfolio familyPortfolio johnsAccount myAccount portfolioDetailedTreePrinter reporteEsperado destinationAccount actualReport |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	destinationAccount := ReceptiveAccount named: 'Una cuenta'. 
	
	Deposit register: 100 * peso on: myAccount.
	Withdraw register: 50 * peso on: myAccount.
	
	Deposit register: 100 * peso on: johnsAccount.
	Withdraw register: 60 * peso on: johnsAccount.
	
	Transfer amount: 20*peso from: angiesAccount to: destinationAccount.
	
	portfolioDetailedTreePrinter := PortfolioDetailedTreePrinter new.
	
	reporteEsperado:= 			'Portfolio de la familia',(String newLineString),
			'   Cuenta mia',(String newLineString),
			'      Depósito por 100 pesos',(String newLineString),
			'      Extracción por 50 pesos',(String newLineString),
			'      Balance = 50 pesos',(String newLineString),
			'   Portfolio de hijos',(String newLineString),
			'      Cuenta de Juan',(String newLineString),
			'         Depósito por 100 pesos',(String newLineString),
			'         Extracción por 60 pesos',(String newLineString),
			'         Balance = 40 pesos',(String newLineString),
			'      Cuenta de Angeles',(String newLineString),
			'         Salida por transferencia de 20 pesos',(String newLineString),
			'         Balance = -20 pesos',(String newLineString),
			'      Balance = 20 pesos',(String newLineString),
			'   Balance = 70 pesos'.
	actualReport := (portfolioDetailedTreePrinter report: familyPortfolio).
	self assert: reporteEsperado		equals: actualReport. "(portfolioDetailedTreePrinter report: familyPortfolio)."
		
! !


!classDefinition: #PortfolioReportsTests category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioReportsTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioReportsTests methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:41:11'!
test01portfolioTreePrintShowsNamesOfPortfolioAndItsAccountsInATreeLikeStructure
	
	| johnsAccount familyPortfolio portfolioTreePrint |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: johnsAccount.
	
	portfolioTreePrint := PortfolioTreePrinter new.
	
	self assert: 		'Portfolio de la familia',(String newLineString),
				'   Cuenta de Juan'
		equals: (portfolioTreePrint report: familyPortfolio ).! !

!PortfolioReportsTests methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:41:11'!
test02
	
	| johnsAccount familyPortfolio portfolioTreePrint angiesAccount myAccount childrenPortfolio |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'. 
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	portfolioTreePrint := PortfolioTreePrinter new.
	
	self assert: 			'Portfolio de la familia',(String newLineString),
				'   Cuenta mia',(String newLineString),
				'   Portfolio de hijos',(String newLineString),
				'      Cuenta de Juan',(String newLineString),
				'      Cuenta de Angeles'
		equals: (portfolioTreePrint report: familyPortfolio).! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'alm 11/17/2022 21:49:41'!
report: aPortfolioPrinter with: anInitialIndentation 

	self subclassResponsibility.! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'accesing' stamp: 'alm 11/16/2022 23:35:36'!
accounts
	^ self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'LL 7/1/2021 03:21:03'!
initialize

	accounts := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'alm 11/16/2022 22:53:00'!
initializeNamed: aName with: aReceptiveAccount 
	self initialize.
	name := aName.
	accounts add: aReceptiveAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'alm 11/16/2022 23:23:36'!
initializeNamed: aName with: anAccount with: anotherAccount 
	name := aName.
	accounts add: anAccount.
	accounts add: anotherAccount.! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'alm 11/17/2022 21:47:54'!
report: aPortfolioPrinter with: anInitialIndentation 
	
	aPortfolioPrinter subreportPortfolio: self with: anInitialIndentation.! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'LL 7/1/2021 03:21:12'!
add: accountToAdd
	
	accounts add: accountToAdd.
	! !


!Portfolio methodsFor: 'accesing' stamp: 'alm 11/17/2022 21:18:41'!
accounts	
	^ accounts
! !

!Portfolio methodsFor: 'accesing' stamp: 'alm 11/16/2022 23:14:10'!
name
	^ name.! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'instance creation' stamp: 'alm 11/16/2022 22:50:50'!
named: aName with: aReceptiveAccount 
	^self new initializeNamed: aName with: aReceptiveAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'alm 11/16/2022 23:22:38'!
named: aName with: anAccount with: anotherAccount 
	^self new initializeNamed: aName with: anAccount with: anotherAccount ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'alm 11/16/2022 22:49:07'!
initializeNamed: aName 
	name := aName.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'alm 11/17/2022 15:59:48'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'alm 11/17/2022 21:49:02'!
report: aPortfolioPrinter with: anInitialIndentation 
	
	aPortfolioPrinter subreportReceptiveAccount: self with: anInitialIndentation.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'private' stamp: 'alm 11/16/2022 23:13:21'!
name
	^ name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'alm 11/16/2022 22:48:40'!
named: aName 
	^ self new initializeNamed: aName ! !


!classDefinition: #AccountReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'reporteAMostrar resultadoAcumulado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:22:17'!
addDeposit: aDeposit
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/16/2022 18:36:17'!
addTransferDepositLeg: aTransferDepositLeg
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/16/2022 18:37:35'!
addTransferWithdrawLeg: aTransferWithdrawLeg
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:22:30'!
addWithdraw: aWithdraw
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:33:23'!
initialize
	reporteAMostrar := ''.
	resultadoAcumulado := 0.! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:16:11'!
newline

	^ String newLineString.! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/16/2022 23:40:36'!
report: anAccount
	self subclassResponsibility ! !

!AccountReport methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:35:00'!
resultadoAcumuladoForReport

	^ resultadoAcumulado amount asString! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:24:28'!
addDeposit: aDeposit
	reporteAMostrar := reporteAMostrar,
					'Depósito por ',aDeposit valueForReport,' pesos',
					self newline.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:24:52'!
addTransferDepositLeg: aTransferDepositLeg
	reporteAMostrar := reporteAMostrar,
					'Entrada por transferencia de ', aTransferDepositLeg valueForReport, ' pesos',
					self newline.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:24:58'!
addTransferWithdrawLeg: aTransferWithdrawLeg
	reporteAMostrar := reporteAMostrar,
					'Salida por transferencia de ', aTransferWithdrawLeg valueForReport, ' pesos',
					self newline.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:25:06'!
addWithdraw: aWithdraw
	reporteAMostrar := reporteAMostrar,'Extracción por ',aWithdraw valueForReport,' pesos', self newline.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:34:36'!
report: anAccount
	
	anAccount transactions do: [:transaction | (transaction report: self)].
	resultadoAcumulado := anAccount balance.
	 ^reporteAMostrar , 'Balance = ',self resultadoAcumuladoForReport,' pesos'.
! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:23:12'!
addDeposit: aDeposit
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:32:08'!
addTransferDepositLeg: aTransferDepositLeg
	
	resultadoAcumulado := aTransferDepositLeg affectBalance: resultadoAcumulado.
	reporteAMostrar := reporteAMostrar,
					'Entrada por transferencia de ', aTransferDepositLeg valueForReport, ' pesos',
					self newline.
	! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:32:08'!
addTransferWithdrawLeg: aTransferWithdrawLeg

	resultadoAcumulado := aTransferWithdrawLeg affectBalance: resultadoAcumulado.
	reporteAMostrar := reporteAMostrar ,
					'Salida por transferencia de ', aTransferWithdrawLeg valueForReport, ' pesos',
					self newline.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:23:20'!
addWithdraw: aWithdraw! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:34:08'!
report: anAccount
	
	anAccount transactions do: [:transaction | 
				transaction report: self.
				].
	^ reporteAMostrar , 'Neto = ',self resultadoAcumuladoForReport,' pesos'.
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'alm 11/16/2022 18:12:29'!
report: anAccountSummary

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'alm 11/17/2022 22:26:15'!
valueForReport
	^ self value amount asString! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'alm 11/17/2022 22:16:52'!
report: anAccountSummary
	^ anAccountSummary addDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'alm 11/17/2022 22:16:41'!
report: anAccountSummary
	^ anAccountSummary addTransferDepositLeg: self.! !

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'alm 11/17/2022 22:17:04'!
report: anAccountSummary
	^ anAccountSummary addTransferWithdrawLeg: self.! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'alm 11/17/2022 22:17:15'!
report: anAccountSummary
	^ anAccountSummary addWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioPrinter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioPrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioPrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:12:07'!
newline

	^ String newLineString! !

!PortfolioPrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:11:52'!
subreportPortfolio: aPortfolio with: anInitialIndentation
	
	self add: anInitialIndentation,aPortfolio name.
	aPortfolio accounts do: [:anAccount | self add: self newline.
						anAccount report: self with: anInitialIndentation,'   '.].! !

!PortfolioPrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 21:24:10'!
subreportReceptiveAccount: aReceptiveAccount with: anInitialIndentation
	
	self add: anInitialIndentation,aReceptiveAccount name.
! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioPrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: 'reporteAMostrar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 14:53:04'!
add: anAccountName
	reporteAMostrar := reporteAMostrar,anAccountName.! !

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 21:57:40'!
balanceString: aPortfolio
	^ 'Balance = ',(aPortfolio balance amount) asString,' pesos'! !

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 14:53:36'!
initialize
	reporteAMostrar := ''.! !

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 14:57:34'!
report: aPortfolio 
	aPortfolio report: self with: ''.
	^ reporteAMostrar.! !

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:02:45'!
subreportPortfolio: aPortfolio with: anInitialIndentation
	
	super subreportPortfolio: aPortfolio with: anInitialIndentation.
	
	self add: self newline,anInitialIndentation,'   ' ,(self balanceString: aPortfolio).! !

!PortfolioDetailedTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:02:45'!
subreportReceptiveAccount: aReceptiveAccount with: anInitialIndentation
	
	| accountSummary reporteDeTransaccionesAConcatenar |
	
	super subreportReceptiveAccount: aReceptiveAccount with: anInitialIndentation.
	
	accountSummary := AccountSummary new.
	reporteDeTransaccionesAConcatenar := accountSummary report: aReceptiveAccount.
	reporteDeTransaccionesAConcatenar linesDo: [:line | self add: self newline, anInitialIndentation, '   ',line.].! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioPrinter subclass: #PortfolioTreePrinter
	instanceVariableNames: 'reporteAMostrar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 14:36:11'!
add: anAccountName
	reporteAMostrar := reporteAMostrar,anAccountName.
	! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 14:36:11'!
initialize
	reporteAMostrar := ''.
	! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 22:41:11'!
report: aPortfolio 
	
	aPortfolio report: self with: ''.
	^ reporteAMostrar.! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 21:24:50'!
subreportPortfolio: aPortfolio with: anInitialIndentation

	super subreportPortfolio: aPortfolio with: anInitialIndentation.! !

!PortfolioTreePrinter methodsFor: 'as yet unclassified' stamp: 'alm 11/17/2022 21:24:34'!
subreportReceptiveAccount: aReceptiveAccount with: anInitialIndentation
	
	super subreportReceptiveAccount: aReceptiveAccount with: anInitialIndentation.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
