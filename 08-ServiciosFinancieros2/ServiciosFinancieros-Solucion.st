!classDefinition: #AccountReportsTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountReportsTest
	instanceVariableNames: 'account originAccount destinationAccount transferNet accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReportsTest methodsFor: 'accountSummaryTests' stamp: 'alm 11/18/2022 14:32:29'!
deposit: anAmountToDeposit inOriginAndThenTransfer: anAmountToTransfer from: anOriginAccount to: aDestinationAccount.
	
	Deposit register: anAmountToDeposit on: anOriginAccount.
	Transfer amount: anAmountToTransfer from: anOriginAccount to: aDestinationAccount.! !

!AccountReportsTest methodsFor: 'accountSummaryTests' stamp: 'alm 11/18/2022 16:58:50'!
newline

	^ String newLineString! !

!AccountReportsTest methodsFor: 'accountSummaryTests' stamp: 'alm 11/18/2022 14:28:52'!
test01accountSummaryMuestraLosDepositosRealizadosEnLaCuentaYSuBalance
	
	Deposit register: 100 * peso on: account.
	
	self assert: 			'Depósito por 100 pesos',self newline,
				'Balance = 100 pesos'
		equals: (accountSummary report: account).! !

!AccountReportsTest methodsFor: 'accountSummaryTests' stamp: 'alm 11/18/2022 14:28:34'!
test02accountSummaryMuestraLosDepositosYExtraccionesRealizadosEnLaCuentaYSuBalance
	
	Deposit register: 100 * peso on: account.
	Withdraw register: 60 * peso on: account.
		
	self assert: 			'Depósito por 100 pesos', self newline,
				'Extracción por 60 pesos',self newline,
				'Balance = 40 pesos'
		equals: (accountSummary report: account).! !

!AccountReportsTest methodsFor: 'accountSummaryTests' stamp: 'alm 11/18/2022 14:33:08'!
test03accountSummaryMuestraLosDepositosYTransferenciasRealizadasPorLaCuentaYSuBalance

	self deposit: 20*peso inOriginAndThenTransfer: 20*peso from: originAccount to: destinationAccount.
	
	self assert: 			'Depósito por 20 pesos',self newline,
				'Salida por transferencia de 20 pesos', self newline,
				'Balance = 0 pesos'
		equals: (accountSummary report: originAccount).! !

!AccountReportsTest methodsFor: 'accountSummaryTests' stamp: 'alm 11/18/2022 14:31:16'!
test04accountSummaryMuestraLasTransferenciasRecibidasPorLaCuentaYSuBalance
	
	self deposit: 30*peso inOriginAndThenTransfer: 30*peso from: originAccount to: destinationAccount.
		
	self assert: 			'Entrada por transferencia de 30 pesos',self newline,
				'Balance = 30 pesos'
		equals: (accountSummary report: destinationAccount).! !


!AccountReportsTest methodsFor: 'setup' stamp: 'alm 11/18/2022 13:34:04'!
setUp
	
	account := ReceptiveAccount new.
	originAccount := ReceptiveAccount new.	
	destinationAccount := ReceptiveAccount new.
	
	accountSummary := AccountSummary new.
	transferNet := TransferNet new.! !


!AccountReportsTest methodsFor: 'transferNetTests' stamp: 'alm 11/18/2022 13:43:33'!
test05transferNetMuestraSolamenteLasTransferenciasRecibidasYRealizadasPorLaCuenta
	
	Deposit register: 100*peso on: originAccount.
	Transfer amount: 30 * peso from: destinationAccount to: originAccount.
	Transfer amount: 20 * peso from: originAccount to: destinationAccount.
	
	self assert: 		'Entrada por transferencia de 30 pesos',self newline,
			'Salida por transferencia de 20 pesos', self newline,
			'Neto = 10 pesos' 
		equals: (transferNet report: originAccount).! !


