!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:04'!
test01MarsRoverApuntaAlEsteDespuesDeLaSecuenciaR
|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'R'.
	self assert: (marsRover apuntaA: self este)! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:11'!
test02MarsRoverApuntaAlOesteDespuesDeLaSecuenciaL
|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'L'.
	self assert: (marsRover apuntaA: self oeste)! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:16'!
test03MarsRoverSeMueveAlPunto01DespuesDeLaSecuenciaF
|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'F'.
	self assert: 0@1 equals: marsRover posicion.! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:24'!
test04MarsRoverSeMueveAlPunto0Menos1DespuesDeLaSecuenciaB
|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'B'.
	self assert: 0@-1 equals: marsRover posicion.! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:32'!
test05MarsRoverApuntaAlSurLuegoDeLaSecuenciaRRLR
|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'RRLR'.
	self assert: (marsRover apuntaA: self sur).! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:37'!
test06MarsRoverNoCambiaElPuntoCardinalAlQueApuntaLuegoDeMoverseHaciaAdelante
|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'RRLRF'.
	self assert: (marsRover apuntaA: self sur).! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:42'!
test07MarsRoverNoCambiaElPuntoCardinalAlQueApuntaLuegoDeMoverseHaciaAtras
|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'RRLRB'.
	self assert: (marsRover apuntaA: self sur).! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:47'!
test08MarsRoverExecutingInvalidSequenceRaiseNoEsUnComandoValidoError
|marsRover|
	marsRover:= MarsRover new.
	self should:[marsRover ejecutarSecuencia: 'Ñ']
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: 'No es un comando valido']
	
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:54'!
test09MarsRoverCanExecuteLowerCaseCommands
	|marsRover|
	marsRover:= MarsRover new.
	marsRover ejecutarSecuencia: 'rrlrfff'.
	self assert: 0@-3 equals: marsRover posicion.! !

!MarsRoverTest methodsFor: 'test' stamp: 'sm 11/4/2022 11:35:59'!
test10MarsRoverMovesUntilInvalidCommandIsGiven
	|marsRover|
	marsRover:= MarsRover new.
	self should:[marsRover ejecutarSecuencia: 'rrlrffñf'.]
		raise: Error
		withExceptionDo: [:anError|
			self assert: anError messageText equals: 'No es un comando valido'.
			self assert: 0@-2 equals: marsRover posicion]! !


!MarsRoverTest methodsFor: 'setUp' stamp: 'SM 10/31/2022 18:59:35'!
este
	^Este new.! !

!MarsRoverTest methodsFor: 'setUp' stamp: 'SM 10/31/2022 18:58:55'!
norte
	^Norte new.! !

!MarsRoverTest methodsFor: 'setUp' stamp: 'SM 10/31/2022 19:00:08'!
oeste
	^Oeste new.! !

!MarsRoverTest methodsFor: 'setUp' stamp: 'SM 10/31/2022 18:59:03'!
sur
	^Sur new.! !


!classDefinition: #Comando category: 'MarsRover'!
Object subclass: #Comando
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Comando methodsFor: 'commandExecution' stamp: 'SM 10/31/2022 19:13:06'!
ejecutarComando: marsRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Comando class' category: 'MarsRover'!
Comando class
	instanceVariableNames: ''!

!Comando class methodsFor: 'error' stamp: 'sm 11/4/2022 11:15:21'!
comandoInvalidoError
	^'No es un comando valido'! !


!Comando class methodsFor: 'class initialization' stamp: 'SM 10/31/2022 18:33:40'!
puedeEjecutar: comando
	self subclassResponsibility.! !

!Comando class methodsFor: 'class initialization' stamp: 'sm 11/4/2022 11:15:44'!
with: comando
|subclass|
	subclass:= self subclasses detect: [:aSubclass | aSubclass puedeEjecutar: comando] ifNone:[^self error: self comandoInvalidoError].
	^subclass new.! !


!classDefinition: #Avanzar category: 'MarsRover'!
Comando subclass: #Avanzar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Avanzar methodsFor: 'commandExecution' stamp: 'SM 10/31/2022 19:13:14'!
ejecutarComando: marsRover
	marsRover moverHaciaAdelante.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Avanzar class' category: 'MarsRover'!
Avanzar class
	instanceVariableNames: ''!