!classDefinition: #PortfolioPrinterTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioPrinterTest
	instanceVariableNames: 'johnsAccount angiesAccount myAccount portfolioTreePrint portfolioDetailedTreePrinter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioPrinterTest methodsFor: 'portfolioTreePrinterTests' stamp: 'alm 11/18/2022 01:18:42'!
composedPortfolioTreeReport

	^ 'Portfolio de la familia',(String newLineString),
				'   Cuenta mia',(String newLineString),
				'   Portfolio de hijos',(String newLineString),
				'      Cuenta de Juan',(String newLineString),
				'      Cuenta de Angeles'! !

!PortfolioPrinterTest methodsFor: 'portfolioTreePrinterTests' stamp: 'alm 11/18/2022 01:17:40'!
simplePortfolioTreeReport

	^ 'Portfolio de la familia',(String newLineString),
				'   Cuenta mia'! !

!PortfolioPrinterTest methodsFor: 'portfolioTreePrinterTests' stamp: 'alm 11/18/2022 14:06:19'!
test01portfolioTreePrintShowsNamesOfPortfolioAndItsReceptiveAccountsInATreeLikeStructure
	
	| familyPortfolio |

	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount..
	
	portfolioTreePrint := PortfolioTreePrinter for: familyPortfolio.
	self assert: 		self simplePortfolioTreeReport
		equals: (portfolioTreePrint report).! !

!PortfolioPrinterTest methodsFor: 'portfolioTreePrinterTests' stamp: 'alm 11/18/2022 14:08:58'!
test02portfolioTreePrintShowsNamesOfPortfolioAndItsAccountsInATreeLikeStructure

	| familyPortfolio childrenPortfolio |
	
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	
	portfolioTreePrint := PortfolioTreePrinter for: familyPortfolio.
	self assert: 		self composedPortfolioTreeReport
		equals: (portfolioTreePrint report).! !


!PortfolioPrinterTest methodsFor: 'portfolioDetailedPrinterTests' stamp: 'alm 11/18/2022 13:48:08'!
composedPortfolioDetailedTreeReport

	^ 'Portfolio de la familia',(String newLineString),
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
			'   Balance = 70 pesos'! !

!PortfolioPrinterTest methodsFor: 'portfolioDetailedPrinterTests' stamp: 'alm 11/18/2022 13:49:08'!
deposit: anAmountToDeposit andThenWithdraw: anAmountToWithdraw on: aReceptiveAccount 
	Deposit register: anAmountToDeposit on: aReceptiveAccount.
	Withdraw register: anAmountToWithdraw on: aReceptiveAccount.! !

!PortfolioPrinterTest methodsFor: 'portfolioDetailedPrinterTests' stamp: 'alm 11/18/2022 13:48:32'!
simplePorfolioDetailedTreeReport

	^ 'Portfolio de la familia',(String newLineString),
			'   Cuenta mia',(String newLineString),
			'      Depósito por 100 pesos',(String newLineString),
			'      Extracción por 50 pesos',(String newLineString),
			'      Balance = 50 pesos',(String newLineString),
			'   Balance = 50 pesos'! !

!PortfolioPrinterTest methodsFor: 'portfolioDetailedPrinterTests' stamp: 'alm 11/18/2022 15:43:15'!
test03detailedPrinterMuestraReporteDetalladoDeUnPortfolioConUnaCuenta

	| familyPortfolio |
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount..
	
	self deposit: 100*peso andThenWithdraw: 50*peso on: myAccount.

	portfolioDetailedTreePrinter := PortfolioDetailedTreePrinter for: familyPortfolio.
	self assert: self simplePorfolioDetailedTreeReport
		equals: (portfolioDetailedTreePrinter report).! !

!PortfolioPrinterTest methodsFor: 'portfolioDetailedPrinterTests' stamp: 'alm 11/18/2022 15:43:00'!
test04detailedPrinterMuestraReporteDeUnPortolioYSuArbolDePortfolioYCuentas

	| familyPortfolio destinationAccount childrenPortfolio |
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.
	destinationAccount := ReceptiveAccount named: 'Una cuenta'. 
	
	self deposit: 100*peso andThenWithdraw: 50*peso on: myAccount.
	self deposit: 100*peso andThenWithdraw: 60*peso on: johnsAccount.
	Transfer amount: 20*peso from: angiesAccount to: destinationAccount.

	portfolioDetailedTreePrinter := PortfolioDetailedTreePrinter for: familyPortfolio.
	self assert: self composedPortfolioDetailedTreeReport
		equals: (portfolioDetailedTreePrinter report).! !


!PortfolioPrinterTest methodsFor: 'setUp' stamp: 'alm 11/18/2022 14:11:38'!
setUp
	
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'. 
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	! !


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

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
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

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
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
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'alm 11/18/2022 03:19:28'!
report: aPortfolioPrinter

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

!Account methodsFor: 'accesing' stamp: 'alm 11/18/2022 02:48:09'!
name
	^ name.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'alm 11/18/2022 14:16:41'!
initialize
	accounts := OrderedCollection new.
	name := 'anonymousPortfolio'! !

!Portfolio methodsFor: 'initialization' stamp: 'alm 11/18/2022 02:37:31'!
initializeNamed: aPortfolioName with: aReceptiveAccount 
	self initialize.
	name := aPortfolioName.
	accounts add: aReceptiveAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'alm 11/18/2022 14:16:12'!
initializeNamed: aPortfolioName with: anAccount with: anotherAccount
	self initializeNamed: aPortfolioName with: anAccount. 
	accounts add: anotherAccount.! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'alm 11/18/2022 15:33:19'!
report: aPortfolioPrinter
	
	aPortfolioPrinter subreportPortfolio: self. "with: anInitialIndentation."! !

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


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'alm 11/18/2022 02:38:54'!
named: aPortfolioName with: aReceptiveAccount 
	^self new initializeNamed: aPortfolioName with: aReceptiveAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'alm 11/18/2022 02:39:03'!
named: aPortfolioName with: anAccount with: anotherAccount 
	^self new initializeNamed: aPortfolioName with: anAccount with: anotherAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'alm 11/18/2022 14:19:58'!
initialize

	transactions := OrderedCollection new.
	name := 'anonymousReceptiveAccount'! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'alm 11/18/2022 14:21:28'!
initializeNamed: aName 

	self initialize.
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

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'alm 11/18/2022 15:33:27'!
report: aPortfolioPrinter
	
	aPortfolioPrinter subreportReceptiveAccount: self. "with: anInitialIndentation."! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'alm 11/18/2022 02:39:38'!
named: aReceptiveAccountName 
	^ self new initializeNamed: aReceptiveAccountName ! !


!classDefinition: #AccountReport category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountReport
	instanceVariableNames: 'reporteAMostrar resultadoAcumulado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountReport methodsFor: 'initialization' stamp: 'alm 11/18/2022 16:45:26'!
initialize
	reporteAMostrar := ReporteAMostrar new.
	resultadoAcumulado := 0.! !


!AccountReport methodsFor: 'main protocol' stamp: 'alm 11/17/2022 22:22:17'!
addDeposit: aDeposit
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'main protocol' stamp: 'alm 11/16/2022 18:36:17'!
addTransferDepositLeg: aTransferDepositLeg
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'main protocol' stamp: 'alm 11/16/2022 18:37:35'!
addTransferWithdrawLeg: aTransferWithdrawLeg
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'main protocol' stamp: 'alm 11/17/2022 22:22:30'!
addWithdraw: aWithdraw
	^ self subclassResponsibility ! !

!AccountReport methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:57:54'!
report: anAccount
	^ self subclassResponsibility ! !


!AccountReport methodsFor: 'private' stamp: 'alm 11/17/2022 22:35:00'!
resultadoAcumuladoForReport

	^ resultadoAcumulado amount asString! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:49:50'!
addDeposit: aDeposit
	reporteAMostrar addLine: 	'Depósito por ',aDeposit valueForReport,' pesos'.! !