!Avanzar class methodsFor: 'class initialization' stamp: 'sm 11/4/2022 11:18:03'!
puedeEjecutar: comando
	^comando asUppercase = $F.! !


!classDefinition: #GirarDerecha category: 'MarsRover'!
Comando subclass: #GirarDerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!GirarDerecha methodsFor: 'commandExecution' stamp: 'SM 10/31/2022 19:13:30'!
ejecutarComando: marsRover
	marsRover girarALaDerecha.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GirarDerecha class' category: 'MarsRover'!
GirarDerecha class
	instanceVariableNames: ''!

!GirarDerecha class methodsFor: 'class initialization' stamp: 'sm 11/4/2022 11:18:11'!
puedeEjecutar: comando
	^comando asUppercase= $R.! !


!classDefinition: #GirarIzquierda category: 'MarsRover'!
Comando subclass: #GirarIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!GirarIzquierda methodsFor: 'commandExecution' stamp: 'SM 10/31/2022 19:13:58'!
ejecutarComando: marsRover
	marsRover girarALaIzquierda.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GirarIzquierda class' category: 'MarsRover'!
GirarIzquierda class
	instanceVariableNames: ''!

!GirarIzquierda class methodsFor: 'class initialization' stamp: 'sm 11/4/2022 11:18:16'!
puedeEjecutar: comando
	^comando asUppercase = $L.! !


!classDefinition: #Retroceder category: 'MarsRover'!
Comando subclass: #Retroceder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Retroceder methodsFor: 'commandExecution' stamp: 'SM 10/31/2022 19:14:19'!
ejecutarComando: marsRover
	marsRover moverHaciaAtras.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Retroceder class' category: 'MarsRover'!
Retroceder class
	instanceVariableNames: ''!

!Retroceder class methodsFor: 'class initialization' stamp: 'sm 11/4/2022 11:18:30'!
puedeEjecutar: comando
	^comando asUppercase = $B.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'aDondeApunta posicion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'SM 10/31/2022 18:47:06'!
initialize
	aDondeApunta := Norte new.
	posicion := 0@0.! !


!MarsRover methodsFor: 'execution' stamp: 'SM 10/31/2022 17:46:14'!
ejecutarSecuencia: secuencia
	secuencia do: [:x| self ejecutarComando: x].
	
	! !


!MarsRover methodsFor: 'comparing' stamp: 'SM 10/31/2022 17:32:15'!
apuntaA: puntoCardinal
	^aDondeApunta = puntoCardinal.! !


!MarsRover methodsFor: 'accessing' stamp: 'SM 10/31/2022 18:04:24'!
posicion
	^posicion.! !


!MarsRover methodsFor: 'movements' stamp: 'SM 10/31/2022 18:47:58'!
girarALaDerecha
	aDondeApunta := aDondeApunta derecha
	"aDondeApunta = 'N' ifTrue:[aDondeApunta := 'E'. ^self].
	aDondeApunta = 'E' ifTrue:[aDondeApunta := 'S'. ^self].
	aDondeApunta = 'S' ifTrue:[aDondeApunta := 'O'. ^self].
	aDondeApunta = 'O' ifTrue:[aDondeApunta := 'N'. ^self]."! !

!MarsRover methodsFor: 'movements' stamp: 'SM 10/31/2022 18:48:53'!
girarALaIzquierda
	aDondeApunta := aDondeApunta izquierda
	"aDondeApunta = 'N' ifTrue:[aDondeApunta := 'O'. ^self].
	aDondeApunta = 'E' ifTrue:[aDondeApunta := 'N'. ^self].
	aDondeApunta = 'S' ifTrue:[aDondeApunta := 'E'. ^self].
	aDondeApunta = 'O' ifTrue:[aDondeApunta := 'S'. ^self]."! !

!MarsRover methodsFor: 'movements' stamp: 'SM 10/31/2022 19:07:00'!
moverHaciaAdelante
	posicion := posicion + aDondeApunta adelante.
	"(self apuntaA: 'N') ifTrue: [posicion := posicion + (0@1)].
	(self apuntaA: 'S') ifTrue: [posicion := posicion + (0@-1)].
	(self apuntaA: 'E') ifTrue: [posicion := posicion + (1@0)].
	(self apuntaA: 'O') ifTrue: [posicion := posicion + (-1@0)]."! !