!AccountSummary methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:45:56'!
addTransferDepositLeg: aTransferDepositLeg
	reporteAMostrar addLine:					'Entrada por transferencia de ', aTransferDepositLeg valueForReport, ' pesos'.! !

!AccountSummary methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:46:20'!
addTransferWithdrawLeg: aTransferWithdrawLeg
	reporteAMostrar addLine:				'Salida por transferencia de ', aTransferWithdrawLeg valueForReport, ' pesos'.! !

!AccountSummary methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:46:35'!
addWithdraw: aWithdraw
	reporteAMostrar addLine: 'Extracción por ',aWithdraw valueForReport,' pesos'.! !

!AccountSummary methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:57:18'!
report: anAccount
	
	anAccount transactions do: [:transaction | transaction report: self].
	resultadoAcumulado := anAccount balance.
	reporteAMostrar addLine: 'Balance = ',self resultadoAcumuladoForReport,' pesos'.
	^ reporteAMostrar print.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
AccountReport subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'main protocol' stamp: 'alm 11/17/2022 22:23:12'!
addDeposit: aDeposit
	! !

!TransferNet methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:53:34'!
addTransferDepositLeg: aTransferDepositLeg
	
	resultadoAcumulado := aTransferDepositLeg affectBalance: resultadoAcumulado.
	reporteAMostrar addLine: 'Entrada por transferencia de ', aTransferDepositLeg valueForReport, ' pesos'.
	! !

!TransferNet methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:53:45'!
addTransferWithdrawLeg: aTransferWithdrawLeg

	resultadoAcumulado := aTransferWithdrawLeg affectBalance: resultadoAcumulado.
	reporteAMostrar addLine: 'Salida por transferencia de ', aTransferWithdrawLeg valueForReport, ' pesos'.! !

!TransferNet methodsFor: 'main protocol' stamp: 'alm 11/17/2022 22:23:20'!
addWithdraw: aWithdraw! !

!TransferNet methodsFor: 'main protocol' stamp: 'alm 11/18/2022 16:56:35'!
report: anAccount
	
	anAccount transactions do: [:transaction | 	transaction report: self.	].
	reporteAMostrar addLine: 'Neto = ',self resultadoAcumuladoForReport,' pesos'.
	^ reporteAMostrar print.	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'alm 11/16/2022 18:12:29'!
report: anAccountSummary

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'report' stamp: 'alm 11/17/2022 22:26:15'!
valueForReport
	^ self value amount asString! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

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

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'report' stamp: 'alm 11/17/2022 22:16:52'!
report: anAccountSummary
	^ anAccountSummary addDeposit: self.! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

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

!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 22:45:01'!
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

!TransferDepositLeg methodsFor: 'report' stamp: 'alm 11/17/2022 22:16:41'!
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

!TransferWithdrawLeg methodsFor: 'report' stamp: 'alm 11/17/2022 22:17:04'!
report: anAccountSummary
	^ anAccountSummary addTransferWithdrawLeg: self.! !


!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


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


!Withdraw methodsFor: 'report' stamp: 'alm 11/17/2022 22:17:15'!
report: anAccountSummary
	^ anAccountSummary addWithdraw: self.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioPrinter category: 'ServiciosFinancieros-Solucion'!
Object subclass: #PortfolioPrinter
	instanceVariableNames: 'reporteAMostrar portfolio indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioPrinter methodsFor: 'reporting' stamp: 'alm 11/18/2022 16:44:05'!
report
	
	portfolio report: self.
	^ reporteAMostrar print.! !

!PortfolioPrinter methodsFor: 'reporting' stamp: 'alm 11/18/2022 16:36:54'!
subreportPortfolio: aPortfolio
	
	self add: indentation ,aPortfolio name.
	self increaseIndentation.
	aPortfolio accounts do: [:anAccount | anAccount report: self.].
	self decreaseIndentation.! !

!PortfolioPrinter methodsFor: 'reporting' stamp: 'alm 11/18/2022 16:37:07'!
subreportReceptiveAccount: aReceptiveAccount
	
	self add: indentation,aReceptiveAccount name.