!MarsRover methodsFor: 'movements' stamp: 'SM 10/31/2022 19:07:23'!
moverHaciaAtras
	posicion := posicion + aDondeApunta atras.
	"(self apuntaA: 'S') ifTrue: [posicion := posicion + (0@1)].
	(self apuntaA: 'N') ifTrue: [posicion := posicion + (0@-1)].
	(self apuntaA: 'O') ifTrue: [posicion := posicion + (1@0)].
	(self apuntaA: 'E') ifTrue: [posicion := posicion + (-1@0)]."! !


!MarsRover methodsFor: 'private' stamp: 'SM 10/31/2022 19:12:43'!
ejecutarComando: comandoDeSecuencia
|comando|
	comando:= Comando with: comandoDeSecuencia.
	comando ejecutarComando: self.
	"
	((comandoDeSecuencia  = $R) or: (comandoDeSecuencia = $L)) ifTrue: [self apuntarA: comandoDeSecuencia. ^self].
	((comandoDeSecuencia  = $F) or: (comandoDeSecuencia = $B)) ifTrue: [self moverHacia: comandoDeSecuencia. ^self].
	^'malAhi'."! !


!classDefinition: #PuntoCardinal category: 'MarsRover'!
Object subclass: #PuntoCardinal
	instanceVariableNames: 'puntoCardinal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PuntoCardinal methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:17:56'!
adelante
	self subclassResponsibility.! !

!PuntoCardinal methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:18:00'!
atras
	self subclassResponsibility.! !

!PuntoCardinal methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:18:05'!
derecha
	self subclassResponsibility.! !

!PuntoCardinal methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:18:16'!
izquierda
	self subclassResponsibility.! !


!PuntoCardinal methodsFor: 'comparing' stamp: 'SM 10/31/2022 18:57:46'!
= otroPuntoCardinal
	^(self puntoCardinal = otroPuntoCardinal puntoCardinal).! !


!PuntoCardinal methodsFor: 'accessing' stamp: 'SM 10/31/2022 18:49:30'!
puntoCardinal
	^puntoCardinal.! !


!classDefinition: #Este category: 'MarsRover'!
PuntoCardinal subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Este methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:04:56'!
adelante
	^1@0! !

!Este methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:05:05'!
atras
	^-1@0! !

!Este methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:44:32'!
derecha
	^Sur new.! !

!Este methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:44:43'!
izquierda
	^Norte new.! !


!Este methodsFor: 'initialization' stamp: 'SM 10/31/2022 18:50:24'!
initialize
	puntoCardinal := 'Este'.! !


!classDefinition: #Norte category: 'MarsRover'!
PuntoCardinal subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Norte methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:03:13'!
adelante
	^0@1! !

!Norte methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:04:35'!
atras
	^0@-1! !

!Norte methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:44:07'!
derecha
	^Este new.! !

!Norte methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:44:19'!
izquierda
	^Oeste new.! !


!Norte methodsFor: 'initialization' stamp: 'SM 10/31/2022 18:50:16'!
initialize
	puntoCardinal := 'Norte'.! !


!classDefinition: #Oeste category: 'MarsRover'!
PuntoCardinal subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Oeste methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:04:18'!
adelante
	^-1@0! !

!Oeste methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:21:38'!
atras
	^1@0! !

!Oeste methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:45:55'!
derecha
	^Norte new.! !

!Oeste methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:45:45'!
izquierda
	^Sur new.! !


!Oeste methodsFor: 'initialization' stamp: 'SM 10/31/2022 18:50:33'!
initialize
	puntoCardinal := 'Oeste'.! !


!classDefinition: #Sur category: 'MarsRover'!
PuntoCardinal subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Sur methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:23:47'!
adelante
	^0@-1! !

!Sur methodsFor: 'relative position' stamp: 'SM 10/31/2022 19:05:30'!
atras
	^0@1.! !

!Sur methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:45:04'!
derecha
	^Oeste new.! !

!Sur methodsFor: 'relative position' stamp: 'SM 10/31/2022 18:45:14'!
izquierda
	^Este new.! !


!Sur methodsFor: 'initialization' stamp: 'SM 10/31/2022 18:50:40'!
initialize
	puntoCardinal := 'Sur'.! !