! !


!PortfolioPrinter methodsFor: 'initialization' stamp: 'alm 11/18/2022 16:43:14'!
initializeFor: aPortfolio 
	portfolio := aPortfolio.
	reporteAMostrar := ReporteAMostrar new.
	indentation := ''.! !


!PortfolioPrinter methodsFor: 'private' stamp: 'alm 11/18/2022 16:38:31'!
add: aLineToAddToTheReport
	reporteAMostrar := reporteAMostrar addLine: aLineToAddToTheReport.! !

!PortfolioPrinter methodsFor: 'private' stamp: 'alm 11/18/2022 15:32:33'!
decreaseIndentation

	^ indentation := indentation copyFrom: 1 to: indentation size-3! !

!PortfolioPrinter methodsFor: 'private' stamp: 'alm 11/18/2022 15:32:19'!
increaseIndentation

	^ indentation := indentation,self moreIndentation! !

!PortfolioPrinter methodsFor: 'private' stamp: 'alm 11/18/2022 14:47:49'!
moreIndentation

	^ '   '! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioPrinter class' category: 'ServiciosFinancieros-Solucion'!
PortfolioPrinter class
	instanceVariableNames: ''!

!PortfolioPrinter class methodsFor: 'instance creation' stamp: 'alm 11/18/2022 14:06:56'!
for: aPortfolio 
	^self new initializeFor: aPortfolio ! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioPrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'alm 11/17/2022 21:57:40'!
balanceString: aPortfolio
	^ 'Balance = ',(aPortfolio balance amount) asString,' pesos'! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'alm 11/18/2022 17:00:46'!
concatSummary: reporteDeTransaccionesAConcatenar
	
	reporteDeTransaccionesAConcatenar print linesDo: [:line |
		self add: indentation, self moreIndentation,line.]! !


!PortfolioDetailedTreePrinter methodsFor: 'reporting' stamp: 'alm 11/18/2022 16:37:18'!
subreportPortfolio: aPortfolio
	
	super subreportPortfolio: aPortfolio.
	
	self add: indentation,self moreIndentation,(self balanceString: aPortfolio).! !

!PortfolioDetailedTreePrinter methodsFor: 'reporting' stamp: 'alm 11/18/2022 15:37:12'!
subreportReceptiveAccount: aReceptiveAccount
	
	| accountSummary reporteDeTransaccionesAConcatenar |
	
	super subreportReceptiveAccount: aReceptiveAccount.
	
	accountSummary := AccountSummary new.
	reporteDeTransaccionesAConcatenar := accountSummary report: aReceptiveAccount.
	self concatSummary: reporteDeTransaccionesAConcatenar.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
PortfolioPrinter subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'reporting' stamp: 'alm 11/18/2022 15:26:14'!
subreportPortfolio: aPortfolio

	super subreportPortfolio: aPortfolio! !

!PortfolioTreePrinter methodsFor: 'reporting' stamp: 'alm 11/18/2022 15:24:46'!
subreportReceptiveAccount: aReceptiveAccount
	
	super subreportReceptiveAccount: aReceptiveAccount! !


!classDefinition: #ReporteAMostrar category: 'ServiciosFinancieros-Solucion'!
Object subclass: #ReporteAMostrar
	instanceVariableNames: 'stringAMostrar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReporteAMostrar methodsFor: 'as yet unclassified' stamp: 'alm 11/18/2022 16:39:42'!
addLine: aLineToAdd
	stringAMostrar := stringAMostrar, (String newLineString), aLineToAdd.! !

!ReporteAMostrar methodsFor: 'as yet unclassified' stamp: 'alm 11/18/2022 16:41:10'!
print
	"Pequeño ajuste, porque addLine siempre agrega un newline al principio (incluyendo la primera vez que se lo llama)"
	^ stringAMostrar allButFirst.! !


!ReporteAMostrar methodsFor: 'initialization' stamp: 'alm 11/18/2022 16:20:50'!
initialize
	stringAMostrar := ''.! !


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
